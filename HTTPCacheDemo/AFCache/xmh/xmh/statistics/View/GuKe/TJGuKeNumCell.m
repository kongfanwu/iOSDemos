//
//  TJGuKeNumCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeNumCell.h"
#import "TJGuKeTotalView.h"
#import "LTitleDetailView.h"
@implementation TJGuKeNumCell
{
    TJGuKeTotalView * _total;
    UIScrollView * _cardSrcollView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [ super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    _total = [[[NSBundle mainBundle]loadNibNamed:@"TJGuKeTotalView" owner:nil options:nil]lastObject];
    _total.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
    [self.contentView addSubview:_total];
    
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, _total.bottom + 60, SCREEN_WIDTH, 10);
    line.backgroundColor = kBackgroundColor;
    [self.contentView addSubview:line];
}
- (void)setModel:(TJGuKeTopModel *)model
{
    if ((model.list.count <=0)) {
        return;
    }
    _total.lb.text = model.list[0].val;
    NSInteger count = model.list.count-1;
    for (int i = 1; i <= count; i++) {
        LTitleDetailView * view = [[[NSBundle mainBundle]loadNibNamed:@"LTitleDetailView" owner:nil options:nil]lastObject];
        CGFloat width = SCREEN_WIDTH/count;
        view.frame = CGRectMake((i-1) * width, _total.bottom, width, 60);
        TJGuKeTopSubModel * subModel = model.list[i];
        if(i == count){
            
        }
        view.model = subModel;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
    }
}
-(void)setCardTopModel:(TJCardTopModel *)cardTopModel
{
    _total.lb.text = cardTopModel.total_num;
    _total.lbTitle.text = @"总项目数";
//
    if (!_cardSrcollView) {
        _cardSrcollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _total.bottom, SCREEN_WIDTH, 60)];
        [self addSubview:_cardSrcollView];
    }
    CGFloat width = 107;
    NSInteger count = cardTopModel.list.count;
    for (int i = 0; i < cardTopModel.list.count; i++) {
       LTitleDetailView * view = [[[NSBundle mainBundle]loadNibNamed:@"LTitleDetailView" owner:nil options:nil]lastObject];
        view.frame = CGRectMake(i * width, 0, width, 60);
        TJCardTopSubModel * model = cardTopModel.list[i];
        view.subCardmodel = model;
        view.backgroundColor = [UIColor whiteColor];
        [_cardSrcollView addSubview:view];
    }
    _cardSrcollView.contentSize = CGSizeMake(count*width, 60);
}
@end
