//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import <Foundation/Foundation.h>
#import "ShengKaXuKaKeShengHuiYuanKa.h"


@class ShengKaXuKaRenXuanModel,ShengKaXuKaRenXuanData;
@interface ShengKaXuKaRenXuanKa : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ShengKaXuKaRenXuanModel *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface ShengKaXuKaRenXuanModel : NSObject

@property (nonatomic, strong) NSArray<ShengKaXuKaRenXuanData *> *list;

@end

@interface ShengKaXuKaRenXuanData : NSObject

@property(nonatomic,assign)BOOL isShow;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, assign) NSInteger nums;

@property (nonatomic, assign) NSInteger is_have;

@property (nonatomic, assign) CGFloat money;

@property (nonatomic, copy) NSString *name;

@property (nonatomic,copy)NSString *award_del;
@property (nonatomic,copy)NSString *save_old;
@property (nonatomic,copy)NSString *to_type;
@property (nonatomic,copy)NSString *up_type;
@property (nonatomic,copy)NSString *inputPrice;
@property (nonatomic,strong)ShengKaXuKaKeShengHuiYuanKaList *ShengKaXuKaShengKaMuBiaoListModel;

@end

