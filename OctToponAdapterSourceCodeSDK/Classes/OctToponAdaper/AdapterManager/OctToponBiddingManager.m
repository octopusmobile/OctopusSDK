//
//  OctToponBiddingManager.m
//  FBSnapshotTestCase
//
//  Created by hongji cai on 2024/2/20.
//

#import "OctToponBiddingManager.h"

#import "OctToponBiddingDelegate.h"

@interface OctToponBiddingManager()
@property (nonatomic, copy) NSNumber *sdkIsInited;
@property (nonatomic, copy) NSString *unitidName;
@property (nonatomic, copy) NSString *appidName;
@property (nonatomic, copy) NSString *sdkIsInitedName;
@property (nonatomic, copy) NSString *isUnifiedName;
@property (nonatomic, copy) NSString *isBidName;

@end

@interface OctToponBiddingManager ()

@property (nonatomic, strong) NSMutableDictionary *bidingAdStorageAccessor;
@property (nonatomic, strong) NSMutableDictionary *bidingAdDelegate;

@end

@implementation OctToponBiddingManager

+ (instancetype)sharedInstance {
    static OctToponBiddingManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OctToponBiddingManager alloc] init];
        sharedInstance.bidingAdStorageAccessor = [NSMutableDictionary dictionary];
        sharedInstance.bidingAdDelegate = [NSMutableDictionary dictionary];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.unitidName = @"slot_id";
        self.appidName = @"app_id";
        self.sdkIsInitedName = @"sdkIsInited";
        self.isUnifiedName = @"is_unified";
        self.isBidName = @"is_bid";
    }
    return self;
}

- (OctToponBiddingRequest *)getRequestItemWithUnitID:(NSString *)unitID {
    @synchronized (self) {
        return [self.bidingAdStorageAccessor objectForKey:unitID];
    }
    
}

- (void)removeRequestItmeWithUnitID:(NSString *)unitID {
    @synchronized (self) {
        [self.bidingAdStorageAccessor removeObjectForKey:unitID];
    }
}

- (void)savaBiddingDelegate:(OctToponBiddingDelegate *)delegate withUnitID:(NSString *)unitID {
    @synchronized (self) {
        [self.bidingAdDelegate setObject:delegate forKey:unitID];
    }
}

- (void)removeBiddingDelegateWithUnitID:(NSString *)unitID {
    @synchronized (self) {
        if (unitID.length) {
            [self.bidingAdDelegate removeObjectForKey:unitID];
        }
    }
}

- (void)startWithRequestItem:(OctToponBiddingRequest *)request {
    
    [self.bidingAdStorageAccessor setObject:request forKey:request.unitID];
    switch (request.adType) {
        default: {
            // 获取代理
            OctToponBiddingDelegate *delegate = [[OctToponBiddingDelegate alloc] init];
            delegate.unitID = request.unitID;
            [request.customObject setValue:delegate forKey:@"delegate"];
            [self savaBiddingDelegate:delegate withUnitID:request.unitID];
            break;
        }
    }
}

@end
