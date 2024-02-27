//
//  OctToponBaseAdapter.h
//  FBSnapshotTestCase
//
//  Created by hongji cai on 2024/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OctToponBaseAdapter : NSObject

@property (nonatomic, readonly) NSString *appId;
@property (nonatomic, readonly) NSString *unitId;

-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo;

@end

NS_ASSUME_NONNULL_END
