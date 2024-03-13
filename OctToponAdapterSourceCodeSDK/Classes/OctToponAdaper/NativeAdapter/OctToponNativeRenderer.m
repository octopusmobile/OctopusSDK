//
//  OctToponNativeRenderer.m
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/3/1.
//

#import "OctToponNativeRenderer.h"

#import <AnyThinkNative/AnyThinkNative.h>
#import <OctAdSDK/OctAdNative.h>

@implementation OctToponNativeRenderer

-(void) renderOffer:(ATNativeADCache *)offer {
    [super renderOffer:offer];
    
    OctAdNative *adNative = (OctAdNative*)[offer.assets valueForKey:kATAdAssetsCustomObjectKey];
    _customEvent = (OctToponNativeCustomEvent*)[offer.assets valueForKey:kATAdAssetsCustomEventKey];
    self.ADView.customEvent = _customEvent;
    _customEvent.adView = self.ADView;
    adNative.controller = self.configuration.rootViewController;
    BOOL isSelfRender = !((NSNumber*)[offer.assets valueForKey:kATNativeADAssetsIsExpressAdKey]).integerValue;
    if(!isSelfRender) {
        [self.ADView addSubview:adNative.nativeAdViews.firstObject];
    }
    else {
        [adNative.adDataModels.firstObject bindVieWithContainer:self.ADView.selfRenderView clickableViews:self.ADView.clickableViews];
        [adNative.adDataModels.firstObject addADCloseTarget:self.ADView.dislikeButton];
    }
}

//-(__kindof UIView*)createMediaView {
//    ATVideoView *videoView = [[ATVideoView alloc] initWithFrame:self.ADView.bounds URL:nil];
//    videoView.autoPlay = ((ATNativeADCache*)self.ADView.nativeAd).placementModel.wifiAutoSwitch;
//    return videoView;
//}


@end
