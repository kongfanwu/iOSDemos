//
//  XMHReportFilterOrganizeListModel.m
//  xmh
//
//  Created by ald_ios on 2019/7/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHReportFilterOrganizeListModel.h"

@implementation XMHReportFilterOrganizeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHReportFilterOrganizeModel class] };
}
@end
@implementation XMHReportFilterOrganizeModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"fram_id":@"id"};
}
@end
