//
//  SLServInfoModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/24.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLServInfoModel.h"

@implementation SLServInfoModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pro_list" : [SLInfoPro_List class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation SLInfoPro_List


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



