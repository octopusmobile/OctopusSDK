//
//  OctToponInterstitialAdapter.m
//  Pods
//
//  Created by hongji cai on 2024/2/8.
//

#import "OctToponInterstitialAdapter.h"

#import "OctToponInterstitialCustomEvent.h"
#import "OctToponBiddingRequest.h"
#import "OctToponBiddingManager.h"

#import <OctCore/OctTools.h>
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>
#import <OctAdSDK/OctAdBanner.h>
#import <OctAdSDK/OctAdManager.h>

@interface OctToponInterstitialAdapter()
@property(nonatomic, strong) OctToponInterstitialCustomEvent *customEvent;
@property (nonatomic, strong) OctAdIntersitital *adIntersitital;
@end

@implementation OctToponInterstitialAdapter

- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    
    NSDictionary *extra = localInfo;
    _customEvent = [[OctToponInterstitialCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    _customEvent.delegate = self.delegateToBePassed;
    
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    OctToponBiddingRequest *request = [[OctToponBiddingManager sharedInstance] getRequestItemWithUnitID:serverInfo[unitidName]];
    if (request) {
        
        if (request.customObject != nil) { // load secced
            self.adIntersitital = request.customObject;
            self.adIntersitital.delegate = _customEvent;
            [_customEvent trackInterstitialAdLoaded:self.adIntersitital adExtra:@{kATAdAssetsCustomObjectKey: self.adIntersitital, kATNativeADAssetsAppPriceKey: @([self.adIntersitital getPrice] / 100.0).stringValue}];
        } else { // fail
            NSError *error = [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}];
            [_customEvent trackInterstitialAdLoadFailed:error];
        }
        [[OctToponBiddingManager sharedInstance] removeRequestItmeWithUnitID:serverInfo[unitidName]];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.adIntersitital = [[OctAdIntersitital alloc] initWithSlotId:serverInfo[unitidName]];
            self.adIntersitital.delegate = self.customEvent;
            [self.adIntersitital loadAd];
        });
    }
}

+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info {
    OctAdIntersitital *adIntersitital = (OctAdIntersitital *)customObject;
    return adIntersitital ? YES : NO;
}

+(void) showInterstitial:(ATInterstitial*)interstitial inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate {
    OctAdIntersitital *adIntersitital = (OctAdIntersitital*)interstitial.customObject;
    [adIntersitital showAdsInViewController:viewController];
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
    request.adType = OctToponAdFormatInterstitial;
    
    OctAdIntersitital *adIntersitital = [[OctAdIntersitital alloc] initWithSlotId:info[unitidName]];
    request.customObject = adIntersitital;
    [biddingManage startWithRequestItem:request];
    [adIntersitital loadAd];
}


+ (void) sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdIntersitital *adIntersitital = (OctAdIntersitital *)customObject;
    NSInteger secondPrice = ceil(price.doubleValue * 100);
    [adIntersitital sendWinNotice:secondPrice];
}

+ (void)sendLossNotifyWithCustomObject:(nonnull id)customObject lossType:(ATBiddingLossType)lossType winPrice:(nonnull NSString *)price userInfo:(NSDictionary *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdIntersitital *adIntersitital= (OctAdIntersitital *)customObject;
    OctAdBiddingFailReason reason = OctAdBiddingLossReasonOther;
    if (lossType == ATBiddingLossWithLowPriceInNormal || lossType == ATBiddingLossWithLowPriceInHB) {
        reason = OctAdBiddingLossReasonLowFilter;
    }
    NSInteger winPrice = ceil(price.doubleValue * 100);
    [adIntersitital sendLossNotice:reason winnerPirce:winPrice winBidder:nil];
}

@end
