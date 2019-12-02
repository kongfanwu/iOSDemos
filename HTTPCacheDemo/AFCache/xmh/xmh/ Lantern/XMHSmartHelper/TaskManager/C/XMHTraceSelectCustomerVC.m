//
//  XMHTraceSelectCustomerVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTraceSelectCustomerVC.h"
#import "XMHTraceCustomerCell.h"
#import "GKGLHomeCustomerListModel.h"
#import "XMHFormTaskNextVCProtocol.h"
@interface XMHTraceSelectCustomerVC ()<UITableViewDelegate,UITableViewDataSource,XMHFormTaskNextVCProtocol>
@property (nonatomic, strong)XMHBaseTableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)UILabel *lbNum;
@property (nonatomic, strong)UIButton * btnAll;
@property (nonatomic, strong)UIButton * btnSure;
@property (nonatomic, copy)NSString  * userIDStr;
@end

@implementation XMHTraceSelectCustomerVC

@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] init];
    _selectArr = [[NSMutableArray alloc] init];
    [self initSubViews];
    [self requestCustomerData];
    
    [self updateNumView];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"追踪顾客" backBtnShow:YES];
    
    UIView * topView = UIView.new;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIButton * btn0 = UIButton.new;
    _btnAll = btn0;
    btn0.backgroundColor = [UIColor clearColor];
    [topView addSubview:btn0];
    [btn0 setTitle:@"   全选" forState:UIControlStateNormal];
    btn0.titleLabel.font = FONT_MEDIUM_SIZE(17);
    __weak typeof(self) _self = self;
    [btn0 bk_addEventHandler:^(UIButton * sender) {
        __strong typeof(_self) self = _self;
        sender.selected = !sender.selected;
        if (sender.selected) {
            [self.selectArr removeAllObjects];
            [self.dataSource enumerateObjectsUsingBlock:^(GKGLHomeCustomerModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
                model.selected = YES;
            }];
            [self.selectArr addObjectsFromArray:self.dataSource];
        }else{
            [self.dataSource enumerateObjectsUsingBlock:^(GKGLHomeCustomerModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
                model.selected = NO;
            }];
            [self.selectArr removeObjectsInArray:self.dataSource];
        }
        [self.tbView reloadData];
        [self updateNumView];
    } forControlEvents:UIControlEventTouchUpInside];
    [btn0 setImage:[UIImage imageNamed:@"znzzst_weixuan"] forState:UIControlStateNormal];
    [btn0 setImage:[UIImage imageNamed:@"znzzst_xuanzong"] forState:UIControlStateSelected];
    [btn0 setTitleColor:kColor3 forState:UIControlStateNormal];
    btn0.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.left).mas_offset(1.5);
        make.bottom.top.mas_equalTo(topView);
        make.width.mas_equalTo(80);
    }];
    
    UILabel * lbNum = UILabel.new;
    _lbNum = lbNum;
    lbNum.text = @"共5人，已选N人";
    [topView addSubview:lbNum];
    lbNum.backgroundColor = [UIColor clearColor];
    lbNum.textAlignment = NSTextAlignmentCenter;
    lbNum.font = FONT_MEDIUM_SIZE(17);
    lbNum.textColor = kColor3;
    lbNum.layer.cornerRadius = 5;
    lbNum.layer.masksToBounds = YES;
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(topView);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
    }];
    
    XMHBaseTableView * tbView = [[XMHBaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tbView.backgroundColor = [UIColor clearColor];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.emptyEnable = YES;
    _tbView = tbView;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tbView];
    [tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbNum.mas_bottom);
        make.left.right.mas_equalTo(self.view);
    }];
    
    UIView * commitView = UIView.new;
    [self.view addSubview:commitView];
    commitView.backgroundColor = [UIColor whiteColor];
    [commitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tbView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(69 + kSafeAreaBottom);
    }];
    
    UIButton * btn = UIButton.new;
    _btnSure = btn;
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
//        NSMutableArray *array = NSMutableArray.new;
        NSMutableArray *ids = NSMutableArray.new;
        [self.selectArr enumerateObjectsUsingBlock:^(GKGLHomeCustomerModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
//            [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:model.uid displayText:model.name]];
            [ids addObject:model.uid];
        }];
        self.rowDescriptor.value = ids;
        self.rowDescriptor.action.nextParams = @{@"userIDs" : ids};
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = kColor9;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [commitView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(commitView.mas_right).mas_offset(-15);
        make.left.mas_equalTo(commitView.mas_left).mas_offset(15);
        make.top.mas_equalTo(commitView).mas_offset(15);
        make.height.mas_equalTo(44);
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHTraceCustomerCell";
    XMHTraceCustomerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = loadNibName(@"XMHTraceCustomerCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    [cell updateCellType:XMHTraceCustomerCellTypeEdit];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GKGLHomeCustomerModel * model = _dataSource[indexPath.row];
    model.selected = !model.selected;
    if (![_selectArr containsObject:model]) {
        [_selectArr addObject:model];
    }else{
        [_selectArr removeObject:model];
    }
    [_tbView reloadData];
    [self updateNumView];
}
- (void)updateNumView
{
    if (_selectArr.count == _dataSource.count) {
        _btnAll.selected = YES;
    }else{
        _btnAll.selected = NO;
    }
    _lbNum.text = [NSString stringWithFormat:@"共%ld人，已选%ld人",_dataSource.count,_selectArr.count];
    if (_selectArr.count > 0) {
        _btnSure.backgroundColor = kColorTheme;
    }else{
        _btnSure.backgroundColor = kColor9;
    }
}
#pragma mark - XMHFormTaskNextVCProtocol
- (void)configParams:(NSDictionary *)params
{
    _userIDStr = [[params objectForKey:@"userIDs"] componentsJoinedByString:@","]; 
}
#pragma mark ------网络请求------
/** 顾客列表数据 */
- (void)requestCustomerData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * type = [NSString stringWithFormat:@"%d",1];
    NSString * q = @"";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:@"-1" forKey:@"page"];
    [param setValue:@"1" forKey:@"sort"];
    [param setValue:type?type:@"1" forKey:@"type"];
    [param setValue:q?q:@"" forKey:@"q"];

    NSString * url = @"v5.user_new/user_new_list";
    
    [YQNetworking postWithUrl:[XMHHostUrlManager url:url] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            GKGLHomeCustomerListModel *model = [GKGLHomeCustomerListModel yy_modelWithDictionary:obj.data];
            [_dataSource addObjectsFromArray:model.list];
            if (_userIDStr.length > 0) {
                [self comparisonUserID:nil];
            }
            [self updateNumView];
            [_tbView reloadData];
        }else{
            
        }
    }];
}
/** 比对选择的顾客id  得出数据源 */
- (void)comparisonUserID:(NSArray *)arr;
{
    NSArray * userIDArr = [_userIDStr componentsSeparatedByString:@","];
    [_dataSource enumerateObjectsUsingBlock:^(GKGLHomeCustomerModel * customrModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [userIDArr enumerateObjectsUsingBlock:^(NSString *ID, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([customrModel.uid isEqualToString:ID]) {
                customrModel.selected = YES;
                [_selectArr addObject:customrModel];
                [self updateNumView];
            }
        }];
    }];
}

@end
