//
//  SASalesInfoModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SASalesInfoModel.h"

@implementation SASalesInfoModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"sale" : [SASaleModel class]};
}
@end
//@implementation SASalesDataModel
//+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
//    return @{@"sale" : [SASaleModel class]};
//}
//@end
@implementation SASaleModel

@end

@implementation SADataModel

@end
@implementation SAProModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SASubModel class]};
}
@end
@implementation SASubModel

@end
@implementation SAGoodsModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SASubGoodModel class]};
}
@end
@implementation SASubGoodModel

@end
@implementation SACardCourseModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SASubCardCourseModel class]};
}
@end
@implementation SASubCardCourseModel

@end
@implementation SACardNumModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SASubCardNumModel class]};
}
@end
@implementation SASubCardNumModel

@end
@implementation SALStoreCardModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SASubStoreCardModel class]};
}
@end
@implementation SASubStoreCardModel

@end
@implementation SACardTimeModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SASubCardTimeModel class]};
}
@end
@implementation SASubCardTimeModel

@end
@implementation SALTicketModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SASubTicketModel class]};
}
@end
@implementation SASubTicketModel

@end

