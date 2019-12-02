//
//  MzzfilterCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzfilterCell.h"
#import "MzzCardsModel.h"
#import "MzzLevelModel.h"
#import "MzzFilterModel.h"
#import "MzzFilterBaseModel.h"
@implementation MzzfilterCell
{
    UIButton * _selectBtn;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContentArr:(NSMutableArray *)contentArr
{
    if (!(contentArr.count >0))
    {
        return;
    }
    for (int i = 0; i< contentArr.count; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = kLabelText_Commen_Color_9.CGColor;
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(13);
        btn.frame = CGRectMake(15 + (11 + 84) * (i%3), 0 + (11 + 30)*(i/3), 84, 30);
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(84 - 15, 30-15, 15, 15)];
        imageV.image = [UIImage imageNamed:@"shaixuancha"];
        imageV.hidden = YES;
        btn.tag = i;
        [btn addSubview:imageV];
        MzzFilterBaseModel * baseModel = contentArr[i];
        if (baseModel.isSelect) {
            imageV.hidden = NO;
        }else{
            imageV.hidden = YES;
        }
        if ([contentArr[i] isKindOfClass:[MzzFilterModel class]]) {
            MzzFilterModel * model = contentArr[i];
            [btn setTitle:model.title forState:UIControlStateNormal];
        }else if([contentArr[i] isKindOfClass:[MzzCustomerLevelModel class]]){
            MzzCustomerLevelModel * model = contentArr[i];
            [btn setTitle:model.name forState:UIControlStateNormal];
        }else{
            MzzCardsModel * model = contentArr[i];
            [btn setTitle:model.name forState:UIControlStateNormal];
        }
        [self.contentView addSubview:btn];
    }
}
- (void)click:(UIButton *)btn
{
//    [self imageViewHiden:btn];
//    [self imageViewHiden:_selectBtn];
//    _selectBtn = btn;
    if (_MzzfilterCellBlock) {
        _MzzfilterCellBlock(btn.tag);
    }
}
- (void)imageViewHiden:(UIButton *)btn
{
    for (UIView * view  in btn.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]])
        {
            view.hidden = !view.hidden;
        }
    }
}
@end
