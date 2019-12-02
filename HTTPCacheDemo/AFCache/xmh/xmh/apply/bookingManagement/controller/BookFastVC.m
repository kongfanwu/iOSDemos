//
//  BookFastVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookFastVC.h"
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
#import "BookSearchCustomerVC.h"
#import "BookTimeVC.h"
/** 模型 */
#import "BookParamModel.h"
#import "LolDetailModel.h"
#import "CustomerListModel.h"
#import "BookParamModel.h"

#import "BookDoneVC.h"
#import "BookBillHomeVC.h"
#import "CommonSubmitView.h"
@interface BookFastVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)BookDetailHeader * tbHeader;
@property (nonatomic, strong)RemarkView * tbFooter;
@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic, strong)UIImageView * seachView;
@property (nonatomic, strong)UIView * tbSearchHeader;
/** 搜索 和顾客信息 总头部 */
@property (nonatomic, strong)UIView * tbAllHeader;

@property (nonatomic,strong)CommonSubmitView *commonSubmitView;
/** 搜索顾客 返回的model */
@property (nonatomic,strong) CustomerModel * searchCustomerModel;
/** 顾客模型 头部数据 */
@property (nonatomic,strong) CustomerMessageModel * customerModel;
@property (nonatomic,strong)LolDetailModel * detailModel;
@property (nonatomic,strong)NSDictionary * btnTitleDic;
@property (nonatomic,strong)NSMutableArray * selectProjectArr;
/** 备注 */
@property (nonatomic,copy) NSString * content;
/** 选择日期 */
@property (nonatomic,copy) NSString * selectDate;
/** 选择时间段 */
@property (nonatomic,strong)  NSMutableArray * selectTimeArr;
@end

@implementation BookFastVC

- (void)dealloc
{
    NSLog(@"BookFastVC dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    
    self.navView.backgroundColor = kBtn_Commen_Color;
     [self.view addSubview:self.commonSubmitView];
    /** 待预约跳转来 */
    if (_paramModel) {
        [self.navView setNavViewTitle:@"生成预约" backBtnShow:YES];
//        [_sureBtn setTitle:@"生成预约" forState:UIControlStateNormal];
         [_commonSubmitView updateCommonSubmitViewTitle:@"生成预约"];
    }else{/** 一键预约跳转过来 */
        [self.navView setNavViewTitle:@"一键预约" backBtnShow:YES];
//        [_sureBtn setTitle:@"一键预约" forState:UIControlStateNormal];
         [_commonSubmitView updateCommonSubmitViewTitle:@"一键预约"];
    }
    [self.view addSubview:self.tbView];
//    [self.view addSubview:self.sureBtn];
   
    
    if (_paramModel) {
        [self requestTbHeaderData];
    }
}
- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        _commonSubmitView.frame = CGRectMake(0, SCREEN_HEIGHT - 70 - kSafeAreaBottom, SCREEN_WIDTH, 70);
        _commonSubmitView.CommonSubmitViewBlock = ^{
            [[[MzzHud alloc]initWithTitle:@"平台提醒" message:@"是否确认生成此预约" leftButtonTitle:@"放弃预约" rightButtonTitle:@"立即预约" click:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf commit];
                }else if (index == 0 && [weakSelf.paramModel.type isEqualToString:@"zxjg"]){
                    [weakSelf back];
                }
            }]show];
        };
    }
    return _commonSubmitView;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav- 70 - kSafeAreaBottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.backgroundColor = [UIColor clearColor];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableFooterView = self.tbFooter;
        _tbView.tableHeaderView = self.tbSearchHeader;
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
- (UIView *)tbAllHeader
{
    WeakSelf
    if (!_tbAllHeader) {
        _tbAllHeader = [[UIView alloc] init];
        _tbAllHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108 + 63 + 10);
        weakSelf.seachView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 63);
        _tbAllHeader.backgroundColor = [UIColor clearColor];
        [_tbAllHeader addSubview:weakSelf.seachView];
        
        weakSelf.tbHeader.frame = CGRectMake(0, weakSelf.seachView.bottom, SCREEN_WIDTH, 108);
        [_tbAllHeader addSubview:weakSelf.tbHeader];
    }
    return _tbAllHeader;
}
- (BookDetailHeader *)tbHeader
{
    if (!_tbHeader) {
        _tbHeader = loadNibName(@"BookDetailHeader");
    }
    return _tbHeader;
}
- (UIImageView *)seachView
{
    if (!_seachView) {
        _seachView = [[UIImageView alloc] initWithImage:UIImageName(@"yygl_search")];
        _seachView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_seachView addGestureRecognizer:tap];
    }
    return _seachView;
}
- (UIView *)tbSearchHeader
{
    WeakSelf
    if (!_tbSearchHeader) {
        _tbSearchHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 83)];
         weakSelf.seachView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 63);
        [_tbSearchHeader addSubview:weakSelf.seachView];
    }
    return _tbSearchHeader;
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    BookSearchCustomerVC * searchCustomerVC = [[BookSearchCustomerVC alloc] init];
    __weak typeof(self) _self = self;
    searchCustomerVC.BookSearchCustomerVCBlock = ^(CustomerModel *model) {
        __strong typeof(_self) self = _self;
        self.searchCustomerModel = model;
        self.detailModel = nil;
        [self.selectProjectArr removeAllObjects];
        self.selectDate = nil;
        [self.selectTimeArr removeAllObjects];
        [self.tbView reloadData];
        [self refreshTbHeaderViewShow];
    };
   [self.navigationController pushViewController:searchCustomerVC animated:NO];
}
- (void)refreshTbHeaderViewShow
{
    if (_searchCustomerModel) {
        _tbView.tableHeaderView = self.tbAllHeader;
    }else{
        _tbView.tableHeaderView = self.tbSearchHeader;
    }

    CustomerMessageModel * model = [[CustomerMessageModel alloc] init];
    model.uname = _searchCustomerModel.uname;
    model.headimgurl = _searchCustomerModel.headimgurl;
    model.grade = _searchCustomerModel.grade_name;
    model.uid = _searchCustomerModel.uid;
    model.mobile = _searchCustomerModel.mobile;
    model.store_code = _searchCustomerModel.store_code;
    model.jis = _searchCustomerModel.jis;
    model.jis_name = _searchCustomerModel.jis_name;
    model.mdname = _searchCustomerModel.mdname;
    model.join_name = _searchCustomerModel.join_name;
    _customerModel = model;
    [_tbHeader updateBookDetailHeaderModel:model];
}
- (RemarkView *)tbFooter
{
    if (!_tbFooter) {
        _tbFooter = loadNibName(@"RemarkView");
        __weak typeof(self) _self = self;
        _tbFooter.RemarkViewBlock = ^(NSString *inPut) {
            __strong typeof(_self) self = _self;
            self.content = inPut;
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
        bookProjectVC.userID = [NSString stringWithFormat:@"%ld",_customerModel.uid];
        __weak typeof(self) _self = self;
        bookProjectVC.BookProjectViewControllerProjectBlock = ^(NSString *proStr, NSInteger maxTime) {
            __strong typeof(_self) self = _self;
            LolDetailModel * model = [[LolDetailModel alloc] init];
            model.pro_list = proStr;
            model.max_time = maxTime;
            model.cellIndex = 0;
            self.detailModel = model;
            self.selectDate = nil;
            [self.selectTimeArr removeAllObjects];
            [self.tbView reloadData];
        };
        bookProjectVC.BookProjectViewControllerBlock = ^(NSMutableArray *modelArr) {
            __strong typeof(_self) self = _self;
            self.selectProjectArr = modelArr;
        };
        [self.navigationController pushViewController:bookProjectVC animated:YES];
    }
    /** 跳转员工时间界面 */
    if (indexPath.row == 1) {
        BookTimeVC * bookTimeVC = [[BookTimeVC alloc] init];
        bookTimeVC.customerModel = _customerModel;
        bookTimeVC.maxTime = _detailModel.max_time;
        __weak typeof(self) _self = self;
        bookTimeVC.BookTimeVCBlock = ^(NSMutableArray *selectArr, NSString *selectDate) {
            __strong typeof(_self) self = _self;
            self.selectDate = selectDate;
            self.selectTimeArr = selectArr;
//            _detailModel.appo_data = [NSString stringWithFormat:@"%@ %@-%@",selectDate,selectArr[0],[selectArr lastObject]];
            self.detailModel.appo_data = [NSString stringWithFormat:@"%@ %@:00",selectDate,selectArr[0]];
            self.detailModel.jis_name = self.customerModel.jis_name;
            [self.tbView reloadData];
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
    __weak typeof(self) _self = self;
    detailSectionHeader.BookDetaiTbSectionHeaderBlock = ^(NSInteger index) {
        __strong typeof(_self) self = _self;
        /** 跳转待选项目界面 */
        if (index == 0) {
            if (!self.customerModel) {
                [XMHProgressHUD showOnlyText:@"请先选择顾客"];
                return ;
            }
            BookProjectViewController * bookProjectVC = [[BookProjectViewController alloc] init];
            bookProjectVC.userID = [NSString stringWithFormat:@"%ld",(long)self.customerModel.uid];
            bookProjectVC.BookProjectViewControllerProjectBlock = ^(NSString *proStr, NSInteger maxTime) {
                LolDetailModel * model = [[LolDetailModel alloc] init];
                model.pro_list = proStr;
                model.max_time = maxTime;
                model.cellIndex = 0;
                self.detailModel = model;
                self.selectDate = nil;
                [self.selectTimeArr removeAllObjects];
                [self.tbView reloadData];
            };
            bookProjectVC.BookProjectViewControllerBlock = ^(NSMutableArray *modelArr) {
                self.selectProjectArr = modelArr;
            };
            [self.navigationController pushViewController:bookProjectVC animated:YES];
        }
        /** 跳转员工时间界面 */
        if (index == 1) {
            if (!self.detailModel) {
                [XMHProgressHUD showOnlyText:@"请先选择项目"];
            }else{
                BookTimeVC * bookTimeVC = [[BookTimeVC alloc] init];
                bookTimeVC.customerModel = self.customerModel;
                bookTimeVC.maxTime = self.detailModel.max_time;
                bookTimeVC.BookTimeVCBlock = ^(NSMutableArray *selectArr, NSString *selectDate) {
                    self.selectDate = selectDate;
                    self.selectTimeArr = selectArr;
                    self.detailModel.appo_data = [NSString stringWithFormat:@"%@ %@:00",selectDate,selectArr[0]];
                    self.detailModel.jis_name = self.customerModel.jis_name;
                    [self.tbView reloadData];
                };
                [self.navigationController pushViewController:bookTimeVC animated:YES];
            }
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
            _tbView.tableHeaderView = self.tbHeader;
            [_tbHeader updateBookDetailHeaderModel:customerMessageModel];
        }else{}
    }];
}
- (void)commit
{
    if (!_customerModel) {
        [XMHProgressHUD showOnlyText:@"请先选择顾客"];
        return;
    }
    if (_selectProjectArr.count == 0) {
        [XMHProgressHUD showOnlyText:@"请选择项目"];
        return;
    }
    if(!_selectDate && _selectTimeArr.count==0){
        [XMHProgressHUD showOnlyText:@"请选择技师时间"];
        return;
    }
    NSString * appoJson = @"";
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
    /** 日期@"2018-10-24 00:00:00" */
//    NSString * appo_date = _selectDate;
    NSString * appo_date = [NSString stringWithFormat:@"%@ %@:00",_selectDate,_selectTimeArr[0]];
    /** 时间段字符串@"9:00,10:00" */
    NSMutableString * timeStr = [[NSMutableString alloc] init];
    for (int i = 0; i< _selectTimeArr.count; i++) {
        [timeStr appendString:_selectTimeArr[i]];
        [timeStr appendString:@","];
    }
    [timeStr replaceCharactersInRange:NSMakeRange(timeStr.length-1, 1) withString:@""];
    NSString * time_bucket = timeStr;
    /** 顾客id */
    NSString * userID = [NSString stringWithFormat:@"%ld",(long)_customerModel.uid];
    
    
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
            
//            BookDoneVC * doneVC = [[BookDoneVC alloc] init];
//            [self.navigationController pushViewController:doneVC animated:NO];
            
        }else{
            [XMHProgressHUD showOnlyText:errorDic[@"error"]];
        }
    }];
}
///** 预约成功跳转 预约订单 tab 已预约 */
//- (void)push
//{
//    BookBillHomeVC * next = [[BookBillHomeVC alloc] init];
//    next.selectIndex = 1;
//    [self.navigationController pushViewController:next animated:NO];
//}
@end
