
//  OctBusinessReport.h
//  OctCore
//
//  Created by ZY on 2019/12/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//0:默认值可不传 1:调起 5:apk安装成功 6:apk下载成功 7:摇一摇灵敏度0时上报 8:回调 9:自动点击 10:补量
//所有的优先级排序 补量>调起>回调>自动点击>摇一摇灵敏度
typedef NS_ENUM(NSUInteger, OctAdClickType) {
    OctAdClickDefaut = 0,
    OctAdClickStart = 1,
    OctAdClickShakefor0 = 7,
    OctAdClickCallBack = 8,
    OctAdClickAutoClick = 9,
    OctAdClickBoost = 10
};

@interface OctBusinessReport : NSObject

@property (nonatomic, assign, readonly) BOOL isReportShow;
@property (nonatomic, assign, readonly) BOOL isReportClick;

//  上报点击时，获取点击位置，赋值点击Point。
@property (nonatomic, assign) CGPoint adClickPoint;
@property (nonatomic, assign) CGPoint srClickPoint;

//  随机uuid
@property (nonatomic, copy) NSString *randomUUID;

//  上报的广告展示的View
@property (nonatomic, strong) UIView *adView;

//  上报的URL
@property (nonatomic, strong) NSArray *reportURLArray;

//  上报展示
- (void)oct_reportShowView:(OctAdClickType)clickType;
- (void)oct_reportBackgroundShowView:(OctAdClickType)clickType;
//  上报点击
- (void)oct_reportClickView:(OctAdClickType)clickType;
- (void)oct_reportDeepLink:(OctAdClickType)clickType;

//  刷新上报状态
- (void)oct_refreshReportStatus;

@end

NS_ASSUME_NONNULL_END
