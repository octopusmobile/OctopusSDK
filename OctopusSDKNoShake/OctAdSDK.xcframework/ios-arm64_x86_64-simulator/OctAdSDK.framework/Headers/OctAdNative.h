//
//  OctAdNative.h
//  OctopusAdDemo
//
//  Created by guantou on 2023/11/16.
//
#import "OctopusBaseAd.h"
#import "OctNativeAdDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OctAdNativeDelegate;

@interface OctAdNative : OctopusBaseAd

// controller 展示view的控制器或者弹出落地页的需要的控制器，此参数不能为空
@property (nonatomic, weak) UIViewController *controller;

// 设置原生广告的代理
@property (nonatomic, weak)id<OctAdNativeDelegate> delegate;

// 原生初始化
- (instancetype)initWithSlotId:(NSString *)slotId;
// isSelfRender：是否是自渲染。 默认为NO； 如果设置为YES， 那么就需要开发者自己渲染视图了， nativeAdViews将无效
- (instancetype)initWithSlotId:(NSString *)slotId isSelfRender:(BOOL)isSelfRender;

// 加载广告
- (void)loadAd;

// 获取广告返回价格
- (int)getPrice;

// 广告加载成功后获得的 原生广告数据模型（使用model数据，自定义View样式）
@property (nonatomic, strong, readonly) NSArray<OctNativeAdDataModel *> *adDataModels;

// 广告加载成功后获得的 View广告（数组内部为加载完成的View形式广告，直接add到目标View）
@property (nonatomic, strong, readonly) NSArray *nativeAdViews;

//是否是自渲染。 默认为NO； 如果设置为YES， 那么就需要开发者自己渲染视图了， nativeAdViews将无效
@property (nonatomic, readonly) BOOL isSelfRender;

@end

@protocol OctAdNativeDelegate <NSObject>

// 加载成功
- (void)octad_nativeSuccessToLoad:(OctAdNative *)nativeAd;

// 加载失败
- (void)octad_nativeAd:(OctAdNative *)nativeAd didFailWithError:(NSError * _Nullable)error;

// 广告曝光
- (void)octad_nativeDidVisible:(OctAdNative *)nativeAd;

// 广告点击
- (void)octad_nativeAdViewDidClick:(OctAdNative *)nativeAd;

// 广告关闭
- (void)octad_nativeAdViewDidClose:(OctAdNative *)nativeAd;

// 广告落地页关闭
- (void)octad_nativeAdViewWillCloseOtherView:(OctAdNative *)nativeAd;

@end

NS_ASSUME_NONNULL_END
