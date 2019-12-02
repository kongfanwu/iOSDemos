//
//  SearchCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SearchCell.h"
#import "JasonSearchView.h"
@interface SearchCell()<UISearchBarDelegate>



@end

@implementation SearchCell
- (IBAction)filterBtnOnclick:(UIButton *)sender {

    if (self.filter) {
        self.filter(sender);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //1. 设置背景颜色
    //设置背景图是为了去掉上下黑线
    _searchbar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    _searchbar.barTintColor = [UIColor whiteColor];
    UITextField *searchField = [_searchbar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        searchField.layer.cornerRadius = 7.0f;
        searchField.layer.borderWidth = 0.5;
        searchField.layer.masksToBounds = YES;
    }
    [_searchbar removeFromSuperview];
    //---------------------------
     JasonSearchView *searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 10, self.contentView.bounds.size.width - 60, self.contentView.bounds.size.height) withPlaceholder:@"搜索会员姓名或手机号"];
    searchView.line1.frame = CGRectMake(0, searchView.height, SCREEN_WIDTH, 1);
    searchView.searchBar.layer.cornerRadius = 5;
    searchView.searchBar.layer.masksToBounds = YES;
//    searchView.layer.cornerRadius = 5;
//    searchView.layer.masksToBounds = YES;
//    searchView.backgroundColor = [UIColor cyanColor];
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(15);
    [btn setTitleColor:kColor6 forState:UIControlStateNormal];
    btn.frame = CGRectMake(searchView.right - 10, 0, 60, 50);
//    btn.backgroundColor = [UIColor cyanColor];
    __weak JasonSearchView *weaksearchView = searchView;
    [searchView.searchBar setBtnRightBlock:^{
        if (self.search) {
            self.search(weaksearchView.searchBar.text);
        }
    }];
    [searchView.searchBar setBtnleftBlock:^{
        if (self.search) {
            weaksearchView.searchBar.text = @"";
            self.search(@"");
        }
    }];
    [self.contentView addSubview:searchView];
    [self.contentView addSubview:btn];
}
//点击return
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (self.search) {
        self.search(searchBar.text);
    }
}

//监听文字改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    if (self.search) {
//        self.search(searchText);
//    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
@end
