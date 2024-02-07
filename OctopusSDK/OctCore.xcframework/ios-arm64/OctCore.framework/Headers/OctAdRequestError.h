//
//  OctAdRequestError.h
//  OctCoreSDK
//
//  Created by guantou on 2019/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// OctSDK Ads error domain.
extern NSString *const kOctErrorDomain;

// NSError codes for Oct error domain.
typedef NS_ENUM(NSInteger, OctErrorCode) {
    kOctErrorUnknown                              = -10000,
    
    // SpaceID不能为空
    kOctErrorSpaceIDNULL                          = -10001,
    
    // 在请求广告数据过程中请求超时
    kOctErrorTimeout                              = -10002,
    
    // 在请求广告数据过程中出现了网络错误
    kOctErrorNetworkError                         = -10003,
    
    // 广告ID使用错误，类型不匹配
    kOctErrorIDUseError                           = -10004,
    
    // 广告请求成功，但没有返回广告内容
    kOctErrorNoFill                               = -10005,
    
    // 广告请求成功，加载素材失败
    kOctErrorLoadAdError                          = -10006,
    
    // 广告请求成功，获取到不支持的广告类型
    kOctErrorDoesNotSupport                       = -10007,
    
    // 广告View未添加到页面
    kOctErrorAdNotAddView                         = -11001,
    
    // 未发现上层控制器
    kOctErrorDoesNotCurrentViewController         = -11002,
    
    // 未发现布局广告View
    kOctErrorDoesNotCurrentView                   = -11003,
    
    // 原生广告上报时，页面没有添加到视图上
    kOctErrorDoesNotDisplayedInScreen             = -11004,
    
    // 第三方渠道错误
    kThirdPartyChannelError                         = -12001,
    
    // 第三方渠道为空
    kOctErrorChannelParameterNULL                 = -12002,
    
    // 获取配置失败
    kOctErrorGetConfigureFail                     = -10100,
    
    // 广告请求的时间过短
    kOctErrorAdRequestTimeLess                    = -10200,
    
    // 未找到广告位ID
    kOctErrorNotGetChannelSpaceID                 = -10300,
    
    // 配置错误
    kOctErrorConfigureError                       = -10400,
    
    //  广告返回失败
    kOctErrorAdBackFail                           = -10500,
    
};

@interface OctAdRequestError : NSError

+ (OctAdRequestError *)errorWithCode:(OctErrorCode)code;

@end

NS_ASSUME_NONNULL_END
