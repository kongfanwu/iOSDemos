//
//Created by ESJsonFormatForMac on 17/12/28.
//

#import <Foundation/Foundation.h>

@class ZhuzhiData,List;
@interface ZhuzhiModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ZhuzhiData *data;

@property (nonatomic, assign) NSInteger code;

@end

@interface ZhuzhiData : NSObject

@property (nonatomic, strong) NSArray<List *> *list;

@end

@interface List : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *store_code;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) NSInteger fram_id;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger main_role;

+ (instancetype)createListWithName:(NSString *)name framId:(NSString *)framId cId:(NSString *)cId;
@end

