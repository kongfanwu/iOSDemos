//
//Created by ESJsonFormatForMac on 18/04/05.
//

#import <Foundation/Foundation.h>

@class SADepositListModelData,SADepositListModelSales,SADepositListModelList;
@interface SADepositListModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) SADepositListModelData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface SADepositListModelData : NSObject

@property (nonatomic, strong) NSArray<SADepositListModelSales *> *sales;

@end

@interface SADepositListModelSales : NSObject
@property (nonatomic, assign)BOOL isShow;
@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger tk_amount;

@property (nonatomic, strong) NSArray<SADepositListModelList *> *list;

@property (nonatomic, copy) NSString *heji;

@property (nonatomic, copy) NSString *inper;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign)NSInteger numDisPlay;

@property (nonatomic, copy)NSString * totalPrice;


@end

@interface SADepositListModelList : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger qk_amount;

@property (nonatomic, copy) NSString *pro_code;

@property (nonatomic, assign) NSInteger tk_amount;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *amount_a;

@end

