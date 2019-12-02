//
//  XMHServiceOrderListTableView.m
//  xmh
//
//  Created by KFW on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderListTableView.h"
#import "XMHServiceOrderListProjectGoodsCell.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"


@interface XMHServiceOrderListTableView() <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
/** <##> */
@property (nonatomic, strong) UITextField *timeTextField;
@end

@implementation XMHServiceOrderListTableView
- (void)dealloc
{
    NSLog(@"XMHServiceOrderListTableView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = kColorF5F5F5;
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return self;
}

- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    [self reloadData];
}

/**
 获取列表最大时长
 */
- (NSInteger)maxShiChang {
    NSInteger maxShiChang = 0;
    for (SLS_Pro *amodel in _modelArray) {
        if ([amodel respondsToSelector:@selector(shichang)]) {
            if (amodel.shichang > maxShiChang) {
                maxShiChang = amodel.shichang;
            }
        }
    }
    self.shiChang = @(maxShiChang).stringValue;
    return maxShiChang;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _modelArray[indexPath.row];
    XMHServiceOrderListProjectGoodsCell *cell = [XMHServiceOrderListProjectGoodsCell createCellWithTable:tableView];
    cell.indexPath = indexPath;
    [cell configureWithModel:model];
    
    __weak NSIndexPath *currentIndexPath = indexPath;
    __weak typeof(self) _self = self;
    [cell setDeleteBlock:^(XMHServiceOrderListProjectGoodsCell * _Nonnull cell) {
        __strong typeof(_self) self = _self;
        if ([self.adelegate respondsToSelector:@selector(deleteProjectGoodsTableView:indexPath:)]) {
            [self.adelegate deleteProjectGoodsTableView:self indexPath:currentIndexPath];
        }
    }];
    
    [cell setDeleteJiShiBlock:^(XMHServiceOrderListProjectGoodsCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        __strong typeof(_self) self = _self;
        [self reloadData];
    }];
    
    [cell setAddJiShiBlock:^(XMHServiceOrderListProjectGoodsCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        __strong typeof(_self) self = _self;
        if ([self.adelegate respondsToSelector:@selector(addJiShiTableView:indexPath:)]) {
            [self.adelegate addJiShiTableView:self indexPath:indexPath];
        }
    }];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 85;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = UIColor.whiteColor;
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:headerView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = headerView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    headerView.layer.mask = cornerRadiusLayer;
    
    UILabel *titleLabel = UILabel.new;
    titleLabel.font = FONT_SIZE(16);
    titleLabel.textColor = kColor3;
    titleLabel.text = @"商品服务清单";
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.equalTo(headerView);
    }];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setTitle:@"全部开始" forState:UIControlStateNormal];
    [startButton setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    startButton.titleLabel.font = FONT_SIZE(11);
    startButton.layer.borderWidth = 1;
    startButton.layer.borderColor = kBtn_Commen_Color.CGColor;
    startButton.layer.cornerRadius = 25 / 2.f;
    startButton.layer.masksToBounds = YES;
    [headerView addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 25));
        make.bottom.mas_equalTo(-12);
        make.right.mas_equalTo(-15);
    }];
    __weak typeof(self) _self = self;
    [startButton bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        if ([self.adelegate respondsToSelector:@selector(startServiceTableView:)]) {
            [self.adelegate startServiceTableView:self];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    startButton.hidden = _isServiceState;
    
    UILabel *timeLeftLabel = UILabel.new;
    timeLeftLabel.font = FONT_SIZE(14);
    timeLeftLabel.textColor = kColor3;
    timeLeftLabel.text = @"设置服务总时长";
    [headerView addSubview:timeLeftLabel];
    [timeLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    
    self.timeTextField = [[UITextField alloc] init];
    _timeTextField.layer.borderWidth = 0.5;
    _timeTextField.layer.borderColor = kColorE.CGColor;
    _timeTextField.textAlignment = NSTextAlignmentCenter;
    _timeTextField.font = FONT_SIZE(14);
    _timeTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _timeTextField.delegate = self;
    [headerView addSubview:_timeTextField];
    [_timeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLeftLabel.mas_right).offset(5);
        make.centerY.equalTo(timeLeftLabel);
        make.size.mas_equalTo(CGSizeMake(57, 19));
    }];
    _timeTextField.text = @([self maxShiChang]).stringValue;
    _timeTextField.userInteractionEnabled = !_isServiceState;
    
    UILabel *timeRightLabel = UILabel.new;
    timeRightLabel.font = FONT_SIZE(14);
    timeRightLabel.textColor = kColor3;
    timeRightLabel.text = @"分钟";
    [headerView addSubview:timeRightLabel];
    [timeRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeTextField.mas_right).offset(5);
        make.centerY.equalTo(timeLeftLabel);
    }];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headerView);
        make.height.mas_equalTo(kSeparatorHeight);
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForFooterInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = UIColor.whiteColor;
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:headerView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = headerView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    headerView.layer.mask = cornerRadiusLayer;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.shiChang = textField.text;
}

@end
