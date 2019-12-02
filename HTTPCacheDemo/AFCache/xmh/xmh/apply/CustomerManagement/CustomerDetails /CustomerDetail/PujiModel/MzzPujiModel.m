//
//  MzzPujiModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPujiModel.h"



@implementation PujiModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"card_time" : [PujiCard class], @"card_exper" : [PujiCard class], @"stored_card" : [PujiCard class], @"card_num" : [PujiCard class], @"card_course" : [PujiCard class], @"goods" : [PujiCard class], @"pro" : [PujiCard class]};
}


@end


@implementation PujiCard


@end




