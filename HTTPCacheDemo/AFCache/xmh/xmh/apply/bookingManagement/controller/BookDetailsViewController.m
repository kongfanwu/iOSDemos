//
//  BookDetailsViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookDetailsViewController.h"
#import "OneStepView.h"
#import "SearchView.h"
#import "OneStepTableViewCell.h"
#import "OneStepUserDescribeView.h"
#import "BookRequest.h"
#import "YiYuYueModel.h"
#import "CustomerMessageModel.h"
#import "BookDetailTableViewCell.h"
#import "CustomerBookProjectModel.h"
#import "ShareBookInstance.h"
#import "BookProjectViewController.h"
#import "ServiceTimeViewController.h"
#import "LolJiShiTimeModel.h"
#import "LolSkipToDetailMode.h"
#import "LolDetailModel.h"
#import "SubmitModel.h"
#import "OneStepTableFooterView.h"
#import "CustomerListModel.h"
@interface BookDetailsViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UITextViewDelegate
>

@end

@implementation BookDetailsViewController{
    //列表
    UITableView * _tb;
    //数据源数组
    NSMutableArray * _dataArr;
    //个人信息View
    OneStepUserDescribeView * _userDescribeView;
    //顾客预约模型
    CustomerBookProjectModel * _projectModel;
    //顾客个人信息model
    CustomerMessageModel * _customerMessageModel;
    
    OneStepView * _one;
    
    NSString * _type;
    // 技师和时间的model
    LolJiShiTimeModel * _jiShiTimeModel;
    //预约项目数组
    NSMutableArray * _bookXiangMuArr;
    //顾客预约项目的model
    LolDetailModel * _detailModel;
    // 提交参数的model
    SubmitModel * _submitModel;
    //
    UITextView * _textView;
    
    OneStepTableFooterView * _footerView;
    
    customNav * _nav;
    
    BOOL  _isWait;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    _isWait = NO;
}
// 加载顾客信息的请求
- (void)loadHeaderViewDataByUserId:(NSString *)usrId
{
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary *parmsDic = [@{@"user_id":usrId} mutableCopy];
    [request requestCustomerMessageParams:parmsDic resultBlock:^(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _userDescribeView.cModel = customerMessageModel;
            _customerMessageModel = customerMessageModel;
            _submitModel.join_code = customerMessageModel.join_code;
            _submitModel.store_code = customerMessageModel.store_code;
            _submitModel.jis =  customerMessageModel.jis;
            [_tb reloadData];
        }else{
            MzzLog(@"......%@",errorDic);
        }
    }];
}
- (void)loadTableViewDataType:(NSString *)type orderNum:(NSString *)orderNum
{
//    if ((_skipModel.to_gd.length>0)) {
//        return;
//    }
    NSMutableDictionary *projectParmsDic = [@{@"ordernum":orderNum,@"type":type,@"to_gd":_skipModel.to_gd?_skipModel.to_gd:@""} mutableCopy];
    BookRequest * request = [[BookRequest alloc] init];
    [request requestDetailParams:projectParmsDic resultBlock:^(LolDetailModel *detailModel, BOOL isSuccess, NSDictionary *errorDic) {
        _detailModel = detailModel;
        _submitModel.appo_data = _detailModel.appo_data;
        _footerView.textView.text = _detailModel.content;
        _footerView.lb1.text = @"";
        _footerView.lbNumLimit.text = [NSString stringWithFormat:@"%ld/300",_detailModel.content.length];
        [_tb reloadData];
    }];
}
// 待预约model
-(void)setDModel:(DaiYuYueModel *)dModel
{
    _dModel = dModel;
    [self loadHeaderViewDataByUserId:dModel.user_id];
    
    _submitModel = [[SubmitModel alloc] init];
    _submitModel.user_id = dModel.user_id;
    _submitModel.jis = _customerMessageModel.jis;
    _submitModel.appo_data = _jiShiTimeModel.time;
    _submitModel.join_code = _customerMessageModel.join_code;
    _submitModel.store_code = _customerMessageModel.store_code;
    _submitModel.content = _textView.text;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    if ([dModel.type isEqualToString:@"pro_rec"]) {
        [dict setValue:dModel.relation_id forKey:@"relation_id"];
        [dict setValue:dModel.relation_ordernum forKey:@"relation_ordernum"];
        _submitModel.pro = @[dict].jsonData;
    }else{
        [dict setValue:dModel.pres_ordernum forKey:@"pres_ordernum"];
        [dict setValue:dModel.ly_type forKey:@"ly_type"];
        _submitModel.pres = @[dict].jsonData;
    }
    _isWait = YES;
}
// 除待预约以外的跳转的model
- (void)setSkipModel:(LolSkipToDetailMode *)skipModel
{
    _skipModel = skipModel;
    [self loadHeaderViewDataByUserId:skipModel.user_id];
    [self loadTableViewDataType:skipModel.type orderNum:skipModel.ordernum];
    _submitModel = [[SubmitModel alloc] init];
    _submitModel.user_id = skipModel.user_id;
    NSMutableArray * proArr = [[NSMutableArray alloc] init];
    NSMutableArray * presArr = [[NSMutableArray alloc] init];
    //重新选择了项目
    if (_bookXiangMuArr.count > 0) {
        for (DaiYuYueModel * model in _bookXiangMuArr) {
            NSDictionary * dict = [[NSDictionary alloc] init];
            if ([model.type isEqualToString:@"pro_rec"]) {
                [dict setValue:model.relation_id forKey:@"relation_id"];
                [dict setValue:model.relation_ordernum forKey:@"relation_ordernum"];
                [proArr addObject:dict];
            }else{
                [dict setValue:model.pres_ordernum forKey:@"pres_ordernum"];
                [dict setValue:model.ly_type forKey:@"ly_type"];
                [presArr addObject:dict];
            }
        }
        _submitModel.pro = [proArr arr2Json:proArr];
        _submitModel.pres = [presArr arr2Json:presArr];
    //证明是自带的项目
    }else{
        _submitModel.jis = _customerMessageModel.jis;
        _submitModel.appo_data = _detailModel.appo_data;
        _submitModel.content = @"";
        _submitModel.join_code = _customerMessageModel.join_code;
        _submitModel.store_code = _customerMessageModel.store_code;
        _submitModel.content = _textView.text;
    }
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
    _one = one;
    [one.btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    one.frame = CGRectMake(0, self.view.height - 70, SCREEN_WIDTH, 70);
    if ([_skipModel.type isEqualToString:@"ghwdd"]) {
        [_one.btn setTitle:@"生成预约" forState:UIControlStateNormal];
    }else if ([_skipModel.type isEqualToString:@"yyy"] || [_skipModel.type isEqualToString:@"xgyy"]){
        [_one.btn setTitle:@"修改预约" forState:UIControlStateNormal];
    }else if ([_skipModel.type isEqualToString:@"wasdd"]){
        _one.hidden = YES;
    }
    if (_isWait) {
        _nav.lbTitle.text = @"生成预约";
        [_one.btn setTitle:@"生成预约" forState:UIControlStateNormal];
    }
    [self.view addSubview:one];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    
    UIView * tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10 + 88)];
    tableHeaderView.backgroundColor = kBackgroundColor;
    
//    SearchView * search = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    [tableHeaderView addSubview:search];
//
    _userDescribeView = [[[NSBundle mainBundle]loadNibNamed:@"OneStepUserDescribeView" owner:nil options:nil]lastObject];
    _userDescribeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 98);
    [tableHeaderView addSubview:_userDescribeView];
    
     _footerView =  [[[NSBundle mainBundle]loadNibNamed:@"OneStepTableFooterView" owner:nil options:nil]lastObject];
    _footerView.textView.delegate = self;
    _tb.tableHeaderView = tableHeaderView;
    _tb.tableFooterView = _footerView;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _footerView.lb1.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    _submitModel.content = textView.text;
      _footerView.lbNumLimit.text = [NSString stringWithFormat:@"%ld/300",_submitModel.content.length];
}
- (void)textViewDidChange:(UITextView *)textView{
    _submitModel.content = textView.text;
    _footerView.lbNumLimit.text = [NSString stringWithFormat:@"%ld/300",_submitModel.content.length];
    
}
- (void)creatNav
{
    NSString * title;
    if (_isWait) {
        title = @"生成预约";
    }else{
        title = @"详情页";
    }
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:title withleftImageStr:@"back" withRightStr:nil];
    _nav = nav;
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cellName";
    BookDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookDetailTableViewCell" owner:nil options:nil]lastObject];
    }
    if (indexPath.row ==0) {
        cell.lb3.text = @"请选择顾客预约内容";
    }else{
        cell.lb3.text = @"请选择服务技师时间";
    }
    if ([_skipModel.type containsString:@"wasdd"]) {
        cell.imgvMore.hidden = YES;
    }else{
        cell.imgvMore.hidden = NO;
    }
    //判断是否是待预约过来的
    if (_dModel) {
        //第一个cell 是预约内容
        if (indexPath.row == 0) {
            // 判断是否是新选择的项目
            if(_bookXiangMuArr.count >0) {
                cell.modelArr = _bookXiangMuArr;
            }else{
              [cell updateBookDetailTableViewCellDaiYuYueModel:_dModel];
            }
        //第二cell是服务技师时间
        }else{
            cell.jiShiTimeModel = _jiShiTimeModel;
        }
    //除待预约意外其他界面过来的
    }else{
        if (indexPath.row == 0) {
            if(_bookXiangMuArr.count >0) {
                cell.modelArr = _bookXiangMuArr;
            }else{
                cell.detailModel = _detailModel;
            }
        }else{
            if (_jiShiTimeModel) {
                cell.jiShiTimeModel = _jiShiTimeModel;
            }else{
                cell.lb1.text = [NSString stringWithFormat:@"服务技师:%@",_customerMessageModel.jis_name];
                cell.lb2.text = [NSString stringWithFormat:@"服务时间:%@",_detailModel.appo_data];
            }
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_skipModel.type isEqualToString:@"wasdd"]) {
        return;
    }
    if (indexPath.row==0) {
        BookProjectViewController * book = [[BookProjectViewController alloc] init];
        book.cModel = _customerMessageModel;
        book.BookProjectViewControllerBlock = ^(NSMutableArray *modelArr) {
            _bookXiangMuArr = modelArr;
            [_tb reloadData];
        };
        [self.navigationController pushViewController:book animated:NO];
    }else{
        ServiceTimeViewController * service = [[ServiceTimeViewController alloc] init];
        service.customerModel = _customerMessageModel;
        service.ServiceTimeViewControllerBlock = ^(LolJiShiTimeModel *model) {
            _jiShiTimeModel = model;
            [_tb reloadData];
        };
        [self.navigationController pushViewController:service animated:NO];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark - submit
- (void)submit{
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

- (void)commitData
{
    WeakSelf
    NSMutableDictionary * appoDict = [[NSMutableDictionary alloc] init];
    [appoDict setValue:_skipModel.ordernum forKey:@"ordernum"];
    [appoDict setValue:@"0" forKey:@"update"];
    NSString * appoJson = @"";
    if (_skipModel) {
        NSArray * arr = @[appoDict];
        appoJson = arr.jsonData;
    }
    
    BookRequest * request = [[BookRequest alloc] init];
    if (_jiShiTimeModel) {
        _submitModel.appo_data = _jiShiTimeModel.time;
    }
    NSMutableDictionary *parmsDic = [@{@"user_id":_submitModel.user_id?_submitModel.user_id:@"",@"jis":_submitModel.jis?_submitModel.jis:@"",@"appo_data":_submitModel.appo_data?_submitModel.appo_data:@"",@"content":_submitModel.content?_submitModel.content:@"",@"join_code":_submitModel.join_code?_submitModel.join_code:@"",@"store_code":_submitModel.store_code?_submitModel.store_code:@"",@"pro":_submitModel.pro?_submitModel.pro:@"",@"pres":_submitModel.pres?_submitModel.pres:@"",@"appo":appoJson?appoJson:@""} mutableCopy];
    [request requestSubmitParams:parmsDic resultBlock:^(BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"预约成功"];
            [weakSelf performSelector:@selector(back) withObject:nil afterDelay:2];
        }else{
            MzzLog(@"失败");
            //            [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionBottom title:@"提交失败"];
            [XMHProgressHUD showOnlyText:@"提交失败"];
        }
    }];
}
@end
