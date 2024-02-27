//
//  OctAdRewardVideo.h
//  OctAdSDK
//
//  Created by guantou on 2023/11/26.
//

#import "OctopusBaseAd.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OctAdRewardVideoDelegate;


@interface OctAdRewardVideo : OctopusBaseAd

// 设置广告的代理
@property (nonatomic, weak)id<OctAdRewardVideoDelegate> delegate;

// 激励视频初始化
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

@protocol OctAdRewardVideoDelegate <NSObject>

// 加载成功
- (void)octad_rewardVideoSuccessToLoad:(OctAdRewardVideo *)rewardVideo;

// 加载失败
- (void)octad_rewardVideo:(OctAdRewardVideo *)rewardVideo didFailWithError:(NSError * _Nullable)error;

// 广告曝光
- (void)octad_rewardVideoDidVisible:(OctAdRewardVideo *)rewardVideo;

// 广告点击
- (void)octad_rewardVideoAdViewDidClick:(OctAdRewardVideo *)rewardVideo;

// 广告关闭
- (void)octad_rewardVideoDidClose:(OctAdRewardVideo *)rewardVideo;

// 广告播放完成
- (void)octad_rewardVideoDidFinished:(OctAdRewardVideo *)rewardVideo;

// 广告发放奖励
- (void)octad_rewardVideoDidReward:(OctAdRewardVideo *)rewardVideo;

@end

NS_ASSUME_NONNULL_END
