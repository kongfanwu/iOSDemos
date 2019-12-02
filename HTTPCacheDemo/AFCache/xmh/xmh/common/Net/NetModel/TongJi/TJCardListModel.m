//
//  TJCardListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJCardListModel.h"

@implementation TJCardListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJCardModel class]};
}
@end
@implementation TJCardModel

@end
