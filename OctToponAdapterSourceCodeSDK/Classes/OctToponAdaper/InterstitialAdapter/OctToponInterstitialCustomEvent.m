//
//  OctToponInterstitialCustomEvent.m
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/3/3.
//

#import "OctToponInterstitialCustomEvent.h"

#import <OctCore/OctTools.h>

#import "OctToponBiddingManager.h"

@interface OctToponInterstitialCustomEvent ()

@end

@implementation OctToponInterstitialCustomEvent

- (NSString *)networkUnitId {
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    return self.serverInfo[unitidName];
}

- (void)removeCustomViewAndNativeAd:(OctAdIntersitital *)adBanner {
    
}

#pragma mark OctAdBannerDelegate协议

- (void)octad_intersititalSuccessToLoad:(OctAdIntersitital *)intersititalAd {
    OctAdLog(@"插屏广告加载成功");
    [self trackInterstitialAdLoaded:intersititalAd adExtra:@{kATAdAssetsCustomObjectKey: intersititalAd, kATNativeADAssetsAppPriceKey: @([intersititalAd getPrice] / 100.0).stringValue}];
}

- (void)octad_intersitital:(OctAdIntersitital *)intersititalAd didFailWithError:(NSError *)error {
    OctAdLog(@"插屏广告加载失败");
    [self trackInterstitialAdLoadFailed:error];
}

- (void)octad_intersititalDidVisible:(OctAdIntersitital *)intersititalAd {
    OctAdLog(@"插屏广告曝光");
    [self trackInterstitialAdShow];
}

- (void)octad_intersititalAdViewDidClick:(OctAdIntersitital *)intersititalAd {
    OctAdLog(@"插屏广告点击");
    [self trackInterstitialAdClick];
}

- (void)octad_intersititalDidClose:(OctAdIntersitital *)intersititalAd {
    OctAdLog(@"插屏广告关闭");
    [self trackInterstitialAdClose:@{}];
}

- (void)octad_intersititalWillCloseOtherView:(OctAdIntersitital *)intersititalAd {
    
}
@end
