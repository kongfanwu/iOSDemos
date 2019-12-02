//
//  OneStepBookViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OneStepBookViewController.h"
#import "OneStepTableSectionHeader.h"
#import "ServiceTimeViewController.h"
#import "BookProjectViewController.h"
#import "OneStepSearchViewController.h"
#import "SearchView.h"
#import "OneStepView.h"
#import "OneStepUserDescribeView.h"
#import "OneStepTableViewCell.h"
#import "ShareBookInstance.h"
#import "LolJiShiTimeView.h"
#import "CustomerListModel.h"
#import "LolJiShiTimeModel.h"
#import "DaiYuYueModel.h"
#import "MzzHud.h"
#import "BookRequest.h"
//#import "MBProgressHUD+NHAdd.h"
#import "JasonSearchView.h"
#import "OneStepTableFooterView.h"
static NSString * cellName = @"BookDoneCell";
@interface OneStepBookViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@end

@implementation OneStepBookViewController
{
    //列表
    UITableView * _tb;
    //顾客描述model
    CustomerModel * _customerModel;
    // 技师时间model
    LolJiShiTimeModel * _jiShiTimeModel;
    //搜索控件
    SearchView * _search;
    //第一个section的高度
    NSInteger _heightForSection0;
    //第二个section的高度
    NSInteger _heightForSection1;
    //预约项目数组
    NSMutableArray * _bookXiangMuArr;
    //顾客个人信息model
    CustomerMessageModel * _customerMessageModel;
    
    OneStepTableFooterView * _footerView;
    
    NSString * _beizhu;
    
    JasonSearchView * _jasonSearch;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self initSettings];
    [self initSubViews];
    if (_userId) {
        [self loadHeaderViewDataByUserId:_userId];
    }
}
- (void)loadHeaderViewDataByUserId:(NSString *)usrId
{
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary *parmsDic = [@{@"user_id":usrId} mutableCopy];
    [request requestCustomerMessageParams:parmsDic resultBlock:^(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _customerMessageModel = customerMessageModel;
            CustomerModel * c = [[CustomerModel alloc] init];
            c.uid =  _customerMessageModel.uid;
            c.headimgurl = _customerMessageModel.headimgurl;
            c.jis = _customerMessageModel.jis;
            c.jis_name = _customerMessageModel.jis_name;
            c.join_name = _customerMessageModel.join_code;
            c.mdname = _customerMessageModel.mdname;
            c.mobile = _customerMessageModel.mobile;
            c.uname = _customerMessageModel.uname;
            _customerModel = c;
            [_tb reloadData];
        }else{
            MzzLog(@"......%@",errorDic);
        }
    }];
}
- (void)initSettings
{

}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"一键预约" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _search.textField.enabled = YES;
    [_search.textField resignFirstResponder];
    [_search.bar resignFirstResponder];
}
- (void)initSubViews
{
    [self creatNav];
    [self createTableView];
    [self createBookbtn];
}
- (void)createBookbtn
{
    OneStepView * one = [[[NSBundle mainBundle]loadNibNamed:@"OneStepView" owner:nil options:nil]lastObject];
    one.frame = CGRectMake(0, self.view.height - 70, SCREEN_WIDTH, 70);
    [one.btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:one];
}
- (void)createTableView{
    //添加列表
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tb.backgroundColor = [UIColor clearColor];
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
     _jasonSearch = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)withPlaceholder:@"姓名/手机号"];
    _jasonSearch.searchBar.userInteractionEnabled = NO;
    [_jasonSearch updateFrame];
    //添加搜索View
    _search = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIView * tableHeaderView = [[UIView alloc] init];
//    __weak UITableView * weakTb = _tb;
//    __weak SearchView *weakSearch = _search;
    [tableHeaderView addSubview:_jasonSearch];
    
//    UIView * line = [[UIView alloc] init];
//    line.frame = CGRectMake(0, _search.bottom, SCREEN_WIDTH, 10);
//    line.backgroundColor = kBackgroundColor;
//    [tableHeaderView addSubview:line];
    
    //搜索View点击事件
//    WeakSelf;
//    _search.searchViewBlock = ^{
//        OneStepSearchViewController * searchVC = [[OneStepSearchViewController alloc] init];
//        searchVC.oneStepSearchViewControllerBlock = ^(CustomerModel *model) {
//            _customerModel = model;
//            dispatch_async(dispatch_get_main_queue(), ^{
//               [weakTb reloadData];
//            });
//
//        };
//        weakSearch.textField.enabled = NO;
//        [weakSelf.navigationController pushViewController:searchVC animated:NO];
//    };
//
    UITapGestureRecognizer *tapDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown)];
    [_jasonSearch addGestureRecognizer:tapDown];
    
    
    tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    tableHeaderView.backgroundColor = kBackgroundColor;
    _tb.tableHeaderView = tableHeaderView;
    _footerView = [[[NSBundle mainBundle]loadNibNamed:@"OneStepTableFooterView" owner:nil options:nil]lastObject];
    _tb.tableFooterView = _footerView;
    _footerView.textView.delegate = self;
    _footerView.lb1.text = @"请填写备注内容";
    
}
- (void)tapDown
{
    OneStepSearchViewController * searchVC = [[OneStepSearchViewController alloc] init];
    searchVC.oneStepSearchViewControllerBlock = ^(CustomerModel *model) {
        _customerModel = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tb reloadData];
        });
        
    };
    [self.navigationController pushViewController:searchVC animated:NO];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _footerView.lb1.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    _beizhu = textView.text;
}
- (void)textViewDidChange:(UITextView *)textView
{
    _footerView.lbNumLimit.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OneStepTableSectionHeader * viewSelect = [[[NSBundle mainBundle]loadNibNamed:@"OneStepTableSectionHeader" owner:nil options:nil]lastObject];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTap:)];
    [viewSelect addGestureRecognizer:tap];
    OneStepUserDescribeView * decribe = [[[NSBundle mainBundle]loadNibNamed:@"OneStepUserDescribeView" owner:nil options:nil] lastObject];
    LolJiShiTimeView * timeView = [[[NSBundle mainBundle]loadNibNamed:@"LolJiShiTimeView" owner:nil options:nil]lastObject];
    UIView * sectionView = [[UIView alloc] init];

    if (section == 0) {
        viewSelect.lb.text = @"请选择顾客预约内容";
        viewSelect.tag = 0;
        //是否选择了顾客
        if (_customerModel) {
            _heightForSection0 = 10 + 98 + 10 + 44;
            decribe.frame = CGRectMake(0, 0, SCREEN_WIDTH,98);
            [decribe updateOneStepUserDescribeView:_customerModel];
            viewSelect.frame = CGRectMake(0, 10 + 98, SCREEN_WIDTH, 44);
            sectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _heightForSection0);
            [sectionView addSubview:decribe];
            [sectionView addSubview:viewSelect];
        }else{
            _heightForSection0 = 10 + 44;
            viewSelect.frame = CGRectMake(0, 10, SCREEN_WIDTH, 44);
            sectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _heightForSection0);
            [sectionView addSubview:viewSelect];
        }
        //是否选择了项目
        if (_bookXiangMuArr.count ==0) {
            return sectionView;
        }else{
            _heightForSection0 = 98 + 10 + 44 + 65;
            timeView.frame = CGRectMake(0, 98 + 10 + 44, SCREEN_WIDTH, 65);
            timeView.modelArr = _bookXiangMuArr;
            sectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _heightForSection0);
            [sectionView addSubview:timeView];
            return sectionView;
        }
    }else{
        viewSelect.lb.text = @"请选择服务技师时间";
        viewSelect.tag = 1;
        if (_jiShiTimeModel) {
            _heightForSection1 = 10 + 44 + 65;
            viewSelect.frame = CGRectMake(0, 10, SCREEN_WIDTH, 44);
            timeView.frame = CGRectMake(0, 10 + 44, SCREEN_WIDTH, 65);
            sectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _heightForSection1);
            timeView.model = _jiShiTimeModel;
            [sectionView addSubview:viewSelect];
            [sectionView addSubview:timeView];
            return sectionView;
        }else{
            _heightForSection1 = 10 + 44;
            viewSelect.frame = CGRectMake(0, 10, SCREEN_WIDTH, 44);
            sectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _heightForSection1);
            [sectionView addSubview:viewSelect];
            return sectionView;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneStepTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OneStepTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSInteger heigt = 0;
    if (section == 0) {
        // 选择了顾客和项目
        if (_customerModel && _bookXiangMuArr.count >= 1) {
            heigt =  98 + 10 + 44 + 65;
        }
        // 顾客和项目都没有选择
        if (!_customerModel && _bookXiangMuArr.count == 0) {
            heigt = 10 + 44;
        }
        // 选择了顾客没有选择项目
        if (_customerModel && _bookXiangMuArr.count ==0) {
            heigt = 10 + 98 + 44;
        }
        // 选择了顾客选择了项目
        if (_customerModel && _bookXiangMuArr.count >=1) {
            heigt = 98 + 44 + 10 + 65;
        }
        return heigt;
    }else{
        // 选择技师和时间
        if (_jiShiTimeModel) {
            heigt = 10 + 44 + 65;
        }else{//没有选择了技师和时间
            heigt = 10 + 44;
        }
        return heigt;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
#pragma mark - section点击事件
- (void)sectionTap:(UITapGestureRecognizer *)tap{
    //选择服务项目
    if (tap.view.tag == 0) {
        if (_customerModel) {
            BookProjectViewController * book = [[BookProjectViewController alloc] init];
            book.BookProjectViewControllerBlock = ^(NSMutableArray *modelArr) {
                _bookXiangMuArr = modelArr;
                dispatch_async(dispatch_get_main_queue(), ^{
                   [_tb reloadData];
                });
            };
            book.model = _customerModel;
            [self.navigationController pushViewController:book animated:NO];
        }else{
            [MzzHud toastWithTitle:@"请注意" message:@"请先选择顾客"];
        }
    //选择服务技师和时间
    }else{
        if (_bookXiangMuArr.count ==0) {
            [MzzHud toastWithTitle:@"请注意" message:@"请先选择服务项目"];
        }else{
            ServiceTimeViewController * service = [[ServiceTimeViewController alloc] init];
            service.customerModel = (CustomerMessageModel *)_customerModel;
            service.ServiceTimeViewControllerBlock = ^(LolJiShiTimeModel *model) {
                _jiShiTimeModel = model;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tb reloadData];
                });
            };
            [self.navigationController pushViewController:service animated:NO];
        }
    }
}
#pragma mark -
- (void)back
{
    _customerModel = nil;
    _jiShiTimeModel = nil;
    [_bookXiangMuArr removeAllObjects];
    _bookXiangMuArr = nil;
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - submit
- (void)submit
{
    WeakSelf
    [[[MzzHud alloc] initWithTitle:@"平台提醒" message:@"是否确认生成此预约" leftButtonTitle:@"放弃预约" rightButtonTitle:@"立即预约" click:^(NSInteger index) {
        if (index ==0) {
            return ;
        }
        if (index == 1) {
            [weakSelf commitData];
        }
    }]show];
    
   
}
- (void)commitData{
    WeakSelf
    NSMutableArray * proArr = [[NSMutableArray alloc] init];
    NSMutableArray * presArr = [[NSMutableArray alloc] init];
    
    
    if (!([[NSString stringWithFormat:@"%ld",_customerModel.uid] length]> 0)) {
        [XMHProgressHUD showOnlyText:@"请选择顾客"];
        return;
    }
    if (_bookXiangMuArr.count > 0) {
        for (DaiYuYueModel *model in _bookXiangMuArr) {
            //如果是项目
            if ([model.type isEqualToString:@"pro_rec"]) {
                NSMutableDictionary * presdict = [[NSMutableDictionary alloc] init];
                [presdict setValue:model.relation_id forKey:@"relation_id"];
                [presdict setValue:model.relation_ordernum forKey:@"relation_ordernum"];
                [presdict setValue:@"0" forKey:@"update"];
                [proArr addObject:presdict];
            }else{
                NSMutableDictionary * prodict = [[NSMutableDictionary alloc] init];
                [prodict setValue:model.pres_ordernum forKey:@"pres_ordernum"];
                [prodict setValue:model.ly_type forKey:@"ly_type"];
                [presArr addObject:prodict];
            }
        }
    }else{
        [XMHProgressHUD showOnlyText:@"请选择项目"];
        return;
    }
    if (!(_jiShiTimeModel.time.length > 0)) {
        [XMHProgressHUD showOnlyText:@"请选择预约时间"];
        return;
    }
    
    NSString * proStr = [proArr arr2Json:proArr];
    NSString * presStr = [proArr arr2Json:presArr];
    if (proArr.count ==0) {
        proStr = @"";
    }
    if (presArr.count ==0) {
        presStr = @"";
    }
    
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary *parmsDic = [@{@"user_id":[NSString stringWithFormat:@"%ld",_customerModel.uid],@"jis":_customerModel.jis?_customerModel.jis:@"",@"appo_data":_jiShiTimeModel.time?_jiShiTimeModel.time:@"",@"content":_beizhu?_beizhu:@"",@"join_code":_customerModel.join_code?_customerModel.join_code:@"",@"store_code":_customerModel.store_code?_customerModel.store_code:@"",@"pro":proStr,@"pres":presStr} mutableCopy];
    [request requestSubmitParams:parmsDic resultBlock:^(BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            MzzLog(@"成功");
            [XMHProgressHUD showOnlyText:@"预约成功"];
            [weakSelf performSelector:@selector(back) withObject:nil afterDelay:2];
        }else{
            MzzLog(@"失败");
            [XMHProgressHUD showOnlyText:errorDic[@"error"]];
        }
    }];
}
@end

