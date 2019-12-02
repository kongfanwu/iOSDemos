//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import "ShengKaXuKaShiJianModel.h"
@implementation ShengKaXuKaShiJianModel


@end

@implementation ShengKaXuKaShiJianData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [ShengKaXuKaShiJianList class]};
}


@end


@implementation ShengKaXuKaShiJianList


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


