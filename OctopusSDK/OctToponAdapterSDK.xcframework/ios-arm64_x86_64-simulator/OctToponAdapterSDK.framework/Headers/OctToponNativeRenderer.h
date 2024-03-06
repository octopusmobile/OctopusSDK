//
//  OctToponNativeRenderer.h
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/3/1.
//

#import <Foundation/Foundation.h>

#import <AnyThinkNative/AnyThinkNative.h>
#import "OctToponNativeCustomEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface OctToponNativeRenderer : ATNativeRenderer
@property(nonatomic, readonly) OctToponNativeCustomEvent *customEvent;
@end

NS_ASSUME_NONNULL_END
