//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import <Foundation/Foundation.h>
#import "ShengKaXuKaKeShengHuiYuanKa.h"
@class ShengKaXuKaShiJianData,ShengKaXuKaShiJianList;
@interface ShengKaXuKaShiJianModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ShengKaXuKaShiJianData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface ShengKaXuKaShiJianData : NSObject

@property (nonatomic, strong) NSArray<ShengKaXuKaShiJianList *> *list;

@end

@interface ShengKaXuKaShiJianList : NSObject

@property (nonatomic,assign)BOOL isShow;
@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger is_have;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, assign) NSInteger expiry;

@property (nonatomic,strong)ShengKaXuKaKeShengHuiYuanKaList *ShengKaXuKaShengKaMuBiaoListModel;

@property (nonatomic,copy)NSString *award_del;
@property (nonatomic,copy)NSString *save_old;
@property (nonatomic,copy)NSString *to_type;
@property (nonatomic,copy)NSString *up_type;
@property (nonatomic,copy)NSString *inputPrice;

@end

