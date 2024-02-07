//
//  OctPlayerView.h
//  OctCoreSDK
//
//  Created by guantou on 2019/12/9.
//

#import <UIKit/UIKit.h>
#import "OctAdvertisingDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 视频广告View
*/
@class OctSpaceInfoModel;

@interface OctPlayerView : UIView

@property (nonatomic, weak) id<OctAdvertisingDelegate> delegate;

/**
 点击位置，相对于广告
*/
@property (nonatomic, assign, readonly) CGPoint adClickPoint;
/**
 点击位置，相对于屏幕
*/
@property (nonatomic, assign, readonly) CGPoint srClickPoint;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 渲染广告
 @param spaceInfo 广告数据模型
 @param view LogoView，由于视频播放器的原因，要先确定尺寸。
 @param index 加载第几个广告
*/
- (void)loadPlayerWithOctSpaceInfo:(OctSpaceInfoModel *)spaceInfo bottomView:(UIView * _Nullable)view index:(NSInteger)index;

/**
 播放
 */
- (void)play;

/**
 暂停
 */
- (void)pause;

/**
 移除本身，在NSObject中无法释放
 */
- (void)closeSelf;

/**
 清理缓存
 */
+ (void)clearCache;

@end

NS_ASSUME_NONNULL_END
