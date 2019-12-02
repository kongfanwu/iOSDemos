//
//  LDealCountView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/8/23.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LDealCountView.h"

@implementation LDealCountView
- (void)setTopModel:(OTopModel *)topModel
{
    _lb1.text = [NSString stringWithFormat:@"%@个",topModel.order];
    _lb2.text = [NSString stringWithFormat:@"%@元",topModel.money];
    _lb3.text = [NSString stringWithFormat:@"%@人",topModel.add];
    _lb4.text = [NSString stringWithFormat:@"%@人",topModel.part];
}
@end
