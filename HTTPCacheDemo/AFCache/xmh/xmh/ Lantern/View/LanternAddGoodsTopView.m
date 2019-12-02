//
//  LanternAddGoodsTopView.m
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternAddGoodsTopView.h"
#import "JasonSearchView.h"
#import "LanternPlanInfoListModel.h"
@implementation LanternAddGoodsTopView
{
    UILabel * _lbName;
    JasonSearchView * _searchView;
    UILabel * _line;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    WeakSelf
    _lbName = [[UILabel alloc] init];
    _lbName.textColor = kColor6;
    _lbName.font = FONT_SIZE(15);
    _lbName.frame = CGRectMake(15, 15, SCREEN_WIDTH - 180, 15);
    _lbName.text = @"1999999";
    _lbName.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lbName];
    
    _searchView = [[JasonSearchView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 180, (self.height - 33)/2, 180, 33) withPlaceholder:@"请输入名称"];
    _searchView.searchBar.frame = CGRectMake(0, 0, _searchView.width, _searchView.height);
    _searchView.layer.cornerRadius = 17;
    _searchView.layer.masksToBounds = YES;
    __weak JasonSearchView * weakSearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        
        if (weakSelf.LanternAddGoodsTopViewSearchBlock) {
            weakSelf.LanternAddGoodsTopViewSearchBlock(weakSearchView.searchBar.text);
        }
    };
    [self addSubview:_searchView];
    
    _line = [[UILabel alloc] init];
    _line.backgroundColor = kColorE;
    _line.frame = CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1);
    [self addSubview:_line];
    
}
- (void)updateLanternAddGoodsTopViewModel:(LanternPlanInfoModel *)model
{
    NSString *secretPhone = @"";
    if (model.phone.length == 11) {
        secretPhone = [model.phone stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
    }
    _lbName.text = [NSString stringWithFormat:@"%@（%@）",model.name,secretPhone];
}
@end
