//
//  XMHDataReportListModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDataReportListModel.h"
@implementation XMHDataReportListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHDataReportModel class]};
}
@end
@implementation XMHDataReportModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
