//
//  OctCoreSDKAdRequestModel.h
//  OctCoreSDK
//
//  Created by guantou on 2020/2/17.
//

#import "OctBaseModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OctGeoModel;
@class OctDevInfoModel;
@class OctEnvInfoModel;
@class OctAdReqInfoModel;
@class OctCaidModel;

/**
 广告请求的model
*/
@interface OctAdRequestModel : OctBaseModel

//  reqid
@property (nonatomic, copy) NSString *reqid;
//  SDK版本号
@property (nonatomic, copy) NSString *version;
//  请求来源    0:未知 1:移动应用 2:移动Web 3:PC 4:测试
@property (nonatomic, copy) NSString *srcType;
//  广告请求类型  0:未知 1:广告请求 2:广告WIFI预加载
@property (nonatomic, copy) NSString *reqType;
//  请求时间戳（毫秒）
@property (nonatomic, assign) uint64_t timeStamp;
//  广告位id
@property (nonatomic, copy) NSString *appid;
//  设备model
@property (nonatomic, strong) OctDevInfoModel *devInfo;
//  用户信息
@property (nonatomic, strong) OctEnvInfoModel *envInfo;
//  广告信息
@property (nonatomic, strong) NSMutableArray<OctAdReqInfoModel *> *adReqInfo;
//  app版本
@property (nonatomic, copy) NSString *appVersion;
//  app包名
@property (nonatomic, copy) NSString *apkName;
//  安装时间
@property (nonatomic, assign) uint64_t appInstallTime;
//  更新时间
@property (nonatomic, assign) uint64_t appUpdateTime;

@end

@interface OctDevInfoModel : OctBaseModel

//  SDK唯一标识
@property (nonatomic, copy) NSString *sdkUID;
//  设备唯一标识
@property (nonatomic, copy) NSString *idfa;
//  设备mac地址
@property (nonatomic, copy) NSString *mac;
//  设备系统版本
@property (nonatomic, copy) NSString *os;
//  平台类型    0:未知 1:ios 2:android 3:其他
@property (nonatomic, copy) NSString *platform;
//  设备类型    0:未知 1:移动电话 2:平板 3:穿戴设备 4:PC 5:其他设备
@property (nonatomic, copy) NSString *devType;
//  设备厂商
@property (nonatomic, copy) NSString *brand;
//  设备型号
@property (nonatomic, copy) NSString *model;
//  屏幕像素
@property (nonatomic, copy) NSString *resolution;
//  屏幕大小
@property (nonatomic, copy) NSString *screenSize;
//  系统语言
@property (nonatomic, copy) NSString *language;
//  屏幕密度
@property (nonatomic, copy) NSString *density;
//  wifi名称
@property (nonatomic, copy) NSString *wifi;//70:BB:E9:9E:CD:0F,Oct3-5G",
//  设备CPU
@property (nonatomic, copy) NSString *cpu;
//  是否越狱
@property (nonatomic, copy) NSString *root;
//系统启动时间
@property (nonatomic, copy) NSString *bootMark;
//系统更新时间
@property (nonatomic, copy) NSString *updateMark;
//caid信息
@property (nonatomic, strong) NSArray<OctCaidModel *> *caidInfo;
//paid信息
@property (nonatomic, copy) NSString *paid;
//idfv信息
@property (nonatomic, copy) NSString *idfv;

@end

@interface OctEnvInfoModel : OctBaseModel
//  网络状态    0:未知 1:3G 2:4G 3:5G 4:WIFI 5:其他 6:2G
@property (nonatomic, copy) NSString *net;
//  运营商     0:未知 1:移动 2:联通 3:电信 4:其他运营
@property (nonatomic, copy) NSString *isp;
//  ip
@property (nonatomic, copy) NSString *ip;
//  地理位置model
@property (nonatomic, strong) OctGeoModel *geo;
//  电量
@property (nonatomic, assign) CGFloat battery;
//  磁盘总空间
@property (nonatomic, assign) uint64_t diskSpace;
//  磁盘使用空间
@property (nonatomic, assign) uint64_t useSpace;

@end

@interface OctGeoModel : OctBaseModel

//  横坐标
@property (nonatomic, copy) NSString *longitude;
//  纵坐标
@property (nonatomic, copy) NSString *latitude;
//  使用坐标系
@property (nonatomic, copy) NSString *name;

@end

@interface OctAdReqInfoModel : OctBaseModel

//  广告位id
@property (nonatomic, copy) NSString *slotId;
//  预留备用参数
@property (nonatomic, copy) NSString *spaceParam;
//  随机id
@property (nonatomic, copy) NSString *requestUUID;
//  广告超时时长
@property (nonatomic, assign) uint64_t channelReserveTs;
//  预留备用字段
@property (nonatomic, copy) NSString *sdkExtInfo;

@end

@interface OctCaidModel : OctBaseModel
//  id值
@property (nonatomic, copy) NSString *caid;
//  版本
@property (nonatomic, copy) NSString *version;

@end



NS_ASSUME_NONNULL_END
