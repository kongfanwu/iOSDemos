//
//  XMHAvailableCouponsTableView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHAvailableCouponsTableView.h"
#import "XMHCouponCell.h"
#import "SATicketListModel.h"
@interface XMHAvailableCouponsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XMHAvailableCouponsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyEnable = YES;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}
-(void)setModel:(SATicketModel *)model
{
    _model = model;
}
#pragma mark -- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * XMHCouponCellID = @"XMHCouponCell";
    XMHCouponCell * cell = [tableView dequeueReusableCellWithIdentifier:XMHCouponCellID];
    if (!cell) {
        cell = [[XMHCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XMHCouponCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    SATicketModel *model = [self.dataArr safeObjectAtIndex:indexPath.row];
    if (model.uid == self.model.uid) {
        model.selected = self.model.selected;
    }else{
        model.selected = NO;
    }
    WeakSelf
    cell.selectedDetail = ^(SATicketModel *model) {
        weakSelf.model = model;
        [weakSelf reloadData];
        if (_selectedCouponsModel) {
            _selectedCouponsModel(_model);
        }
    };
    [cell updateCellModel:model cellType:0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
