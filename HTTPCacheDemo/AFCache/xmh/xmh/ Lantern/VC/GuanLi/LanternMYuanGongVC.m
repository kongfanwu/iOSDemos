//
//  LanternMYuanGongVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMYuanGongVC.h"
#import "LanternMYuanGongCell.h"
#import "LanternMYuanGongTbSectionHeader.h"
#import "LanternRequest.h"
#import "LanternMResultVC.h"
#import "MzzCustomerRequest.h"
#import "LanternMSelectStoreView.h"
#import "MzzStoreModel.h"
#import "LSelectBaseModel.h"
#import "TJDatePickView.h"
#import "LanternMResultVC.h"
#define kCollectionViewSectionHeaderH 30
#define kCollectionViewCellH 30
#define kCollectionViewMargin 5
@interface LanternMYuanGongVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSArray * nameSource;
@property (nonatomic, assign)NSInteger selectSection;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, strong)NSMutableDictionary * resultDic;
@property (nonatomic, strong)LanternMSelectStoreView * storeView;
@property (nonatomic, strong)TJDatePickView * datePickView;
@property (nonatomic, strong)NSMutableArray * keySource;
@property (nonatomic, copy)NSString * startTime;
@property (nonatomic, copy)NSString * endTime;
@property (nonatomic, strong)NSMutableArray * selectStores;
@property (nonatomic, strong)NSMutableDictionary * param;
@property (nonatomic, strong)NSMutableArray * sectionDataSource;
/** 门店原始数据 */
@property (nonatomic, strong)NSMutableArray * sourceStoreData;
@property (nonatomic, assign)BOOL isFromHistory;
@property (nonatomic, assign)BOOL isFirst;
@property (nonatomic, assign)BOOL isFirstSearch;
@end

@implementation LanternMYuanGongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [ShareWorkInstance shareInstance].showW = 20;
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchTapNotice:) name:@"Search" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reset:) name:@"reset" object:nil];
    _dataSource = [[NSMutableArray alloc] init];
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"检索范围",@"selected":@"1"}];
    NSMutableDictionary * dic2 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"基础信息",@"selected":@"0"}];
    NSMutableDictionary * dic3 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"管理顾客",@"selected":@"0"}];
    NSMutableDictionary * dic4 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"顾客行为",@"selected":@"0"}];
    NSMutableDictionary * dic5 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"工作行为",@"selected":@"0"}];
    _sectionDataSource = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5, nil];
    _param = [[NSMutableDictionary alloc] init];
    _nameSource = @[@"检索范围",@"基础信息",@"管理顾客",@"顾客行为",@"工作行为"];
    _isFromHistory = NO;
    _isFirst = YES;
    _isFirstSearch = YES;
    [self initSubViews];
    [self requestSearchData];
    [self requestStoreData];
   
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _isFirst = YES;
    _isFirstSearch = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Search" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reset" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchTapNotice:) name:@"Search" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reset:) name:@"reset" object:nil];
     MzzLog(@"page............LanternMYuanGongVC");
}
- (void)setSearchID:(NSString *)searchID
{
     _searchID = searchID;
    _isFromHistory = YES;
    [self requestSearchData];
}
- (void)reset:(NSNotification *)not
{
//    if (_isFirst) {
        for (int i = 0; i < _sectionDataSource.count; i++) {
            NSMutableDictionary * param = _sectionDataSource[i];
            param[@"selected"] = @"0";
        }
        if ([not.object integerValue]== 0){
            [[[MzzHud alloc] initWithTitle:@"" message:@"是否清空选择内容" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
                if (index == 1) {
                    [self requestSearchData];
                    [self requestStoreData];
                }
            }]show];
        }
//        _isFirst = NO;
//    }
    
}
- (TJDatePickView *)datePickView
{
    WeakSelf
    if (!_datePickView) {
        _datePickView = [[TJDatePickView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds cornerRadius:10];
        _datePickView.TJDatePickView = ^(NSString *startTime, NSString *endTime) {
            weakSelf.startTime = startTime;
            weakSelf.endTime = endTime;
            [weakSelf organizeParam];
        };
    }
    return _datePickView;
}
- (void)searchTapNotice:(NSNotification *)not
{
//    if (_isFirstSearch) {
        if ([not.object integerValue]== 0) {
            NSMutableArray * tempArr3 = _resultDic[@"list3"];
            NSMutableArray * tempArr4 = _resultDic[@"list4"];
            BOOL customerBehavior = NO;
            BOOL workBehavior = NO;
            /** 判断是否选择了顾客行为里的条件 */
            for (int i = 0; i < tempArr3.count; i ++) {
                NSMutableDictionary * temp = tempArr3[i];
                for (int j = 0; j < [temp[@"list"] count]; j ++) {
                    if ([temp[@"list"][j][@"select"] boolValue]) {
                        customerBehavior = YES;
                    }
                }
            }
            /** 判断是否选择了工作行为里的条件 */
            for (int i = 0; i < tempArr4.count; i ++) {
                NSMutableDictionary * temp = tempArr4[i];
                for (int j = 0; j < [temp[@"list"] count]; j ++) {
                    if ([temp[@"list"][j][@"select"] boolValue]) {
                        workBehavior = YES;
                    }
                }
            }
            if (customerBehavior || workBehavior) {
                [[UIApplication sharedApplication].keyWindow addSubview:self.datePickView];
            }else{
                [self organizeParam];
            }
        }
//        _isFirstSearch = NO;
//    }
    
}
- (void)initSubViews
{
    [self.view addSubview:self.tbView];
}
- (LanternMSelectStoreView *)storeView
{
    WeakSelf
    if (!_storeView) {
        _storeView = loadNibName(@"LanternMSelectStoreView");
        _storeView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _storeView.LanternMSelectStoreViewBlock = ^(NSMutableArray * _Nonnull param) {
            weakSelf.selectStores = param;
        };
        _storeView.LanternMSelectStoreViewSearchBlock = ^(NSString * _Nonnull key) {
            [weakSelf filtrateStoreDataKey:key];
        };
    }
    return _storeView;
}
- (void)filtrateStoreDataKey:(NSString *)key
{
    if (key.length > 0) {
        NSMutableArray * filtrateStores = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < _sourceStoreData.count ; i++) {
            MzzStoreModel * model = _sourceStoreData[i];
            if ([model.store_name containsString:key]) {
                [filtrateStores addObject:model];
            }
        }
        [_storeView updateViewParam:filtrateStores];
    }else{
        [_storeView updateViewParam:_sourceStoreData];
    }
    
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 150 - 70 - 20) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.layer.cornerRadius = 5;
        _tbView.layer.masksToBounds = YES;
    }
    return _tbView;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * kLanternMYuanGongCell = @"kLanternMYuanGongCell";
    LanternMYuanGongCell * cell = [tableView dequeueReusableCellWithIdentifier:kLanternMYuanGongCell];
    if (!cell) {
        cell =  [[LanternMYuanGongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLanternMYuanGongCell];
    }
    [cell updateCellModule:@"员工检索"];
    cell.LanternMYuanGongCellBlock = ^(NSMutableDictionary *param){
        if ([param[@"name"]isEqualToString:@"所属门店"]) {
            [[UIApplication sharedApplication].keyWindow addSubview:self.storeView];
        }
    };
    if ([_sectionDataSource[indexPath.section][@"selected"] integerValue] == 1) {
        NSMutableArray * tempArr = _resultDic[[NSString stringWithFormat:@"list%ld",indexPath.section]];
        [cell updateCellParam:tempArr ];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_sectionDataSource[section][@"selected"] integerValue] == 1) {
        return 1;
    }else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WeakSelf
    LanternMYuanGongTbSectionHeader * header = loadNibName(@"LanternMYuanGongTbSectionHeader");
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, 50);
    [header updateViewParam:_sectionDataSource[section]];
    header.LanternMYuanGongTbSectionHeaderTapBlock = ^(NSMutableDictionary * _Nonnull param) {
        [_sectionDataSource replaceObjectAtIndex:[_sectionDataSource indexOfObject:param] withObject:param];
        for (int i = 0; i < _sectionDataSource.count; i++) {
            if (i != [_sectionDataSource indexOfObject:param]) {
                NSMutableDictionary * tempDic = _sectionDataSource[i];
                tempDic[@"selected"] = @"0";
            }
        }
        [weakSelf.tbView reloadData];
    };
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_sectionDataSource[indexPath.section][@"selected"] integerValue] == 1) {
        CGFloat cellHeight= 0.0;
        NSMutableArray * tempArr = _resultDic[[NSString stringWithFormat:@"list%ld",indexPath.section]];
        /** 几组数据 */
        cellHeight = cellHeight + tempArr.count * kCollectionViewSectionHeaderH;
        /** collectionView  cell高度 */
        NSInteger cellCount = 0;
        for (int i = 0; i < tempArr.count; i++) {
            NSDictionary * tempDic = tempArr[i];
            cellCount = [tempDic[@"list"] count];
            if (cellCount%4 ==0) {
                cellHeight = cellHeight + kCollectionViewCellH * (cellCount / 4) + (cellCount/4 + 1) * kCollectionViewMargin;
            }else{
                cellHeight = cellHeight +  kCollectionViewCellH * (cellCount /4 + 1) + (cellCount/4 + 2) * kCollectionViewMargin;
            }
        }
        _cellHeight = cellHeight;
        return cellHeight;
    }else{
        return 0;
    }
}
/** 获取员工检索条件 */
- (void)requestSearchData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (_searchID.length > 0) {
        [param setValue:_searchID?_searchID:@"" forKey:@"id"];
    }else{
        [param setValue:@"default" forKey:@"id"];
    }
    
    [param setValue:@"1" forKey:@"type"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_SEARCHRESULT_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _resultDic = [[NSMutableDictionary alloc] initWithDictionary:resultDic];
            if (_isFromHistory) {
                NSDictionary * dic = @{@"name":@"所属门店",@"list":@[],@"show":@"0"};
                [_resultDic setValue:@[dic] forKey:@"list0"];
            }else{
                NSDictionary * dic = @{@"name":@"所属门店",@"list":@[],@"show":@"1"};
                [_resultDic setValue:@[dic] forKey:@"list0"];
            }
            [_tbView reloadData];
        }else{}
    }];
}
/** 获取门店数据 */
- (void)requestStoreData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [MzzCustomerRequest requestStoreListParams:param resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            for ( int i = 0; i < listModel.list.count; i++) {
                MzzStoreModel * model = listModel.list[i];
                model.isSelect = YES;
            }
            MzzStoreModel * tempModel = [[MzzStoreModel alloc] init];
            tempModel.store_name = @"全部门店";
            tempModel.store_code = @"all";
            tempModel.isSelect = YES;
            NSMutableArray * tempArr = [[NSMutableArray alloc] initWithArray:listModel.list];
            [tempArr insertObject:tempModel atIndex:0];
            _sourceStoreData = tempArr;
            [self.storeView updateViewParam:tempArr];
        }else{}
    }];
}

/** 组织搜索条件 */
- (void)organizeParam
{
    if (_selectStores.count == 0) {
        _selectStores = _sourceStoreData;
    }
//    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSMutableString * storeCode = [[NSMutableString alloc] init];
    if ([_selectStores[0] isSelect]) {
        [storeCode appendString:@"all"];
        [storeCode appendString:@","];
    }else{
        for (int i = 1; i < _selectStores.count; i++) {
            MzzStoreModel * model = _selectStores[i];
            if (model.isSelect) {
                [storeCode appendString:model.store_code];
                [storeCode appendString:@","];
            }
        }
    }
    if (storeCode.length > 1) {
        if ([[storeCode substringWithRange:NSMakeRange(storeCode.length - 1, 1)]isEqualToString:@","]) {
            [storeCode replaceCharactersInRange:NSMakeRange(storeCode.length - 1, 1) withString:@""];
        }
    }
    
    [_param setValue:_startTime forKey:@"start_time"];
    [_param setValue:_endTime forKey:@"end_time"];
    [_param setValue:storeCode?storeCode:@"" forKey:@"store_code"];
//    [_param setValue:@"all" forKey:@"store_code"];
    
    [self keys:@[@"junior_time",@"age",@"grade",@"role_id"] source:_resultDic[@"list1"]];
    [self keys:@[@"baoyou",@"huodong",@"youxiao",@"xiumian",@"liushi",@"biaozhun"] source:_resultDic[@"list2"]];
    [self keys:@[@"popularzing_rate",@"kjxhdj",@"expend_pro_average",@"in_store"] source:_resultDic[@"list3"]];
    [self keys:@[@"sale",@"expend",@"rec_user_id",@"expend_pro",@"appo_user_id",@"pres"] source:_resultDic[@"list4"]];
    
    LanternMResultVC * resultVC = [[LanternMResultVC alloc] init];
    resultVC.searchType = LanternSearchTypeStaff;
    resultVC.search_where = _param.jsonData;
    resultVC.paramDic = _resultDic;
    resultVC.storeArr = _selectStores;
    resultVC.storeParamArr = _sourceStoreData;
    [self.navigationController pushViewController:resultVC animated:NO];
    
}
- (void)keys:(NSArray *)keys source:(NSMutableArray *)source
{
    NSArray * keylist1 = keys;
    
    NSMutableArray * list1 = source;
    for (int i = 0; i< keylist1.count; i ++) {
        NSMutableArray * customArr = [[NSMutableArray alloc] init];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        NSMutableArray * sysArr = [[NSMutableArray alloc] init];
        for (int j = 0; j < [list1[i][@"list"] count]; j++) {
            if ([list1[i][@"list"][j][@"select"] boolValue]) {
                if ([[list1[i][@"list"][j] allKeys] containsObject:@"custom"]) {
                    [customArr addObject:list1[i][@"list"][j][@"name"]];
                }else{
                    [sysArr addObject:@(j + 1)];
                }
                    
            }
            [dict setValue:customArr forKey:@"custom"];
            [dict setValue:sysArr forKey:@"sys"];
        }
        [_param setValue:dict forKey:keylist1[i]];
    }
    
}
@end
