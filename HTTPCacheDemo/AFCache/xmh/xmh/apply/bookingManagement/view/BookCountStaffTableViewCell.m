//
//  BookCountStaffTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookCountStaffTableViewCell.h"
#import "StateNumView.h"
#import "HomePageHeadModel.h"
@implementation BookCountStaffTableViewCell
{
    NSArray * _titles1;
    NSArray * _titles2;
    UIView * _line;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        _titles1 = @[@"待预约",@"已预约"];
        _titles2 = @[@"修改预约",@"执行预约",@"实际接待",@"未按时到店",@"规划外到店",@"到店率"];
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    
    for (int i = 0; i <2; i++) {
        StateNumView * view = [[StateNumView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 * i, 0, SCREEN_WIDTH/2, 62)];
        view.btnMore.hidden = NO;
        view.tag = 100 + i;
        view.lb1.text = _titles1[i];
        [view updateStateNumView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
    }
    for (int i = 0; i<6; i++) {
        
        StateNumView * view = [[StateNumView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3 *(i%3), 62 + 52.5 * (i/3), SCREEN_WIDTH/3, 52.5)];
        view.tag = 102 +i;
        view.lb1.text = _titles2[i];
        [view updateStateNumView];
        [self addSubview:view];
        if (!_line) {
            _line = [[UIView alloc] init];
            _line.backgroundColor = kBackgroundColor;
            [self addSubview:_line];
        }
        if (i>=3) {
            _line.frame = CGRectMake(0, view.bottom, SCREEN_HEIGHT, 10);
        }
    }
}
- (void)tap:(UITapGestureRecognizer *)tap{
    
    if (_bookCountStaffTableViewCellBlock) {
        _bookCountStaffTableViewCellBlock(tap.view.tag);
    }
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
