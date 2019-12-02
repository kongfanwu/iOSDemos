//
//  XMHOrderSaleBuYeJiTableView.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderSaleBuYeJiTableView.h"
#import "SASaleListModel.h"
#import "CustomerListModel.h"
#import "XMHSaleOrderStatisticCell.h"
#import "XMHAwardStatisticCell.h"
#import "XMHSaleOrderYejiCell.h"
#import "SLSearchManagerModel.h"
#import "MLJishiSearchModel.h"
#import "XMHComputeOrderAchievementModel.h"
#import "UITextView+XMHPlaceholder.h"
#import "XMHAwardBuYeJiCell.h"

@interface XMHOrderSaleBuYeJiTableView() <UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
/** <##> */
@property (nonatomic, strong) UITextView *remarkTextView;
@property (nonatomic, assign) CGFloat section0CellH;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat section2CellHeight;
@property (nonatomic, assign) CGFloat awardCellH;

@end
@implementation XMHOrderSaleBuYeJiTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.saleData = [NSMutableArray array];
        
        _section2CellHeight = 228;
        _awardCellH = 87;
    }
    return self;
}
- (void)setComputeOrderAchievementModel:(XMHComputeOrderAchievementModel *)computeOrderAchievementModel
{
    _computeOrderAchievementModel = computeOrderAchievementModel;
    if (!_computeOrderAchievementModel.jiShiList.count) {
        _section2CellHeight = 228;
    }else{
        CGFloat h = _computeOrderAchievementModel.jiShiList.count * 30 + (_computeOrderAchievementModel.jiShiList.count - 1) *10;
        _section2CellHeight = 228 + h;
    }
    
}
- (void)setAwardData:(NSMutableArray<SaleModel *> *)awardData
{
    _awardData = awardData;
    _awardCellH =  87 + (_awardData.count * 14) + (_awardData.count - 1) * 5;
}
#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
       return 1;
       
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  [self getSection0CellHeight];
    }else if (indexPath.section == 1){
        return  self.awardCellH;
    }else if (indexPath.section == 2){
        return _section2CellHeight;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {// 结算统计
        XMHSaleOrderStatisticCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[XMHSaleOrderStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHSaleOrderStatisticCellID"];
        }
        cell.buYeji = self.buYeJi;
        [cell refresCellModelArr:_saleData];
        return cell;
    }else if (indexPath.section == 1){// 奖赠
        
        XMHAwardBuYeJiCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[XMHAwardBuYeJiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHAwardBuYeJiCell"];
        }
        [cell refresCellModelArr:_awardData];
        return cell;
        
    }else if (indexPath.section == 2){// 置后填写
        XMHSaleOrderYejiCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[XMHSaleOrderYejiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHSaleOrderYejiCell"];
        }
        __weak typeof(self) _self = self;
        [cell setShuiShuBlock:^(NSInteger tag) {
            __strong typeof(_self) self = _self;
            if ([self.aDelegate respondsToSelector:@selector(guiShutableView:tag:)]) {
                [self.aDelegate guiShutableView:self tag:tag];
            }
        }];
        cell.deleteJiShiBlock = ^(XMHComputeOrderAchievementModel * _Nonnull model, XMHSaleOrderYejiCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
            __strong typeof(_self) self = _self;
            self.computeOrderAchievementModel = model;
            [self reloadData];
        };
        [cell refresCellModel:self.computeOrderAchievementModel];
        return cell;
    }
    
    return UITableViewCell.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 54;
    }else if (section == 1 || section == 2){
        return 10;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    
    UIView *headerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerBGView.backgroundColor = [UIColor clearColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerBGView.height - 10)];
    headerView.backgroundColor = UIColor.whiteColor;
    headerView.layer.cornerRadius = 5;
    headerView.layer.masksToBounds = YES;
    [headerBGView addSubview:headerView];
    
    
    if (section == 0) {
        UILabel *customerInfoLabel = [[UILabel alloc] init];
        customerInfoLabel.text = @"顾客信息";
        customerInfoLabel.font = FONT_SIZE(15);
        customerInfoLabel.textColor = kLabelText_Commen_Color_6;
        [headerView addSubview:customerInfoLabel];
        [customerInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(headerView);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = FONT_SIZE(15);
        nameLabel.textColor = kLabelText_Commen_Color_6;
        nameLabel.textAlignment = NSTextAlignmentRight;
        [headerView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(headerView);
            make.left.equalTo(customerInfoLabel.mas_right);
        }];
        nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.selectUserModel.uname,[self.selectUserModel safeMobile]];
    }
    return headerBGView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        return 140;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForFooterInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = kColorF5F5F5;
    
    UIView *bgView = UIView.new;
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [headerView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(10);
        make.left.right.bottom.equalTo(headerView);
    }];
    
    UILabel *nameLabel = UILabel.new;
    nameLabel.font = FONT_SIZE(15);
    nameLabel.textColor = kColor3;
    nameLabel.text = @"备注信息";
    [bgView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.mas_equalTo(15);
    }];
    
    self.remarkTextView = [UITextView new];
    _remarkTextView.layer.borderWidth = 0.5;
    _remarkTextView.delegate = self;
    _remarkTextView.layer.borderColor = kColorE.CGColor;
    _remarkTextView.font = FONT_SIZE(11);
    _remarkTextView.userInteractionEnabled = NO;
    [bgView addSubview:_remarkTextView];
    [_remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(67);
    }];
    [_remarkTextView xmhAddPlaceholder:@"请输入需要让承接人知晓的信息，以此提高工作效率。"];
    if (!IsEmpty(_remarkText)) {
        _remarkTextView.text = _remarkText;
    }
    
    return headerView;
}
#pragma mark --cellHeight
- (CGFloat)getSection0CellHeight
{
    CGFloat itemH = 14;
    CGFloat cellH = 53;//20 + 18 + 15;
    // self.cellH =  self.cellH +( count *itemH)+ (count - 1)*10 + 44;
    CGFloat section0CellH = cellH + 34 + (itemH * (self.saleData.count - 2)) + (10 * (self.saleData.count - 1)) + 44 + 15;
    if (self.yingfuPrice) {
        section0CellH = section0CellH + 44;//逆向开单增加订单金额
    }
    return section0CellH;
}
#pragma mark -- UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_textViewContent) {
        _textViewContent(textView.text);
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"YINGFUJINERERNotification"];
}
#pragma mark - 业绩划分数据

@end
