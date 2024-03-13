//
//  OctToponSplashCustomEvent.h
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/2/20.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSplash/AnyThinkSplash.h>
#import <OctAdSDK/OctAdSplash.h>

@interface OctToponSplashCustomEvent : ATSplashCustomEvent<OctAdSplashDelegate>

@property(nonatomic, weak) UIView *containerView;

@end
