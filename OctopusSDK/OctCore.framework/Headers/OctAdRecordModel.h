//
//  OctAdRecordModel.h
//  OctCoreSDK
//
//  Created by guantou on 2019/12/10.
//

#import <Foundation/Foundation.h>
#import "OctAdvertisingType.h"
#import "OctAdRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 广告周期Model，跟随一个广告的生命周期运行
*/
@interface OctAdRecordModel : NSObject

@property (nonatomic, copy) NSString *adTypeId;     // 聚合adid
@property (nonatomic, copy) NSString *spaceParam;

@property (nonatomic, assign) OctChannelType channel;   // 渠道类型

@property (nonatomic, assign) uint64_t lifeTime;
@property (nonatomic, assign) OctAdvertisingType adType;

@property (nonatomic, copy) NSString *randomUUID;
@property (nonatomic, assign) NSTimeInterval requestTimeStamp;
@property (nonatomic, assign) NSTimeInterval startInitTimeStamp;
@property (nonatomic, assign) NSTimeInterval overInitTimeStamp;

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




//@property (nonatomic, copy) NSString *octAppID;
//@property (nonatomic, copy) NSString *octSlotID;
//@property (nonatomic, copy) NSString *KSAppID;
//@property (nonatomic, copy) NSString *KSSlotID;
//@property (nonatomic, copy) NSString *GDTAppID;
//@property (nonatomic, copy) NSString *GDTSlotID;
//@property (nonatomic, copy) NSString *BUAdAppID;
//@property (nonatomic, copy) NSString *BUAdSlotID;
//@property (nonatomic, copy) NSString *baiduAppID;
//@property (nonatomic, copy) NSString *baiduSlotID;

@end

NS_ASSUME_NONNULL_END
