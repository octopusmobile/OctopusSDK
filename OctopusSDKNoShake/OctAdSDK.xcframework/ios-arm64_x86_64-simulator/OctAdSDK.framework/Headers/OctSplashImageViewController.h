//
//  OctSplashImageViewController.h
//  OctopusAdSDK
//
//  Created by guantou on 2020/1/13.
//

#import <UIKit/UIKit.h>
#import <OctCore/OctBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@class OctSDKSpaceInfoModel;
@protocol OctWorkerDelegate;
@class OctBuyerModel;
@class OCTStrategyHelper;

@interface OctSplashImageViewController : OctBaseViewController

- (instancetype)initWithSpaceInfo:(OctSDKSpaceInfoModel *)spaceInfo BottomView:(UIView *)bottomView SkipView:(UIView *)skipView;

@property (nonatomic, strong) OctBuyerModel *buyerModel;
@property (nonatomic, weak) id<OctWorkerDelegate> delegate;

//@property (nonatomic, weak) UIWindow *containerWindow;

@property (nonatomic, copy) NSString *randomUUID;

@property (nonatomic, strong) OCTStrategyHelper *strategyHelper;

- (void)addCloseView;

- (void)reportDeepLink;

// 上报竞价成功
- (void)oct_reportWinPrice:(NSString*)secondPrice;

// 上报竞价失败
- (void)oct_reportLossPrice:(NSString*)winPrice loseReason:(NSString*)reason winBidder:(NSString *)bidder;

//- (void)isCloseAdNextButton;

@end

NS_ASSUME_NONNULL_END
