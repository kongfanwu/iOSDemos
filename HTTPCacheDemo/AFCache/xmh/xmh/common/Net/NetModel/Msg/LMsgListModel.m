//
//  LMsgListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LMsgListModel.h"

@implementation LMsgListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [LMsgModel class]};
}
@end
@implementation LMsgModel

@end
