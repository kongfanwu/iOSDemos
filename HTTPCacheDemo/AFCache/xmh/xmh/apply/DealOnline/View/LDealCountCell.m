//
//  LDealCountCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDealCountCell.h"
#import "MzzTitleAndDetailView.h"
@implementation LDealCountCell
{
    NSArray * _titles;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titles = @[@"成交订单数",@"交易金额总额",@"新增顾客",@"参与人数"];
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kBackgroundColor;
    }
    return self;
}
- (void)initSubViews
{
    for (int i = 0; i < 4; i ++) {
       MzzTitleAndDetailView *View = [[MzzTitleAndDetailView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 *(i%2), 62 * (i/2), SCREEN_WIDTH/(2), 62)];
        View.tag = i;
        [self.contentView addSubview:View];
        [View setTitle:_titles[i] andDetail:@"151646"];
        View.backgroundColor = [UIColor whiteColor];
    }
}
- (void)setTopModel:(OTopModel *)topModel
{
    for (int i =0; i< self.contentView.subviews.count; i++) {
        
        UIView * view1 = self.contentView.subviews[i];
        if ([view1 isKindOfClass:[MzzTitleAndDetailView class]]) {
            MzzTitleAndDetailView * view = (MzzTitleAndDetailView *)view1;
            if (view.tag ==0) {
                [view setTitle:_titles[i] andDetail:[NSString stringWithFormat:@"%@个",topModel.order]];
            }else if (view.tag ==1){
                [view setTitle:_titles[i] andDetail:[NSString stringWithFormat:@"%@元",topModel.money]];
            }else if (view.tag ==2){
                [view setTitle:_titles[i] andDetail:[NSString stringWithFormat:@"%@人",topModel.add]];
            }else{
                [view setTitle:_titles[i] andDetail:[NSString stringWithFormat:@"%@人",topModel.part]];
            }
        }
    }
}
@end
