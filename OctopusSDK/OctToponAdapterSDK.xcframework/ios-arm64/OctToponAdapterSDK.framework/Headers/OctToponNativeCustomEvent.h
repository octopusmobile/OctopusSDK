//
//  OctToponNativeCustomEvent.h
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/3/1.
//

#import <Foundation/Foundation.h>

#import <AnyThinkNative/AnyThinkNative.h>
#import <OctAdSDK/OctAdNative.h>

NS_ASSUME_NONNULL_BEGIN

@interface OctToponNativeCustomEvent : ATNativeADCustomEvent<OctAdNativeDelegate>

@property(nonatomic, weak) UIView *containerView;

@end

NS_ASSUME_NONNULL_END
