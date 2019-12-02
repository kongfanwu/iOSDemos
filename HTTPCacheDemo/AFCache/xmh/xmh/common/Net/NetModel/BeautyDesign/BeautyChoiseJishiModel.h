//
//Created by ESJsonFormatForMac on 18/01/11.
//

#import <Foundation/Foundation.h>

@class BeautyChoiseJishiData,BeautyChoiseJishiList;
@interface BeautyChoiseJishiModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) BeautyChoiseJishiData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface BeautyChoiseJishiData : NSObject

@property (nonatomic, strong) NSArray<BeautyChoiseJishiList *> *list;

@end

@interface BeautyChoiseJishiList : NSObject

@property (nonatomic, copy) NSString *mname;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, assign) NSInteger skill_level;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) NSInteger account_id;

@property (nonatomic, copy) NSString *name;

@end

