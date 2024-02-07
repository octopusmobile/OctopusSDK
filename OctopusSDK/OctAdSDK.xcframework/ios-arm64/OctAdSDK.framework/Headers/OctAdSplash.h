//
//  OctAdSplash.h
//  OctopusAdSDK
//
//  Created by guantou on 2023/10/24.
//

#import "OctopusBaseAd.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OctAdSplashDelegate;

@interface OctAdSplash : OctopusBaseAd

// 设置开屏广告的代理
@property (nonatomic, weak)id<OctAdSplashDelegate> delegate;

// 开屏初始化
- (instancetype)initWithSlotId:(NSString *)slotId;

// 加载开屏广告
- (void)loadAd;

// 展示广告
- (void)showAdsInWindow:(UIWindow *)window;

// 获取广告返回价格
- (int)getPrice;

@end

/**
 代理方法
 */
@protocol OctAdSplashDelegate <NSObject>

@optional

/**
 @return 展示下部logo位置，需要给传入view设置尺寸。
 */
- (UIView *)octad_splashBottomView;

/**
 广告加载成功
 */
- (void)octad_splashAdSuccess:(OctAdSplash *)splashAd;

/**
 广告展示
 */
- (void)octad_splashAdDidVisible:(OctAdSplash *)splashAd;

/**
 广告加载失败
 */
- (void)octad_splashAd:(OctAdSplash *)splashAd didFailWithError:(NSError * _Nullable)error;

/**
 SDK渲染开屏广告点击回调
 */
- (void)octad_splashAdDidClick:(OctAdSplash *)splashAd;

/**
 SDK渲染开屏广告关闭回调，当用户点击广告时会直接触发此回调，建议在此回调方法中直接进行广告对象的移除操作
 */
- (void)octad_splashAdDidClose:(OctAdSplash *)splashAd;

/**
 倒计时为0时会触发此回调
 */
- (void)octad_splashAdCountdownToZero:(OctAdSplash *)splashAd;

@end


NS_ASSUME_NONNULL_END
