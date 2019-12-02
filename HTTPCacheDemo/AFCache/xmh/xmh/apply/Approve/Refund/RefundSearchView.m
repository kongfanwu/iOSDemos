//
//  RefundSearchView.m
//  xmh
//
//  Created by ald_ios on 2018/11/12.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundSearchView.h"
#import "JasonSearchView.h"
@implementation RefundSearchView
{
    JasonSearchView * _searchView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    WeakSelf
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _searchView = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, 15, frame.size.width - 30, frame.size.height - 30) withPlaceholder:@"请输入要查询的商品"];
        _searchView.searchBar.frame = CGRectMake(0, 0, _searchView.width, _searchView.height);
        _searchView.line1.hidden = YES;
        _searchView.layer.cornerRadius = 3;
        _searchView.layer.masksToBounds = YES;
        _searchView.searchBar.btnRightBlock = ^{
            [weakSelf back];
        };
        [self addSubview:_searchView];
    }
    return self;
}
- (void)back
{
    if (_RefundSearchViewBlock) {
        _RefundSearchViewBlock(_searchView.searchBar.text);
    }
}
@end
