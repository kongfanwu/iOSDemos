//
//Created by ESJsonFormatForMac on 18/04/16.
//

#import <Foundation/Foundation.h>

@class ZheKouData,ZheKouStored_Card;
@interface ZheKouModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ZheKouData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface ZheKouData : NSObject

@property (nonatomic, strong) NSArray<ZheKouStored_Card *> *stored_card;//折扣优惠数组

@end

@interface ZheKouStored_Card : NSObject

@property (nonatomic, copy) NSString *code;//储值卡编码

@property (nonatomic, copy) NSString *money;//储值卡余额

@property (nonatomic, assign) NSInteger ID;//卡id或票券id

@property (nonatomic, copy) NSString *name;//储值卡名称

@property (nonatomic, copy) NSString *price;//折扣价后价格

@property (nonatomic, assign) BOOL selected;//是否选中

@property (nonatomic, assign)NSInteger xm_discount;//项目折扣

@property (nonatomic, assign)NSInteger cp_discount;//产品折扣
@end

