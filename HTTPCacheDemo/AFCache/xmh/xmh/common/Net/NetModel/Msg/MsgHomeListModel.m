//
//  MsgHomeListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/21.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MsgHomeListModel.h"

@implementation MsgHomeListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [MsgHomeModel class]};
}
@end
@implementation MsgHomeModel

@end
