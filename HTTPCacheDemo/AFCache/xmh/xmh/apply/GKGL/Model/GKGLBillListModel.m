//
//  GKGLBillListModel.m
//  xmh
//
//  Created by ald_ios on 2019/1/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLBillListModel.h"

@implementation GKGLBillListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [GKGLBillModel class]};
}
@end
@implementation GKGLBillModel

@end

