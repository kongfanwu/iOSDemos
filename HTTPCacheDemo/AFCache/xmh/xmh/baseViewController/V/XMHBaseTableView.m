//
//  XMHBaseTableView.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBaseTableView.h"

@implementation XMHBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 44.f; // 只能设置 44.其他高度 DZNEmptyDataSet 会有位置不对影响
        self.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}


#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (!_emptyEnable) {
        return nil;
    }
    if (_tmptyImageName) {
        return [UIImage imageNamed:_tmptyImageName];
    }
    return [UIImage imageNamed:@"zanwushuju"];
}

/**
 设置默认图Y位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UITableView *)scrollView {
    // 如果存在 tableHeaderView tableFooterView
    CGFloat gap = 0;
    if ([scrollView isKindOfClass:[UITableView class]]) {
        gap += scrollView.tableHeaderView.height;
        gap += scrollView.tableFooterView.height;
    }
    return gap / 2.f;
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    if (!_emptyEnable) {
        return NO;
    }
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (_emptyDataDidTapView) _emptyDataDidTapView(self, view);
}

@end
