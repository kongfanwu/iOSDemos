//
//  TJBBListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJBBListModel.h"

@implementation TJBBListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"next" : [TJBBModel class]};
}
@end

@implementation TJBBModel
@end
