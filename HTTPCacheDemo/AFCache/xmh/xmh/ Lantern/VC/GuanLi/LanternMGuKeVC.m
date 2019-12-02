//
//  LanternMGuKeVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMGuKeVC.h"
#import "LanternMYuanGongCell.h"
#import "LanternMYuanGongTbSectionHeader.h"
#import "LanternRequest.h"
#import "LanternMResultVC.h"
#import "LanternMSelectStoreView.h"
#import "MzzCustomerRequest.h"
#import "MzzStoreModel.h"
#import "LSelectBaseModel.h"
#import "ShareWorkInstance.h"
#import "TJDatePickView.h"
#import "LanternMCardView.h"
#define kCollectionViewSectionHeaderH 30
#define kCollectionViewCellH 30
#define kCollectionViewMargin 5
@interface LanternMGuKeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSArray * nameSource;
@property (nonatomic, assign)NSInteger selectSection;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, strong)NSMutableDictionary * resultDic;
@property (nonatomic, strong)NSMutableDictionary * gradeDic;
@property (nonatomic, strong)LanternMSelectStoreView * storeView;
@property (nonatomic, strong)LanternMSelectStoreView * selectJisView;
@property (nonatomic, strong)NSMutableArray * sectionDataSource;
@property (nonatomic, strong)NSMutableArray * selectStores;
@property (nonatomic, strong)NSMutableArray * selectJisArr;
@property (nonatomic, strong)NSMutableDictionary * param;
@property (nonatomic, strong)TJDatePickView * datePickView;
@property (nonatomic, copy)NSString * startTime;
@property (nonatomic, copy)NSString * endTime;
@property (nonatomic, strong)LanternMCardView * cardView;
@property (nonatomic, strong)NSMutableArray * proArr;
@property (nonatomic, assign)BOOL isFromHistory;

/** 门店原始数据 */
@property (nonatomic, strong)NSMutableArray * sourceStoreData;
/** 技师原始数据 */
@property (nonatomic, strong)NSMutableArray * sourceJisData;
@end

@implementation LanternMGuKeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [ShareWorkInstance shareInstance].showW = 20;
    _dataSource = [[NSMutableArray alloc] init];
    _nameSource = @[@"检索范围",@"基础信息",@"管理信息",@"顾客行为"];
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"检索范围",@"selected":@"1"}];
    NSMutableDictionary * dic2 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"基础信息",@"selected":@"0"}];
    NSMutableDictionary * dic3 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"管理顾客",@"selected":@"0"}];
    NSMutableDictionary * dic4 = [[NSMutableDictionary alloc] initWithDictionary:@{@"name":@"顾客行为",@"selected":@"0"}];
    _sectionDataSource = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4, nil];
    _param = [[NSMutableDictionary alloc] init];
    [self initSubViews];
    [self requestSearchData];
    [self requestStoreData];
//    [self requestJisData];
    [self requestProData];
    _isFromHistory = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Search" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reset" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchTapNotice:) name:@"Search" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reset:) name:@"reset" object:nil];
    MzzLog(@"page............LanternMGuKeVC");
}
- (void)setSearchID:(NSString *)searchID
{
    _searchID = searchID;
    _isFromHistory = YES;
    [self requestSearchData];
}
- (void)reset:(NSNotification *)not
{
    if ([not.object integerValue]== 1){
        [[[MzzHud alloc] initWithTitle:@"" message:@"是否清空选择内容" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
            if (index == 1) {
                [self requestSearchData];
                [self requestStoreData];
            }
        }]show];
    }
}
- (void)searchTapNotice:(NSNotification *)not
{
    if ([not.object integerValue]== 1) {
        NSMutableArray * tempArr3 = _resultDic[@"list3"];
//        NSMutableArray * tempArr4 = _resultDic[@"list4"];
        BOOL customerBehavior = NO;
//        BOOL workBehavior = NO;
        /** 判断是否选择了顾客行为里的条件 */
        for (int i = 0; i < tempArr3.count; i ++) {
            NSMutableDictionary * temp = tempArr3[i];
            for (int j = 0; j < [temp[@"list"] count]; j ++) {
                if ([temp[@"list"][j][@"select"] boolValue]) {
                    customerBehavior = YES;
                }
            }
        }
//        /** 判断是否选择了工作行为里的条件 */
//        for (int i = 0; i < tempArr4.count; i ++) {
//            NSMutableDictionary * temp = tempArr3[i];
//            for (int j = 0; j < [temp[@"list"] count]; j ++) {
//                if ([temp[@"list"][j][@"select"] boolValue]) {
//                    workBehavior = YES;
//                }
//            }
//        }
        if (customerBehavior) {
            [[UIApplication sharedApplication].keyWindow addSubview:self.datePickView];
        }else{
            [self organizeParam];
        }
    }
}
- (LanternMCardView *)cardView
{
    WeakSelf
    if (!_cardView) {
        _cardView = loadNibName(@"LanternMCardView");
        _cardView.frame = CGRectMake(0, Heigh_StatusBar, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_StatusBar);
        _cardView.LanternMCardViewSureBlock = ^(NSMutableArray * _Nonnull param) {
            weakSelf.proArr = param;
        };
    }
    return _cardView;
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
- (LanternMSelectStoreView *)selectJisView
{
    WeakSelf
    if (!_selectJisView) {
        _selectJisView = loadNibName(@"LanternMSelectStoreView");
         [_selectJisView updateSelectViewPlaceHolder:@"请输入技师姓名或手机号"];
        _selectJisView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _selectJisView.LanternMSelectStoreViewBlock = ^(NSMutableArray * _Nonnull param) {
            weakSelf.selectJisArr = param;
        };
        _selectJisView.LanternMSelectStoreViewSearchBlock = ^(NSString * _Nonnull key) {
            [weakSelf filtrateJisDataKey:key];
        };
    }
    return _selectJisView;
}
- (LanternMSelectStoreView *)storeView
{
    WeakSelf
    if (!_storeView) {
        _storeView = loadNibName(@"LanternMSelectStoreView");
        [_storeView updateSelectViewPlaceHolder:@"请输入门店名称"];
        _storeView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _storeView.LanternMSelectStoreViewBlock = ^(NSMutableArray * _Nonnull param) {
            weakSelf.selectStores = param;
            [weakSelf requestJisData];
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
- (void)filtrateJisDataKey:(NSString *)key
{
    if (key.length > 0) {
        NSMutableArray * filtrateJis = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < _sourceJisData.count ; i++) {
            MzzStoreModel * model = _sourceJisData[i];
            if ([model.store_name containsString:key]) {
                [filtrateJis addObject:model];
            }
        }
        [_selectJisView updateViewParam:filtrateJis];
    }else{
        [_selectJisView updateViewParam:_sourceJisData];
    }
}
- (void)initSubViews
{
    [self.view addSubview:self.tbView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH- 20, SCREEN_HEIGHT - 150 - 70 - 20) style:UITableViewStylePlain];
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
    
    cell.LanternMYuanGongCellBlock = ^(NSMutableDictionary *param){
        if ([param[@"name"]isEqualToString:@"所属门店"]) {
            [[UIApplication sharedApplication].keyWindow addSubview:self.storeView];
        }else if ([param[@"name"]isEqualToString:@"所属技师"]){
            [[UIApplication sharedApplication].keyWindow addSubview:self.selectJisView];
            
        }else if ([param[@"name"]isEqualToString:@"顾客卡项"]){
            [[UIApplication sharedApplication].keyWindow addSubview:self.cardView];
        }else{}
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
    return _sectionDataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_sectionDataSource[indexPath.section][@"selected"] integerValue] == 1) {
        NSMutableArray * tempArr = _resultDic[[NSString stringWithFormat:@"list%ld",indexPath.section]];
        if (!tempArr || tempArr.count ==0) {
            return 0;
        }
        return [LanternMYuanGongCell cellHeight:tempArr count:4.0];
       
    }else{
        return 0;
    }
}
/** 组织搜索条件 */
- (void)organizeParam
{
//    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 门店编码 */
    if (_selectStores.count == 0) {
        _selectStores = _sourceStoreData;
    }
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
    
    /** 技师 account */
    if (_selectJisArr.count == 0) {
        _selectJisArr = _sourceJisData;
    }
    NSMutableString * jisStr = [[NSMutableString alloc] init];
    if ([_selectJisArr[0] isSelect]) {
        [jisStr appendString:@"all"];
        [jisStr appendString:@","];
    }else{
        for (int i = 0; i < _selectJisArr.count; i++) {
            MzzStoreModel * model = _selectJisArr[i];
            if (model.isSelect) {
                [jisStr appendString:model.store_code];
                [jisStr appendString:@","];
            }
        }
    }
  
    if (jisStr.length > 1) {
        if ([[jisStr substringWithRange:NSMakeRange(jisStr.length - 1, 1)]isEqualToString:@","]) {
            [jisStr replaceCharactersInRange:NSMakeRange(jisStr.length - 1, 1) withString:@""];
        }
    }
    
    
    [_param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [_param setValue:_endTime?_endTime:@"" forKey:@"end_time"];
    [_param setValue:storeCode?storeCode:@"" forKey:@"store_code"];
    [_param setValue:jisStr?jisStr:@"" forKey:@"jis"];
    /** 组织基础信息 */
    
    [self keys:@[@"create_time",@"age",@"bir_month"] source:_resultDic[@"list1"]];
    
    
    /** 顾客等级 */
    NSMutableDictionary * gradeDic = [[NSMutableDictionary alloc] init];
    NSMutableArray * gradesys = [[NSMutableArray alloc] init];
    NSMutableArray * gradecustom = [[NSMutableArray alloc] init];
    for (int i = 0; i <[_resultDic[@"list1"][3][@"list"]count] ; i ++) {
        NSMutableDictionary * dic = _resultDic[@"list1"][3][@"list"][i];
        if ([dic[@"select"] boolValue]) {
            [gradesys addObject:[NSString stringWithFormat:@"%@",dic[@"id"]]];
        }
    }
    [gradeDic setValue:gradesys forKey:@"sys"];
    [gradeDic setValue:gradecustom forKey:@"custom"];
    [_param setValue:gradeDic forKey:@"grade"];
    /** 组织管理顾客 */
    NSMutableArray * list2 = _resultDic[@"list2"];
    /** 顾客类型 */
    NSString * user_type = @"";
    NSMutableArray * sublist1 = list2[0][@"list"];
    NSMutableDictionary * userTypeDic = [[NSMutableDictionary alloc] init];
    NSMutableArray * userTypeSys = [[NSMutableArray alloc] init];
    NSMutableArray * userTypeCus = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < sublist1.count; i++) {
        NSMutableDictionary * tempDic = sublist1[i];
        if ([tempDic[@"select"] boolValue]) {
            user_type = [NSString stringWithFormat:@"%d",i + 1];
            [userTypeSys addObject:user_type];
        }
        
    }
    [userTypeDic setValue:userTypeSys forKey:@"sys"];
    [userTypeDic setValue:userTypeCus forKey:@"custom"];
    [_param setValue:userTypeDic?userTypeDic:@"" forKey:@"user_type"];
    /** 顾客标签 */
//    NSString * label = @"";
    NSMutableArray * sysArr = [[NSMutableArray alloc] init];
//    NSMutableArray * customerArr = [[NSMutableArray alloc] init];
    NSMutableDictionary * labDic = [[NSMutableDictionary alloc] init];
    NSMutableArray * sublist2 = list2[1][@"list"];
    for (int i = 0; i < sublist2.count; i++) {
        NSMutableDictionary * tempDic = sublist2[i];
        if ([tempDic[@"select"] boolValue]) {
            
            [sysArr addObject:[NSString stringWithFormat:@"%@",tempDic[@"id"]]];
        }
        [labDic setValue:sysArr forKey:@"sys"];
    }
    [_param setValue:labDic?labDic:@"" forKey:@"label"];
    
    /** 顾客行为 */
    
    [self keys:@[@"xiaohaodanjia",@"xiaohaoxianmushu",@"yuedaodianpinci",@"xiaofeipinci",@"xiaofeijine",@"xiaohaojine",@"fuzhaijine"] source:_resultDic[@"list3"]];
    
    /** 顾客卡项 */
    NSMutableArray * cardCommitArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _proArr.count; i ++) {
        NSMutableDictionary * tempDic = _proArr[i];
        NSMutableDictionary * commitDic = [[NSMutableDictionary alloc] init];
        NSMutableArray * list = [[NSMutableArray alloc] init];
        for (int j = 0; j < [tempDic[@"list"] count]; j++) {
            NSMutableDictionary * d = tempDic[@"list"][j];
            if ([d[@"select"] boolValue]) {
                [list addObject:d];
            }
        }
        [commitDic setValue:list forKey:@"list"];
        [commitDic setValue:tempDic[@"name"] forKey:@"name"];
        [commitDic setValue:tempDic[@"type"] forKey:@"type"];
        [cardCommitArr addObject:commitDic];
    }
    [_param setValue:cardCommitArr forKey:@"card_pro"];
    
    LanternMResultVC * resultVC = [[LanternMResultVC alloc] init];
    resultVC.searchType = LanternSearchTypeCustomer;
    resultVC.search_where = _param.jsonData;
    resultVC.paramDic = _resultDic;
    resultVC.storeArr = _selectStores;
    resultVC.jisParamArr = _selectJisArr;
    
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
                [sysArr addObject:@(j + 1)];
                if ([[list1[i][@"list"][j] allKeys] containsObject:@"custom"]) {
                    [customArr addObject:list1[i][@"list"][j][@"name"]];
                }
            }
            [dict setValue:customArr forKey:@"custom"];
            if (customArr.count > 0) {
                [sysArr removeAllObjects];
                [dict setValue:sysArr forKey:@"sys"];
            }else{
                [dict setValue:sysArr forKey:@"sys"];
            }
        }
        [_param setValue:dict forKey:keylist1[i]];
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
    [param setValue:@"2" forKey:@"type"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_SEARCHRESULT_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _resultDic = [[NSMutableDictionary alloc] initWithDictionary:resultDic];
            if (_isFromHistory) {
                NSDictionary * dic = @{@"name":@"所属门店",@"list":@[],@"show":@"0"};
                NSDictionary * dic1 = @{@"name":@"所属技师",@"list":@[],@"show":@"0"};
                [_resultDic setValue:@[dic,dic1] forKey:@"list0"];
            }else{
                NSDictionary * dic = @{@"name":@"所属门店",@"list":@[],@"show":@"1"};
                NSDictionary * dic1 = @{@"name":@"所属技师",@"list":@[],@"show":@"1"};
                [_resultDic setValue:@[dic,dic1] forKey:@"list0"];
            }
            
            NSMutableDictionary * card = [[NSMutableDictionary alloc] init];
            [card setValue:@"顾客卡项" forKey:@"name"];
            [card setObject:@"1" forKey:@"show"];
            [card setValue:@[] forKey:@"list"];
            NSMutableArray * list2 = _resultDic[@"list2"];
            [list2 addObject:card];
            [self requestGradeData];
        }else{}
    }];
}
/** 获取顾客等级和标签 */
- (void)requestGradeData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_CUSTOMERGRADE_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _gradeDic = [[NSMutableDictionary alloc] initWithDictionary:resultDic];;
            for (int i = 0; i < [_gradeDic[@"grade_list"] count]; i++) {
                NSMutableDictionary * param = _gradeDic[@"grade_list"][i];
                [param setValue:@"NO" forKey:@"select"];
            }
            [self organizeJson];
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
            [self requestJisData];
        }else{}
    }];
}
/** 获取技师数据 */
- (void)requestJisData
{
    if (_selectStores.count == 0) {
        _selectStores = _sourceStoreData;
    }
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    /** 门店全选时传framID  手动选择时门店编码拼接字符串 */
    NSMutableString * storeCode = [[NSMutableString alloc] init];
    if ([_selectStores[0] isSelect]) {
       [param setValue:framId?framId:@"" forKey:@"fram_id"];
    }else{
        for (int i = 1; i < _selectStores.count; i++) {
            MzzStoreModel * model = _selectStores[i];
            if (model.isSelect) {
                [storeCode appendString:model.store_code];
                [storeCode appendString:@","];
            }
        }
        if (storeCode.length > 1) {
            if ([[storeCode substringWithRange:NSMakeRange(storeCode.length - 1, 1)]isEqualToString:@","]) {
                [storeCode replaceCharactersInRange:NSMakeRange(storeCode.length - 1, 1) withString:@""];
            }
        }
        [param setValue:storeCode?storeCode:@"" forKey:@"store_code"];
    }
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_CUSTOMERJIS_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            NSMutableArray * tempArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < [resultDic[@"list"] count]; i++) {
                MzzStoreModel * tempModel = [[MzzStoreModel alloc] init];
                tempModel.store_name = resultDic[@"list"][i][@"name"];
                tempModel.store_code = resultDic[@"list"][i][@"account"];;
                tempModel.isSelect = YES;
                [tempArr addObject:tempModel];
            }
            MzzStoreModel * firstModel = [[MzzStoreModel alloc] init];
            firstModel.store_name = @"全部技师";
            firstModel.store_code = @"all";
            firstModel.isSelect = YES;
            [tempArr insertObject:firstModel atIndex:0];
            _sourceJisData = tempArr;
            [self.selectJisView updateViewParam:tempArr];
        }else{}
    }];
}
/** 获取项目 */
- (void)requestProData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_CUSTOMERJPRO_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            for (int i = 0; i < [resultDic[@"list"] count]; i ++) {
                NSMutableDictionary * tempDic = resultDic[@"list"][i];
                for (int j = 0; j < [tempDic[@"list"] count]; j++) {
                    NSMutableDictionary * dic = tempDic[@"list"][j];
                    [dic setValue:@(NO) forKey:@"select"];
                }
            }
            [self.cardView updateViewParam: resultDic[@"list"]];
        }else{}
    }];
}
- (void)organizeJson
{
    NSMutableArray * list2Arr = _resultDic[@"list2"];
    NSMutableDictionary * dictMark =  list2Arr[1];
    
    NSMutableArray * list1Arr = _resultDic[@"list1"];
    NSMutableDictionary * dictGrade =  list1Arr[3];
    
    NSMutableArray * grade_list = _gradeDic[@"grade_list"];
    NSMutableArray * content_list = _gradeDic[@"content_list"];
    /** 替换开始json 内顾客标签 */
    dictMark[@"list"]= content_list;
    dictGrade[@"list"] = grade_list;
    [_tbView reloadData];
}

@end
