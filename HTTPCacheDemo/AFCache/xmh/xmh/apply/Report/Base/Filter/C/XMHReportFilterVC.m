//
//  XMHReportFilterVC.m
//  xmh
//
//  Created by ald_ios on 2019/7/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHReportFilterVC.h"
#import "JasonSearchView.h"
#import "DemoTableViewController.h"
#import "XMHReportFilterTableView.h"
#import "XMHReportFilterFastListModel.h"
#import "XMHReportFilterOrganizeListModel.h"
@interface XMHReportFilterVC ()<MYTreeTableViewControllerDelegate>
@property (nonatomic, strong)NSArray *data;
@property (nonatomic, strong)UIButton * selectBtn;
/** 全选  反选按钮 选择 */
@property (nonatomic, strong)UIButton * checkBoxBtn;
/** 原始数据 */
@property (nonatomic, strong)NSMutableArray * netDataSource;
/** 筛选后的数据 */
@property (nonatomic, strong)NSMutableArray * filterDataSource;
/** 层级控制器视图 */
@property (nonatomic, strong)DemoTableViewController * demoVC;
@property (nonatomic, strong)XMHReportFilterTableView * tbView;
@property (nonatomic, strong) NSArray <MYTreeItem *>*checkItems;
/** 快捷按钮数据源 */
@property (nonatomic, strong)NSMutableArray * fastBtndataSource;
/** 组织架构数据源 */
@property (nonatomic, strong)NSMutableArray * organizedataSource;
/** 搜索 */
@property (nonatomic, strong)JasonSearchView * search;
/** 点击反选 保留的 数据源 */
@property (nonatomic, strong)NSMutableArray *invertiSource;

@property (nonatomic, assign)BOOL isSerach;
@end

@implementation XMHReportFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initSubViews];
    [self.navView setNavViewTitle:@"筛选" backBtnShow:YES];
    
    [self requestOrganizeListData];
    /** 员工报表 */
    if (_reportType == XMHBaseReportVCTypeYuanGong) {
        [self createFastFilterData];
        return;
    }
    [self requestFilterData];
    
}

- (void)initSubViews
{
    /** 头部白色背景 */
    UIView * bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    WeakSelf
    [self.view addSubview:bgView];
    
    NSString *placeHolder = @"岗位名称、人员名称及门店名称";
    if (_reportType == XMHBaseReportVCTypeYuanGong)  {
        placeHolder = @"请输入门店名称及员工名称";
    }
    JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:placeHolder];
    _search = search;
    search.line1.hidden = YES;
    search.searchBar.frame = search.bounds;
    [bgView addSubview:search];
    search.searchBar.layer.cornerRadius = 3;
    search.searchBar.layer.masksToBounds = YES;
    search.searchBar.btnRightBlock = ^{
        [weakSelf filterData];
    };
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(15);
    [btn setTitleColor:kColor6 forState:UIControlStateNormal];
    btn.frame = CGRectMake(search.right, search.top, 55, search.height);
    btn.userInteractionEnabled = YES;
    [btn bk_addEventHandler:^(id sender) {
        [weakSelf filterData];
    } forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    CGFloat btnW = 0;
    CGFloat btnH = 30;
    NSInteger lineNum = 3;
    NSInteger count = _fastBtndataSource.count;
    CGFloat margin = 15;
    
    btnW = (SCREEN_WIDTH - (lineNum + 1) * margin)/lineNum;
    for (int i = 0; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = FONT_SIZE(13);
        XMHReportFilterFastModel * fastModel = _fastBtndataSource[i];
        [btn setTitle:[NSString stringWithFormat:@"%@",fastModel.name] forState:UIControlStateNormal];
        btn.frame = CGRectMake(15 + (i%3) * (15 + btnW), search.bottom + 25 + (15 + btnH) * (i/lineNum), btnW, btnH);
        btn.backgroundColor = kColorF5F5F5;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:kColorC forState:UIControlStateNormal];
        [btn setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
    }
    if (count == 0) {
        bgView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, search.bottom + 15);
    }else{
        bgView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, search.bottom + 25 + (15 + btnH) * ((count - 1)/lineNum) + btnH + 15);
    }
    
    
    /** 全选  反选 按钮容器 */
    UIView * selectView = UIView.new;
    selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectView];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    /** 全选按钮 */
    UIButton *allBtn = UIButton.new;
    allBtn.tag = 8000;
    [allBtn setTitle:@"  全选 " forState:UIControlStateNormal];
    [allBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [allBtn addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    allBtn.backgroundColor = [UIColor whiteColor];
    allBtn.titleLabel.font = FONT_SIZE(15);
    [allBtn setImage:[UIImage imageNamed:@"danxuan_weixuan"] forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"danxuan_xuanzhong"] forState:UIControlStateSelected];
    [allBtn setTitleColor:kColor3 forState:UIControlStateNormal];
    allBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [selectView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selectView.mas_left).offset(15);
        make.height.mas_equalTo(selectView.mas_height);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(selectView.top);
    }];
    
    /** 反选按钮 */
    UIButton *fanBtn = UIButton.new;
    fanBtn.tag = 8001;
    [fanBtn setTitle:@"  反选 " forState:UIControlStateNormal];
    [fanBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [fanBtn addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    fanBtn.backgroundColor = [UIColor whiteColor];
    fanBtn.titleLabel.font = FONT_SIZE(15);
    [fanBtn setImage:[UIImage imageNamed:@"danxuan_weixuan"] forState:UIControlStateNormal];
    [fanBtn setImage:[UIImage imageNamed:@"danxuan_xuanzhong"] forState:UIControlStateSelected];
    [fanBtn setTitleColor:kColor3 forState:UIControlStateNormal];
    fanBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [selectView addSubview:fanBtn];
    [fanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(allBtn.mas_right).offset(15);
        make.height.mas_equalTo(selectView.mas_height);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(selectView.top);
    }];
    
   
    /** 确定按钮容器 */
    UIView *bottomView = UIView.new;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(69 + kSafeAreaBottom);
    }];
  
    /** 确定按钮 */
    UIButton * sureBtn = UIButton.new;
    sureBtn.backgroundColor = kColorTheme;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    sureBtn.titleLabel.font = FONT_SIZE(17);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(bottomView).mas_offset(10);
        make.right.mas_equalTo(bottomView.right).mas_offset(-10);
        make.height.mas_equalTo(44);
    }];
    
    DemoTableViewController * demoVC = [[DemoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    demoVC.delegate = self;
    _demoVC = demoVC;
    [self.view addSubview:demoVC.view];
    [self addChildViewController:demoVC];
    [demoVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selectView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
        
    }];
    
    XMHReportFilterTableView *tableview = [[XMHReportFilterTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    tableview.backgroundColor = kColorTheme;
    tableview.hidden = YES;
    _tbView = tableview;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selectView.mas_bottom);
        make.right.left.mas_equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
}
/** 快捷按钮时间 */
- (void)btnClick:(UIButton *)btn
{
    if ([_selectBtn isEqual:btn]) {
        _selectBtn.selected = !_selectBtn.selected;
        if (_selectBtn.selected) {
            _selectBtn.layer.borderWidth = 0.1;
            _selectBtn.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
            _selectBtn.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        }else{
            _selectBtn.layer.borderWidth = 0;
            _selectBtn.backgroundColor = kColorF5F5F5;
        }
        _selectBtn = nil;
    }else{
        _selectBtn.selected = NO;
        _selectBtn.layer.borderWidth = 0;
        _selectBtn.backgroundColor = kColorF5F5F5;
        
        btn.selected = YES;
        btn.layer.borderWidth = 0.1;
        btn.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
        btn.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        
        _selectBtn = btn;
    }
    /** 点选快捷按钮 根据按钮条件筛选数据源 */
    
    if (_selectBtn && _selectBtn.selected) {
        _demoVC.view.hidden = YES;
        [self fastBtnFilterData];
    }else{
        _demoVC.view.hidden = NO;
        [_demoVC allExpandItemClick];
    }
    /** 重置所有操作 */
    [self resetOperation];
    _tbView.hidden = !_demoVC.view.hidden;
    
}
#pragma mark----全选反选按钮事件
/** 全选 反选 按钮点击 */
- (void)checkBoxClick:(UIButton *)btn
{
    if ([btn isEqual:_checkBoxBtn]) {
        _checkBoxBtn.selected = !_checkBoxBtn.selected;
    }
    else{
        _checkBoxBtn.selected = NO;
        btn.selected = YES;
        _checkBoxBtn = btn;
    }
    
    if (btn.tag == 8000 ) {
        /** 全选 */
        if (btn.selected) {
            [_demoVC allCheckItemClick];
            [_tbView allCheck];
        }
        /** 全不选 */
        else{
            [_demoVC allUnCheckItemClick];
            [_tbView allUnCheck];
        }
    }
    /** 反选 */
    else{
        if (btn.selected) {
            [_demoVC allInvertiCheck];
            [_tbView allInvertiCheck];
            _invertiSource = [[NSMutableArray alloc] initWithArray:[_demoVC getCheckItems]];
        }else{
            [_demoVC allUnCheckItemClick];
            [_tbView allUnCheck];
        }
       
    }
    
}
/** 刷新 全选 反选按钮状态 */
- (void)updateAllBtnAndInvertBtnState
{
    //全选
    if (_checkBoxBtn.tag == 8000 && !_checkBoxBtn.selected) {
        if ([_demoVC getShowItems].count == [_demoVC getCheckItems].count) {
            [self checkBoxClick:_checkBoxBtn];
        }
    }
    if (_checkBoxBtn.tag == 8000 && _checkBoxBtn.selected) {
        if ([_demoVC getShowItems].count != [_demoVC getCheckItems].count) {
            _checkBoxBtn.selected = NO;
        }
    }
    //反选
    //1、
    if (_checkBoxBtn.tag == 8001 && _checkBoxBtn.selected) {
        
        if (![[_demoVC getCheckItems] isEqual:_invertiSource]) {
            _checkBoxBtn.selected = NO;
        }
    }
    if (_checkBoxBtn.tag == 8001 && !_checkBoxBtn.selected) {
        
        if ([[_demoVC getCheckItems] isEqual:_invertiSource]) {
            _checkBoxBtn.selected = YES;
        }
    }
}
#pragma mark----提交H5数据
/** 确定按钮点击 */
- (void)sureClick:(UIButton *)btn
{
    // 1、获取点击的内容
    _checkItems = [_demoVC getCheckItems];
    
    // 2、提取MYTreeItem data数据  组织h5 要的数据
    /** 列表模式 */
    NSMutableArray * submitData = [[NSMutableArray alloc] init];
    if (_selectBtn || _search.searchBar.text.length > 0) {
        [_tbView.dataArray enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (organizeModel.selected) {
                [submitData addObject:organizeModel];
            }
        }];
    }
    /** 层级模式 */
    else{
        [_checkItems enumerateObjectsUsingBlock:^(MYTreeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [submitData addObject:obj.data];
        }];
    }
    // 3、传递数据 submitData
    
    /** 所选数据 id 数组
        @[@"id1",@"id2",@"id3"]
     */
    NSMutableArray * pidArr = [[NSMutableArray alloc]init];
    
    /** 员工报表 专属数组
     数组内格式 @[@{@"account":@"value",@"store_code":@"value"},@{@"account":@"value",@"store_code":@"value"}]
     */
    NSMutableArray * employArr = [[NSMutableArray alloc] init];
    
    [submitData enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (_reportType == XMHBaseReportVCTypeYuanGong) {
            NSMutableDictionary * tmpDict = organizeModel.yy_modelToJSONObject;
            [employArr addObject:tmpDict];
        }
        else{
           [pidArr addObject:[NSString stringWithFormat:@"%ld",organizeModel.fram_id]];
        }
        
    }];
    /**
     1、员工筛选拼接 account
     2、非员工筛选 拼接 id
     格式为 @"a,b,c"
     */
    NSString * pidMerge = [pidArr componentsJoinedByString:@","];
    if (_reportType == XMHBaseReportVCTypeYuanGong) {
        if (_XMHReportEmpioyFilterVCBlock) {
            _XMHReportEmpioyFilterVCBlock(employArr.jsonData);
        }
    }
    else{
        if (_XMHReportFilterVCBlock) {
            _XMHReportFilterVCBlock(pidMerge);
        }
    }
    [self.navigationController popViewControllerAnimated:NO];
}
/** 快捷按钮点击 筛选数据 */
- (void)fastBtnFilterData
{
    // 1、获取快捷按钮对应的 model
    XMHReportFilterFastModel * fastModel = _fastBtndataSource[_selectBtn.tag];
    NSMutableArray * filterData = [[NSMutableArray alloc] init];
    
    /**
        员工报表 判断规则
     1、如果只看门店 筛选account 为空的数据
     2、如果只看员工 筛选account 不为空的数据
     
        其余报表规则
     1、筛选 fram_name_id 相同的数据
     */
    if (_reportType == XMHBaseReportVCTypeYuanGong) {
        [_organizedataSource enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
            /** 门店 */
            if (fastModel.fram_name_id == 1 ) {
                if (organizeModel.account.length == 0) {
                    [filterData addObject:organizeModel];
                }
            }
            /** 员工 */
            else{
                if (organizeModel.account.length > 0) {
                    [filterData addObject:organizeModel];
                }
            }
           
        }];
    }
    else{
        [_organizedataSource enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (organizeModel.fram_name_id == fastModel.fram_name_id) {
                organizeModel.selected = NO;
                [filterData addObject:organizeModel];
            }
        }];
    }
    
    
    _tbView.dataArray = filterData;
    [_tbView reloadData];
    
}
#pragma mark ----搜索
/** 筛选数据 */
- (void)filterData
{
//    if (!_selectBtn) return;
    /** 原始数据备份 */
    NSMutableArray * copyData = nil;
    
    /** 搜索结果数据 */
    NSMutableArray * tempData = [[NSMutableArray alloc] init];
    /** 层级模式 */
    if (_selectBtn) {
        copyData = [[NSMutableArray alloc] initWithArray:_tbView.dataArray];
    }
    /** 列表模式 */
    else{
        copyData = [[NSMutableArray alloc] initWithArray:_organizedataSource];
    }
    
    /** 筛选数据 */
    NSString * key = _search.searchBar.text;
    [copyData enumerateObjectsUsingBlock:^(XMHReportFilterOrganizeModel * organizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([organizeModel.name containsString:key] || [organizeModel.store_name containsString:key]) {
            [tempData addObject:organizeModel];
        }
    }];
    
    if (key.length == 0) {
        _tbView.dataArray = copyData;
        _demoVC.view.hidden = NO;
    }else{
        _tbView.dataArray = tempData;
        _demoVC.view.hidden = YES;
    }
    _tbView.hidden = !_demoVC.view.hidden;
    
    [_tbView reloadData];
    
}
/** 模式切换  重置所有操作 */
- (void)resetOperation
{
    // 1、全选 反选按钮
    self.checkBoxBtn.selected = NO;
    _checkBoxBtn = nil;
    
    // 2、取消层级结构的选中
    [_demoVC allUnCheckItemClick];
    
    // 3、取消列表的选中
    [_tbView allUnCheck];
    
    // 4、清除搜索关键字
    _search.searchBar.text = @"";
    
}
#pragma mark ---MYTreeTableViewControllerParentClassDelegate
- (void)tableViewController:(MYTreeTableViewController *)tableViewController checkItems:(NSArray<MYTreeItem *> *)items {
    [self updateAllBtnAndInvertBtnState];
}
#pragma mark ----网络请求
/** 获取快捷按钮数据 */
- (void)requestFilterData
{
    [XMHProgressHUD showGifImage];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * framNameID = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_name_id];
//    NSString * framNameID = @"16";/** 测试数据 */
//    [param setValue:@"SJ000003" forKey:@"join_code"];
    [param setValue:framNameID?framNameID:@"" forKey:@"fram_name_id"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:kREPORT_FILTER_FASTBUTTON_URL] refreshRequest:YES cache:NO params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            XMHReportFilterFastListModel *model = [XMHReportFilterFastListModel yy_modelWithDictionary:obj.data];
            _fastBtndataSource = [[NSMutableArray alloc] initWithArray:model.list];
            [self initSubViews];
            [self requestOrganizeData];
        }
    }];
}
/** 快捷按钮数据 获取 */
- (void)createFastFilterData
{
    NSDictionary * employFastDic = @{@"list":@[@{@"id":@"1",@"name":@"只看门店"},@{@"id":@"2",@"name":@"只看员工"}]};
    XMHReportFilterFastListModel *model = [XMHReportFilterFastListModel yy_modelWithDictionary:employFastDic];
    _fastBtndataSource = [[NSMutableArray alloc] initWithArray:model.list];
    [self initSubViews];
}
/** 获取组织架构数据 */
- (void)requestOrganizeData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * framID = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
//    NSString * framID = @"790";/** 测试数据 */
//    [param setValue:@"SJ000003" forKey:@"join_code"];
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:kREPORT_FILTER_ORGANIZE_URL] refreshRequest:YES cache:NO params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            XMHReportFilterOrganizeListModel *model = [XMHReportFilterOrganizeListModel yy_modelWithDictionary:obj.data];
            _organizedataSource = [[NSMutableArray alloc] initWithArray:model.list];
            _demoVC.manager = [self getOrganize];
        }
    }];
}
- (MYTreeTableManager *)getOrganize
{
    NSMutableSet *items = [NSMutableSet set];
    
    for (XMHReportFilterOrganizeModel *organizeModel in _organizedataSource) {
        /** 判断是否为子节点 */
        BOOL isLeaf = NO;
        /** 员工报表
            根据是否有account 有的话为子节点
         */
        if (_reportType == XMHBaseReportVCTypeYuanGong) {
            isLeaf = organizeModel.account.length > 0?YES:NO;
        }
        /** 非员工报表
            根据时候有store_code  有的话为子节点
         */
        else{
            isLeaf = organizeModel.store_code.length > 0?YES:NO;
        }
        MYTreeItem *item = [[MYTreeItem alloc] initWithName:organizeModel.name
                                                         ID:[NSString stringWithFormat:@"%ld",organizeModel.fram_id]
                                                   parentID:[NSString stringWithFormat:@"%ld", (long)organizeModel.pid]
                                                    orderNo:organizeModel.account
                                                       type:nil
                                                     isLeaf:isLeaf
                                                       data:organizeModel];
        [items addObject:item];
    }
    
    // ExpandLevel 为 0 全部折叠，为 1 展开一级，以此类推，为 NSIntegerMax 全部展开
    MYTreeTableManager *manager = [[MYTreeTableManager alloc] initWithItems:items andExpandLevel:NSIntegerMax];
    
    return manager;
}
/** 获取层级数据 */
- (void)requestOrganizeListData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        NSString * framID = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
//    NSString * framID = @"790";/** 测试数据 */
//    [param setValue:@"SJ000003" forKey:@"join_code"];
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    
    /** 报表不同  请求层级数据的接口不同 */
    NSString * postUrl = @"";
    switch (_reportType) {
        case XMHBaseReportVCTypeYuanGong:
            postUrl = kREPORT_YUANGONG_ORGANIZE_URL;
            break;
        case XMHBaseReportVCTypeYeJi:
            postUrl = kREPORT_YEJI_ORGANIZE_URL;
            break;
        case XMHBaseReportVCTypeShouYin:
            
            break;
        case XMHBaseReportVCTypeXiaoHao:
            postUrl = kREPORT_XIAOHAO_ORGANIZE_URL;
            break;
        case XMHBaseReportVCTypeGuKeBaoYou:
            
            break;
        case XMHBaseReportVCTypeGuKeHuoYue:
            
            break;

        case XMHBaseReportVCTypeGuKeDengJi:
            
            break;
    }
    
    [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:postUrl] refreshRequest:YES cache:NO params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            XMHReportFilterOrganizeListModel *model = [XMHReportFilterOrganizeListModel yy_modelWithDictionary:obj.data];
            _organizedataSource = [[NSMutableArray alloc] initWithArray:model.list];
            _demoVC.manager = [self getOrganize];
        }
    }];
}

@end
