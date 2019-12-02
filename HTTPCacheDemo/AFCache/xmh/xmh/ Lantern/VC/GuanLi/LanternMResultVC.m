//
//  LanternMResultVC.m
//  xmh
//
//  Created by ald_ios on 2019/2/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMResultVC.h"
#import "LanternMResultCell.h"
#import "LanternMResultTbHeaderView.h"
#import "ShareWorkInstance.h"
#import "LanternRequest.h"
#import "UserManager.h"
#import "LanternMAlertView.h"
#import "LanternMFiltrateView.h"
#import "NSString+Costom.h"
#import "MzzStoreModel.h"
#import "LanternMFilterStaffAndCustomerView.h"
#import "UIScrollView+EmptyDataSet.h"
#import "XMHRefreshGifHeader.h"
@interface LanternMResultVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)LanternMResultTbHeaderView *tbHeaderView;
@property (nonatomic, strong)NSDictionary * resultDic;
@property (nonatomic, copy)NSString * searchName;
@property (nonatomic, strong)LanternMAlertView * alertView;
@property (nonatomic, strong)LanternMFiltrateView *filterView;
@property (nonatomic, strong)LanternMFilterStaffAndCustomerView * customerFilterView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation LanternMResultVC
{
    /** 加载更多 */
    BOOL _isMore;
    /** 页码 */
    NSInteger _page;
    /** 搜索条件 */
    
    /** 排序条件 */
    NSInteger _type;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 初始化数据 */
    _dataSource = [[NSMutableArray alloc] init];
    /** 默认非加载更多 */
    _isMore = NO;
    _page = 1;
    
    self.view.backgroundColor = kColorE;
    [self initSubViews];
    
    //    [self requestCustomerData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestSearchData];
}
- (void)initSubViews
{
    WeakSelf
    [self.view addSubview:self.tbView];
    [self.navView setNavViewTitle:@"智能检索" backBtnShow:YES rightBtnImage:@"shaixuan"];
    self.navView.NavViewRightBlock = ^{
        if (weakSelf.searchType == LanternSearchTypePro) {
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.filterView];
        }else if (weakSelf.searchType == LanternSearchTypeStaff){
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.customerFilterView];
        }else if (weakSelf.searchType == LanternSearchTypeCustomer){
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.customerFilterView];
        }
     
    };
    self.navView.backgroundColor = kColorTheme;
}
- (LanternMResultTbHeaderView *)tbHeaderView
{
    WeakSelf
    if (!_tbHeaderView) {
        _tbHeaderView = loadNibName(@"LanternMResultTbHeaderView");
        _tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
        _tbHeaderView.LanternMResultTbHeaderViewBlock = ^{
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.alertView];
        };
    }
    
    return _tbHeaderView;
}
- (LanternMFiltrateView *)filterView
{
    WeakSelf
    if (!_filterView) {
        _filterView = loadNibName(@"LanternMFiltrateView");
        _filterView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _filterView.dataSource = weakSelf.searchDataSource;
        _filterView.LanternMFiltrateViewSearchBlock = ^(NSString * _Nonnull text) {
            weakSelf.search_where = text;
            [weakSelf requestSearchData];
        };
        
//        _filterView.
    }
    return _filterView;
}
- (LanternMFilterStaffAndCustomerView *)customerFilterView
{
    WeakSelf
    if (!_customerFilterView) {
        _customerFilterView = loadNibName(@"LanternMFilterStaffAndCustomerView");
        _customerFilterView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _customerFilterView.resultDic = _paramDic;
        _customerFilterView.LanternMFilterStaffAndCustomerViewBlock = ^(NSString * _Nonnull text) {
            weakSelf.search_where = text;
            [weakSelf requestSearchData];
        };
        _customerFilterView.storeArr = _storeParamArr;
    }
    return _customerFilterView;
}
- (LanternMAlertView *)alertView
{
    WeakSelf
    if (!_alertView) {
        _alertView = loadNibName(@"LanternMAlertView");
        _alertView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _alertView.LanternMAlertViewSureBlock = ^(NSString * _Nonnull text) {
            weakSelf.searchName = text;
            [weakSelf requestSaveSearchCondition];
        };
    }
    return _alertView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.tableHeaderView = self.tbHeaderView;
        _tbView.layer.cornerRadius = 5;
        _tbView.layer.masksToBounds = YES;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        _tbView.emptyDataSetDelegate = self;
        _tbView.emptyDataSetSource =  self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestMoreData];
        }];
//        [_tbView.mj_header beginRefreshing];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
          [self refreshTbData];
           
        }];
    }
    return _gifHeader;
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestSearchData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestSearchData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"xmhdefault_zanwutishi"];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternMResultCell = @"kLanternMResultCell";
    LanternMResultCell * cell = [tableView dequeueReusableCellWithIdentifier:kLanternMResultCell];
    if (!cell) {
        cell =  loadNibName(@"LanternMResultCell");
    }
    [cell updateCellParam:_dataSource[indexPath.row] searchType:_searchType];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//        return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}
#pragma mark ------网络请求------

/** 开始检索 */
- (void)requestSearchData
{
    NSString * url = @"";
    if (_searchType == LanternSearchTypePro) {
        url = kLANTERN_MANAGE_SEARCHPRO_URL;
    }else if (_searchType == LanternSearchTypeStaff){
        url = kLANTERN_MANAGE_SEARCHSTAFF_URL;
    }else if (_searchType == LanternSearchTypeCustomer){
        url = kLANTERN_MANAGE_SEARCHCUSTOMER_URL;
    }else{}
    NSString * framid = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framid?framid:@"" forKey:@"fram_id"];
    [param setValue:_search_where?_search_where:@"" forKey:@"search_where"];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [param setValue:page ?page:@"1" forKey:@"page"];
    [LanternRequest requestCommonUrl:url Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            _resultDic = resultDic;
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            if ([resultDic[@"list"]count] == 0 ) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
            [_tbHeaderView updateViewParam:resultDic];
        }else{}
    }];
}
/** 保存项目检索条件 */
- (void)requestSavePro
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * where = @"";
    NSMutableString * history = [[NSMutableString alloc] init];
    NSString * haveIndex ;
    for (int i = 0; i< _searchDataSource.count; i++) {
        NSArray * tempArr = _searchDataSource[i][@"list"];
        NSString * str = @"";
        for (int j = 0; j< tempArr.count; j++) {
            NSMutableDictionary * tempDic = tempArr[j];
            if ([tempDic[@"select"]boolValue]) {
                str = tempDic[@"name"];
                haveIndex = [NSString stringWithFormat:@"%d",i];
            }
        }
        if (haveIndex.length > 0) {
            if (haveIndex.integerValue == 0) {
                [history appendString:@"销售业绩占比："];
                haveIndex = @"";
            }else if (haveIndex.integerValue ==1){
                [history appendString:@"成交人数占比："];
                haveIndex = @"";
            }else if (haveIndex.integerValue ==2){
                [history appendString:@"试做人数占比："];
                haveIndex = @"";
            }else if (haveIndex.integerValue ==3){
                [history appendString:@"普及率："];
                haveIndex = @"";
            }else if (haveIndex.integerValue ==4){
                [history appendString:@"复购率："];
                haveIndex = @"";
            }
        }
        [history appendString:str];
        if (str.length > 0) {
            [history appendString:@","];
        }
    }
    if (history.length > 1) {
        [history replaceCharactersInRange:NSMakeRange(history.length -1, 1) withString:@""];
    }
    NSMutableDictionary * whereDic = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < _searchDataSource.count; i ++) {
        NSMutableDictionary * tempDic = [[NSMutableDictionary alloc] init];
        [tempDic setValue:_searchDataSource[i][@"name"] forKey:@"name"];
        [tempDic setValue:_searchDataSource[i][@"list"] forKey:@"list"];
        NSMutableArray * tempArr = [[NSMutableArray alloc] init];
        [tempArr addObject:tempDic];
        [whereDic setValue:tempArr forKey:[NSString stringWithFormat:@"list%d",i + 1]];
    }
    where = whereDic.jsonData;
    
    NSString * zhanbi = [NSString stringWithFormat:@"人数：%@人",_resultDic[@"num"]?_resultDic[@"num"]:@""];
    NSString * num = [NSString stringWithFormat:@"占比：%@%@",_resultDic[@"zhanbi"]?_resultDic[@"zhanbi"]:@"",@"%"];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:@"3" forKey:@"type"];
    [param setValue:_searchName?_searchName:@"" forKey:@"name"];
    [param setValue:where?where:@"" forKey:@"where"];
    [param setValue:num forKey:@"num"];
    [param setValue:zhanbi forKey:@"bfb"];
    [param setValue:history?history:@"" forKey:@"history"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_SAVESEARCH_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            
        }else{}
    }];
    
}
/** 保存员工检索条件 */
- (void)requestSaveStaff
{
    NSDictionary * whereDic =  [_search_where dictionaryWithJsonString:_search_where];
    MzzLog(@"%@........dic",whereDic);
    NSMutableString * history = [[NSMutableString alloc] init];
    if ([whereDic.allKeys containsObject:@"start_time"]) {
        [history appendFormat:@"开始时间：%@", whereDic[@"start_time"]];
        [history appendString:@","];
    }
    if ([whereDic.allKeys containsObject:@"end_time"]) {
        [history appendFormat:@"结束时间：%@", whereDic[@"end_time"]];
        [history appendString:@","];
    }
    if ([whereDic.allKeys containsObject:@"store_code"]) {
        NSString * storeCode = whereDic[@"store_code"];
        if ([storeCode isEqualToString:@"all"]) {
            [history appendString:@"选择门店：全部门店"];
            [history appendString:@","];
        }else{
            NSArray * storeCodeArr = [storeCode componentsSeparatedByString:@","];
            for (int i = 0; i < storeCodeArr.count; i++) {
                NSString * code = storeCodeArr[i];
                for (int j = 0; j < _storeArr.count; j++) {
                    MzzStoreModel * tempModel = _storeArr[j];
                    if ([tempModel.store_code isEqualToString:code]) {
                        [history appendString:tempModel.store_name];
                        [history appendString:@","];
                    }
                }
            }
        }
    }
 

    for (int z = 0; z < _paramDic.allKeys.count; z++) {
        id  searchList = _paramDic[[NSString stringWithFormat:@"list%d",z]];
        if ([searchList isKindOfClass:[NSArray class]]) {
            NSMutableArray * tempArr = (NSMutableArray *)searchList;
            for (int i= 0; i< tempArr.count; i ++) {
                NSMutableDictionary * dic = tempArr[i];
                for (int j = 0 ; j < [dic[@"list"] count]; j ++) {
                    if ([dic[@"list"][j][@"select"] boolValue]) {
                        [history appendFormat:@"%@：%@",dic[@"name"] ,dic[@"list"][j][@"name"]];
                        [history appendString:@","];
                    }
                }
            }
        }
    }
    
    NSString * where = @"";
    where = _paramDic.jsonData;
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * zhanbi = [NSString stringWithFormat:@"人数：%@人",_resultDic[@"num"]?_resultDic[@"num"]:@""];
    NSString * num = [NSString stringWithFormat:@"占比：%@%@",_resultDic[@"zhanbi"]?_resultDic[@"zhanbi"]:@"",@"%"];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:@"1" forKey:@"type"];
    [param setValue:_searchName?_searchName:@"" forKey:@"name"];
    [param setValue:where?where:@"" forKey:@"where"];
    [param setValue:num forKey:@"num"];
    [param setValue:zhanbi forKey:@"bfb"];
    [param setValue:history?history:@"" forKey:@"history"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_SAVESEARCH_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            
        }else{}
    }];
}
/** 保存顾客检索条件 */
- (void)requestSaveCustomer
{
    NSDictionary * whereDic =  [_search_where dictionaryWithJsonString:_search_where];
    MzzLog(@"%@........dic",whereDic);
    NSMutableString * history = [[NSMutableString alloc] init];
    if ([whereDic.allKeys containsObject:@"start_time"]) {
        if ([whereDic[@"start_time"] length] > 0) {
            [history appendFormat:@"开始时间：%@", whereDic[@"start_time"]];
            [history appendString:@","];
        }
    }
    if ([whereDic.allKeys containsObject:@"end_time"]) {
        if ([whereDic[@"end_time"] length] > 0) {
            [history appendFormat:@"结束时间：%@", whereDic[@"end_time"]];
            [history appendString:@","];
        }
    }
    /** 展示的门店名字 */
    if ([whereDic.allKeys containsObject:@"store_code"]) {
        NSString * storeCode = whereDic[@"store_code"];
        if ([storeCode isEqualToString:@"all"]) {
            [history appendString:@"选择门店：全部"];
            [history appendString:@","];
        }else{
            [history appendString:@"选择门店："];
            NSArray * storeCodeArr = [storeCode componentsSeparatedByString:@","];
            for (int i = 0; i < storeCodeArr.count; i++) {
                NSString * code = storeCodeArr[i];
                for (int j = 0; j < _storeArr.count; j++) {
                    MzzStoreModel * tempModel = _storeArr[j];
                    if ([tempModel.store_code isEqualToString:code]) {
                        [history appendString:tempModel.store_name];
                        [history appendString:@","];
                    }
                }
            }
        }
    }
    /** 展示的技师名字 */
    if ([whereDic.allKeys containsObject:@"jis"]) {
        NSString * storeCode = whereDic[@"jis"];
        if ([storeCode isEqualToString:@"all"]) {
            [history appendString:@"选择技师：全部"];
            [history appendString:@","];
        }else{
            [history appendString:@"选择技师："];
            NSArray * storeCodeArr = [storeCode componentsSeparatedByString:@","];
            for (int i = 0; i < storeCodeArr.count; i++) {
                NSString * code = storeCodeArr[i];
                for (int j = 0; j < _jisParamArr.count; j++) {
                    MzzStoreModel * tempModel = _jisParamArr[j];
                    if ([tempModel.store_code isEqualToString:code]) {
                        [history appendString:tempModel.store_name];
                        [history appendString:@","];
                    }
                }
            }
        }
    }
    for (int z = 0; z < _paramDic.allKeys.count; z++) {
        id  searchList = _paramDic[[NSString stringWithFormat:@"list%d",z]];
        if ([searchList isKindOfClass:[NSArray class]]) {
            NSMutableArray * tempArr = (NSMutableArray *)searchList;
            for (int i= 0; i< tempArr.count; i ++) {
                NSMutableDictionary * dic = tempArr[i];
                for (int j = 0 ; j < [dic[@"list"] count]; j ++) {
                    if ([dic[@"list"][j][@"select"] boolValue]) {
                        [history appendFormat:@"%@：%@",dic[@"name"] ,dic[@"list"][j][@"name"]];
                        [history appendString:@","];
                    }
                }
            }
        }
    }
    
    
    
    NSString * where = @"";
    where = _paramDic.jsonData;
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * zhanbi = [NSString stringWithFormat:@"人数：%@人",_resultDic[@"num"]?_resultDic[@"num"]:@""];
    NSString * num = [NSString stringWithFormat:@"占比：%@%@",_resultDic[@"zhanbi"]?_resultDic[@"zhanbi"]:@"",@"%"];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:@"2" forKey:@"type"];
    [param setValue:_searchName?_searchName:@"" forKey:@"name"];
    [param setValue:where?where:@"" forKey:@"where"];
    [param setValue:num forKey:@"num"];
    [param setValue:zhanbi forKey:@"bfb"];
    [param setValue:history?history:@"" forKey:@"history"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_SAVESEARCH_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            
        }else{}
    }];
}
- (void)requestSaveSearchCondition
{
    if (_searchType == LanternSearchTypeCustomer) {
        [self requestSaveCustomer];
    }else if (_searchType == LanternSearchTypeStaff){
        [self requestSaveStaff];
    }else if (_searchType == LanternSearchTypePro){
        [self requestSavePro];
    }else{}
}
@end
