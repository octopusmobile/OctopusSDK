//
//  OctToponNativeAdapter.m
//  Pods
//
//  Created by hongji cai on 2024/2/8.
//

#import "OctToponNativeAdapter.h"

#import "OctToponNativeCustomEvent.h"

#import "OctToponBiddingRequest.h"
#import "OctToponBiddingManager.h"
#import "OctToponNativeRenderer.h"

#import <OctCore/OctTools.h>
#import <OctAdSDK/OctAdManager.h>

@interface OctToponNativeAdapter ()
@property (nonatomic, strong) OctToponNativeCustomEvent *customEvent;
@property (nonatomic, strong) OctAdNative *adNative;
@end

@implementation OctToponNativeAdapter

- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    
    NSDictionary *extra = localInfo;
    _customEvent = [[OctToponNativeCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    _customEvent.delegate = self.delegateToBePassed;
    
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    NSString *isUnifiedName = [OctToponBiddingManager.sharedInstance valueForKey:@"isUnifiedName"];
    NSInteger isSelfRender = ((NSString*)serverInfo[isUnifiedName]).intValue;
    OctToponBiddingRequest *request = [[OctToponBiddingManager sharedInstance] getRequestItemWithUnitID:serverInfo[unitidName]];
    if (request) {
        
        if (request.customObject != nil) { // load secced
            self.adNative = request.customObject;
            self.adNative.delegate = _customEvent;
            
            NSMutableArray<NSDictionary*>* assets = [NSMutableArray<NSDictionary*> array];
            NSMutableDictionary *asset = [NSMutableDictionary dictionary];
            [asset setValue:_customEvent forKey:kATAdAssetsCustomEventKey];
            [asset setValue:self.adNative forKey:kATAdAssetsCustomObjectKey];
            [asset setValue:@(!isSelfRender) forKey:kATNativeADAssetsIsExpressAdKey];
            
            if(isSelfRender) {
                [asset setValue:@(self.adNative.adDataModels.firstObject.octWidth) forKey:kATNativeADAssetsMainImageWidthKey];
                [asset setValue:@(self.adNative.adDataModels.firstObject.octHeight) forKey:kATNativeADAssetsMainImageHeightKey];
                [asset setValue:self.adNative.adDataModels.firstObject.octHeadline forKey:kATNativeADAssetsMainTitleKey];
                [asset setValue:self.adNative.adDataModels.firstObject.octLabel forKey:kATNativeADAssetsMainTextKey];
                [asset setValue:self.adNative.adDataModels.firstObject.octImages.firstObject forKey:kATNativeADAssetsImageURLKey];
                [asset setValue:self.adNative.adDataModels.firstObject.octLogoURL forKey:kATNativeADAssetsLogoURLKey];
            }
            else {
                UIView *adView = (UIView*)self.adNative.nativeAdViews.firstObject;
                [asset setValue:@(adView.frame.size.width) forKey:kATNativeADAssetsNativeExpressAdViewWidthKey];
                [asset setValue:@(adView.frame.size.height) forKey:kATNativeADAssetsNativeExpressAdViewHeightKey];
            }
            
            [assets addObject:asset];
            _customEvent.requestCompletionBlock(assets, nil);
        } else { // fail
            NSError *error = [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}];
            _customEvent.requestCompletionBlock(nil, error);
        }
        [[OctToponBiddingManager sharedInstance] removeRequestItmeWithUnitID:serverInfo[unitidName]];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.adNative = [[OctAdNative alloc] initWithSlotId:serverInfo[unitidName] isSelfRender:isSelfRender];
            self.adNative.delegate = self.customEvent;
            [self.adNative loadAd];
        });
    }
}

+(Class) rendererClass {
    return [OctToponNativeRenderer class];
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
    NSString *isUnifiedName = [OctToponBiddingManager.sharedInstance valueForKey:@"isUnifiedName"];
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
    request.adType = OctToponAdFormatNative;
    
    OctAdNative *adNative = [[OctAdNative alloc] initWithSlotId:info[unitidName] isSelfRender:((NSString*)info[isUnifiedName]).intValue];
    request.customObject = adNative;
    [biddingManage startWithRequestItem:request];
    [adNative loadAd];
}


+ (void) sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdNative *splashAd = (OctAdNative *)customObject;
    NSInteger secondPrice = ceil(price.doubleValue * 100);
    [splashAd sendWinNotice:secondPrice];
}

+ (void)sendLossNotifyWithCustomObject:(nonnull id)customObject lossType:(ATBiddingLossType)lossType winPrice:(nonnull NSString *)price userInfo:(NSDictionary *)userInfo {
    OctAdLog(@"%s", __FUNCTION__);
    OctAdNative *splashAd = (OctAdNative *)customObject;
    OctAdBiddingFailReason reason = OctAdBiddingLossReasonOther;
    if (lossType == ATBiddingLossWithLowPriceInNormal || lossType == ATBiddingLossWithLowPriceInHB) {
        reason = OctAdBiddingLossReasonLowFilter;
    }
    NSInteger winPrice = ceil(price.doubleValue * 100);
    [splashAd sendLossNotice:reason winnerPirce:winPrice winBidder:nil];
}


@end
