//
//  XMHTaskManagerHomeLIstModel.m
//  xmh
//
//  Created by ald_ios on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTaskManagerHomeListModel.h"

@implementation XMHTaskManagerHomeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHTaskManagerHomeModel class] };
}
@end
@implementation XMHTaskManagerHomeModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"taskID":@"id"};
}
@end
