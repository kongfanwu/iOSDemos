//
//  XMHCheckView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCheckView.h"

@implementation XMHCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    
        /** 填充背景 */
        CGPoint center = CGPointMake(rect.size.width*0.5,rect.size.height*0.5);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width*0.5 - rect.size.width*0.03) startAngle:0 endAngle:M_PI*2 clockwise:YES];
        //设置颜色
        [kColorTheme set];
        // 填充：必须是一个完整的封闭路径,默认就会自动关闭路径
        [path fill];
        
        /** 绘制勾 */
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        path1.lineWidth = rect.size.width*0.06;
        // 设置起点//0.23
        [path1 moveToPoint:CGPointMake(rect.size.width*0.3, rect.size.height*0.48)];//0.43 //0.5
        // 添加一根线到某个点
        [path1 addLineToPoint:CGPointMake(rect.size.width*0.45, rect.size.height*0.7)];
        [path1 addLineToPoint:CGPointMake(rect.size.width*0.79, rect.size.height*0.35)];
        //设置颜色
        [[UIColor whiteColor] set];
        // 绘制路径
        [path1 stroke];
    
   
}
@end
