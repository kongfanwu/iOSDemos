//
//  XMHFilterTableView.m
//  xmh
//
//  Created by ald_ios on 2019/7/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHReportFilterTableView.h"
#import "XMHReportFilterCell.h"
#import "XMHReportFilterOrganizeListModel.h"
@interface XMHReportFilterTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation XMHReportFilterTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.clearColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 44;
    }
    return self;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 5;
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHReportFilterCell";
    XMHReportFilterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[XMHReportFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell updateCellModel:_dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHReportFilterOrganizeModel * organizeModel = _dataArray[indexPath.row];
    organizeModel.selected = !organizeModel.selected;
    [self reloadData];
}
#pragma mark - UITableView Delegate methods

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44;
//}

/** 全选 */
- (void)allCheck
{
    [_dataArray enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
        organizeModel.selected = YES;
    }];
    [self reloadData];
}
/** 全不选 */
- (void)allUnCheck
{
    [_dataArray enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
        organizeModel.selected = NO;
    }];
    [self reloadData];
}
/** 反选 */
- (void)allInvertiCheck
{
    [_dataArray enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
        organizeModel.selected = !organizeModel.selected;
    }];
    [self reloadData];
}
@end
