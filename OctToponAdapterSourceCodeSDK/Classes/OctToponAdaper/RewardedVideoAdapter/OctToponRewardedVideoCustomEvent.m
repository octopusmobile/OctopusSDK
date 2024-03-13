//
//  OctToponRewardedVideoCustomEvent.m
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/3/2.
//

#import "OctToponRewardedVideoCustomEvent.h"

#import <OctCore/OctTools.h>

#import "OctToponBiddingManager.h"

@interface OctToponRewardedVideoCustomEvent ()
@property (nonatomic, assign) BOOL isFailed;
@end

@implementation OctToponRewardedVideoCustomEvent

- (NSString *)networkUnitId {
    NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
    return self.serverInfo[unitidName];
}

- (void)removeCustomViewAndNativeAd:(OctAdRewardVideo *)adRewardVideo {
    
}

#pragma mark OctAdRewardVideoDelegate协议
// 加载成功
- (void)octad_rewardVideoSuccessToLoad:(OctAdRewardVideo *)rewardVideo {
    OctAdLog(@"激励视频广告加载成功");
    [self trackRewardedVideoAdLoaded:rewardVideo adExtra:@{kATNativeADAssetsAppPriceKey: @([rewardVideo getPrice] / 100.0).stringValue}];
}

// 加载失败
- (void)octad_rewardVideo:(OctAdRewardVideo *)rewardVideo didFailWithError:(NSError * _Nullable)error {
    OctAdLog(@"激励视频广告加载失败：%@", error);
    if (!_isFailed) {
        [self trackRewardedVideoAdLoadFailed:error];
        _isFailed = true;
    }
}

// 广告曝光
- (void)octad_rewardVideoDidVisible:(OctAdRewardVideo *)rewardVideo {
    OctAdLog(@"激励视频广告曝光");
    [self trackRewardedVideoAdShow];
    [self trackRewardedVideoAdVideoStart];
}

// 广告点击
- (void)octad_rewardVideoAdViewDidClick:(OctAdRewardVideo *)rewardVideo {
    OctAdLog(@"激励视频广告点击");
    [self trackRewardedVideoAdClick];
}

// 广告关闭
- (void)octad_rewardVideoDidClose:(OctAdRewardVideo *)rewardVideo {
    OctAdLog(@"激励视频广告关闭");
    [self trackRewardedVideoAdCloseRewarded:self.rewardGranted extra:@{}];
}

// 广告播放完成
- (void)octad_rewardVideoDidFinished:(OctAdRewardVideo *)rewardVideo {
    OctAdLog(@"激励视频广告播放完成");
    [self trackRewardedVideoAdVideoEnd];
}

// 广告发放奖励
- (void)octad_rewardVideoDidReward:(OctAdRewardVideo *)rewardVideo {
    OctAdLog(@"激励视频广告发放奖励");
    self.rewardGranted = NO;
}
@end
