//
//Created by ESJsonFormatForMac on 18/01/08.
//

#import "BeautyCardModel.h"
@implementation BeautyCardModel

@end

@implementation BeautyCardData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"card_time" : [Card_Time class], @"card_num" : [Card_Num class], @"stored_card" : [Stored_Card class]};
}
@end

@implementation Card_Time

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
@end


@implementation Card_Num
{
    NSInteger _ywlNum;
}
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation Card_Course

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation Stored_Card

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation BeautyCardInfo

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"range" : [BeautyCardRange class]};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end

@implementation BeautyCardRange

@end



