//
//  BookSearchCustomerVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookSearchCustomerVC.h"
/** 网路请求 */
#import "MzzCustomerRequest.h"
/** 通用 */
#import "JasonSearchView.h"
#import "ShareWorkInstance.h"
/** 自定义Cell */
#import "BookSearchCustomerCell.h"
/** 自定义View */
/** VC */
/** 模型 */
#import "CustomerListModel.h"
#import "UserManager.h"
#import "XMHRefreshGifHeader.h"
@interface BookSearchCustomerVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView * tbView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BookSearchCustomerVC
{
    NSString * _searchText;
    NSInteger _currentPage;
    NSMutableArray * _dataSource;
    JasonSearchView * _search;
    UIImageView * _imgV;
    UILabel * _notice;
    BOOL _isMore;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 0;
    _isMore = NO;
    _dataSource = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    CGFloat searchy = IS_IPHONE_X ? 40:27;
    CGFloat btny = IS_IPHONE_X ? 30:20;
    JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(40, searchy, SCREEN_WIDTH - 70 - 40, 30) withPlaceholder:@"请输入顾客的姓名或手机号"];
    search.searchBar.btnRightBlock = ^{
        _searchText = search.searchBar.text;
        [_dataSource removeAllObjects];
        [self requestCustomer];
    };
    search.searchBar.btnleftBlock = ^{
        _searchText = @"";
        [self requestCustomer];
    };
    search.searchBar.frame = CGRectMake(0, 0, search.width, search.height);
    search.layer.cornerRadius = 5;
    search.layer.masksToBounds = YES;
    _search = search;
    [self.navView addSubview:search];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitle:@"取消" forState:UIControlStateSelected];
    sureBtn.titleLabel.font = FONT_SIZE(15);
    sureBtn.frame = CGRectMake(search.right, btny, 70, 44);
    [sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:sureBtn];
    
    [self.view addSubview:self.tbView];
    
    UIImage * img = UIImageName(@"styygl_zaiwu");
    _imgV = [[UIImageView alloc] initWithImage:img];
    _imgV.frame = CGRectMake((SCREEN_WIDTH - img.size.width)/2, 200, img.size.width, img.size.height);
    _imgV.hidden = YES;
    [self.view addSubview:_imgV];
    
    _notice = [[UILabel alloc] init];
    _notice.font = FONT_SIZE(15);
    _notice.textColor = kLabelText_Commen_Color_9;
    _notice.text = @"暂无此顾客";
    [_notice sizeToFit];
    _notice.frame = CGRectMake((SCREEN_WIDTH - _notice.width)/2, _imgV.bottom + 18, _notice.width, _notice.height);
    _notice.hidden = YES;
    [self.view addSubview:_notice];
    
    
    
}
- (void)sureClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if ([btn.currentTitle isEqualToString:@"确定"]) {
        [_dataSource removeAllObjects];
        _searchText = _search.searchBar.text;
        [self requestCustomer];
    }
    if ([btn.currentTitle isEqualToString:@"取消"]) {
        _searchText = @"";
        _search.searchBar.text = @"";
    }
    [_search.searchBar resignFirstResponder];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.backgroundColor = [UIColor clearColor];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestMoreData];
        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshTbData];
            });
        }];
    }
    return _gifHeader;
}
- (void)requestMoreData
{
    _isMore = YES;
    _currentPage ++;
    [self requestCustomer];
}
- (void)refreshTbData
{
    _isMore = NO;
    _currentPage = 0;
    [self requestCustomer];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kSearchCustomerCell = @"kSearchCustomerCell";
    BookSearchCustomerCell * searchCustomerCell = [tableView dequeueReusableCellWithIdentifier:kSearchCustomerCell];
    if (!searchCustomerCell) {
        searchCustomerCell = loadNibName(@"BookSearchCustomerCell");
    }
    [searchCustomerCell updateBookSearchCustomerCellModel:_dataSource[indexPath.row]];
    return searchCustomerCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_BookSearchCustomerVCBlock) {
        _BookSearchCustomerVCBlock(_dataSource[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark ------网络请求------
- (void)requestCustomer
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    NSString * oneClick = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * page = [NSString stringWithFormat:@"%ld",_currentPage];
    
    [params setValue:oneClick?oneClick:@"" forKey:@"oneClick"];
    [params setValue:@"-1" forKey:@"twoListId"];
    [params setValue:account?account:@"" forKey:@"inId"];
    [params setValue:page?page:@"" forKey:@"page"];
    [params setValue:_searchText?_searchText:@"" forKey:@"q"];
    [MzzCustomerRequest requestBookCustomerListParams:params resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
                [_dataSource addObjectsFromArray:listModel.list];
                if (listModel.list.count == 0) {
                    _notice.hidden = NO;
                    _imgV.hidden = NO;
                    _tbView.hidden = YES;
                }else{
                    _notice.hidden = YES;
                    _imgV.hidden = YES;
                    _tbView.hidden = NO;
                }
            }else{
                [_dataSource addObjectsFromArray:listModel.list];
                if (listModel.list.count == 0) {
                    [_tbView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_tbView reloadData];
        }else{}
    }];
    
}
@end
