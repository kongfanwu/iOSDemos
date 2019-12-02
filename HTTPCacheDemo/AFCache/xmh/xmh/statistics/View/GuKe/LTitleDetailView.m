//
//  LTitleDetailView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LTitleDetailView.h"

@implementation LTitleDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(TJGuKeTopSubModel *)model
{
    _lb1.text = [NSString stringWithFormat:@"%@人",model.val];
    _lb2.text = [NSString stringWithFormat:@"%@",model.key];
}
- (void)setSubCardmodel:(TJCardTopSubModel *)subCardmodel
{
    _lb1.text = [NSString stringWithFormat:@"%@个",subCardmodel.num];
    _lb2.text = [NSString stringWithFormat:@"%@",subCardmodel.name];
}
@end
