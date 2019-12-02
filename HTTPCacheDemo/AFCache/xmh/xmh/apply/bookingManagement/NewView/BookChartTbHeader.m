//
//  BookChartTbHeader.m
//  xmh
//
//  Created by ald_ios on 2019/3/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookChartTbHeader.h"
#import "JasonSearchView.h"
@interface BookChartTbHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *container;

@end
@implementation BookChartTbHeader
- (void)awakeFromNib
{
    WeakSelf
    [super awakeFromNib];
    _container.layer.cornerRadius = 5;
    _container.layer.masksToBounds = YES;
    JasonSearchView * searchView = [[JasonSearchView alloc] initWithFrame:_container.bounds withPlaceholder:@"搜索店铺"];
    searchView.layer.cornerRadius = 3;
    searchView.layer.masksToBounds = YES;
    searchView.searchBar.frame = searchView.bounds;
    __weak JasonSearchView * weakSearchView = searchView;
    searchView.searchBar.btnRightBlock = ^{
        if (weakSelf.BookChartTbHeaderSearchBlock) {
            weakSelf.BookChartTbHeaderSearchBlock(weakSearchView.searchBar.text);
        }
    };
    _container.userInteractionEnabled = YES;
    [_container addSubview:searchView];
}
@end
