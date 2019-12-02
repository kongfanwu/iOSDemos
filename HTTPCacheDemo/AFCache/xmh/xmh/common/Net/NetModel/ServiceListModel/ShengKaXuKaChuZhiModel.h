//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import <Foundation/Foundation.h>
#import "ShengKaXuKaKeShengHuiYuanKa.h"
@class ShengKaXuKaChuZhiData,ShengKaChuZhiList;
@interface ShengKaXuKaChuZhiModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ShengKaXuKaChuZhiData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface ShengKaXuKaChuZhiData : NSObject

@property (nonatomic, strong) NSArray<ShengKaChuZhiList *> *list;

@end

@interface ShengKaChuZhiList : NSObject

@property (nonatomic, assign)BOOL isShow;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger is_have;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger card_id;

@property (nonatomic, assign) NSInteger user_card_id;

@property (nonatomic,strong)ShengKaXuKaKeShengHuiYuanKaList *ShengKaXuKaShengKaMuBiaoListModel;

@property (nonatomic,copy)NSString *award_del;
@property (nonatomic,copy)NSString *save_old;
@property (nonatomic,copy)NSString *to_type;
@property (nonatomic,copy)NSString *up_type;
@property (nonatomic,copy)NSString *inputPrice;
@end

