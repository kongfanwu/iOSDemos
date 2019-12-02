//
//  SAStoredCardListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SAStoredCardListModel.h"

@implementation SAStoredCardListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"stored_card" : [SAStoredCardModel class]};
}
@end
@implementation SAStoredCardModel

@end
