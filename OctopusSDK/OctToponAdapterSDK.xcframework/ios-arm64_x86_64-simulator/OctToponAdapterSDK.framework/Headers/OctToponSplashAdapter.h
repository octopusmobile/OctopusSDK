//
//  OctToponSplashAdapter.h
//  FBSnapshotTestCase
//
//  Created by hongji cai on 2024/2/8.
//

#import <Foundation/Foundation.h>

#import "OctToponBaseAdapter.h"
#import <AnyThinkSplash/ATSplash.h>

NS_ASSUME_NONNULL_BEGIN

@class ATSplash;
@protocol ATSplashDelegate;
@class ATPlacementModel;
@class ATUnitGroupModel;
@class ATBidInfo;

@interface OctToponSplashAdapter : OctToponBaseAdapter

+ (void)showSplash:(ATSplash *)splash localInfo:(NSDictionary*)localInfo delegate:(id<ATSplashDelegate>)delegate;
+(BOOL)adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info;
+(void)bidRequestWithPlacementModel:(ATPlacementModel*)placementModel unitGroupModel:(ATUnitGroupModel*)unitGroupModel info:(NSDictionary*)info completion:(void(^)(ATBidInfo *bidInfo, NSError *error))completion;
+ (void) sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo;
+ (void)sendLossNotifyWithCustomObject:(nonnull id)customObject lossType:(ATBiddingLossType)lossType winPrice:(nonnull NSString *)price userInfo:(NSDictionary *)userInfo;

- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
