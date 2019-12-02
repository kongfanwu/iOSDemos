//
//Created by ESJsonFormatForMac on 18/05/11.
//

#import <Foundation/Foundation.h>

@class bank,banksub;
@interface SAAccountModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) bank *data;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *inputPrice;

@end
@interface bank : NSObject

@property (nonatomic, strong) banksub *bank;

@end

@interface banksub : NSObject

@property (nonatomic, copy) NSString *money;

@property (nonatomic, assign) NSInteger bank_id;

@end

