//
//  TJGuKeTopModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeTopModel.h"

@implementation TJGuKeTopModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJGuKeTopSubModel class]};
}
@end
@implementation TJGuKeTopSubModel

@end
