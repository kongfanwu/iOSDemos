//
//  XMHBillRecoverStatisticVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillRecoverStatisticVC.h"
#import "XMHSaleOrderStatisticCell.h"
#import "CustomerListModel.h"
#import "UITextView+XMHPlaceholder.h"
#import "XMHBillReListModel.h"
#import "MzzCustomerRequest.h"
#import "XMHBillRecoveryOrderRequest.h"
#import "MzzStoreModel.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "XMHBillRecoveryListModel.h"
#import "XMHSuccessAlertView.h"
#import "XMHNormalOrderManagementVC.h"
#import "XMHShoppingCartManager.h"
#import "XMHBillRecoveryVC.h"
#import "XMHSalesOrderVC.h"
#import "XMHSaleOrderRequest.h"
#import "XMHNewMzzJiSuanViewController.h"
@interface XMHBillRecoverStatisticVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UITextView *remarkTextView;
/** 是否可编辑 默认YES */
@property (nonatomic) BOOL remarkTextViewUserInteractionEnabled;
/** 备注内容 */
@property (nonatomic, copy) NSString *remarkText;
@property (nonatomic, strong)NSMutableArray *section0Arr;
@property (nonatomic ,strong)MzzStoreList *storeList;
@property (nonatomic ,strong)MzzStoreModel *selectStoreModel;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, strong)UIButton *commitBtn;


@end

@implementation XMHBillRecoverStatisticVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = Color_NormalBG;
    _remarkTextViewUserInteractionEnabled = YES;
    [self initValue];
    [self creatNav];
    [self createSubViews];
    [self getCustomerStoreCode];
}
- (void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    CGFloat itemH = 14;
    CGFloat cellH = 53 + 34;//结算统计+回收p商品的高度
    CGFloat section0CellH = cellH + (itemH * self.dataArr.count) + (10 * (self.dataArr.count - 1)) + 44 + 15;
    _cellHeight = section0CellH;
    [_tableView reloadData];
}
- (void)initValue
{
    _section0Arr = [NSMutableArray array];
    //伪造数据
    XMHBillRecoveryStatiscModel *pro = [[XMHBillRecoveryStatiscModel alloc]init];
    pro.name = @"商品名称";
    [_section0Arr safeAddObject:pro];
    [_section0Arr safeAddObjectsFromArray:self.dataArr];
    
}

- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"结算统计" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.lineImageView.hidden = YES;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)createSubViews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, self.view.width, self.view.height - 69) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:_tableView];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafeAreaBottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(69);
    }];
    [bgView addSubview:self.commitBtn];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).mas_offset(kMargin);
        make.right.mas_equalTo(bgView.mas_right).mas_offset(-kMargin);
        make.top.mas_equalTo(bgView.mas_top).mas_offset(13);
        make.bottom.mas_equalTo(bgView.mas_bottom).mas_offset(-13);
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _cellHeight;//[self getSection0CellHeight]
    }
  return  0;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XMHSaleOrderStatisticCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[XMHSaleOrderStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHSaleOrderStatisticCellBillID"];
        }
        [cell refresCellBillRecoverModelArr:self.section0Arr];
        return cell;
    }
    return UITableViewCell.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
         return 54;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
        
        UIView *headerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
        headerBGView.backgroundColor = [UIColor clearColor];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerBGView.height - 10)];
        headerView.backgroundColor = UIColor.whiteColor;
        headerView.layer.cornerRadius = 5;
        headerView.layer.masksToBounds = YES;
        [headerBGView addSubview:headerView];
        
        
        UILabel *customerInfoLabel = [[UILabel alloc] init];
        customerInfoLabel.text = @"顾客信息";
        customerInfoLabel.font = FONT_SIZE(15);
        customerInfoLabel.textColor = kLabelText_Commen_Color_6;
        [headerView addSubview:customerInfoLabel];
        [customerInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(headerView);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = FONT_SIZE(15);
        nameLabel.textColor = kLabelText_Commen_Color_6;
        nameLabel.textAlignment = NSTextAlignmentRight;
        [headerView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(headerView);
            make.left.equalTo(customerInfoLabel.mas_right);
        }];
        nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.selectUserModel.uname,[self.selectUserModel safeMobile]];
        return headerBGView;
    }
    return UIView.new;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 140;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        CGFloat headerHeight = [self tableView:tableView heightForFooterInSection:section];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
        headerView.backgroundColor = kColorF5F5F5;
        
        UIView *bgView = UIView.new;
        bgView.backgroundColor = UIColor.whiteColor;
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        [headerView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.equalTo(headerView);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        UILabel *nameLabel = UILabel.new;
        nameLabel.font = FONT_SIZE(15);
        nameLabel.textColor = kColor3;
        nameLabel.text = @"备注信息";
        [bgView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView);
            make.top.mas_equalTo(15);
        }];
        
        self.remarkTextView = [UITextView new];
        _remarkTextView.layer.borderWidth = 0.5;
        _remarkTextView.delegate = self;
        _remarkTextView.layer.borderColor = kColorE.CGColor;
        _remarkTextView.font = FONT_SIZE(11);
        _remarkTextView.userInteractionEnabled = _remarkTextViewUserInteractionEnabled;
        [bgView addSubview:_remarkTextView];
        [_remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.equalTo(nameLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(67);
        }];
        [_remarkTextView xmhAddPlaceholder:@"请输入需要让承接人知晓的信息，以此提高工作效率。"];
        if (!IsEmpty(_remarkText)) {
            _remarkTextView.text = _remarkText;
        }
        
        return headerView;
    }
    return UIView.new;
}

-(UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.layer.cornerRadius = 3;
        _commitBtn.backgroundColor = kColorTheme;
        [_commitBtn setTitle:@"确认回收" forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

#pragma mark -- event

-(void)commiBtnClick
{
    NSMutableArray *y_awardArr = [NSMutableArray array];
    for (XMHBillRecoveryStatiscModel *model in self.dataArr) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@(model.uid) forKey:@"did"];
        [dic setValue:model.type forKey:@"type"];
        [dic setValue:model.price forKey:@"price"];
        [dic setValue:model.code forKey:@"code"];
        [dic setValue:model.num forKey:@"num"];
        [dic setValue:model.name forKey:@"name"];
        [y_awardArr safeAddObject:dic];
    }
    NSMutableDictionary *y_awardDic = [NSMutableDictionary dictionary];
    [y_awardDic setValue:y_awardArr forKey:@"y_award"];
    LolUserInfoModel *LolUserInfoModelmodel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *inId =  LolUserInfoModelmodel.data.account;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue: _selectStoreModel.store_code? _selectStoreModel.store_code :@""  forKey:@"store_code"];
    //当前用户的门店code
    [param setValue:[ShareWorkInstance shareInstance].share_join_code.store_code ? [ShareWorkInstance shareInstance].share_join_code.store_code :@""  forKey:@"store_code"];
    [param setValue: self.totalPrice forKey:@"heji"];
    [param setValue: [NSString stringWithFormat:@"%ld",(long)self.selectUserModel.uid] forKey:@"user_id"];
    [param setValue: inId forKey:@"inper"];
    [param setValue: self.remarkTextView.text? self.remarkTextView.text:@"" forKey:@"content"];
    [param setValue: y_awardDic.jsonData forKey:@"cart"];
    [param setValue: [ShareWorkInstance shareInstance].join_code forKey:@"join_code"];
    
    [XMHBillRecoveryOrderRequest requestBillRecoveryCommitParams:param resultBlock:^(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic) {
        if (isSuccess) {
            NSDictionary *dic = result;
            
            WeakSelf
            [[[XMHSuccessAlertView alloc]initWithTitle:@"订单创建成功!" cancelButtonTitle:@"返回首页" otherButtonTitles:@"查看详情" click:^(NSInteger index) {
                [XMHShoppingCartManager.sharedInstance clear];
                if (index == 0) {
                    for (UIViewController *temp in weakSelf.navigationController.viewControllers) {
                        if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
                            [weakSelf.navigationController popToViewController:temp animated:NO];
                        }
                    }
                    
                }else{
//                    XMHSalesOrderVC *vc = [[XMHSalesOrderVC alloc]init];
//                    vc.selectModel = weakSelf.selectUserModel;
//                    vc.navView.NavViewBackBlock = ^{
//                        for (UIViewController *temp in weakSelf.navigationController.viewControllers) {
//                            [XMHShoppingCartManager.sharedInstance clear];
//                            if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
//                                [weakSelf.navigationController popToViewController:temp animated:NO];
//                            }
//                        }
//                    };
//                    [weakSelf.navigationController pushViewController:vc animated:YES];
                    for (UIViewController *temp in weakSelf.navigationController.viewControllers) {
                        if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
                            XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
                            [vc setOrderNum:dic[@"order_num"] andYemianStyle:YemianXiangQing andType:[dic[@"type"] integerValue]  andUid:[NSString stringWithFormat:@"%ld",(long)self.selectUserModel.uid] withName:@""];
                            vc.popToOrderMainPageVC = ^{
                                [self.navigationController popToViewController:temp animated:NO];
                            };
                            [self.navigationController pushViewController:vc animated:NO];
                        }
                    }
                  
                }
            }] show];
            

        }
    }];
}
#pragma mark -- UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
//    if (_textViewContent) {
//        _textViewContent(textView.text);
//    }
}

/**
 获取门店编码
 */
-(void)getCustomerStoreCode
{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    //门店归属
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _storeList = listModel;
            _selectStoreModel = _storeList.list[0];
        }
    }];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
