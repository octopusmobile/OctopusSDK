//
//  OctToponBannerCustomEvent.m
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/3/2.
//

#import "OctToponBannerCustomEvent.h"

#import <OctCore/OctTools.h>

#import "OctToponBiddingManager.h"

@interface OctToponBannerCustomEvent ()

@end

@implementation OctToponBannerCustomEvent

- (NSString *)networkUnitId {
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    return self.serverInfo[unitidName];
}

- (void)removeCustomViewAndNativeAd:(OctAdBanner *)adBanner {
    
}

#pragma mark OctAdBannerDelegate协议

- (void)octad_bannerSuccessToLoad:(OctAdBanner *)bannerAd {
    OctAdLog(@"广告加载成功");
    [self trackBannerAdLoaded:bannerAd adExtra:@{kATAdAssetsCustomObjectKey: bannerAd, kATNativeADAssetsAppPriceKey: @([bannerAd getPrice] / 100.0).stringValue}];
}

// 加载失败
- (void)octad_banner:(OctAdBanner *)bannerAd didFailWithError:(NSError *)error {
    OctAdLog(@"广告加载失败");
    [self handleLoadingFailure:error];
}

// 广告曝光
- (void)octad_bannerDidVisible:(OctAdBanner *)bannerAd {
    OctAdLog(@"广告曝光");
    
    [self trackBannerAdImpression];
}

// 广告点击
- (void)octad_bannerAdViewDidClick:(OctAdBanner *)bannerAd {
    OctAdLog(@"广告点击");
    [self trackBannerAdClick];
}

// 广告关闭
- (void)octad_bannerDidClose:(OctAdBanner *)bannerAd {
    OctAdLog(@"广告关闭");
    [self trackBannerAdClosed];
}

// 广告落地页关闭
- (void)octad_bannerWillCloseOtherView:(OctAdBanner *)bannerAd {
    OctAdLog(@"广告落地页关闭");
}


@end
