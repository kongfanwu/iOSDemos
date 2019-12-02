//
//Created by ESJsonFormatForMac on 18/04/16.
//

#import "ZheKouModel.h"
@implementation ZheKouModel


@end

@implementation ZheKouData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"stored_card" : [ZheKouStored_Card class]};
}


@end


@implementation ZheKouStored_Card


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


