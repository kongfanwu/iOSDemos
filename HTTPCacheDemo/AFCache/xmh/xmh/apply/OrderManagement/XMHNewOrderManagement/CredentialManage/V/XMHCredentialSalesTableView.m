//
//  XMHCredentialSalesTableView.m
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentialSalesTableView.h"
#import "XMHCredentialSalesCell.h"

@implementation XMHCredentialSalesTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = UIView.new;
    }
    return self;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCredentialSalesCell *cell = [XMHCredentialSalesCell createCellWithTable:tableView];
    [cell configureWithModel:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model = _dataArray[indexPath.row];
    if ([self.adelegate respondsToSelector:@selector(tableView:didSelectModel:)]) {
        [self.adelegate tableView:self didSelectModel:model];
    }
}

@end
