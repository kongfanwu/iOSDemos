//
//Created by ESJsonFormatForMac on 18/02/02.
//

#import <Foundation/Foundation.h>

@class LSAUserModel;
@interface LSADaiFenPeiModel : NSObject
@property (nonatomic, assign) NSInteger type2;

@property (nonatomic, assign) NSInteger type1;

@property (nonatomic, assign) NSInteger type4;

@property (nonatomic, strong) NSArray<LSAUserModel *> *list;

@property (nonatomic, assign) NSInteger type3;

@end

@interface LSAUserModel : NSObject

@property (nonatomic, copy) NSString *mdname;

@property (nonatomic, copy) NSString *user_img;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, assign) NSInteger jis_min;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, copy) NSString *jis_max;

@property (nonatomic, copy) NSString *jis_img;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, assign)BOOL isSelect;

@property (nonatomic, copy) NSString *hs_content;

@property (nonatomic, copy) NSString *hs_type;

@property (nonatomic, copy) NSString *jis_type_content;

@property (nonatomic, copy)NSString * join_code;
@end

