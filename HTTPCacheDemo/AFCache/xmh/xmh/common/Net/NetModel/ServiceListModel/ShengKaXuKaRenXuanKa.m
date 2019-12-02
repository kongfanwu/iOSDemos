//
//Created by ESJsonFormatForMac on 18/03/30.
//

#import "ShengKaXuKaRenXuanKa.h"
@implementation ShengKaXuKaRenXuanKa


@end

@implementation ShengKaXuKaRenXuanModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [ShengKaXuKaRenXuanData class]};
}


@end


@implementation ShengKaXuKaRenXuanData


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


