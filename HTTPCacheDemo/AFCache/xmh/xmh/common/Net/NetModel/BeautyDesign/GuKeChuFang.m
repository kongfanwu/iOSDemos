//
//  GuKeChuFang.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "GuKeChuFang.h"

@implementation GuKeChuFang
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
