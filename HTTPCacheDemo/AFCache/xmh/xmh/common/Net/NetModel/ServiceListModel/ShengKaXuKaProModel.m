//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import "ShengKaXuKaProModel.h"
@implementation ShengKaXuKaProModel


@end

@implementation ShengKaXuKaProData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [ShengKaXuKaProDataList class]};
}


@end


@implementation ShengKaXuKaProDataList


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


