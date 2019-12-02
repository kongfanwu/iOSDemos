//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import <Foundation/Foundation.h>
#import "ShengKaXuKaKeShengHuiYuanKa.h"
@class ShengKaXuKaKeShengHuiYuanKaData,ShengKaXuKaKeShengHuiYuanKaList;
@interface ShengKaXuKaKeShengHuiYuanKa : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ShengKaXuKaKeShengHuiYuanKaData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface ShengKaXuKaKeShengHuiYuanKaData : NSObject

@property (nonatomic, strong) NSArray<ShengKaXuKaKeShengHuiYuanKaList *> *list;

@end

@interface ShengKaXuKaKeShengHuiYuanKaList : NSObject

@property (nonatomic, copy) NSString *denomination;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger card_id;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) BOOL selected;

@end

