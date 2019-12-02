//
//  MzzPujiCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPujiCell.h"
#import "MzzPujiModel.h"
#import "MzzPujiButton.h"
@implementation MzzPujiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCtArr:(NSMutableArray *)ctArr{
    _ctArr = ctArr;
    [_ctView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    for (UIView *view in self.ctView.subviews) {
//        if ([view isKindOfClass:[MzzPujiButton class]]) {
//            [view removeFromSuperview];
//        }
//    }
    //todo
    CGFloat marginW = 15;
    CGFloat marginH = 12;
    int col = 2;
    CGFloat witch = (SCREEN_WIDTH - (col + 1) * marginW) / col;
    CGFloat heigh = 28;
    NSInteger needDisplay =ctArr.count>6 ? 6 : ctArr.count;
    for (int i = 0; i <needDisplay; i ++) {
        int currentRow = i / col;
        int currentCol =   i % col;
        MzzPujiButton *btn = [MzzPujiButton buttonWithType:UIButtonTypeCustom];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        btn.tag = i;
        btn.frame = CGRectMake(marginW +(marginW +witch)*currentCol, marginH + (marginH + heigh) * currentRow, witch, heigh);
        btn.selectColor = kBtn_Commen_Color;
        PujiCard *model = [ctArr objectAtIndex:i];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitle:model.name forState:UIControlStateSelected];
//        [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        if (model.is_have) {
            [btn setSelected:YES];
        }
        [_ctView addSubview:btn];
    }   
}

- (void)btnOnclick:(MzzPujiButton *)btn{
    [btn setSelected:!btn.selected];
     PujiCard *model = [_ctArr objectAtIndex:btn.tag];
    model.is_have = !btn.selected ;
}

-(void)setHeight:(CGFloat)height{
    
}

-(void)setSelected:(BOOL)selected{
    
}
@end
