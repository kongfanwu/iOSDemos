//
//  XMHFormTableView.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTableView.h"
#import "XMHFormSectionModel.h"
#import "XMHFormModel.h"
#import "XMHFormBaseCell.h"
#import "XMHFormCouponCell.h"
#import "XMHFormDefaultCell.h"
#import "XMHFormImageCell.h"
#import "XMHFormTextFieldCell.h"
#import "XMHFormTextView.h"
#import "XMHFormDateStartEndCell.h"
#import "XMHFormSelectCell.h"
#import "XMHFormDiscountCell.h"
#import "XMHFormContentFilledCell.h"

@interface XMHFormTableView() <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@end

@implementation XMHFormTableView

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XMHFormSectionModel *sectionModel = _dataArray[section];
    return sectionModel.sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHFormSectionModel *sectionModel = _dataArray[indexPath.section];
    XMHFormModel *model = sectionModel.sectionArray[indexPath.row];
    XMHFormBaseCell *cell;
    __weak typeof(self) _self = self;
    switch (model.type) {
        case XMHFormTypeCoupon:{
            cell = [XMHFormCouponCell createCellWithTable:tableView];
            cell.indexPath = indexPath;
            [((XMHFormCouponCell *)cell) setDidSelectBlock:^(XMHFormCouponCell *cell, XMHItemModel *itemMdoel){
                __strong typeof(_self) self = _self;
                if ([self.aDelegate respondsToSelector:@selector(didChangeCouponType:indexPath:)]) {
                    [self.aDelegate didChangeCouponType:itemMdoel indexPath:cell.indexPath];
                }
            }];
            break;
        }
        case XMHFormTypeDefault:{
            cell = [XMHFormDefaultCell createCellWithTable:tableView];
            break;
        }
        case XMHFormTypeInputTextField:{
            cell = [XMHFormTextFieldCell createCellWithTable:tableView];
            break;
        }
        case XMHFormTypeImage:{
            cell = [XMHFormImageCell createCellWithTable:tableView];
            [((XMHFormImageCell *)cell) setAddPhotoClick:^(XMHFormImageCell *acell){
                __strong typeof(_self) self = _self;
                if ([self.aDelegate respondsToSelector:@selector(addPhotoClick:)]) {
                    [self.aDelegate addPhotoClick:(XMHFormModel *)acell.model];
                }
            }];
            break;
        }
        case XMHFormTypeInputTextView:{
            cell = [XMHFormTextView createCellWithTable:tableView];
            break;
        }
        case XMHFormTypeDateStartEnd:{
            cell = [XMHFormDateStartEndCell createCellWithTable:tableView];
            break;
        }
        case XMHFormTypeSelect:
        case XMHFormTypeSelectNoEditContentFilled:{
            cell = [XMHFormSelectCell createCellWithTable:tableView];
            break;
        }
        case XMHFormTypeDiscount:{
            cell = [XMHFormDiscountCell createCellWithTable:tableView];
            break;
        }
        case XMHFormTypeContentFilled:{
            cell = [XMHFormContentFilledCell createCellWithTable:tableView];
            break;
        }
        default:
            break;
    }
    
    cell.indexPath = indexPath;
    if ((sectionModel.sectionArray.count - 1) == indexPath.row) {
        cell.isLastCell = YES;
    } else {
        cell.isLastCell = NO;
    }
    [cell configureWithModel:model];
    return cell ? cell : UITableViewCell.new;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    XMHFormSectionModel *sectionModel = _dataArray[section];
    
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = UIColor.whiteColor;
    [UIView addRadiusWithView:headerView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    
    UILabel *titleLabel = UILabel.new;
    titleLabel.font = FONT_SIZE(16);
    titleLabel.textColor = kColor3;
    titleLabel.text = sectionModel.title;
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForFooterInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = kBackgroundColor;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.aDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.aDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endEditing:YES];
}

@end
