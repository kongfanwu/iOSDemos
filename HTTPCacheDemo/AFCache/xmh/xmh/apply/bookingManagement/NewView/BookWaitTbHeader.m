//
//  BookWaitTbHeader.m
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookWaitTbHeader.h"
#import "JasonSearchView.h"
@interface BookWaitTbHeader ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW;
/** <##> */
@property (nonatomic, strong) JasonSearchView * searchView;;
@end
@implementation BookWaitTbHeader
{
//    JasonSearchView * _searchView;
}
- (void)awakeFromNib
{
    WeakSelf
    [super awakeFromNib];
    _searchView = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (self.height - 39)/2, SCREEN_WIDTH - _btnW.constant - 15, 39) withPlaceholder:@"输入顾客姓名或手机号"];
    NSLog(@".........%@",NSStringFromCGRect(self.frame));
    _searchView.searchBar.layer.cornerRadius = 5;
    _searchView.line1.hidden = YES;
    [_searchView updateFrame];
    [self addSubview:_searchView];
    
    _searchView.searchBar.btnleftBlock = ^{
        
    };
    __block NSString * weakStr = @"";
    _searchView.searchBar.btnRightBlock = ^{
        weakStr = weakSelf.searchView.searchBar.text;
        if (weakSelf.BookWaitTbHeaderBlock) {
            weakSelf.BookWaitTbHeaderBlock(weakStr);
        }
    };
    
}
- (void)updateFram
{
    
    _left.constant = 0;
    _right.constant = 0;
    _top.constant = 0;
}
@end
