//
//Created by ESJsonFormatForMac on 18/03/12.
//

#import <Foundation/Foundation.h>

@class SABalanceDataModel;
@interface SABalanceModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray<SABalanceDataModel *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface SABalanceDataModel : NSObject

@property (nonatomic, copy) NSString *stored_code;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger card_id;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger bank_id;

@property (nonatomic, assign) NSInteger del;

@end

