//
//  OctopusBaseAd.h
//  OctopusAdSDK
//
//  Created by guantou on 2023/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OctAdBiddingFailReason) {
    OctAdBiddingLossReasonLowPrice,
    OctAdBiddingLossReasonOther
};

@interface OctopusBaseAd : NSObject

////  请求广告
//- (void)requestAds;

/**开屏广告需要方法及其变量*/
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *skipView;

- (void)sendWinNotificationWithPrice:(NSInteger)price;
- (void)sendWinFailNotificationReason:(OctAdBiddingFailReason)failReason winnerPirce:(NSInteger)price;

@end

NS_ASSUME_NONNULL_END
