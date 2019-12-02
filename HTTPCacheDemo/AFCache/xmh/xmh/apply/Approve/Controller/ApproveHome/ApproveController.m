//
//  ApproveController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ApproveController.h"
#import "LApprovePointView.h"
#import "LApproveCell.h"
#import "LApproveModel.h"
#import "LWaitMeApproveController.h"
#import "LFromMeApproveController.h"
#import "LToMeApproveController.h"
#import "SPNetViewController.h"
#import "MzzTDViewController.h"
#import "LMemberFreezeViewController.h"
#import "ApproveRequest.h"
#import "ShareWorkInstance.h"
#import "BaseModel.h"
#import "LClearCardController.h"
#import "LBillReviseController.h"
#import "MzzBillReviseController.h"
#import "SPRequest.h"
#import "UserManager.h"
#import "SPGetNumModel.h"
#import "RefundCustomer.h"
#import "LMemberFreezeNewViewController.h"
@interface ApproveController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ApproveController
{
    UITableView * _tb;
    NSMutableArray * _headerModelArr;
    NSMutableArray * _cellModelArr;
    SPGetNumModel * _numModel;
    UIView * _containerView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _headerModelArr = [[NSMutableArray alloc] init];
    _cellModelArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = kBackgroundColor;
    
    
    /** nav */
    [self.navView setNavViewTitle:@"审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [_cellModelArr addObject:[LApproveModel modelTitle:@"会员冻结" imgName:@"stspyy_huiyuandongjie"]];
    [_cellModelArr addObject:[LApproveModel modelTitle:@"客户调店" imgName:@"stspyy_kehutiaodian"]];
    [_cellModelArr addObject:[LApproveModel modelTitle:@"退款审批" imgName:@"stspyy_tuankunshenpi"]];
//    [_cellModelArr addObject:[LApproveModel modelTitle:@"账单校正" imgName:@"stspyy_zhangdanjiaozheng"]];
//    [_cellModelArr addObject:[LApproveModel modelTitle:@"接口测试" imgName:@"stshenpzhandanjiaozheng"]];
    [self getNumData];
    [self initSubViews];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)getNumData
{
    WeakSelf
     LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary * param = [@{@"join_code":joincode?joincode:@"",@"account_id":accountId?accountId:@""}mutableCopy];
    [SPRequest requestGetNumParams:param resultBlock:^(SPGetNumModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _numModel = model;
            [weakSelf refreshNumView];
        }
    }];
}
- (void)refreshNumView
{
    for (int i = 0;i < _containerView.subviews.count;i++) {
        UIView * v = _containerView.subviews[i];
        if ([v isKindOfClass:[LApprovePointView class]]) {
            LApprovePointView * view = (LApprovePointView *)v;
            if (i ==0) {
                if (_numModel.waitNum == 0) {
                    view.lbPoint.hidden = YES;
                }else{
                    view.lbPoint.hidden = NO;
                }
            }
            if (i==2) {
                if (_numModel.duplicateNum ==0) {
                    view.lbPoint.hidden = YES;
                }else{
                    view.lbPoint.hidden = NO;
                }
            }
            if (i==1) {
                view.lbPoint.hidden = YES;
            }
        }
    }
}
- (void)initSubViews
{
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"审批" withleftImageStr:@"back" withRightStr:nil];
//    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
    [self createTableView];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(10, Heigh_Nav, SCREEN_WIDTH - 20, kNavContentHeight)];
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.backgroundColor = kBackgroundColor;
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tb.width, 130)];
    header.backgroundColor = kBackgroundColor;
    
    UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, _tb.width, 110)];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 5;
    containerView.layer.masksToBounds = YES;
    
    [_headerModelArr addObject:[LApproveModel modelTitle:@"我审批的" imgName:@"stspyy_woshenpide"]];
    [_headerModelArr addObject:[LApproveModel modelTitle:@"我发起的" imgName:@"stspyy_wofaqide"]];
    [_headerModelArr addObject:[LApproveModel modelTitle:@"抄送我的" imgName:@"stspyy_chasongwode"]];
    CGFloat margin = 20;
    CGFloat w = (SCREEN_WIDTH - 20 * 5)/3;
    for (int i = 0; i <_headerModelArr.count; i++) {
        LApproveModel * model = _headerModelArr[i];
        CGRect rect = CGRectMake(margin +  (margin+ w) * i,
                                 (containerView.height - 90)/2,
                                 w,
                                 90);
        LApprovePointView * view = [[LApprovePointView alloc] initWithFrame:rect title:model.title imgName:model.imgName];
        view.btn1.tag = i;
        [view.btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:view];
    }
    _containerView = containerView;
    [header addSubview:containerView];
    _tb.tableHeaderView = header;
    _tb.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tb];
}
- (void)click:(UIButton *)btn
{
    for (UIView * view in _containerView.subviews) {
        if ([view isKindOfClass:[LApprovePointView class]]) {
            LApprovePointView * v = (LApprovePointView *)view;
            if (v.tag == btn.tag) {
                v.lbPoint.hidden = YES;
            }
        }
    }
    if (btn.tag == 0) { //带我审批
        LWaitMeApproveController * wait = [[LWaitMeApproveController alloc] init];
        [self.navigationController pushViewController:wait animated:NO];
    }else if (btn.tag == 1){//我发起的
        LFromMeApproveController * from = [[LFromMeApproveController alloc] init];
        [self.navigationController pushViewController:from animated:NO];
    }else{//抄送我的
        LToMeApproveController * to = [[LToMeApproveController alloc] init];
        [self.navigationController pushViewController:to animated:NO];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf;
    static NSString * cellName = @"cellName";
    LApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[LApproveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.arrs = _cellModelArr;
    __weak typeof(self) _self = self;
    cell.LApproveCellBlock = ^(NSInteger tag) {
        __strong typeof(_self) self = _self;
        if (tag == 0) {
//            LMemberFreezeViewController * next = [[LMemberFreezeViewController alloc] init];
//            [weakSelf.navigationController pushViewController:next animated:NO];
//            return;
            
            
            NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
            NSArray * role = [ShareWorkInstance shareInstance].share_join_code.framework_function_role;
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"1" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        LMemberFreezeViewController * next = [[LMemberFreezeViewController alloc] init];
                        [weakSelf.navigationController pushViewController:next animated:NO];
                    }else{
                     MzzHud * hub = [[MzzHud alloc]initWithTitle:@"注意" message:@"您没有权限使用此审批,如有疑问请联系管理员。" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }];
                        [hub show];
                    }
                }
            }];
        }else if(tag == 1){
            NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
            NSArray * role = [ShareWorkInstance shareInstance].share_join_code.framework_function_role;
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"2" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        MzzTDViewController *tdVc = [[MzzTDViewController alloc] init];
                        [self.navigationController pushViewController:tdVc animated:NO];
                    }else{
                        MzzHud * hub = [[MzzHud alloc]initWithTitle:@"注意" message:@"您没有权限使用此审批,如有疑问请联系管理员。" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }];
                        [hub show];
                    }
                }
            }];
           
        }else if (tag == 2){
            NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
            NSArray * role = [ShareWorkInstance shareInstance].share_join_code.framework_function_role;
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"3" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        RefundCustomer * next = [[RefundCustomer alloc] init];
                        [self.navigationController pushViewController:next animated:NO];
                    }else{
                        MzzHud * hub = [[MzzHud alloc]initWithTitle:@"注意" message:@"您没有权限使用此审批,如有疑问请联系管理员。" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }];
                        [hub show];
                    }
                }
            }];
           
        }else if (tag == 3){
            NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
            NSArray * role = [ShareWorkInstance shareInstance].share_join_code.framework_function_role;
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"4" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        MzzBillReviseController * next = [[MzzBillReviseController alloc] init];
//                        LBillReviseController * next = [[LBillReviseController alloc] init];
                        [self.navigationController pushViewController:next animated:NO];
                    }else{
                        MzzHud * hub = [[MzzHud alloc]initWithTitle:@"注意" message:@"您没有权限使用此审批,如有疑问请联系管理员。" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }];
                        [hub show];
                    }
                }
            }];
           
        }else{
            SPNetViewController *vc = [[SPNetViewController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
        }
    };
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * lb = [[UILabel alloc] init];
    lb.text = @"审批项目";
    lb.font = FONT_SIZE(15);
    lb.textColor = kColor3;
    [lb sizeToFit];
    lb.frame = CGRectMake(15, 15, lb.width, lb.height);
    [view addSubview:lb];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.bottom.equalTo(view);
    }];
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = view.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    view.layer.mask = cornerRadiusLayer;
    
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = _cellModelArr.count;
    if (count%3 ==0) {
        return (70+ 30 + 10) * count/3;
    }else{
        return (70+ 30 + 10)  * (count/3 + 1) + 10;
    }
}

@end
