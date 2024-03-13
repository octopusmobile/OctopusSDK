//
//  OctToponSplashCustomEvent.m
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/2/20.
//

#import "OctToponSplashCustomEvent.h"
#import <OctCore/OctTools.h>

#import "OctToponBiddingManager.h"

@implementation OctToponSplashCustomEvent

- (NSString *)networkUnitId {
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    return self.serverInfo[unitidName];
}

- (void)removeCustomViewAndsplashAd:(OctAdSplash *)splashAd {
    
    if (self.containerView) {
        [self.containerView removeFromSuperview];
    }
}

#pragma mark OctAdSplashDelegate协议
/**
 @return 展示下部logo位置，需要给传入view设置尺寸。
 */
- (UIView *)octad_splashBottomView {
    UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 100)];
    view.backgroundColor = [UIColor whiteColor];
    view.text = @"章鱼SDK";
    view.textAlignment = NSTextAlignmentCenter;
    view.textColor = UIColor.blackColor;
    return view;
}


- (void)octad_splashAdSuccess:(id)splashAd {
    OctAdLog(@"广告加载成功");
    [self trackSplashAdLoaded:splashAd adExtra:@{kATNativeADAssetsAppPriceKey: @([splashAd getPrice] / 100.0).stringValue}];
}

/**
 广告已出现
 */
- (void)octad_splashAdDidVisible:(OctAdSplash *)splashAd {
    OctAdLog(@"广告曝光");
    [self trackSplashAdShow];
}

/**
 广告加载失败
 */
- (void)octad_splashAd:(OctAdSplash *)splashAd didFailWithError:(NSError * _Nullable)error {
    OctAdLog(@"广告加载失败");
    [self removeCustomViewAndsplashAd:splashAd];
    
    [self trackSplashAdLoadFailed:error];
}

/**
 SDK渲染开屏广告点击回调
 */
- (void)octad_splashAdDidClick:(OctAdSplash *)splashAd {
    OctAdLog(@"广告点击");
    
    [self trackSplashAdClick];
}

/**
 SDK渲染开屏广告关闭回调，当用户点击广告时会直接触发此回调，建议在此回调方法中直接进行广告对象的移除操作
 */
- (void)octad_splashAdDidClose:(OctAdSplash *)splashAd {
    OctAdLog(@"广告已经关闭");
    
    [self removeCustomViewAndsplashAd:splashAd];
    [self trackSplashAdClosed:nil];
}

/**
 用户点击跳过按钮时会触发此回调，可在此回调方法中处理用户点击跳转后的相关逻辑
 */
- (void)octad_splashAdDidClickSkip:(OctAdSplash *)splashAd {
    
}

/**
 倒计时为0时会触发此回调
 */
- (void)octad_splashAdCountdownToZero:(OctAdSplash *)splashAd {
   
}

@end
