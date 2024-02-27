//
//  OctAdIntersitital.h
//  FBSnapshotTestCase
//
//  Created by guantou on 2023/11/20.
//

#import "OctopusBaseAd.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OctAdIntersititalDelegate;

@interface OctAdIntersitital : OctopusBaseAd

// 设置广告的代理
@property (nonatomic, weak)id<OctAdIntersititalDelegate> delegate;

// 插屏初始化
- (instancetype)initWithSlotId:(NSString *)slotId;

// 加载广告
- (void)loadAd;

// 获取广告返回价格
- (int)getPrice;

// 广告是否加载成功
- (BOOL)isLoaded;

// 展示广告
- (void)showAdsInViewController:(UIViewController *)viewController;

@end

@protocol OctAdIntersititalDelegate <NSObject>

// 加载成功
- (void)octad_intersititalSuccessToLoad:(OctAdIntersitital *)intersititalAd;

// 加载失败
- (void)octad_intersitital:(OctAdIntersitital *)intersititalAd didFailWithError:(NSError * _Nullable)error;

// 广告曝光
- (void)octad_intersititalDidVisible:(OctAdIntersitital *)intersititalAd;

// 广告点击
- (void)octad_intersititalAdViewDidClick:(OctAdIntersitital *)intersititalAd;

// 广告关闭
- (void)octad_intersititalDidClose:(OctAdIntersitital *)intersititalAd;

// 广告落地页关闭
- (void)octad_intersititalWillCloseOtherView:(OctAdIntersitital *)intersititalAd;

@end

NS_ASSUME_NONNULL_END
