//
//  LolGuKeListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolGuKeListModel.h"
#import "LolHomeGuKeModel.h"
@implementation LolGuKeListModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LolHomeGuKeModel class] };
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
