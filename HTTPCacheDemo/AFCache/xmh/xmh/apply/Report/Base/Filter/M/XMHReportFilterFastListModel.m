//
//  XMHReportFilterFastLIstModel.m
//  xmh
//
//  Created by ald_ios on 2019/7/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHReportFilterFastListModel.h"

@implementation XMHReportFilterFastListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHReportFilterFastModel class] };
}
@end
@implementation XMHReportFilterFastModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"fram_name_id":@"id"};
}
@end
