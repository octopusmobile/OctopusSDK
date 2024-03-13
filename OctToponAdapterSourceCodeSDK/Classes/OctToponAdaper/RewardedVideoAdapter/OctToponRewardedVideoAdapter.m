//
//  OctToponRewardedVideoAdapter.m
//  OctAdAdpaterSDK
//
//  Created by hongji cai on 2024/2/8.
//

#import "OctToponRewardedVideoAdapter.h"

#import "OctToponRewardedVideoCustomEvent.h"
#import "OctToponBiddingRequest.h"
#import "OctToponBiddingManager.h"

#import <OctCore/OctTools.h>
#import <AnyThinkRewardedVideo/AnyThinkRewardedVideo.h>
#import <OctAdSDK/OctAdRewardVideo.h>
#import <OctAdSDK/OctAdManager.h>

@interface OctToponRewardedVideoAdapter ()
@property(nonatomic, strong) OctToponRewardedVideoCustomEvent *customEvent;
@property (nonatomic, strong) OctAdRewardVideo *adRewardVideo;
@end


@implementation OctToponRewardedVideoAdapter

- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    
    NSDictionary *extra = localInfo;
    _customEvent = [[OctToponRewardedVideoCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    _customEvent.delegate = self.delegateToBePassed;
    
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    OctToponBiddingRequest *request = [[OctToponBiddingManager sharedInstance] getRequestItemWithUnitID:serverInfo[unitidName]];
    if (request) {
        
        if (request.customObject != nil) { // load secced
            self.adRewardVideo = request.customObject;
            self.adRewardVideo.delegate = _customEvent;
            [_customEvent trackRewardedVideoAdLoaded:self.adRewardVideo adExtra:@{kATNativeADAssetsAppPriceKey: @([self.adRewardVideo getPrice] / 100.0).stringValue}];
        } else { // fail
            NSError *error = [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}];
            [_customEvent trackRewardedVideoAdLoadFailed:error];
        }
        [[OctToponBiddingManager sharedInstance] removeRequestItmeWithUnitID:serverInfo[unitidName]];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.adRewardVideo = [[OctAdRewardVideo alloc] initWithSlotId:serverInfo[unitidName]];
            self.adRewardVideo.delegate = self.customEvent;
            [self.adRewardVideo loadAd];
        });
    }
}

+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info {
    OctAdRewardVideo *adRewardVideo = (OctAdRewardVideo *)customObject;
    return adRewardVideo ? YES : NO;
}

+(void) showRewardedVideo:(ATRewardedVideo*)rewardedVideo inViewController:(UIViewController*)viewController delegate:(id<ATRewardedVideoDelegate>)delegate {
    OctAdRewardVideo *adRewardVideo = (OctAdRewardVideo *)rewardedVideo.customObject;
    OctToponRewardedVideoCustomEvent *customEvent = (OctToponRewardedVideoCustomEvent*)rewardedVideo.customEvent;
    customEvent.delegate = delegate;
    [adRewardVideo showAdsInViewController:viewController];
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
    request.adType = OctToponAdFormatRewardedVideo;
    
    OctAdRewardVideo *rewardVideo = [[OctAdRewardVideo alloc] initWithSlotId:info[unitidName]];
    request.customObject = rewardVideo;
    [biddingManage startWithRequestItem:request];
    [rewardVideo loadAd];
}


+ (void) sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdRewardVideo *rewardVideo = (OctAdRewardVideo *)customObject;
    NSInteger secondPrice = ceil(price.doubleValue * 100);
    [rewardVideo sendWinNotice:secondPrice];
}

+ (void)sendLossNotifyWithCustomObject:(nonnull id)customObject lossType:(ATBiddingLossType)lossType winPrice:(nonnull NSString *)price userInfo:(NSDictionary *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdRewardVideo *rewardVideo = (OctAdRewardVideo *)customObject;
    OctAdBiddingFailReason reason = OctAdBiddingLossReasonOther;
    if (lossType == ATBiddingLossWithLowPriceInNormal || lossType == ATBiddingLossWithLowPriceInHB) {
        reason = OctAdBiddingLossReasonLowFilter;
    }
    NSInteger winPrice = ceil(price.doubleValue * 100);
    [rewardVideo sendLossNotice:reason winnerPirce:winPrice winBidder:nil];
}

@end
