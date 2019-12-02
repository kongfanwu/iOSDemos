//
//  ChoiseCustomerViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ChoiseCustomerViewController.h"
#import "choiseCustomerHeader.h"
#import "TheOneCustomerViewController.h"
#import "BeautyRequest.h"
#import "JasonSearchView.h"
#import "MzzCustomerRequest.h"
#import "CustomerListModel.h"
#import "ShareWorkInstance.h"
#import "BeautyCustomerCommonCell.h"
#import "UserManager.h"
#import "BeautyAskViewController.h"
#import "XMHRefreshGifHeader.h"
@interface ChoiseCustomerViewController ()<UITableViewDelegate,UITableViewDataSource>{
    __block UITableView *_tbView;
    choiseCustomerHeader *_tbHeaderView;
    BeautyRequest       *_guKeRequest;
    NSIndexPath         *_lastindexPath;
    JasonSearchView     *_searchView;
    CustomerListModel *_customerListModel;
    
    //数据源
    NSMutableArray  *_sourceArr;
    NSInteger   page;
    BOOL _firstRequest;
    NSString *_searchQ;
    
    UIView *header;
}
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation ChoiseCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _guKeRequest = [[BeautyRequest alloc]init];
    _sourceArr = [[NSMutableArray alloc]init];
    _searchQ = @"";
    [self creatNav];
    [self initSubviews];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"选择顾客" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubviews{
    
    _tbHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"choiseCustomerHeader" owner:nil options:nil] firstObject];
    _tbHeaderView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 110);
    [_tbHeaderView reFreshchoiseCustomerHeader:1];
    [self.view addSubview:_tbHeaderView];
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _tbHeaderView.bottom,SCREEN_WIDTH,Heigh_View_normal - _tbHeaderView.height) style:UITableViewStylePlain];
    _tbView.separatorColor = [UIColor clearColor];
    _tbView.backgroundColor = Color_NormalBG;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    
    WeakSelf;
    _tbView.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf refreshData];
//    }];
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
    [self refreshData];
}
- (XMHRefreshGifHeader *)gifHeader {
    WeakSelf
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf refreshData];
            });
        }];
    }
    return _gifHeader;
}
- (void)refreshData{
    page = 0;
    _firstRequest = YES;
    [self requestNetData];
}
- (void)requestNetData{
    //顾客列表
    
    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc]init];
    NSString *oneClick = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    [parmsDic setValue:@"-1" forKey:@"twoListId"];
    [parmsDic setValue:oneClick forKey:@"oneClick"];
    [parmsDic setValue:account forKey:@"inId"];
    
//    [parmsDic setValue:[ShareWorkInstance shareInstance].coneClick?[ShareWorkInstance shareInstance].coneClick:@"" forKey:@"oneClick"];
//    [parmsDic setValue:[ShareWorkInstance shareInstance].cinId?[ShareWorkInstance shareInstance].cinId:@"" forKey:@"inId"];
    [parmsDic setValue:[ShareWorkInstance shareInstance].join_code?[ShareWorkInstance shareInstance].join_code:@"" forKey:@"join_code"];
    [parmsDic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [parmsDic setValue:_searchQ forKey:@"q"];
    [MzzCustomerRequest requestCustomerListParams:parmsDic resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        _customerListModel = listModel;
        if (isSuccess) {
            if (_firstRequest) {
                [_sourceArr removeAllObjects];
                [_sourceArr addObjectsFromArray:_customerListModel.list];
                [_tbView reloadData];
            }else{
                if (_customerListModel.list.count == 0) {
                    page--;
                }else{
                    [_sourceArr addObjectsFromArray:_customerListModel.list];
                    [_tbView reloadData];
                }
            }
//            [_orginsourceArr addObjectsFromArray:_customerListModel.list];
            
        }else{
            if (!_firstRequest) {
                page--;
            }
        }
        [self endRefreshing];
    }];
}
- (void)requestMoreNetData{
    page++;
    _firstRequest = NO;
    [self requestNetData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBeautyCustomerCommonCell = @"kBeautyCustomerCommonCell";
    BeautyCustomerCommonCell * customerCell = [tableView dequeueReusableCellWithIdentifier:kBeautyCustomerCommonCell];
    if (!customerCell) {
        customerCell = loadNibName(@"BeautyCustomerCommonCell");
    }
    [customerCell updateBeautyCustomerCommonCellModel:_sourceArr[indexPath.row]];
    return customerCell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!header) {
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 63)];
        header.backgroundColor = [UIColor whiteColor];
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH- 60, 39)withPlaceholder:@"输入顾客姓名或手机号"];
        _searchView.layer.cornerRadius = 3;
        _searchView.layer.masksToBounds = YES;
        UILabel * lb = [[UILabel alloc] init];
        lb.text = @"搜索";
        lb.font = FONT_SIZE(15);
        lb.textColor = kLabelText_Commen_Color_6;
        lb.frame = CGRectMake(_searchView.right, 0, 60, 63);
        lb.textAlignment = NSTextAlignmentCenter;
        [header addSubview:_searchView];
        [header addSubview:lb];
    }
    _searchView.line1.hidden = YES;
    WeakSelf;
    __block JasonSearchView    *tempsearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        _searchQ = tempsearchView.searchBar.text;
        [weakSelf refreshData];
    };
    _searchView.searchBar.btnleftBlock = ^{
        _searchQ = @"";
        [weakSelf refreshData];
    };
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
    line.backgroundColor = RGBColor(235, 235, 235);
    [header addSubview:line];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSMutableArray *temparr = [NSMutableArray arrayWithArray:_sourceArr];
//    NSInteger i = 0;
//    for (CustomerModel *info in temparr) {
//        if (info.seleted) {
//            CustomerModel *tempinfo = _sourceArr[i];
//            tempinfo.seleted = NO;
//        }
//        i++;
//    }
    CustomerModel *info = _sourceArr[indexPath.row];
//    info.seleted = YES;
//    if (_lastindexPath) {
//        [_tbView reloadRowsAtIndexPaths:[NSArray arrayWithObject:_lastindexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//    [_tbView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    _lastindexPath = indexPath;
//    [_tbView scrollToRowAtIndexPath:_lastindexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    TheOneCustomerViewController *vc = [[TheOneCustomerViewController alloc]init];
    vc.from = 1;
    vc.uid = [NSString stringWithFormat:@"%@",@(info.uid)];
    vc.join_code = info.join_code;
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
