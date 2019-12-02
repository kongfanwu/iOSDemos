//
//  XMHServiceOrderList.m
//  xmh
//
//  Created by KFW on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderListVC.h"
#import "CustomerListModel.h"
#import "XMHServiceOrderListTableView.h"
#import "LFWDNoticeView.h"
#import "XMHShoppingCartManager.h"
#import "XMHSelectJiShiVC.h"
#import "SLS_ProModel.h"
#import "XMHComputeOredrVC.h"
#import "SLRequest.h"

@interface XMHServiceOrderListVC() <XMHServiceOrderListTableViewDelegate>
/** <##> */
@property (nonatomic, strong) UIView *topBGView;
/** <##> */
@property (nonatomic, strong) XMHServiceOrderListTableView *tableView;
/** <##> */
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation XMHServiceOrderListVC

- (void)dealloc
{
    NSLog(@"XMHServiceOrderListVC dealloc");
    _tableView.adelegate = nil;
    _tableView = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.createOrderType = XMHCreateOrderTypeExperience;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;

    [self.navView setNavViewTitle:@"服务制单" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;

    [self loadTopView];

    [self loadBottomView];

    self.tableView = [[XMHServiceOrderListTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 20, self.view.height - Heigh_Nav - 52 - 69) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.adelegate = self;
    __weak typeof(self) _self = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(_self) self = _self;
        make.top.equalTo(self.topBGView.mas_bottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];

    // 获取技师数据并获取自己登录的数据
//    __weak typeof(self) _self = self;
    [self getJiShiListComplete:^(MLJiShiModel *jishiModel) {
        __strong typeof(_self) self = _self;
        // 所有商品设置默认技师
        for (id model in self.modelArray) {
            if ([model respondsToSelector:@selector(jiShiList)]) {
                SLS_Pro *amodel = (SLS_Pro *)model;
                if (![self existJishiModel:jishiModel list:amodel.jiShiList]) {
                    [amodel.jiShiList addObject:jishiModel];
                }
            }
        }
        self.tableView.modelArray = self.modelArray;
        [self.tableView reloadData];
    }];

    _tableView.modelArray = _modelArray;
}


/**
 是否存在技师

 @return YES 存在 NO 不存在
 */
- (BOOL)existJishiModel:(MLJiShiModel *)jishiModel list:(NSArray *)jishiList {
    BOOL exist = NO;
    for (MLJiShiModel *jm in jishiList) {
        if (jm.ID == jishiModel.ID) {
            exist = YES;
            break;
        }
    }
    return exist;
}

#pragma mark - getData

/**
 获取技师列表
 */
- (void)getJiShiListComplete:(void(^)(MLJiShiModel *jishiModel))complete {
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *account = infomodel.data.account;
    // 搜索技师数据
    NSNumber *framId = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = framId;
    [SLRequest requesSearchJisParams:params resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (!isSuccess) return;
        for (MLJiShiModel *jishiModel in model.list) {
            if ([jishiModel.account isEqualToString:account]) {
                if(complete) complete(jishiModel);
                break;
            }
        }
    }];
}

- (void)loadTopView {
    self.topBGView = UIView.new;
    _topBGView.backgroundColor = kColorF5F5F5;
    [self.view addSubview:_topBGView];
    [_topBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(52);
    }];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kBtn_Commen_Color;
    [_topBGView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_topBGView);
        make.height.mas_equalTo(30);
    }];
    
    UIView *userBgView = UIView.new;
    userBgView.backgroundColor = UIColor.whiteColor;
    userBgView.layer.cornerRadius = 5;
    userBgView.layer.masksToBounds = YES;
    [_topBGView addSubview:userBgView];
    [userBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBGView);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *customerInfoLabel = [[UILabel alloc] init];
    customerInfoLabel.text = @"顾客信息";
    customerInfoLabel.font = FONT_SIZE(15);
    customerInfoLabel.textColor = kLabelText_Commen_Color_6;
    [userBgView addSubview:customerInfoLabel];
    [customerInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(userBgView);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = FONT_SIZE(15);
    nameLabel.textColor = kLabelText_Commen_Color_6;
    nameLabel.textAlignment = NSTextAlignmentRight;
    [userBgView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(userBgView).offset(-10);
        make.centerY.equalTo(userBgView);
        make.left.equalTo(customerInfoLabel.mas_right);
    }];
    nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.selectUserModel.uname, [self.selectUserModel safeMobile]];
}

- (void)loadBottomView {
    self.bottomView = UIView.new;
    _bottomView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.height.mas_equalTo(69);
    }];
    
    UIButton *addServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addServiceBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [addServiceBtn setTitle:@"追加服务" forState:UIControlStateNormal];
    addServiceBtn.titleLabel.font = FONT_SIZE(17);
    addServiceBtn.layer.cornerRadius = 3;
    addServiceBtn.layer.masksToBounds = YES;
    [_bottomView addSubview:addServiceBtn];
    __weak typeof(self) _self = self;
    [addServiceBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *finishServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishServiceBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [finishServiceBtn setTitle:@"完成服务" forState:UIControlStateNormal];
    finishServiceBtn.titleLabel.font = FONT_SIZE(17);
    finishServiceBtn.layer.cornerRadius = 3;
    finishServiceBtn.layer.masksToBounds = YES;
    [_bottomView addSubview:finishServiceBtn];
    [finishServiceBtn addTarget:self action:@selector(finishServiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *btns = @[addServiceBtn, finishServiceBtn];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.height.mas_equalTo(44);
    }];
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
}

/**
 检测每个项目或者产品是否选择了技师，有一个没选技师返回NO.

 @return bool
 */
- (BOOL)checkSelectJishi {
    BOOL select = YES;
    for (id model in _modelArray) {
        if ([model respondsToSelector:@selector(jiShiList)]) {
            SLS_Pro *amodel = (SLS_Pro *)model;
            if (amodel.jiShiList.count == 0) {
                select = NO;
                return select;
            }
        }
    }
    return select;
}

#pragma mark - Event

- (void)finishServiceBtnClick:(UIButton *)sender {
    // 校验是否选了技师
    if (![self checkSelectJishi]) {
        [MzzHud toastWithTitle:@"提示" message:@"有项目或产品未选技师"];
        return;
    }
    
    LFWDNoticeView * notice = [[LFWDNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [notice showWithTitle:@"温馨提示" content:@"亲，服务已经完成，请确认此次服务时长" input:_tableView.shiChang leftBtnTitle:@"取消" rightBtnTitle:@"确认"];
    __weak typeof(self) _self = self;
    notice.LFWDNoticeViewBlock = ^(NSInteger index, NSString *time) {
        __strong typeof(_self) self = _self;
        if (!(time.length > 0)) {
            [XMHProgressHUD showOnlyText:@"请确定服务时间"];
            return ;
        }
        if ([time isEqualToString:@"0"]) {
            [XMHProgressHUD showOnlyText:@"服务时长不能为0"];
            return ;
        }
        if (index == 1) {
            XMHComputeOredrVC *vc = XMHComputeOredrVC.new;
            vc.createOrderType = self.createOrderType;
            vc.selectUserModel = self.selectUserModel;
            vc.modelArray = self.modelArray;
            vc.shiChang = time;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
}

#pragma mark - XMHServiceOrderListTableViewDelegate

/**
 全部开始服务
 */
- (void)startServiceTableView:(XMHServiceOrderListTableView *)tableView {
    // 校验是否选了技师
    if (![self checkSelectJishi]) {
        [MzzHud toastWithTitle:@"提示" message:@"有项目或产品未选技师"];
        return;
    }
    
    __weak typeof(self) _self = self;
    MzzHud *hudView = [[MzzHud alloc] initWithTitle:@"温馨提示" message:@"确定要开始全部服务？" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
        __strong typeof(_self) self = _self;
        if (index == 1) {
            self.tableView.isServiceState = YES;
            [self.tableView reloadData];
        }
    }];
    [hudView show];
}

/**
 添加技师
 */
- (void)addJiShiTableView:(XMHServiceOrderListTableView *)tableView indexPath:(NSIndexPath *)indexPath {
    XMHSelectJiShiVC *vc = XMHSelectJiShiVC.new;
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof(self) _self = self;
    [vc setSelectBlock:^(XMHSelectJiShiVC * _Nonnull vc, MLJiShiModel * _Nonnull jiShiModel) {
        __strong typeof(_self) self = _self;
        id model = tableView.modelArray[indexPath.row];
        if ([model respondsToSelector:@selector(jiShiList)]) {
            SLS_Pro *amodel = (SLS_Pro *)model;
            
            if (![self existJishiModel:jiShiModel list:amodel.jiShiList]) {
                [amodel.jiShiList addObject:jiShiModel];
            }

            [tableView reloadData];
        }
    }];
}

/**
 删除项目或商品
 */
- (void)deleteProjectGoodsTableView:(XMHServiceOrderListTableView *)tableView indexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) _self = self;
    MzzHud *hudView = [[MzzHud alloc] initWithTitle:@"温馨提示" message:@"确定是否要删除此项？" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
        __strong typeof(_self) self = _self;
        if (index == 1) {
            // 移除购物车数据
            id model = self.modelArray[indexPath.row];
            [XMHShoppingCartManager.sharedInstance deleteModel:model];
            // 重新赋值新数据并刷新
            self.modelArray = XMHShoppingCartManager.sharedInstance.dataArray;
            self.tableView.modelArray = self.modelArray;
            
            if (self.modelArray.count == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    [hudView show];
}


@end
