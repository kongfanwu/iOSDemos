//
//  XMHSalesOrderTableView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSalesOrderTableView.h"
#import "XMHSaleOrderCell.h"
#import "SASaleListModel.h"
#import "XMHBillRecDetailView.h"
#import "UITableView+XMHEmptyData.h"
//static const CGFloat sidebarTableW = 100;

@interface XMHSalesOrderTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UILabel *headerLab;

@end

@implementation XMHSalesOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
//        self.frame = frame;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        //2019-4.18产品不添加卡项
//        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - sidebarTableW, 30)];
//        headView.backgroundColor = [UIColor whiteColor];
//        UILabel *headerLab = [[UILabel alloc]init];
//        headerLab.textAlignment = NSTextAlignmentLeft;
//        headerLab.font = [UIFont systemFontOfSize:17];
//        headerLab.frame = CGRectMake(15, 0, headView.frame.size.width - 15, 30);
//        headerLab.textColor = kLabelText_Commen_Color_3;
//        [headView addSubview:headerLab];
//        self.tableHeaderView = headView;
//        self.headerLab = headerLab;
    }
    return self;
}
//- (void)setCardName:(NSString *)cardName
//{
//    _cardName = cardName;
//    self.headerLab.text = _cardName;
//}

#pragma mark -- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellH;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch && !self.dataArr.count) {
        [tableView tableViewDisplayWithMsg:@"亲,没有查询到您所需要商品!" ifNecessaryForRowCount:self.dataArr.count];
    }else{
        [tableView tableViewDisplayWithMsg:@"" ifNecessaryForRowCount:self.dataArr.count];
    }
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"XMHSaleOrderCell";
    XMHSaleOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XMHSaleOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [cell resetCell];
    if (indexPath.row < self.dataArr.count) {
         SaleModel *model = [_dataArr safeObjectAtIndex:indexPath.row];
        [self refreshCell:cell model:model];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SaleModel *model = [self.dataArr safeObjectAtIndex:indexPath.row];
    if (_didSelectModel) {
        _didSelectModel(model);
    }
   
}
- (void)refreshCell:(XMHSaleOrderCell *)cell model:(SaleModel *)model
{
    if ([self.cardType isEqualToString:@"pro"]) {
        [cell refreshCellProModel:model];
    }else if ([self.cardType isEqualToString:@"goods"]){
        [cell refreshCellGoodsModel:model];
    }else if ([self.cardType isEqualToString:@"card_course"]){
        [cell refreshCellCardCourseModel:model];
    }else if ([self.cardType isEqualToString:@"card_num"]){
        [cell refreshCellCardNumModel:model];
    }else if ([self.cardType isEqualToString:@"card_time"]){
        [cell refreshCellCardTimeModel:model];
    }else if ([self.cardType isEqualToString:@"stored_card"]){
        [cell refreshCellStoredModel:model];
    }else if ([self.cardType isEqualToString:@"ticket"]){
        [cell refreshCellTicketModel:model];
    }else if ([self.cardType isEqualToString:@"skxk"]){
        [cell refreshCellSkxkModel:model];
    }
}

@end
