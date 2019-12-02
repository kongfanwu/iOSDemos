//
//  WorkGreetListModel.m
//  xmh
//
//  Created by ald_ios on 2018/10/25.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkGreetListModel.h"

@implementation WorkGreetListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [WorkGreetModel class]};
}
@end

@implementation WorkGreetModel

@end
