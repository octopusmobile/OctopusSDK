//
//  OctToponBaseAdapter.m
//  FBSnapshotTestCase
//
//  Created by hongji cai on 2024/2/8.
//

#import "OctToponBaseAdapter.h"

#import "OctToponBiddingManager.h"
#import <OctAdSDK/OctAdManager.h>

@interface OctToponBaseAdapter()

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *unitId;

@end

@implementation OctToponBaseAdapter

-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo {
    self = [super init];
    if (self != nil) {
        NSString *appidName = [OctToponBiddingManager.sharedInstance valueForKey:@"appidName"];
        NSString *unitidName = [OctToponBiddingManager.sharedInstance valueForKey:@"unitidName"];
        self.appId = serverInfo[appidName];
        self.unitId = serverInfo[unitidName];
        NSString *sdkIsInitedName = [OctToponBiddingManager.sharedInstance valueForKey:@"sdkIsInitedName"];
        BOOL sdkIsInited = [(NSNumber*)[OctToponBiddingManager.sharedInstance valueForKey: sdkIsInitedName] boolValue];
        if(!sdkIsInited) {
            [OctAdManager configureWithApplicationID: self.appId];
            [OctToponBiddingManager.sharedInstance setValue:@(YES) forKey:sdkIsInitedName];
        }
    }
    return self;
}

@end
