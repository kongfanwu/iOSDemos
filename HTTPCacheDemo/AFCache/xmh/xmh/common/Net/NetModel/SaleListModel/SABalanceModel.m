//
//Created by ESJsonFormatForMac on 18/03/12.
//

#import "SABalanceModel.h"
@implementation SABalanceModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [SABalanceDataModel class]};
}


@end

@implementation SABalanceDataModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


