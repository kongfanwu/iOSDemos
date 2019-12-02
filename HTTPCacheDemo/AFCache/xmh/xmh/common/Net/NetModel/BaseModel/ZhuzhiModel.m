//
//Created by ESJsonFormatForMac on 17/12/28.
//

#import "ZhuzhiModel.h"
@implementation ZhuzhiModel


@end

@implementation ZhuzhiData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [List class]};
}

@end

@implementation List

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
+ (instancetype)createListWithName:(NSString *)name framId:(NSString *)framId cId:(NSString *)cId
{
    List * list = [[List alloc] init];
    list.name = name;
    list.fram_id = framId.integerValue;
    list.ID = cId;
    return list;
}
@end


