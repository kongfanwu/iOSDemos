//
//  YiYuYueListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "YiYuYueListModel.h"
#import "YiYuYueModel.h"
@implementation YiYuYueListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [YiYuYueModel class] };
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
