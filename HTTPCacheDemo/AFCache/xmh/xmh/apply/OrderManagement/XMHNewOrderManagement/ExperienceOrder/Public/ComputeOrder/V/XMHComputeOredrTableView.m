//
//  XMHComputeOredrTableView.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHComputeOredrTableView.h"
#import "XMHComputeOredrModel.h"
#import "XMHComputeOrderAchievementModel.h"
#import "XMHComputeOrderCell.h"
#import "XMHComputeOrderAchievementCell.h"
#import "UITextView+XMHPlaceholder.h"

@interface XMHComputeOredrTableView() <UITableViewDelegate, UITableViewDataSource>
/** <##> */
@property (nonatomic, strong) UITextView *remarkTextView;
@end

@implementation XMHComputeOredrTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.remarkTextViewUserInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id model = _dataArray[section];
    if ([model isKindOfClass:[XMHComputeOredrModel class]]) {
        return 1;
    }
    else if ([model isKindOfClass:[XMHComputeOrderAchievementModel class]]) {
        if (_isYeJi) {
            return 1;
        } else {
            return 0;
        }
    }
    
//    if (section == 0) {
//        return 1;
//    } else if (section == 1) {
//        if (_isYeJi) {
//            return 1;
//        } else {
//            return 0;
//        }
//    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArray[indexPath.section];
    if ([model isKindOfClass:[XMHComputeOredrModel class]]) {
        XMHComputeOrderCell *cell = [XMHComputeOrderCell createCellWithTable:tableView];
        cell.createOrderType = _createOrderType;
        [cell configureWithModel:model];
        return cell;
    } else if ([model isKindOfClass:[XMHComputeOrderAchievementModel class]]) {
        XMHComputeOrderAchievementCell *cell = [XMHComputeOrderAchievementCell createCellWithTable:tableView];
        cell.createOrderType = _createOrderType;
        [cell configureWithModel:model];
        __weak typeof(self) _self = self;
        [cell setShuiShuBlock:^(NSInteger tag) {
            __strong typeof(_self) self = _self;
            if ([self.aDelegate respondsToSelector:@selector(guiShutableView:tag:)]) {
                [self.aDelegate guiShutableView:self tag:tag];
            }
        }];
        return cell;
    }
    return UITableViewCell.new;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id model = _dataArray[section];
    if ([model isKindOfClass:[XMHComputeOredrModel class]]) {
        return 54;
    }
    else if ([model isKindOfClass:[XMHComputeOrderAchievementModel class]]) {
        if (_isBuYeJi) {
            if (_isYeJi) {
                return 10;
            }
            return 68;
        } else {
            return 68;
        }
    }
    
//    if (section == 0) {
//        return 54;
//    } else if (section == 1) {
//        return 68;
//    }
    return 0;
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
    
    id model = _dataArray[section];
    if ([model isKindOfClass:[XMHComputeOredrModel class]]) {
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
        nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.selectUserModel.uname, [self.selectUserModel safeMobile]];
    }
    else if ([model isKindOfClass:[XMHComputeOrderAchievementModel class]]) {
        
        // 后置填写，不展示后置填写UI。
        if (_isYeJi && _isBuYeJi) {
            headerBGView.backgroundColor = kColorF5F5F5;
            return headerBGView;
        }
        
        headerView.frame = CGRectMake(0, 10, tableView.width, headerBGView.height - 20);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick:)];
        [headerView addGestureRecognizer:tap];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"后置填写";
        titleLabel.font = FONT_SIZE(15);
        titleLabel.textColor = kColor3;
        [headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(headerView);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.tag = 1000;
        arrowImageView.image = UIImageName(@"_st_tkshangjiantou"); // 上
        arrowImageView.highlightedImage = UIImageName(@"_st_tkxiajiantou"); // 下
        [headerView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 5.4));
            make.centerY.equalTo(headerView);
            make.left.equalTo(titleLabel.mas_right).offset(5);
        }];
        
        arrowImageView.highlighted = !_isYeJi;
    }
    return headerBGView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id model = _dataArray[section];
    if ([model isKindOfClass:[XMHComputeOrderAchievementModel class]]) {
        return 140;
    }
//    if (section == 1) {
//        return 140;
//    }
    return CGFLOAT_MIN;
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
        if (!_isYeJi && !_isBuYeJi) {
            make.top.mas_equalTo(0);
        } else {
            make.top.mas_equalTo(10);
        }
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
    _remarkTextView.layer.borderColor = kColorE.CGColor;
    _remarkTextView.font = FONT_SIZE(11);
    _remarkTextView.userInteractionEnabled = _remarkTextViewUserInteractionEnabled;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Event

- (void)headerViewClick:(UITapGestureRecognizer *)tap {
    _isYeJi = !_isYeJi;
    [self reloadData];
}

@end
