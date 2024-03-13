//
//  OctToponNativeCustomEvent.m
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/3/1.
//

#import "OctToponNativeCustomEvent.h"

#import <OctCore/OctTools.h>

#import "OctToponBiddingManager.h"

@implementation OctToponNativeCustomEvent

- (NSString *)networkUnitId {
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    return self.serverInfo[unitidName];
}

- (NSInteger)isSelfRender {
    NSString *isUnifiedName = [OctToponBiddingManager.sharedInstance valueForKey:@"isUnifiedName"];
    return ((NSString*)self.serverInfo[isUnifiedName]).intValue;
}

- (void)removeCustomViewAndNativeAd:(OctAdNative *)nativeAd {
    
    if (self.containerView) {
        [self.containerView removeFromSuperview];
    }
}

#pragma mark OctAdNativeDelegate协议
- (void)octad_nativeSuccessToLoad:(OctAdNative *)nativeAd {
    OctAdLog(@"广告加载成功");
    NSMutableArray<NSDictionary*>* assets = [NSMutableArray<NSDictionary*> array];
    NSMutableDictionary *asset = [NSMutableDictionary dictionary];
    [asset setValue:self forKey:kATAdAssetsCustomEventKey];
    [asset setValue:nativeAd forKey:kATAdAssetsCustomObjectKey];
    [asset setValue:@(![self isSelfRender]) forKey:kATNativeADAssetsIsExpressAdKey];
    
    if([self isSelfRender]) {
        [asset setValue:@(nativeAd.adDataModels.firstObject.octWidth) forKey:kATNativeADAssetsMainImageWidthKey];
        [asset setValue:@(nativeAd.adDataModels.firstObject.octHeight) forKey:kATNativeADAssetsMainImageHeightKey];
        [asset setValue:nativeAd.adDataModels.firstObject.octHeadline forKey:kATNativeADAssetsMainTitleKey];
        [asset setValue:nativeAd.adDataModels.firstObject.octLabel forKey:kATNativeADAssetsMainTextKey];
        [asset setValue:nativeAd.adDataModels.firstObject.octImages.firstObject forKey:kATNativeADAssetsImageURLKey];
        [asset setValue:nativeAd.adDataModels.firstObject.octLogoURL forKey:kATNativeADAssetsLogoURLKey];
    }
    else {
        UIView *adView = (UIView*)nativeAd.nativeAdViews.firstObject;
        [asset setValue:@(adView.frame.size.width) forKey:kATNativeADAssetsNativeExpressAdViewWidthKey];
        [asset setValue:@(adView.frame.size.height) forKey:kATNativeADAssetsNativeExpressAdViewHeightKey];
    }
    
    [assets addObject:asset];
    
//    [self trackNativeAdLoaded:assets];
    self.requestCompletionBlock(assets, nil);
}

// 加载失败
- (void)octad_nativeAd:(OctAdNative *)nativeAd didFailWithError:(NSError * _Nullable)error {
    OctAdLog(@"广告加载失败");
    
    [self removeCustomViewAndNativeAd:nativeAd];
    self.requestCompletionBlock(nil, error);
//    [self trackNativeAdLoadFailed:error];
}

// 广告曝光
- (void)octad_nativeDidVisible:(OctAdNative *)nativeAd {
    OctAdLog(@"广告曝光");
    [self.adView notifyNativeAdShow];
}

// 广告点击
- (void)octad_nativeAdViewDidClick:(OctAdNative *)nativeAd {
    OctAdLog(@"广告点击");
    
    [self trackNativeAdClick];
}

// 广告关闭
- (void)octad_nativeAdViewDidClose:(OctAdNative *)nativeAd {
    OctAdLog(@"广告关闭");
    NSInteger isSelfRender = ((NSNumber*)self.serverInfo[@"isUnifiedName"]).intValue;
    if(!isSelfRender) {
        UIView *adView = (UIView*)nativeAd.nativeAdViews.firstObject;
        [adView removeFromSuperview];
    }
    [self removeCustomViewAndNativeAd:nativeAd];
    [self trackNativeAdClosed];
}

// 广告落地页打开
- (void)octad_nativeAdViewWillPresentOtherView:(OctAdNative *)nativeAd {

}

// 广告落地页关闭
- (void)octad_nativeAdViewWillCloseOtherView:(OctAdNative *)nativeAd {

}

@end

