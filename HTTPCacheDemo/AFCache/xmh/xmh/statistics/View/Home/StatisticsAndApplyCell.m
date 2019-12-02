//
//  StatisticsAndApplyCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/9.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "StatisticsAndApplyCell.h"
#import "MineCellModel.h"
#import "XMHBadgeLabel.h"

@implementation StatisticsAndApplyCell
{
    UIImageView * _iconImgView;
    UILabel * _lbTitle;
    XMHBadgeLabel * _lb;          //消息条数

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}
- (void)setUI{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 56.5)/2, 10, 56.5, 56.5)];
    _iconImgView = imageView;
    [self.contentView addSubview:imageView];
    
    _lb = [XMHBadgeLabel defaultBadgeLabel];
    _lb.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];;
    _lb.layer.borderColor = [UIColor whiteColor].CGColor;
    _lb.layer.borderWidth = 2;
    _lb.left =imageView.width*3/4+imageView.x;
    _lb.top =imageView.y + imageView.height/4-10;
    _lb.height = 14;
    _lb.hidden = YES;
    [self.contentView addSubview:_lb];
    
    UILabel * lbTitel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 11, self.width, 14)];
    lbTitel.text = @"业务统计";
    lbTitel.textAlignment = NSTextAlignmentCenter;
    lbTitel.textColor = kLabelText_Commen_Color_6;
    lbTitel.font = FONT_SIZE(14);
    _lbTitle = lbTitel;
    [self.contentView addSubview:lbTitel];
    
}
- (void)setTitle:(NSArray *)titles icon:(NSArray *)icons index:(NSIndexPath *)indexPath{
    
    if(icons.count == 2){
        
        _iconImgView.image = [UIImage imageNamed:icons[indexPath.section][indexPath.row]];
        _lbTitle.text = [NSString stringWithFormat:@"%@",titles[indexPath.section][indexPath.row]];
    }else{
        
        _iconImgView.image = [UIImage imageNamed:icons[indexPath.row]];
        _lbTitle.text = [NSString stringWithFormat:@"%@",titles[indexPath.row]];
    }
    
}
- (void)updateStatisticsAndApplyCellModel:(MineCellModel *)model withCount:(NSString *)count
{
    _iconImgView.image = UIImageName(model.iconStr);
    if ([model.iconStr isEqualToString:@"group_10"]) {
        if (count.length == 0||[count isEqualToString:@"0"]) {
            _lb.hidden=YES;
        }else{
            _lb.hidden=NO;
        }
    }else{
        _lb.hidden = YES;
    }
    _lbTitle.text = model.title;

    _lb.text = count;
}
@end
