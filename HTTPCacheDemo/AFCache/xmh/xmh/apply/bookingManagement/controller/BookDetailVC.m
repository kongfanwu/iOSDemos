//
//  BookDetailVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookDetailVC.h"
/** 网路请求 */
#import "BookRequest.h"
/** 通用 */
/** 自定义Cell */
#import "BookDetailCell.h"
/** 自定义View */
#import "BookDetailHeader.h"
#import "BookDetaiTbSectionHeader.h"
#import "RemarkView.h"
/** VC */
#import "BookProjectViewController.h"
#import "BookTimeVC.h"
/** 模型 */
#import "BookParamModel.h"
#import "LolDetailModel.h"
#import "CommonSubmitView.h"
@interface BookDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)BookDetailHeader * tbHeader;
@property (nonatomic, strong)RemarkView * tbFooter;
@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic,strong)CommonSubmitView *commonSubmitView;
@end

@implementation BookDetailVC
{
    LolDetailModel * _detailModel;
    NSDictionary * _btnTitleDic;
    CustomerMessageModel * _customerModel;
    NSMutableArray * _selectProjectArr;
    /** 备注 */
    NSString * _content;
    /** 选择日期 */
    NSString * _selectDate;
    /** 选择时间段 */
    NSMutableArray * _selectTimeArr;
    /** 是否修改了原有时间数据 */
    BOOL _isModifyTime;
    /** 是否修改了原有项目数据 */
    BOOL _isModifyPro;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 初始化数据 */
    _btnTitleDic = @{@"ghwdd":@"生成预约",@"yyy":@"修改预约",@"xgyy":@"修改预约",@"wasdd_appo":@"修改预约",@"wasdd_pres":@"修改预约",@"ahdd":@"生成预约",@"ghydd":@"生成预约"};
    /** 默认没有修改原有数据 */
    _isModifyPro = NO;
    _isModifyTime = NO;
    
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:_paramModel.vcTitle backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.commonSubmitView];
    [self.view addSubview:self.tbView];
//    [self.view addSubview:self.sureBtn];
    if ([_paramModel.type containsString:@"wasdd"]) {
        _sureBtn.hidden = YES;
    }
//    [_sureBtn setTitle:_btnTitleDic[_paramModel.type] forState:UIControlStateNormal];
    [_commonSubmitView updateCommonSubmitViewTitle:_btnTitleDic[_paramModel.type]];
    [self requestTbHeaderData];
    [self requestTbViewData];
}
- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        _commonSubmitView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
        _commonSubmitView.CommonSubmitViewBlock = ^{
            [[[MzzHud alloc]initWithTitle:@"平台提醒" message:@"是否确认生成此预约" leftButtonTitle:@"放弃预约" rightButtonTitle:@"立即预约" click:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf commit];
                }
            }]show];
        };
    }
    return _commonSubmitView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 70) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.backgroundColor = [UIColor clearColor];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView  = self.tbHeader;
        _tbView.tableFooterView = self.tbFooter;
//        _tbView.scrollEnabled = NO;
    }
    return _tbView;
}
- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = kBtn_Commen_Color;
        _sureBtn.titleLabel.font = FONT_SIZE(16);
        _sureBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 44 * 2, SCREEN_WIDTH - 30, 44);
        [_sureBtn setTitle:@"生成预约" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (BookDetailHeader *)tbHeader
{
    if (!_tbHeader) {
        _tbHeader = loadNibName(@"BookDetailHeader");
    }
    return _tbHeader;
}
- (RemarkView *)tbFooter
{
    if (!_tbFooter) {
        _tbFooter = loadNibName(@"RemarkView");
        _tbFooter.RemarkViewBlock = ^(NSString *inPut) {
            _content = inPut;
        };
    }
    return _tbFooter;
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_detailModel) {
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBookDetailCell = @"kBookDetailCell";
    BookDetailCell * bookDetailCell = [tableView dequeueReusableCellWithIdentifier:kBookDetailCell];
    if (!bookDetailCell) {
        bookDetailCell = loadNibName(@"BookDetailCell");
    }
    _detailModel.cellIndex = indexPath.row;
    [bookDetailCell updateBookDetailCellModel:_detailModel];
    return bookDetailCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 跳转待选项目界面 */
    if (indexPath.row == 0) {
        BookProjectViewController * bookProjectVC = [[BookProjectViewController alloc] init];
        bookProjectVC.userID = _paramModel.userID;
        bookProjectVC.BookProjectViewControllerProjectBlock = ^(NSString *proStr, NSInteger maxTime) {
//            LolDetailModel * model = [[LolDetailModel alloc] init];
//            model.pro_list = proStr;
//            model.max_time = maxTime;
//            model.cellIndex = 0;
//            _detailModel = model;
            if (proStr.length > 0) {
                _detailModel.pro_list = proStr;
                _detailModel.max_time = maxTime;
                _detailModel.cellIndex = 0;
                _detailModel.appo_data = nil;
                _detailModel.jis_name = nil;
            }
            _selectDate = nil;
            [_selectTimeArr removeAllObjects];
            [_tbView reloadData];
        };
        bookProjectVC.BookProjectViewControllerBlock = ^(NSMutableArray *modelArr) {
            _selectProjectArr = modelArr;
            _isModifyPro = YES;
        };
        [self.navigationController pushViewController:bookProjectVC animated:YES];
    }
    /** 跳转员工时间界面 */
    if (indexPath.row == 1) {
        BookTimeVC * bookTimeVC = [[BookTimeVC alloc] init];
        bookTimeVC.customerModel = _customerModel;
        bookTimeVC.maxTime = _detailModel.max_time;
        bookTimeVC.BookTimeVCBlock = ^(NSMutableArray *selectArr, NSString *selectDate) {
            _selectDate = selectDate;
            _selectTimeArr = selectArr;
            if (selectDate.length > 0 && selectArr.count > 0) {
                _detailModel.appo_data = [NSString stringWithFormat:@"%@ %@:00",selectDate,selectArr[0]];
                _detailModel.jis_name = _customerModel.jis_name;
            }
            [_tbView reloadData];
            _isModifyTime = YES;
        };
        [self.navigationController pushViewController:bookTimeVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BookDetaiTbSectionHeader * detailSectionHeader = loadNibName(@"BookDetaiTbSectionHeader");
    [detailSectionHeader updateBookDetaiTbSectionHeader:section];
    detailSectionHeader.BookDetaiTbSectionHeaderBlock = ^(NSInteger index) {
        /** 跳转待选项目界面 */
        if (index == 0) {
            BookProjectViewController * bookProjectVC = [[BookProjectViewController alloc] init];
            bookProjectVC.userID = _paramModel.userID;
            bookProjectVC.BookProjectViewControllerProjectBlock = ^(NSString *proStr, NSInteger maxTime) {
//                LolDetailModel * model = [[LolDetailModel alloc] init];
//                model.pro_list = proStr;
//                model.max_time = maxTime;
//                model.cellIndex = 0;
//                _detailModel = model;
                if (proStr.length > 0) {
                    _detailModel.pro_list = proStr;
                    _detailModel.max_time = maxTime;
                    _detailModel.cellIndex = 0;
                    _detailModel.appo_data = nil;
                    _detailModel.jis_name = nil;
                }
                _selectDate = nil;
                [_selectTimeArr removeAllObjects];
                [_tbView reloadData];
            };
            bookProjectVC.BookProjectViewControllerBlock = ^(NSMutableArray *modelArr) {
                _selectProjectArr = modelArr;
                _isModifyPro = YES;
            };
            [self.navigationController pushViewController:bookProjectVC animated:YES];
        }
        /** 跳转员工时间界面 */
        if (index == 1) {
            BookTimeVC * bookTimeVC = [[BookTimeVC alloc] init];
            bookTimeVC.customerModel = _customerModel;
            bookTimeVC.maxTime = _detailModel.max_time;
            bookTimeVC.BookTimeVCBlock = ^(NSMutableArray *selectArr, NSString *selectDate) {
                _selectDate = selectDate;
                _selectTimeArr = selectArr;
                if (selectDate.length > 0 && selectArr.count > 0) {
                    _detailModel.appo_data = [NSString stringWithFormat:@"%@ %@:00",selectDate,selectArr[0]];
                    _detailModel.jis_name = _customerModel.jis_name;
                }
                [_tbView reloadData];
                _isModifyTime = YES;
            };
            [self.navigationController pushViewController:bookTimeVC animated:YES];
        }
    };
    return detailSectionHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_detailModel) {
        return 0.0f;
    }
    return 54.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_detailModel) {
        return 1;
    }
    return 2;
}
#pragma mark ------网络请求------
/** 加载头部数据 */
- (void)requestTbHeaderData
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_paramModel.userID?_paramModel.userID:@"" forKey:@"user_id"];
    [BookRequest requestCustomerMessageParams:params resultBlock:^(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _customerModel = customerMessageModel;
            [_tbHeader updateBookDetailHeaderModel:customerMessageModel];
        }else{}
    }];
}
/** 获取预约项目 服务时间 备注 */
- (void)requestTbViewData
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_paramModel.orderNum?_paramModel.orderNum:@"" forKey:@"ordernum"];
    [params setValue:_paramModel.type?_paramModel.type:@"" forKey:@"type"];
    [BookRequest requestDetailParams:params resultBlock:^(LolDetailModel *detailModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _detailModel = detailModel;
            [_tbFooter updateRemarkViewContent:detailModel.content];
            [_tbView reloadData];
        }else{}
    }];
}
/** 提交数据 */
- (void)commit
{
    /** 组织待预约过来的数据 */
    NSMutableDictionary * appoDict = [[NSMutableDictionary alloc] init];
    [appoDict setValue:_paramModel.orderNum forKey:@"ordernum"];
    [appoDict setValue:@"0" forKey:@"update"];
    NSString * appoJson = @"";
    NSArray * arr = @[appoDict];
    appoJson = arr.jsonData;
   
    /** 项目的临时数组 */
    NSMutableArray * proArr = [[NSMutableArray alloc] init];
    /** 处方的临时数组 */
    NSMutableArray * presArr = [[NSMutableArray alloc] init];
    /** 产品的临时数组 */
    NSMutableArray * goodsArr = [[NSMutableArray alloc] init];
    
    /** 组织 （一键预约 和 待预约） 项目处方产品 数据 */
    if (_selectProjectArr.count > 0) {
        for (DaiYuYueModel * model in _selectProjectArr) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            if ([model.type isEqualToString:@"pres"]) {
                [dict setValue:model.pres_ordernum forKey:@"pres_ordernum"];
                [presArr addObject:dict];
            }
            if ([model.type isEqualToString:@"pro"]) {
                [dict setValue:model.relation_id forKey:@"relation_id"];
                [dict setValue:model.relation_ordernum forKey:@"relation_ordernum"];
                [proArr addObject:dict];
            }
            if ([model.type isEqualToString:@"goods"]) {
                [dict setValue:model.goods_id forKey:@"goods_id"];
                [dict setValue:model.goods_ordernum forKey:@"goods_ordernum"];
                [goodsArr addObject:dict];
            }
        }
    }
    
    
    /** 处方json串 */
    NSString * pres = [presArr arr2Json:presArr];
    /** 项目json串 */
    NSString * pro = [proArr arr2Json:proArr];
    /** 产品json串 */
    NSString * goods = [goodsArr arr2Json:goodsArr];
    /** 日期@"2018-10-24" */
    NSString * appo_date = @"";
    if (_isModifyTime) {
        appo_date = [NSString stringWithFormat:@"%@ %@:00",_selectDate,_selectTimeArr[0]];
    }else{
        appo_date = _detailModel.appo_data;
    }
    if (appo_date.length <= 0) {
        [XMHProgressHUD showOnlyText:@"请选择技师时间"];
        return;
    }
    /** 时间段字符串@"9:00,10:00" */
    NSMutableString * timeStr = [[NSMutableString alloc] init];
    if (_selectTimeArr.count > 0) {
        for (int i = 0; i< _selectTimeArr.count; i++) {
            [timeStr appendString:_selectTimeArr[i]];
            [timeStr appendString:@","];
        }
        [timeStr replaceCharactersInRange:NSMakeRange(timeStr.length-1, 1) withString:@""];
    }
    NSString * time_bucket = timeStr;
    /** 顾客id */
    NSString * userID = [NSString stringWithFormat:@"%ld",_customerModel.uid];
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:userID?userID:@"" forKey:@"user_id"];
    [params setValue:_customerModel.jis?_customerModel.jis:@"" forKey:@"jis"];
    [params setValue:appo_date?appo_date:@"" forKey:@"appo_data"];
    [params setValue:_content?_content:@"" forKey:@"content"];
    [params setValue:_customerModel.store_code?_customerModel.store_code:@"" forKey:@"store_code"];
    [params setValue:pro?pro:@"" forKey:@"pro"];
    [params setValue:pres?pres:@"" forKey:@"pres"];
    [params setValue:goods?goods:@"" forKey:@"goods"];
    [params setValue:appoJson?appoJson:@"" forKey:@"appo"];
    [params setValue:time_bucket?time_bucket:@"" forKey:@"time_bucket"];
    [BookRequest requestSubmitParams:params resultBlock:^(BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"预约成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:2];
        }else{
            [XMHProgressHUD showOnlyText:errorDic[@"error"]];
        }
    }];
}
@end
