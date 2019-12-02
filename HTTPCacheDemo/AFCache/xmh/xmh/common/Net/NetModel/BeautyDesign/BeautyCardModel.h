//
//Created by ESJsonFormatForMac on 18/01/08.
//

#import <Foundation/Foundation.h>

@class BeautyCardData,Card_Time,Card_Num,Card_Course,Stored_Card,BeautyCardInfo,BeautyCardRange;
@interface BeautyCardModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) BeautyCardData *data;

@property (nonatomic, assign) NSInteger code;

@end

@interface BeautyCardData : NSObject

@property (nonatomic, strong) NSArray<Card_Time *> *card_time;

@property (nonatomic, strong) NSArray<Card_Num *> *card_num;

@property (nonatomic, strong) NSMutableArray<Stored_Card *> *stored_card;

@end

@interface Card_Time : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *card_time_code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger num1;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) BeautyCardInfo *info;


@end

@interface Card_Num : NSObject

@property (nonatomic, assign) NSInteger cardcard;

@property (nonatomic, copy) NSString *card_num_code;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, copy) NSString *amount_a;


@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger num1;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) BeautyCardInfo *info;
/** 能用的次数 */
@property (nonatomic, assign) NSInteger canUseNum;


@end

@interface Card_Course : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, assign) NSInteger num1;

@property (nonatomic, copy) NSString *card_course_code;

@property (nonatomic, strong) BeautyCardInfo *info;

@end

@interface Stored_Card : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *stored_code;

@property (nonatomic, assign) NSInteger cardcard;

@property (nonatomic, strong) BeautyCardInfo *info;

@end

@interface BeautyCardInfo : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSArray<BeautyCardRange *> *range;

@property (nonatomic, copy) NSString *name;

@end

@interface BeautyCardRange : NSObject

@property (nonatomic, assign) NSInteger rights;

@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, assign) NSInteger group_id;

@property (nonatomic, assign) NSInteger group_map;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, assign) NSInteger main;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger num;

@property(nonatomic, assign)long numDisplay;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger fixed;

@property (nonatomic, assign) NSInteger addnum;

@property (nonatomic, assign) NSInteger max_num;

@property (nonatomic, assign) NSInteger min_num;

@property (nonatomic, copy) NSString *typeName;


@end


