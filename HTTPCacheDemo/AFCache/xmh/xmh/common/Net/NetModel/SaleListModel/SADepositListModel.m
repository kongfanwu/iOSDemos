//
//Created by ESJsonFormatForMac on 18/04/05.
//

#import "SADepositListModel.h"
@implementation SADepositListModel


@end

@implementation SADepositListModelData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"sales" : [SADepositListModelSales class]};
}


@end


@implementation SADepositListModelSales

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SADepositListModelList class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation SADepositListModelList


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


