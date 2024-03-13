//
//  OctToponBiddingManager.h
//  FBSnapshotTestCase
//
//  Created by hongji cai on 2024/2/20.
//

#import <Foundation/Foundation.h>
#import "OctToponBiddingRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface OctToponBiddingManager : NSObject

+ (instancetype)sharedInstance;

- (void)startWithRequestItem:(OctToponBiddingRequest *)request;

- (OctToponBiddingRequest *)getRequestItemWithUnitID:(NSString *)unitID;

- (void)removeRequestItmeWithUnitID:(NSString *)unitID;

- (void)removeBiddingDelegateWithUnitID:(NSString *)unitID;

@end

NS_ASSUME_NONNULL_END

