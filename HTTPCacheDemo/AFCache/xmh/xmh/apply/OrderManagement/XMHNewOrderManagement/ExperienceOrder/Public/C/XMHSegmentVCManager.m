//
//  XMHSegmentVCManager.m
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSegmentVCManager.h"
#import "XMHSegmentVCModel.h"
#import "XMHSegmentCell.h"
#import "UIViewController+XMHSegment.h"
#import "XMHOrderContentSearchView.h"

@implementation XMHSegmentVCManagerEmptyDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    XMHOrderContentSearchView *searchView = [[XMHOrderContentSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 53)];
    [self.view addSubview:searchView];
    
    self.defaultImageView = [[UIImageView alloc] initWithImage:UIImageName(@"ddglst_zanwutishi")];
    [self.view addSubview:_defaultImageView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _defaultImageView.frame = CGRectMake((SCREEN_WIDTH - 100 - 142) * 0.5, 110 + 53, 142, 157);
}

@end

CGFloat const kLeftViewWidth = 100;

@interface XMHSegmentVCManager () <UITableViewDelegate, UITableViewDataSource>
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
/** <##> */
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) XMHSegmentVCModel *currentItemModel;
@end

@implementation XMHSegmentVCManager

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = kLabelText_Commen_Color_F5;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 49;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(_tableView.right, 0, self.view.width - _tableView.width, self.view.height)];
    [self.view addSubview:_contentView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, kLeftViewWidth, self.view.height);
    _contentView.frame = CGRectMake(_tableView.right, 0, self.view.width - _tableView.width, self.view.height);
}

#pragma mark - Private

- (void)setDataArray:(NSMutableArray<XMHSegmentVCModel *> *)dataArray {
    _dataArray = dataArray;
    [_tableView reloadData];
    
    // 刷新后无数据，清空显示的内容
    if (!_dataArray.count) {
        self.currentItemModel = nil;
        [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        XMHSegmentVCModel *model = _dataArray[i];
        // 选择状态
        if (model.select) {
            // 是否存在子集
            if (model.childList.count) {
                [model.childList enumerateObjectsUsingBlock:^(XMHSegmentVCModel * _Nonnull childModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (childModel.select) {
                        [self showContentVCModel:childModel];
                        *stop = YES;
                    }
                }];
            } else {
                [self showContentVCModel:model];
            }
        }
    }
}

- (void)changeDataStateIndexPath:(NSIndexPath *)indexPath {
    [_dataArray enumerateObjectsUsingBlock:^(XMHSegmentVCModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.select = NO;
        [obj.childList enumerateObjectsUsingBlock:^(XMHSegmentVCModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.select = NO;
        }];
    }];
    
    XMHSegmentVCModel *model = [_dataArray safeObjectAtIndex:indexPath.section];//_dataArray[indexPath.section];
    XMHSegmentVCModel *cellModel = [model.childList safeObjectAtIndex:indexPath.row];//model.childList[indexPath.row];
    
    model.select = YES;
    cellModel.select = YES;
    [_tableView reloadData];
}

/**
 切换VC
 */
- (void)showContentVCModel:(XMHSegmentVCModel *)model {
    
    if (self.currentItemModel) {
        if ([self.currentItemModel.contentVC respondsToSelector:@selector(viewWillDisappear)]) {
            [self.currentItemModel.contentVC viewWillDisappear];
        }
    }
    
    [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    model.contentVC.view.frame = _contentView.bounds;
    [_contentView addSubview:model.contentVC.view];
    
    if ([model.contentVC respondsToSelector:@selector(viewWillAppear)]) {
        [model.contentVC viewWillAppear];
    }
    
    self.currentItemModel = model;
}

#pragma mark - Event

- (void)tableSectionHeaderClick:(UIControl *)control {
    NSInteger tag = control.tag - 1000;
    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:tag]];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XMHSegmentVCModel *model = _dataArray[section];
    if (model.select) {
        return model.childList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHSegmentVCModel *model = _dataArray[indexPath.section];
    XMHSegmentVCModel *cellModel = model.childList[indexPath.row];
    
    static NSString *cellIdentifier = @"Cell";
    XMHSegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[XMHSegmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell configModel:cellModel];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 49;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMHSegmentVCModel *model = _dataArray[section];
    
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIControl *headerView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, tableView.width, height)];
    headerView.tag = 1000 + section;
    [headerView addTarget:self action:@selector(tableSectionHeaderClick:) forControlEvents:UIControlEventTouchUpInside];
    if (model.select && model.edit) {
        headerView.backgroundColor = UIColor.whiteColor;
    } else {
        headerView.backgroundColor = kLabelText_Commen_Color_F5;
    }
    
    
    UIImageView *arrowImageView;
    if (model.childList.count) { //22 12
        arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.width - 10 - 5, (height - 5.4) / 2.f, 10, 5.4)];
        [headerView addSubview:arrowImageView];
        arrowImageView.image = UIImageName(@"_st_tkshangjiantou"); // 上
        arrowImageView.highlightedImage = UIImageName(@"_st_tkxiajiantou"); // 下
        arrowImageView.highlighted = !model.select;
    }
    
    UIView *lineView;
    if (model.select && model.edit) {
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (height - 16) / 2.f, 3, 16)];
        lineView.backgroundColor = kBtn_Commen_Color;
        [headerView addSubview:lineView];
    }
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = model.text;
    [headerView addSubview:textLabel];
    [textLabel sizeToFit];
    CGFloat textViewWidth = headerView.width - (model.select ? lineView.width : 0) - (model.childList.count ? arrowImageView.width : 0);
    // 内容超过最大宽，按照最大宽计算
    CGFloat contentWidth = textLabel.width > textViewWidth ? textViewWidth : textLabel.width;
    textLabel.left = (headerView.width - contentWidth) / 2.f;
    textLabel.top = (headerView.height - textLabel.height) / 2.f;
    
    if (model.select) {
        textLabel.font = FONT_SIZE(16);
        textLabel.textColor = kBtn_Commen_Color;
    } else {
        textLabel.font = FONT_SIZE(15);
        textLabel.textColor = kColor6;
    }
  
    // 不显示小红点
//    if (model.badge > 0) {
//        UILabel *badgeLabel = [[UILabel alloc] init];
//        badgeLabel.text = @(model.badge).stringValue;
//        badgeLabel.font = FONT_SIZE(10);
//        badgeLabel.textColor = UIColor.whiteColor;
//        badgeLabel.textAlignment = NSTextAlignmentCenter;
//        badgeLabel.backgroundColor = kBtn_Commen_Color;
//        [badgeLabel sizeToFit];
//        badgeLabel.layer.cornerRadius = badgeLabel.height / 2.f;
//        badgeLabel.layer.masksToBounds = YES;
//        [headerView addSubview:badgeLabel];
////        badgeLabel.left = textLabel.right;
////        badgeLabel.bottom = textLabel.top;
//        badgeLabel.top = 5;
//        badgeLabel.width = badgeLabel.width + 10;
//        badgeLabel.right = headerView.width - 5;
//    }
    
    UIView *bottonLineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.height - 0.6, headerView.width, 0.6)];
    bottonLineView.backgroundColor = kColorE5E5E5;
    [headerView addSubview:bottonLineView];
    // 不可编辑状态
    if (!model.edit) {
        textLabel.font = FONT_SIZE(15);
        textLabel.textColor =  kColor9;
        bottonLineView.backgroundColor = kLabelText_Commen_Color_F5;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return UIView.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHSegmentVCModel *model = [_dataArray safeObjectAtIndex:indexPath.section];// _dataArray[indexPath.section];
    XMHSegmentVCModel *cellModel;
    if (model.childList.count > indexPath.row) {
        cellModel =   [model.childList safeObjectAtIndex:indexPath.row];//model.childList[indexPath.row];
    }
    
    // 不可编辑状态
    if (!model.edit) return;
    
    [self changeDataStateIndexPath:indexPath];
    
    [self showContentVCModel:model.childList.count ? cellModel : model];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
