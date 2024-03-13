//
//  OctToponBiddingRequest.h
//  OctToponAdapterSDK
//
//  Created by hongji cai on 2024/2/21.
//

#import <Foundation/Foundation.h>

#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OctToponAdFormat) {
    OctToponAdFormatSplash = 0,
    OctToponAdFormatNative,
    OctToponAdFormatInterstitial,
    OctToponAdFormatRewardedVideo,
    OctToponAdFormatBanner
};



@interface OctToponBiddingRequest : NSObject

@property(nonatomic, strong) id customObject;

@property(nonatomic, strong) ATUnitGroupModel *unitGroup;

@property(nonatomic, strong) ATAdCustomEvent *customEvent;

@property(nonatomic, copy) NSString *unitID;
@property(nonatomic, copy) NSString *placementID;

@property(nonatomic, copy) NSDictionary *extraInfo;

@property(nonatomic, copy) void(^bidCompletion)(ATBidInfo * _Nullable bidInfo, NSError * _Nullable error);

@property(nonatomic, assign) OctToponAdFormat adType;

@end

NS_ASSUME_NONNULL_END
