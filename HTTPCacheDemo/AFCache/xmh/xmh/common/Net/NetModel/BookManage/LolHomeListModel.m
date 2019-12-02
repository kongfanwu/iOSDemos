//
//  LolHomeListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolHomeListModel.h"
#import "LolHomeModel.h"
#import "YYModel.h"
@implementation LolHomeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LolHomeModel class] };
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
