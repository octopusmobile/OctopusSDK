//
//  OctSecurityAndGziptTool.h
//  OctCoreSDK
//
//  Created by guantou on 2020/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 *  解压缩，加密、解密。
 */
@interface OctSecurityAndGziptTool : NSObject

//  Gzipt压缩
+ (NSData *)AdGzipData:(NSData*)uncompressedData;
//  Gzipt解压
+ (NSData *)AdUngzipData:(NSData *)compressedData;

/// oct加密
/// @param encryptString 需要加密的字符串
+ (NSData *)OctEncryptWithString:(NSString *)encryptString;

/// oct解密
/// @param decryptString 需要解密的字符串
+ (NSData *)OctDecryptWithString:(NSString *)decryptString;

+ (NSData *)OctAESEncryptWithString:(NSString *)encryptString;
+ (NSData *)OctAESDecryptWithString:(NSString *)decryptString;

//可选加解密
+ (NSData *)OctOptionEncryptWithString:(NSString *)encryptString;
+ (NSData *)OctOptionDecryptWithString:(NSString *)decryptString;

+ (NSData *)OctOptionAESEncryptWithString:(NSString *)encryptString;
+ (NSData *)OctOptionAESDecryptWithString:(NSString *)decryptString;


@end

NS_ASSUME_NONNULL_END
