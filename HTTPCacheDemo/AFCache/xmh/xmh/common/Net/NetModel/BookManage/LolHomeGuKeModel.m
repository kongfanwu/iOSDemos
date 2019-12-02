//
//  LolHomeGuKeModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/21.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolHomeGuKeModel.h"

@implementation LolHomeGuKeModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"user_id" :@"id"};
}
@end
