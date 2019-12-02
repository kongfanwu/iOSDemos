//
//  CustomerGradeListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerGradeListModel.h"

@implementation CustomerGradeListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"next" : [CustomerGradeModel class]};
}
@end
@implementation CustomerGradeModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [CustomerSubGradeModel class]};
}
@end
@implementation CustomerSubGradeModel

@end
