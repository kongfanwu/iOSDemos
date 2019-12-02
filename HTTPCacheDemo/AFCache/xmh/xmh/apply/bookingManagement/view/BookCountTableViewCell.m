//
//  BookCountTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookCountTableViewCell.h"
#import "StateNumView.h"
#import "HomePageHeadModel.h"
@implementation BookCountTableViewCell
{
    NSArray * _titles1;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titles1 = @[@"待预约",@"已预约",@"修改预约",@"执行预约",@"实际接待",@"未按时到店",@"规划外到店",@"到店率"];
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initSubViews{
    
    for (int i = 0; i < 8; i++) {
        StateNumView * view =  [[StateNumView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4 * (i%4),52.5 * (i/4), SCREEN_WIDTH/4, 52.5)];
        view.lb1.text = _titles1[i];
        [view updateStateNumView];
        view.tag = 100 + i;
        [self addSubview:view];
        if (i==3||i==7) {
            view.line1.hidden = YES;
        }
    }
    //灰色条形
    UILabel * lb = [[UILabel alloc] init];
    lb.frame = CGRectMake(0, 115, SCREEN_WIDTH, 10);
    lb.backgroundColor = kBackgroundColor;
    [self addSubview:lb];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateBookCountStaffTableViewCellHomePageHeadModel:(HomePageHeadModel *)model{
    for (StateNumView * view in self.subviews) {
        
        switch (view.tag) {
            case 100:
                view.lb2.text = [NSString stringWithFormat:@"%ld人",(long)model.dyy];
                break;
            case 101:
                view.lb2.text = [NSString stringWithFormat:@"%ld人",(long)model.yyy];
                break;
            case 102:
                view.lb2.text = [NSString stringWithFormat:@"%ld人",(long)model.xgyy];
                break;
            case 103:
                view.lb2.text = [NSString stringWithFormat:@"%ld人",(long)model.zxyy];
                break;
            case 104:
                view.lb2.text = [NSString stringWithFormat:@"%ld人",(long)model.sjjd];
                break;
            case 105:
                view.lb2.text = [NSString stringWithFormat:@"%ld人",(long)model.wasdd];
                break;
            case 106:
                view.lb2.text = [NSString stringWithFormat:@"%ld人",(long)model.ghwdd];
                break;
            case 107:
                view.lb2.text = [NSString stringWithFormat:@"%ld%@",(long)model.ddl,@"%"];
                break;
            default:
                break;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
