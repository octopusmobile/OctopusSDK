//
//  NSString+OctEncryption.h
//  OctCoreSDK
//
//  Created by guantou on 2018/11/27.
//

#import <Foundation/Foundation.h>

@interface NSString (OctEncryption)

- (NSString *)Oct_MD5String;
//  加密
- (NSString *)base64EncodeString;
//  解密
- (NSString *)base64DecodeString;

@end
