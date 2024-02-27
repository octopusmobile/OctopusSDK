#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "OctToponBannerAdapter.h"
#import "OctToponBaseAdapter.h"
#import "OctToponInterstitialAdapter.h"
#import "OctToponNativeAdapter.h"
#import "OctToponRewardedVideoAdapter.h"
#import "OctToponSplashAdapter.h"
#import "OctToponSplashCustomEvent.h"

FOUNDATION_EXPORT double OctToponAdapterSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char OctToponAdapterSDKVersionString[];

