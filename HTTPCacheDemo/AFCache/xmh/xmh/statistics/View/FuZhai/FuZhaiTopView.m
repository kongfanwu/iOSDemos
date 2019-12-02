//
//  FuZhaiTopView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FuZhaiTopView.h"

@implementation FuZhaiTopView

- (void)setModel:(FuZhaiTopModel *)model
{
    _lb1.text = [NSString stringWithFormat:@"¥%ld",model.total_fuzhai];
    _lb2.text = [NSString stringWithFormat:@"%ld人",model.user_fuzhai];
    _lb3.text = [NSString stringWithFormat:@"%ld人",model.user_num];
    _lb4.text = [NSString stringWithFormat:@"%ld元",model.inport_amount];
    _lb5.text = [NSString stringWithFormat:@"%ld个",model.num_fuzhai];
}
@end
