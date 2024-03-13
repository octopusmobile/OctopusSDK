//
//  OctToponSplashAdapter.m
//  FBSnapshotTestCase
//
//  Created by hongji cai on 2024/2/8.
//

#import "OctToponSplashAdapter.h"

#import "OctToponSplashCustomEvent.h"

#import "OctToponBiddingRequest.h"
#import "OctToponBiddingManager.h"

#import <OctCore/OctTools.h>
#import <OctAdSDK/OctAdManager.h>



@interface OctToponSplashAdapter ()
@property (nonatomic, strong) OctToponSplashCustomEvent *customEvent;
@property (nonatomic, strong) OctAdSplash *splashView;
@end

@implementation OctToponSplashAdapter

- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    
    NSDictionary *extra = localInfo;
    NSTimeInterval tolerateTimeout = localInfo[kATSplashExtraTolerateTimeoutKey] ? [localInfo[kATSplashExtraTolerateTimeoutKey] doubleValue] : 5.0;
    if (tolerateTimeout > 0) {
        _customEvent = [[OctToponSplashCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
        _customEvent.requestCompletionBlock = completion;
        _customEvent.delegate = self.delegateToBePassed;
        
        NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
        OctToponBiddingRequest *request = [[OctToponBiddingManager sharedInstance] getRequestItemWithUnitID:serverInfo[unitidName]];
        if (request) {
            
            if (request.customObject != nil) { // load secced
                self.splashView = request.customObject;
                self.splashView.delegate = _customEvent;
                [_customEvent trackSplashAdLoaded:self.splashView adExtra:@{kATNativeADAssetsAppPriceKey: @([self.splashView getPrice] / 100.0).stringValue}];
            } else { // fail
                NSError *error = [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}];
                [_customEvent trackSplashAdLoadFailed:error];
            }
            [[OctToponBiddingManager sharedInstance] removeRequestItmeWithUnitID:serverInfo[unitidName]];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.splashView = [[OctAdSplash alloc] initWithSlotId:serverInfo[unitidName]];
                self.splashView.delegate = self.customEvent;
                [self.splashView loadAd];
                
            });
        }
    } else {
        completion(nil, [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}]);
    }
}

//v 5.7.06 及以上版本中， splash 广告的 load 和 show 方法已经分开了
+ (void)showSplash:(ATSplash *)splash localInfo:(NSDictionary*)localInfo delegate:(id<ATSplashDelegate>)delegate {
    OctAdSplash *adSplash = (OctAdSplash *)splash.customObject;
    if (adSplash) {
        UIWindow *window = localInfo[kATSplashExtraWindowKey];
        [adSplash showAdsInWindow:window];
    }
}

+(BOOL)adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info {
    OctAdSplash *adSplash = (OctAdSplash *)customObject;
    return adSplash ? YES : NO;
}

#pragma mark - Header bidding
#pragma mark - c2s
+(void)bidRequestWithPlacementModel:(ATPlacementModel*)placementModel unitGroupModel:(ATUnitGroupModel*)unitGroupModel info:(NSDictionary*)info completion:(void(^)(ATBidInfo *bidInfo, NSError *error))completion {

    OctAdLog(@"%s", __FUNCTION__);
    if (NSClassFromString(@"OctAdManager") == nil) {
        if (completion != nil) { completion( nil, [NSError errorWithDomain:@"com.ubix.mediation.ios" code:1 userInfo:@{NSLocalizedDescriptionKey:@"Bid request has failed", NSLocalizedFailureReasonErrorKey:@"OctToponAdapterSDK is not imported"}]); }
        return;
    }
    NSString *appidName = [OctToponBiddingManager.sharedInstance valueForKey:@"appidName"];
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    NSString *sdkIsInitedName = [OctToponBiddingManager.sharedInstance valueForKey:@"sdkIsInitedName"];
    BOOL sdkIsInited = [(NSNumber*)[OctToponBiddingManager.sharedInstance valueForKey: sdkIsInitedName] boolValue];
    if(!sdkIsInited) {
        [OctAdManager configureWithApplicationID: info[appidName]];
        [OctToponBiddingManager.sharedInstance setValue:@(YES) forKey:sdkIsInitedName];
    }
    
    OctToponBiddingManager *biddingManage = [OctToponBiddingManager sharedInstance];
    OctToponBiddingRequest *request = [OctToponBiddingRequest new];
    request.unitGroup = unitGroupModel;
    request.placementID = placementModel.placementID;
    request.bidCompletion = completion;
    request.unitID = info[unitidName];
    request.extraInfo = info;
    request.adType = OctToponAdFormatSplash;
    
    OctAdSplash *splash = [[OctAdSplash alloc] initWithSlotId:info[unitidName]];
    request.customObject = splash;
    [biddingManage startWithRequestItem:request];
    [splash loadAd];
}


+ (void) sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdSplash *splashAd = (OctAdSplash *)customObject;
    NSInteger secondPrice = ceil(price.doubleValue * 100);
    [splashAd sendWinNotice:secondPrice];
}

+ (void)sendLossNotifyWithCustomObject:(nonnull id)customObject lossType:(ATBiddingLossType)lossType winPrice:(nonnull NSString *)price userInfo:(NSDictionary *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdSplash *splashAd = (OctAdSplash *)customObject;
    OctAdBiddingFailReason reason = OctAdBiddingLossReasonOther;
    if (lossType == ATBiddingLossWithLowPriceInNormal || lossType == ATBiddingLossWithLowPriceInHB) {
        reason = OctAdBiddingLossReasonLowFilter;
    }
    NSInteger winPrice = ceil(price.doubleValue * 100);
    [splashAd sendLossNotice:reason winnerPirce:winPrice winBidder:nil];
}

@end
