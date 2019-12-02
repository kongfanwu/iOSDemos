//
//  LanternMCardView.m
//  xmh
//
//  Created by ald_ios on 2019/3/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMCardView.h"
#import "JasonSearchView.h"
#import "LanternMStoreCell.h"
#import "LanternMProSectionHeaderView.h"
@interface LanternMCardView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSMutableArray * searchSource;
@property (nonatomic, strong)NSMutableArray * searchResult;
@property (nonatomic, strong)JasonSearchView * search;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;
@property (nonatomic, assign)BOOL isSearch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopViewH;
@end

@implementation LanternMCardView
- (void)awakeFromNib
{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    _searchSource = [[NSMutableArray alloc] init];
    _searchResult = [[NSMutableArray alloc] init];
    
    _isSearch = NO;
    WeakSelf
    [super awakeFromNib];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, 10, _container.width - 15 - 55, 34) withPlaceholder:@"请输入卡项名称"];
    search.searchBar.frame = search.bounds;
    search.searchBar.btnRightBlock = ^{
         [weakSelf searchData];
    };
    _search = search;
    [_container addSubview:search];
    search.searchBar.layer.cornerRadius = 3;
    search.searchBar.layer.masksToBounds = YES;
    search.userInteractionEnabled = YES;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(15);
    [btn setTitleColor:kColor6 forState:UIControlStateNormal];
    btn.frame = CGRectMake(search.right, 0, 55, _container.height);
    btn.userInteractionEnabled = NO;
    [_container addSubview:btn];
    _TopViewH.constant = kSafeAreaTop + 44;
    
}
- (void)searchData
{
    if (_search.searchBar.text.length == 0) {
        _isSearch = NO;
       
    }else{
        _isSearch = YES;
        [_searchResult removeAllObjects];
        for (int i = 0; i < _searchSource.count; i++) {
            NSMutableDictionary * dic = _searchSource[i];
            NSString * name = dic[@"name"];
            if ([name containsString:_search.searchBar.text]) {
                [_searchResult addObject:dic];
            }
        }
    }
    [_tbView reloadData];
}
- (IBAction)cancel:(id)sender
{
    [self removeFromSuperview];
}
- (IBAction)sure:(id)sender
{
    if (_LanternMCardViewSureBlock) {
        _LanternMCardViewSureBlock(_dataSource);
    }
    [self removeFromSuperview];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternMStoreCell = @"kLanternMStoreCell";
    LanternMStoreCell * cell = [tableView dequeueReusableCellWithIdentifier:kLanternMStoreCell];
    if (!cell) {
        cell =  loadNibName(@"LanternMStoreCell");
    }
    if (_isSearch) {
        [cell updateCellParam:_searchResult[indexPath.row]];
    }else{
        [cell updateCellParam:_dataSource[indexPath.section][@"list"][indexPath.row]];
    }
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch) {
        return _searchResult.count;
    }
    return [_dataSource[section][@"list"] count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSearch) {
        NSMutableDictionary * tempDic = _searchResult[indexPath.row];
        if ([tempDic[@"select"] boolValue]) {
            tempDic[@"select"] = @(NO);
        }else{
            tempDic[@"select"] = @(YES);
        }
    }else{
        NSMutableDictionary * tempDic = _dataSource[indexPath.section][@"list"][indexPath.row];
        if ([tempDic[@"select"] boolValue]) {
            tempDic[@"select"] = @(NO);
        }else{
            tempDic[@"select"] = @(YES);
        }
    }
    [_tbView reloadData];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_isSearch) {
        return [[UIView alloc] init];
    }
    LanternMProSectionHeaderView * headerView = loadNibName(@"LanternMProSectionHeaderView");
    [headerView updateViewParam:_dataSource[section]];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearch) {
        return 1;
    }
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)updateViewParam:(NSMutableArray *)param
{
    _dataSource = param;
    for (int i = 0; i < _dataSource.count; i++) {
        NSArray * listArr = _dataSource[i][@"list"];
        for (int j = 0; j< listArr.count; j++) {
            [_searchSource addObject:listArr[j]];
        }
    }
    [_tbView reloadData];
}
@end
