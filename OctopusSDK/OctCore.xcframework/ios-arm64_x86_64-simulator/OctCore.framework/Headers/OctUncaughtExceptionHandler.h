//
//  OctUncaughtExceptionHandler.h
//  OctCoreSDK
//
//  Created by guantou on 2019/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OctUncaughtExceptionHandler : NSObject

+ (void)installUncaughtExceptionHandler:(BOOL)install;

@end

NS_ASSUME_NONNULL_END
