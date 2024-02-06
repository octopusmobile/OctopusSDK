//
//  OctImageView.h
//  OctCoreSDK
//
//  Created by guantou on 2019/12/9.
//

#import <UIKit/UIKit.h>
#import "OctAdvertisingDelegate.h"

NS_ASSUME_NONNULL_BEGIN
/**
 Image类型广告View
*/
@class OctSpaceInfoModel;

@interface OctImageView : UIImageView

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
 @param index 加载第几个广告
*/
- (void)loadImageViewWithOctSpaceInfo:(OctSpaceInfoModel *)spaceInfo index:(NSInteger)index;

/**
 移除本身，在NSObject中无法释放
 */
- (void)closeSelf;

@end

NS_ASSUME_NONNULL_END
