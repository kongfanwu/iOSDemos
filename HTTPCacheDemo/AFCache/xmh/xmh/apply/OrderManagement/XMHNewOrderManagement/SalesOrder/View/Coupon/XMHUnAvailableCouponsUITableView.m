//
//  XMHUnAvailableCouponsUITableView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUnAvailableCouponsUITableView.h"
#import "XMHCouponCell.h"
@interface XMHUnAvailableCouponsUITableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XMHUnAvailableCouponsUITableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyEnable = YES;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
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
    [cell updateCellModel:[self.dataArr safeObjectAtIndex:indexPath.row] cellType:1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
