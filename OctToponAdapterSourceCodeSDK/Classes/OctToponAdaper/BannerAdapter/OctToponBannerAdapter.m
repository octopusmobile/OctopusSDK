//
//  OctToponBannerAdapter.m
//  Pods
//
//  Created by hongji cai on 2024/2/8.
//

#import "OctToponBannerAdapter.h"

#import "OctToponBannerCustomEvent.h"
#import "OctToponBiddingRequest.h"
#import "OctToponBiddingManager.h"

#import <OctCore/OctTools.h>
#import <OctCore/OctWebView.h>
#import <AnyThinkBanner/AnyThinkBanner.h>
#import <OctAdSDK/OctAdBanner.h>
#import <OctAdSDK/OctAdManager.h>

@interface OctToponBannerAdapter ()
@property(nonatomic, strong) OctToponBannerCustomEvent *customEvent;
@property (nonatomic, strong) OctAdBanner *adBanner;
@end

@implementation OctToponBannerAdapter

- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    
    NSDictionary *extra = localInfo;
    _customEvent = [[OctToponBannerCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    _customEvent.delegate = self.delegateToBePassed;
    
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    OctToponBiddingRequest *request = [[OctToponBiddingManager sharedInstance] getRequestItemWithUnitID:serverInfo[unitidName]];
    if (request) {
        
        if (request.customObject != nil) { // load secced
            self.adBanner = request.customObject;
            self.adBanner.delegate = _customEvent;
            [_customEvent trackBannerAdLoaded:self.adBanner adExtra:@{kATAdAssetsCustomObjectKey: self.adBanner, kATNativeADAssetsAppPriceKey: @([self.adBanner getPrice] / 100.0).stringValue}];
        } else { // fail
            NSError *error = [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}];
            [_customEvent trackBannerAdLoadFailed:error];
        }
        [[OctToponBiddingManager sharedInstance] removeRequestItmeWithUnitID:serverInfo[unitidName]];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.adBanner = [[OctAdBanner alloc] initWithSlotId:serverInfo[unitidName]];
            self.adBanner.delegate = self.customEvent;
            [self.adBanner loadAd];
        });
    }
}

+(void) showBanner:(ATBanner*)banner inView:(UIView*)view presentingViewController:(UIViewController*)viewController {
    //展示banner
    OctAdBanner *adBanner = (OctAdBanner*)banner.customObject;
    adBanner.controller = viewController;
    OctWebView *adView = adBanner.adViews.firstObject;
    [view addSubview:adView];
    CGRect rect = adView.frame;
    rect.size = view.frame.size;
    adView.frame = rect;
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
    request.adType = OctToponAdFormatBanner;
    
    OctAdBanner *adBanner = [[OctAdBanner alloc] initWithSlotId:info[unitidName]];
    request.customObject = adBanner;
    [biddingManage startWithRequestItem:request];
    [adBanner loadAd];
}


+ (void) sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdBanner *adBanner = (OctAdBanner *)customObject;
    NSInteger secondPrice = ceil(price.doubleValue * 100);
    [adBanner sendWinNotice:secondPrice];
}

+ (void)sendLossNotifyWithCustomObject:(nonnull id)customObject lossType:(ATBiddingLossType)lossType winPrice:(nonnull NSString *)price userInfo:(NSDictionary *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdBanner *adBanner = (OctAdBanner *)customObject;
    OctAdBiddingFailReason reason = OctAdBiddingLossReasonOther;
    if (lossType == ATBiddingLossWithLowPriceInNormal || lossType == ATBiddingLossWithLowPriceInHB) {
        reason = OctAdBiddingLossReasonLowFilter;
    }
    NSInteger winPrice = ceil(price.doubleValue * 100);
    [adBanner sendLossNotice:reason winnerPirce:winPrice winBidder:nil];
}


@end
