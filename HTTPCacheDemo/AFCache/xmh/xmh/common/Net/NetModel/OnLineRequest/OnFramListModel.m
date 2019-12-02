//
//  OnFramListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OnFramListModel.h"

@implementation OnFramListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [Fram_List class]};
}
@end
