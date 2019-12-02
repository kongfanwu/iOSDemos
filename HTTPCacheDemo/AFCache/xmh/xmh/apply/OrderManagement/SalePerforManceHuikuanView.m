//
//  SalePerforManceHuikuanView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/18.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "SalePerforManceHuikuanView.h"
@interface SalePerforManceHuikuanView()
@property (weak, nonatomic) IBOutlet UILabel *lbOneTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTwotitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;

@end
@implementation SalePerforManceHuikuanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setYejiListModel:(LOrderYejiListModel *)yejiListModel
{
    _lb1.text = [NSString stringWithFormat:@"%ld",yejiListModel.sales_num];
    _lb2.text = [NSString stringWithFormat:@"%@",yejiListModel.sales_amount];
    _lbOneTitle.text = [NSString stringWithFormat:@"%@",@"回款单数（个）："];
    _lbTwotitle.text = [NSString stringWithFormat:@"%@",@"总金额（元）："];
}

@end
