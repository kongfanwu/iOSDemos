//
//  TJGradeListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJGradeListModel.h"

@implementation TJGradeListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJGradeModel class]};
}
@end

@implementation TJGradeModel

@end
