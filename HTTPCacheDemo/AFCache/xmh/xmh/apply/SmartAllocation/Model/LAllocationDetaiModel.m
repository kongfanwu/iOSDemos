//
//  LAllocationDetaiModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LAllocationDetaiModel.h"
@implementation LAllocationDetaiModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"jis_list" : [LAllocationListModel class]};
}
@end

@implementation LAllocationListModel
+ (instancetype)AllocationListModelAccountid:(NSInteger)accountid jis:(NSString *)jis jis_cql:(NSString *)jis_cql jis_hkdj:(NSString *)jis_hkdj jis_xsyj:(NSString *)jis_xsyj jis_xhxm:(NSString *)jis_xhxm jis_ddpc:(NSString *)jis_ddpc jis_img:(NSString *)jis_img jis_name:(NSString *)jis_name jis_max:(NSString *)jis_max jis_min:(NSInteger)jis_min{
    LAllocationListModel * model = [[LAllocationListModel alloc] init];
    model.account_id = accountid;
    model.jis = jis;
    model.jis_cql = jis_cql;
    model.jis_hkdj = jis_hkdj;
    model.jis_name = jis_name;
    model.jis_xsyj = jis_xsyj;
    model.jis_xhxm= jis_xhxm;
    model.jis_ddpc = jis_ddpc;
    model.jis_img = jis_img;
    model.jis_max = jis_max;
    model.jis_min = jis_min;
    return model;
}
@end


@implementation LAllocationHeaderModel

@end
