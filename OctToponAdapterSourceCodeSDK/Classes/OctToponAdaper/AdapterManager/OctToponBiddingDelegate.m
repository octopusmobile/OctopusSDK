//
//  OctToponBiddingDelegate.m
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/2/21.
//

#import "OctToponBiddingDelegate.h"
#import "OctToponBiddingManager.h"
#import "OctToponBiddingRequest.h"

#import <OctAdSDK/OctAdSplash.h>
#import <OctAdSDK/OctAdNative.h>
#import <OctAdSDK/OctAdRewardVideo.h>
#import <OctAdSDK/OctAdIntersitital.h>
#import <OctAdSDK/OctAdBanner.h>
#import <AnyThinkSplash/AnyThinkSplash.h>
#import <OctCore/OctTools.h>

@interface OctToponBiddingDelegate()<OctAdSplashDelegate, OctAdNativeDelegate, OctAdRewardVideoDelegate, OctAdBannerDelegate, OctAdIntersititalDelegate>
@end

@implementation OctToponBiddingDelegate

#pragma mark OctAdSplashDelegate协议
/**
 @return 展示下部logo位置，需要给传入view设置尺寸。
 */
- (UIView *)octad_splashBottomView {
    UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 100)];
    view.backgroundColor = [UIColor whiteColor];
    view.text = @"章鱼SDK";
    view.textAlignment = NSTextAlignmentCenter;
    view.textColor = UIColor.blackColor;
    return view;
}


- (void)octad_splashAdSuccess:(id)splashAd {
    OctAdLog(@"%s", __FUNCTION__);
    
    [self biddingCompletion:splashAd AdFormat:OctToponAdFormatSplash];
}


/**
 广告加载失败
 */
- (void)octad_splashAd:(OctAdSplash *)splashAd didFailWithError:(NSError * _Nullable)error {
    OctAdLog(@"%s %@", __FUNCTION__ ,error);
    
    [self biddingFail:OctToponAdFormatSplash didFailWithError:error];
}

#pragma mark OctAdSplashDelegate协议
- (void)octad_nativeSuccessToLoad:(OctAdNative *)nativeAd {
    [self biddingCompletion:nativeAd AdFormat:OctToponAdFormatNative];
}

- (void)octad_nativeAd:(OctAdNative *)nativeAd didFailWithError:(NSError *)error {
    [self biddingFail:OctToponAdFormatNative didFailWithError:error];
}

#pragma mark OctAdRewardVideoDelegate协议
// 加载成功
- (void)octad_rewardVideoSuccessToLoad:(OctAdRewardVideo *)rewardVideo {
    [self biddingCompletion:rewardVideo AdFormat:OctToponAdFormatRewardedVideo];
}

// 加载失败
- (void)octad_rewardVideo:(OctAdRewardVideo *)rewardVideo didFailWithError:(NSError * _Nullable)error {
    [self biddingFail:OctToponAdFormatRewardedVideo didFailWithError:error];
}

#pragma mark OctAdBannerDelegate协议
- (void)octad_bannerSuccessToLoad:(OctAdBanner *)bannerAd {
    [self biddingCompletion:bannerAd AdFormat:OctToponAdFormatBanner];
}

// 加载失败
- (void)octad_banner:(OctAdBanner *)bannerAd didFailWithError:(NSError *)error {
    [self biddingFail:OctToponAdFormatBanner didFailWithError:error];
}

#pragma mark OctAdIntersititalDelegate协议
- (void)octad_intersititalSuccessToLoad:(OctAdIntersitital *)intersititalAd {
    [self biddingCompletion:intersititalAd AdFormat:OctToponAdFormatInterstitial];
}

- (void)octad_intersitital:(OctAdIntersitital *)intersititalAd didFailWithError:(NSError *)error {
    [self biddingFail:OctToponAdFormatInterstitial didFailWithError:error];
}

#pragma mark 公共方法
- (void)biddingCompletion:(id)customObject AdFormat:(OctToponAdFormat)adType {
    OctToponBiddingRequest *request = [[OctToponBiddingManager sharedInstance] getRequestItemWithUnitID:self.unitID];
    NSString *price = @"";
    switch (adType) {
        case OctToponAdFormatSplash:
            price = @([((OctAdSplash*)customObject) getPrice] / 100.0).stringValue;
            break;
        case OctToponAdFormatNative:
            price = @([((OctAdNative*)customObject) getPrice] / 100.0).stringValue;
            break;
        case OctToponAdFormatRewardedVideo:
            price = @([((OctAdRewardVideo*)customObject) getPrice] / 100.0).stringValue;
            break;
        case OctToponAdFormatBanner:
            price = @([((OctAdBanner*)customObject) getPrice] / 100.0).stringValue;
            break;
        case OctToponAdFormatInterstitial:
            price = @([((OctAdIntersitital*)customObject) getPrice] / 100.0).stringValue;
            break;
            
        default:
            break;
    }
    if (request.bidCompletion) {
        ATBidInfo *bidInfo = [ATBidInfo bidInfoC2SWithPlacementID:request.placementID unitGroupUnitID:request.unitGroup.unitID adapterClassString:request.unitGroup.adapterClassString price:price currencyType:ATBiddingCurrencyTypeCNY expirationInterval:request.unitGroup.networkTimeout customObject:customObject];
        request.bidCompletion(bidInfo, nil);
    }
    
    [[OctToponBiddingManager sharedInstance] removeBiddingDelegateWithUnitID:self.unitID];
}

- (void)biddingFail:(OctToponAdFormat)adType didFailWithError:(NSError * _Nullable)error {
    OctToponBiddingRequest *request = [[OctToponBiddingManager sharedInstance] getRequestItemWithUnitID:self.unitID];
    if (request.bidCompletion) {
        request.bidCompletion(nil, error);
    }
    [[OctToponBiddingManager sharedInstance] removeBiddingDelegateWithUnitID:self.unitID];
}

@end
