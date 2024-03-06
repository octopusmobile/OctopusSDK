//
//  OctopusNativeAdDataModel.h
//  OctopusAdDemo
//
//  Created by guantou on 2023/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OctResponseModel;
@class OctSpaceInfoModel;

@interface OctNativeAdDataModel : NSObject

//  按钮文字
@property (nonatomic, strong, readonly) NSString *octAction;
//  广告标题
@property (nonatomic, strong, readonly) NSString *octHeadline;
//  广告图片素材
@property (nonatomic, strong, readonly) NSArray *octImages;
//  广告文字素材
@property (nonatomic, strong, readonly) NSArray *octTexts;
//  广告视频素材
@property (nonatomic, strong, readonly) NSArray *octVideos;
//  广告素材宽
@property (nonatomic, assign, readonly) NSInteger octWidth;
//  广告素材高
@property (nonatomic, assign, readonly) NSInteger octHeight;


// 由于广告法规定，必须添加logo，（建议：广告图片放置在广告的左下角，logo放置在广告的右下角）
//  广告图片，当此字符串不为空时，加载adLabelURL的图片。
@property (nonatomic, strong, readonly) NSString *octLabelURL;
//  广告文字，当adLabelURL为空时，使用adLabel的文字
@property (nonatomic, strong, readonly) NSString *octLabel;
//  logo图片，当此字符串不为空时，加载logoURL的图片。
@property (nonatomic, strong, readonly) NSString *octLogoURL;
//  logo文字，当logoURL为空时，使用logoLabel的文字
@property (nonatomic, strong, readonly) NSString *octLogoLabel;


// 绑定展示视图和广告点击View（该视图点击可以跳转到落地页）
- (void)bindVieWithContainer:(UIView *)containerView clickableViews:(NSArray *)clickableViews;
// 添加关闭视图（该视图点击，可以关闭广告）
- (void)addADCloseTarget:(UIView*)targetView;


/**
 SDK内部方法，无需调用与使用
 */
- (instancetype)initWithData:(OctResponseModel *)octAdResponse octSpaceInfoModel:(OctSpaceInfoModel*)spaceInfo;

@end

NS_ASSUME_NONNULL_END
