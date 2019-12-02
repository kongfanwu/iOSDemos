//
//  FWDController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDController.h"
#import "FWDHeaderView.h"
#import "FWDWebCell.h"
#import "FWDYeJiCell.h"
#import "FWDHaoKaCell.h"
#import "FWDCommitView.h"
#import "LFreezeCell3.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "SLRequest.h"
#import "MLJishiSearchModel.h"
#import "FWDSelectView.h"
#import "MzzCustomerRequest.h"
#import "SLSearchManagerModel.h"
#import "MzzStoreModel.h"
#import "LSelectBaseModel.h"
#import "FWDYeJGuiShuModel.h"
#import "FWDDetailViewController.h"
#import "SLOrderNumModel.h"
#import "FWDCommentCell.h"
#import "NSString+Costom.h"
#import "FWDRecordController.h"
#import "OrderManagementViewController.h"
#import "FWDAleartVIew.h"
#import "BookBillHomeVC.h"
@interface FWDController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataModelarr;//获取每个项目中的技师model数组
@property (nonatomic, assign) BOOL clickSubmit;//是否点击提交按钮
@property (nonatomic, assign) int modelnum;//每个项目中的技师数量
@property (nonatomic, strong)FWDAleartVIew * alertView;
@end

@implementation FWDController
{
    UITableView * _tb;
    MLJishiSearchModel *_jisListModel;
    SLSearchManagerModel * _managerListModel;
    MzzStoreList * _storeListModel;
    FWDSelectView * _select;
    CGFloat _row1Height;
    LSelectBaseModel * _selectModel;
    MzzStoreModel * _selectStore;
    NSString * _joinCode;
    NSMutableDictionary * _selectDict;
    NSArray * _yejiguishuArr;
    NSMutableDictionary * _webParamDict; //列表网页要的参数
    CGFloat _row0Height;
    FWDWebCell * _webCell;
    NSMutableArray * _proListArr;
    FWDCommitView * _foot;
    CGFloat _row3Height;
    NSLayoutConstraint * _rightConstraint;
    FWDCommentCell * _commentCell;
    NSString * _content;
    NSArray * _guiShu;
    
    CGFloat  _totalMoney;
    NSString * _haoka;
    CGFloat _money_card;
    
    NSMutableArray *_jishiArray;
    
}
- (FWDAleartVIew *)alertView
{
    if (!_alertView) {
        _alertView = loadNibName(@"FWDAleartVIew");
        _alertView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    }
    return _alertView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataModelarr = [NSMutableArray array];
    self.view.backgroundColor = kBackgroundColor;
    _jishiArray = [[NSMutableArray alloc] init];
    MLJiShiModel * model = [[MLJiShiModel alloc] init];
    model.name = @"公共业绩";
    model.account = @"0";
    //    model.bfb = @"";
    [_jishiArray addObject:model];
    _selectDict = [[NSMutableDictionary alloc] init];
    _webParamDict = [[NSMutableDictionary alloc] init];
    _proListArr = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCell0Height:) name:Fwd_Cell0Height object:nil];
    _row1Height = 160;
    _row0Height = 210;
    _row3Height = 0;
    [self formatData];
    [self initYeJiGuiShuData];
    [self initSubViews];
    [self requestGuiShuData];
}

- (void)refreshCell0Height:(NSNotification *)notice
{
    NSString * heightStr = notice.object;
    _row0Height = heightStr.floatValue + 10;
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [_tb reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [_tb reloadData];
}
- (void)formatData
{
    [_webParamDict setValue:_commitDic[@"z_shichang"] forKey:@"z_shichang"];
    
    //    NSArray * pres = _commitDic[@"pres"];
    NSMutableArray * jisNameArr = [[NSMutableArray alloc] init];
    NSMutableArray *ticketArray = [[NSMutableArray alloc]init];

    for (id value in _commitDic.allValues) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray * arr = (NSArray *)value;
            for (NSDictionary * dict in arr) {
                NSMutableDictionary * dictweb = [[NSMutableDictionary alloc] initWithDictionary:dict];
                NSString *str = [dict[@"ticketArray"]objectForKey:@"name"];
                if ([dict.allKeys containsObject:@"type"]) {
                    NSString * type =  dict[@"type"];
                    if ([type containsString:@"提卡"]) {
                        NSString * price = dict[@"n_price"];
                        NSString * num = dict[@"numDisplay"];
                        _money_card +=  price.floatValue * num.integerValue ;
                    }
                }
                if([dict.allKeys containsObject:@"n_price"] ){
                    NSString * price = dict[@"n_price"];
                    NSString * num = @"";
                    if ([_commitDic[@"serv_type"] isEqualToString:@"1"]) {//销售服务单
                        num = dict[@"num"];
                    }else{
                        num = dict[@"numDisplay"];
                    }
                    //                    dictweb[@"price"] = [NSString stringWithFormat:@"%ld",price.integerValue * num.integerValue];
                    if (str.length!=0) {
                        _totalMoney = _totalMoney + price.floatValue;
                    }else{
                        _totalMoney = _totalMoney + price.floatValue * num.integerValue ;
                    }
                }
                if ([_commitDic[@"serv_type"] isEqualToString:@"1"]) {//销售服务单
                    dictweb[@"num"] = dict[@"num"];

                }else{
                    dictweb[@"num"] = dict[@"numDisplay"];
                }
                [_proListArr addObject:dictweb];
                [_webParamDict setValue:_proListArr forKey:@"pro_list"];
                NSArray * jisArr = dict[@"jis"];
                //添加选择的项目所有技师
                for (MLJiShiModel *model in jisArr) {
                    BOOL exist = NO;
                    if ([_jishiArray containsObject:model]) {
                        exist = YES;
                        break;
                    }
                    if (!exist) {
                        [_jishiArray addObject:model];
                    }
                }
                for (id jis in jisArr) {
                    if ([jis isKindOfClass:[NSString class]]) {
                        if (!([jisNameArr containsObject:jis])) {
                            [jisNameArr addObject:jis];
                            
                        }
                    }else if([jis isKindOfClass:[MLJiShiModel class]]){
                        MLJiShiModel * jis1 = (MLJiShiModel *)jis;
                        if (!([jisNameArr containsObject:jis1.name])) {
                            [jisNameArr addObject:jis1.name];
                            
                        }
                    }else{
                        
                    }
                }
                if (str.length!=0) {
                    [ticketArray addObject:dict[@"ticketArray"]];
                }
            }
        }
    }
    if (ticketArray.count) {
        [_webParamDict setValue:ticketArray forKey:@"ticket"];
    }
    [_webParamDict setValue:jisNameArr forKey:@"jis"];
    [_webParamDict setValue:[NSString stringWithFormat:@"%.2f",_totalMoney] forKey:@"z_price"];

    [_webParamDict setValue:[NSString stringWithFormat:@"%.2f",_money_card] forKey:@"money_card"];
    
    [_webParamDict setValue:[NSString stringWithFormat:@"%ld",[_webParamDict[@"pro_list"] count]] forKey:@"num"];
    for (id value in _webParamDict.allValues) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray * arr = (NSArray *)value;
            for (id sub in arr) {
                if ([sub isKindOfClass:[NSDictionary class]]) {
                    NSDictionary * dict = (NSDictionary *)sub;
                    if ([dict.allKeys containsObject:@"jis"]) {
                        [dict setValue:@"" forKey:@"jis"];
                    }
                }
            }
        }
    }
    if ([_commitDic[@"serv_type"] isEqualToString:@"0"]) {
        [_webParamDict setValue:@"1" forKey:@"pagetype"];
    }else{//销售服务单传
        [_webParamDict setValue:[NSString stringWithFormat:@"%.2f",_totalMoney] forKey:@"z_zhifu"];
    }
}
- (void)initYeJiGuiShuData
{
    FWDYeJGuiShuModel * model = [[FWDYeJGuiShuModel alloc]init];
    model.showName = @"售前业绩";
    model.belong = @"1";
    FWDYeJGuiShuModel * model1 = [[FWDYeJGuiShuModel alloc]init];
    model1.showName = @"售中业绩";
    model1.belong = @"2";
    FWDYeJGuiShuModel * model2 = [[FWDYeJGuiShuModel alloc]init];
    model2.showName = @"售后业绩";
    model2.belong = @"3";
    _yejiguishuArr = @[model,model1,model2];
}
- (void)initSubViews
{
    [self creatNav];
    [self createTableView];
    [self createSelectView];
}
- (void)requestGuiShuData
{
    WeakSelf;
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    _joinCode = join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
    }
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    if (token) {
        [parms setValue:token forKey:@"token"];
    }
    NSString * framId = [NSString stringWithFormat:@"%ld",model.data.join_code[0].fram_id];
    [parms setValue:framId?framId:@"" forKey:@"fram_id"];
    //技师
    [SLRequest requesSearchJisParams:parms resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _jisListModel = model;
        }
    }];
    //门店
    [parms setValue:_joinCode?_joinCode:@"" forKey:@"join_code"];
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _storeListModel = listModel;
            [_selectDict setValue:_storeListModel.list forKey:@"mendian"];
            [weakSelf requestDianZhangData];
        }
    }];
}
- (void)requestDianZhangData
{
    //店长
    NSMutableDictionary *DZparms = [[NSMutableDictionary alloc]init];
    [DZparms setValue:_joinCode?_joinCode:@"" forKey:@"join_code"];
    MzzStoreModel * model = _selectDict[@"mendian"][0];
    [DZparms setValue:model.store_code forKey:@"store_code"];
    [SLRequest  requesSearchManagerParams:DZparms resultBlock:^(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _managerListModel = model;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [_tb reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}
- (void)createSelectView
{
    FWDSelectView * select = [[FWDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    select.FWDSelectViewBlock = ^(LSelectBaseModel *model) {
        if ([model isKindOfClass:[MLJiShiModel class]]) {
            if ([_jishiArray containsObject:model]) {
                [XMHProgressHUD showOnlyText:@"此技师已被选择"];
            }else{
                [_jishiArray addObject:model];
            }
        }else{
            _selectModel = model;
            if([model isKindOfClass:[FWDYeJGuiShuModel class]]){
                FWDYeJGuiShuModel * selectModel = (FWDYeJGuiShuModel *)model;
                [_selectDict setValue:selectModel forKey:@"yeji"];
            }else{
                SLManagerModel * selectModel = (SLManagerModel *)model;
                [_selectDict setValue:selectModel forKey:@"dianzhang"];
            }
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        _row1Height = (_jishiArray.count + 4) * 25 + 40;
        [_tb reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    _select = select;
    select.hidden = YES;
    [self.view addSubview:select];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav+30) withTitleStr:@"服务制单" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)pop
{
    if (self.clickSubmit) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:_commitDic];
        
        for (int i = 0; i < dic.allValues.count; i ++) {
            id value = dic.allValues[i];
            if ([value isKindOfClass:[NSArray class]]) {
                NSArray * arr = (NSArray *)value;
                if (arr.count > 0) {
                    NSMutableDictionary * subDic = [[NSMutableDictionary alloc] init];
                    
                    for (int i = 0; i < arr.count; i ++) {
                        subDic = arr[i];
                        
                        if ([subDic.allKeys containsObject:@"jis"]) {
                            id va = subDic[@"jis"];
                            NSMutableArray *arrmodel = self.dataModelarr[self.modelnum];
                            self.modelnum += 1;
                            NSMutableArray * arrjis = (NSMutableArray *)va;
                            if ([va isKindOfClass:[NSMutableArray class]]&&arrjis.count > 0) {
                                
                                for (int i = 0; i < arrjis.count; i ++) {
                                    NSString *jisModel = arrjis[i];
                                    if([jisModel isKindOfClass:[NSString class]]){
                                        
                                        MLJiShiModel *model = arrmodel[i];
                                        if ([model.account isEqualToString:jisModel]) {
                                            [arrjis replaceObjectAtIndex:i withObject:model];
                                        }
                                        
                                    }
                                }
                            }
                            subDic[@"jis"] = arrjis;
                        }
                    }
                }
            }
        }
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createTableView
{
    FWDHeaderView * header = [[[NSBundle mainBundle]loadNibNamed:@"FWDHeaderView" owner:nil options:nil]lastObject];
    header.lbName.text = _name;
    header.lbPhone.text = _mobile;
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(15, Heigh_Nav, SCREEN_WIDTH-30, SCREEN_HEIGHT - Heigh_Nav- 75) style:UITableViewStylePlain];
    _tb.backgroundColor = [UIColor clearColor];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableHeaderView = header;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.showsVerticalScrollIndicator = NO;
    FWDCommitView * foot =  [[[NSBundle mainBundle]loadNibNamed:@"FWDCommitView" owner:nil options:nil]lastObject];
    [foot.btnCommit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    foot.frame = CGRectMake(0, SCREEN_HEIGHT - 65, SCREEN_WIDTH, 65);
    [self.view addSubview:foot];
    _foot = foot;
    [self.view addSubview:_tb];

}
- (void)commit
{
    [self conmitEvent];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (!_webCell) {
            _webCell =  [[FWDWebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yejicell"];
            _webCell.params = _webParamDict.jsonData;
        }
        return _webCell;
    }else if (indexPath.row == 1){
        FWDYeJiCell * cell = [[FWDYeJiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yejicell"];
        cell.FWDYeJiCellBlock = ^(NSInteger index) {
            if (index == 0) { //业绩
                _select.hidden = NO;
                _select.listModel = _yejiguishuArr;
            }else if (index == 1){
                _select.hidden = YES;
            }
            else if (index == 2){//店长
                _select.hidden = NO;
                _select.listModel = _managerListModel;
            }else{//员工
                _select.hidden = NO;
                _select.listModel = _jisListModel;
            }
        };
        //        cell.selectModel = _selectModel;
        cell.selectDic = _selectDict;
        cell.MrenjisArr = _jishiArray;
        cell.FWDYeJiCellDelBlock = ^(NSMutableArray *arr) {
            _jishiArray = arr;
            _row1Height = (_jishiArray.count + 4) * 25 + 40;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [_tb reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.FWDYeJiCellGuiShuBlock = ^(NSMutableArray *arr) {
            _guiShu = arr;
        };
        return cell;
    }else if (indexPath.row ==2){
        FWDHaoKaCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"FWDHaoKaCell" owner:nil options:nil]lastObject];
        cell.FWDHaoKaCellBlock = ^(NSString *select) {
            _haoka = select;
        };
        return cell;
    }else{
        if (!_commentCell) {
            _commentCell =  [[[NSBundle mainBundle]loadNibNamed:@"FWDCommentCell" owner:nil options:nil]lastObject];
            _commentCell.textView.delegate = self;
            [_commentCell.lb1 sizeToFit];
            _commentCell.textViewRight = _rightConstraint;
        }
        return _commentCell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return _row0Height;
    }else if (indexPath.row ==1){
        return (_jishiArray.count + 4) * 25+26;
    }else if (indexPath.row ==2){
        return 90;
    }else{
        return _row3Height + 145;
    }
}
- (void)conmitEvent{
    //    NSMutableDictionary *dic = _commitDic;
    self.clickSubmit = YES;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:_commitDic];
    
    for (id value in dic.allValues) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray * arr = (NSArray *)value;
            if (arr.count > 0) {
                NSMutableDictionary * subDic = [[NSMutableDictionary alloc] init];
                for (subDic in arr) {
                    NSMutableArray * jisArr = [[NSMutableArray alloc] init];
                    NSMutableArray * jisArrmodel = [[NSMutableArray alloc] init];
                    
                    if ([subDic.allKeys containsObject:@"jis"]) {
                        id va = subDic[@"jis"];
                        NSArray * arrjis = (NSArray *)va;
                        if ([va isKindOfClass:[NSArray class]]&&arrjis.count > 0) {
                            for (MLJiShiModel * jisModel in arrjis) {
                                [jisArrmodel addObject:jisModel];
                                
                                if([jisModel isKindOfClass:[NSString class]]){
                                    [jisArr addObject:jisModel];
                                }else{
                                    [jisArr addObject:jisModel.account];
                                }
                            }
                        }
                        subDic[@"jis"] = jisArr;
                    }
                    if ([subDic.allKeys containsObject:@"ticketArray"]) {
                        
                    }
                    [self.dataModelarr addObject:jisArrmodel];
                    
                }
            }
        }
    }
    FWDYeJGuiShuModel * selectModel = _selectDict[@"yeji"];
    [dic setValue:selectModel.belong forKey:@"belong"];
    
    MzzStoreModel * storeModel = _selectDict[@"mendian"][0];
    [dic setValue:storeModel.store_code forKey:@"store_code"];
    
    SLManagerModel * DZModel = _selectDict[@"dianzhang"];
    [dic setValue:DZModel.account forKey:@"dianzhang"];
    
    [dic setValue:_haoka?_haoka:@"1" forKey:@"xiaohao"];
    [dic setValue:_content?_content:@"" forKey:@"content"];
    if ([_commitDic[@"serv_type"] isEqualToString:@"1"]){
        [dic setValue:@(1) forKey:@"serv_type"];
    }else{
        [dic setValue:@(0) forKey:@"serv_type"];
    }
    float guishuTotal = 0.0;
    NSMutableArray *guishuArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < _guiShu.count; i ++) {
        NSMutableDictionary *gsDic1 = [[NSMutableDictionary alloc]init];
        MLJiShiModel * jis = _guiShu[i];
        [gsDic1 setValue:jis.account forKey:@"acc"];
        [gsDic1 setValue:[NSString stringWithFormat:@"%.2f",jis.bfb] forKey:@"bfb"];
        [guishuArr addObject:gsDic1];
        guishuTotal +=  jis.bfb;
    }

    if ([[NSString stringWithFormat:@"%.2f",guishuTotal]floatValue] != [[_webParamDict objectForKey:@"z_price"]floatValue]) {
        [XMHProgressHUD showOnlyText:@"业绩归属总计不等于销售服务金额，请重新分配"];
        return;
    }
    [dic setValue:guishuArr forKey:@"guishu"];
    NSString *str = dic.jsonData;
    NSMutableDictionary *parmsdic = [[NSMutableDictionary alloc]init];
    [parmsdic setValue:str forKey:@"data"];
    WeakSelf
    [SLRequest commitParams:parmsdic resultBlock:^(SLOrderNumModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
            self.alertView.FWDAleartVIewDetailBlock = ^{
                FWDDetailViewController * next = [[FWDDetailViewController alloc] init];
                next.ordernum = model.ordernum;
                [weakSelf.navigationController pushViewController:next animated:NO];
            };
            self.alertView.FWDAleartVIewRecordBlock = ^{
                FWDRecordController * next = [[FWDRecordController alloc] init];
                next.ordernum = model.ordernum;
                [weakSelf.navigationController pushViewController:next animated:NO];
            };
            self.alertView.FWDAleartVIewDelBlock = ^{
                [weakSelf togoHomePage];
            };
            
        }
//        if (isSuccess) {
//            MzzHud * hub = [[MzzHud alloc] initWithTitle:@"" message:@"创建订单成功！" leftButtonTitle:@"查看详情" rightButtonTitle:@"服务记录" iconStr:@"fuwudan_chenggong" click:^(NSInteger index) {
//
//                if (index == 0) {
//                    FWDDetailViewController * next = [[FWDDetailViewController alloc] init];
//                    next.ordernum = model.ordernum;
//                    [self.navigationController pushViewController:next animated:NO];
//                }else{
//                    FWDRecordController * next = [[FWDRecordController alloc] init];
//                    next.ordernum = model.ordernum;
//                    [self.navigationController pushViewController:next animated:NO];
//                }
//            }];
//            [hub show];
//            [hub.contentTipView.btnCancel addTarget:self action:@selector(togoHomePage) forControlEvents:UIControlEventTouchUpInside];
//        }
    }];
}
- (void)togoHomePage
{
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[OrderManagementViewController class]]) {
            [self.navigationController popToViewController:temp animated:NO];
        }
        if ([temp isKindOfClass:[BookBillHomeVC class]]) {
            [self.navigationController popToViewController:temp animated:NO];
        }
    }
    
    //    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
}
- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = [textView.text stringHeightWithFont:FONT_SIZE(14) width:SCREEN_WIDTH - _rightConstraint.constant - 60];
    _row3Height = size.height  + 30;
    _commentCell.lbLimit.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
    if (textView.text.length == 0) {
        _commentCell.lb1.hidden = NO;
    }else{
        _commentCell.lb1.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    _content = textView.text;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [_tb reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
