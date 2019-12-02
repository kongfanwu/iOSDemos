//
//  SaleServiceNextViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SaleServiceNextViewController.h"
#import "SLRequest.h"
#import "SaleServiceNextCell.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "MLJishiSearchModel.h"
#import "SaleServiceJishiCell.h"
#import "JasonSearchView.h"
#import "MzzShengkaXukaController.h"
#import "FWDController.h"
#import "MzzGuDingZhiDanController.h"
#import "MzzYiGouZhiHuanController.h"
#import "MzzGeXingZhiDanController.h"
#import "LFWDNoticeView.h"
#import "RolesTools.h"
#import "LolUserInfoModel.h"

@interface SaleServiceNextViewController ()<UITextFieldDelegate>
{
    NSArray  *_arrJishi;
    JasonSearchView    *_searchView;
    NSString * _timeTotal;
    NSMutableDictionary * _dictCell;
}
@property (weak, nonatomic) IBOutlet UITextField *tfTime;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (weak, nonatomic) IBOutlet UIView *navBackGround;

@property (strong, nonatomic)NSMutableArray * selectArray;
@property (strong, nonatomic)MLJiShiModel * jisModel;

@property (nonatomic, strong) NSMutableArray *modelarray;

@end

@implementation SaleServiceNextViewController
{
    NSIndexPath * _indexPath;
    NSMutableArray * _dataArr;
    BOOL _isStart;
    NSString * _q;
    NSArray *  _copyArr;
    BOOL delJs;//点击删除技师
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _copyArr = [[NSArray alloc] init];
    _isStart = YES;
    [self creatNav];
    [_bgView addObserver:self forKeyPath:@"hidden" options: NSKeyValueObservingOptionNew || NSKeyValueChangeOldKey context:nil];
    _lbName.text = [NSString stringWithFormat:@"%@ (%@)",_name,_mobile];
    _btn1.layer.borderColor = [kBtn_Commen_Color CGColor];
    _btn1.layer.borderWidth = 1.0;
    _btn1.layer.cornerRadius = 14;
    [self loadJisData];
    self.modelarray = [NSMutableArray array];
    _bgView.hidden = YES;
    _tb.backgroundColor = kBackgroundColor;
    _text1.delegate = self;
    //设置默认服务时长
    NSInteger maxTime = 0;
    for (id value in _commitDic.allValues) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray * arr = (NSArray *)value;
            if (arr.count > 0) {
                for (NSDictionary * dic in arr) {
                    NSInteger  time = [dic[@"shichang"] integerValue];
                    if (time > maxTime) {
                        maxTime = time;
                    }
                }
            }
        }
    }
    _text1.text = [NSString stringWithFormat:@"%ld",maxTime];
    _timeTotal = _text1.text;
    self.jisModel =[[MLJiShiModel alloc]init];
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 10)];
    footView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:footView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6,6)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = footView.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    footView.layer.mask = maskLayer;
    _tb.tableFooterView = footView;
    _tb.showsVerticalScrollIndicator = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 10;//设置你footer高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _text1.text = textField.text;
    _timeTotal = _text1.text;
}
#pragma mark --------获取本店技师---------
- (void)loadJisData
{
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
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
    
    [SLRequest requesSearchJisParams:parms resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _arrJishi = model.list;
            _copyArr = model.list;
            [_jsTb reloadData];
        }
    }];
}
#pragma mark --------搜索技师---------
- (void)selectMetaData:(NSString *)q
{
    if (q.length== 0) {
        [_jsTb reloadData];
        return;
    }
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
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
    [parms setValue:q forKey:@"q"];
    
    [SLRequest requesSearchJisParams:parms resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _arrJishi = model.list;
            [_jsTb reloadData];
        }
    }];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"服务制单" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.lineImageView.hidden = YES;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SaleServiceNextCellindentifier = @"SaleServiceNextCellindentifier";
    static NSString *SaleServiceJishiCellindentifier = @"SaleServiceJishiCellindentifier";
    if (tableView == _tb) {
        SaleServiceNextCell * cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleServiceNextCell" owner:nil options:nil] firstObject];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:SaleServiceNextCellindentifier];
        }
        id value = _commitDic.allValues[indexPath.section];
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableDictionary * dict = (NSMutableDictionary *)((NSArray *)value[indexPath.row]);
            _dictCell = dict;
            if (_commitDic.allKeys.count-1 == indexPath.section) {
                if ([value isKindOfClass:[NSArray class]]) {
                    if (((NSArray *)value).count - 1 == indexPath.row) {
                        cell.line.hidden = YES;
                    }
                }
            }
            //判断默认技师显示当前登录账号还是选择的技师
            NSMutableArray *array= [_dictCell objectForKey:@"jis"];
            if (!array.count) {
                if (!delJs) {
                    [self chooseMrJs:dict];
                }
            }
            cell.modelDict = _dictCell;
            cell.btnSaleServiceNextBlock = ^(NSMutableDictionary * dictinside){
                _dictCell = dictinside;
                _indexPath = indexPath;
                NSArray *array=[dictinside objectForKey:@"jis"];

                if (array.count>=4) {
                    [XMHProgressHUD showOnlyText:@"最多选择四个技师"];
                }else{
                    _bgView.hidden = NO;
                }
            };
            //删除技师
            cell.btntDeljisBlock = ^(NSInteger btn, NSMutableDictionary *dictinside) {
                [[[MzzHud alloc] initWithTitle:@"温馨提示" message:@"确认是否要删除技师" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
                    if (index == 1) {
                        delJs = YES;
                        NSMutableArray *array=[dictinside objectForKey:@"jis"];
                        [array removeObjectAtIndex:btn-10000];
                        _dictCell = dictinside;
                        [_tb reloadData];
                    }
                }]show];
            };
            cell.btnSaleServiceNextDelBlock = ^{
                [[[MzzHud alloc] initWithTitle:@"温馨提示" message:@"确认是否要删除此项" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
                    if (index == 1) {
                        [_commitDic.allValues[indexPath.section] removeObject:dict];
                        [_tb reloadData];
                    }
                }]show];
            };
        }
        return cell;
    }else{
        SaleServiceJishiCell *cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleServiceJishiCell" owner:nil options:nil] firstObject];
        }else{
            cell  = [tableView dequeueReusableCellWithIdentifier:SaleServiceJishiCellindentifier];
        }
        if (indexPath.row < _arrJishi.count) {
            MLJiShiModel *model = _arrJishi[indexPath.row];
            [cell freshSaleServiceJishiCell:model];
        }
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tb) {
        return _commitDic.allKeys.count;
    } else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tb) {
        id value =  _commitDic.allValues[section];
        if ([value isKindOfClass:[NSArray class]]) {
            return  ((NSArray *)value).count;
        }else{
            return 0;
        }
    } else {
        return _arrJishi.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tb) {
        NSMutableArray *array= [_dictCell objectForKey:@"jis"];
        if (array.count) {
            if (array.count==1) {
                return 120;
            }else if (array.count==2){
                return 148;
            }else if (array.count==3){
                return 178;
            }else{
                return 210;
            }
        }else{
            return 100;
        }
    } else {
        return 40;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tb) {
        return 0;
    } else {
        return 90;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tb) {
        return nil;
    } else {
        UIView  *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *lb = [[UILabel alloc]init];
        lb.font = [UIFont systemFontOfSize:15];
        lb.text = @"请选择服务技师";
        lb.textColor = kLabelText_Commen_Color_3;
        [lb sizeToFit];
        lb.frame = CGRectMake(15, (40 - lb.height)/2.0, lb.width, lb.height);
        [headerView addSubview:lb];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
        line.backgroundColor = kBackgroundColor;
        [headerView addSubview:line];
        
        UIButton *btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCancle setTitle:@"取消" forState:UIControlStateNormal];
        btnCancle.titleLabel.font = [UIFont systemFontOfSize:15];
        [btnCancle setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
        btnCancle.frame = CGRectMake(SCREEN_WIDTH - 15-60-10-60, 0, 60, 40);
        [headerView addSubview:btnCancle];
        [btnCancle addTarget:self action:@selector(btnCancleEvent) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSure setTitle:@"确认" forState:UIControlStateNormal];
        btnSure.titleLabel.font = [UIFont systemFontOfSize:15];
        [btnSure setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
        btnSure.frame = CGRectMake(SCREEN_WIDTH - 15-60, 0, 60, 40);
        [btnSure addTarget:self action:@selector(btnSureEvent) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btnSure];
        
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, 45)withPlaceholder:@"搜索外店技师，请输入姓名/手机号"];
        [headerView addSubview:_searchView];
        WeakSelf
        __block NSString * weakQ = _q;
        _searchView.searchBar.btnRightBlock = ^{
            weakQ = _searchView.searchBar.text;
            [weakSelf selectMetaData:weakQ];
        };
        _searchView.searchBar.btnleftBlock = ^{
            _arrJishi = _copyArr;
        };
        return headerView;
    }
}
- (void)btnCancleEvent{
    _bgView.hidden = YES;
    _arrJishi = _copyArr;
}
- (NSIndexPath *)extracted {
    return _indexPath;
}
//确定按钮
- (void)btnSureEvent{
    _bgView.hidden = YES;
    _arrJishi = _copyArr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == _jsTb) {
        MLJiShiModel * jisModel = _arrJishi[indexPath.row];
        for (MLJiShiModel *model in _arrJishi) {
            if ([model.name isEqualToString:jisModel.name]) {
                model.isSelect = YES;
            }else{
                model.isSelect = NO;
            }
        }
        id value = _commitDic.allValues[indexPath.section];
        NSMutableArray *array = [NSMutableArray array];
        if ([value isKindOfClass:[NSArray class]]) {
            
            array= [_dictCell objectForKey:@"jis"];
            if (array == nil) {
                array = [NSMutableArray array];
            }
            
            if (array.count) {
                BOOL exist = NO;
                for (MLJiShiModel *model in array) {
                    if (model.ID==jisModel.ID) {
                        exist = YES;
                        break;
                    }
                }
                if (!exist) {
                    [array addObject:jisModel];
                }
            }else{
                [array addObject:jisModel];
                
            }
        }
        [_dictCell setValue:array forKey:@"jis"];
        _bgView.hidden = YES;
        [_tb reloadData];
        [_jsTb reloadData];
    }
}
- (IBAction)btnBegain:(UIButton *)sender {
    [_text1 resignFirstResponder];
    if (_isStart) {
        sender.enabled = NO;
        _isStart = NO;
    }
    MzzHud * hub = [[MzzHud alloc] initWithTitle:@"温馨提示" message:@"确定开始全部服务？" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
        if (index ==1) {
            _timeTotal = _text1.text;
            _text1.userInteractionEnabled = NO;
            sender.hidden = YES;
        }
    }];
    [hub show];
}
- (IBAction)zuijiaEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
- (BOOL)isChooseJiShi
{
    for (id value in _commitDic.allValues) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray * arr = (NSArray *)value;
            if (arr.count > 0) {
                for (NSDictionary * dic in arr) {
                    if (![dic.allKeys containsObject:@"jis"]) {
                        return NO;
                    }
                    id sub = dic[@"jis"];
                    if ([sub isKindOfClass:[NSArray class]]) {
                        NSArray * subarr = (NSArray *)sub;
                        if (subarr.count == 0) {
                            return NO;
                        }
                    }
                }
            }
        }
    }
    return YES;
}
- (IBAction)wanchengEvent:(UIButton *)sender {
    //制单的类型 1、服务单 2、销售服务单 3、固定制单 4、已购置换 5、个性制单 6、升卡续卡
    switch (_billType) {
        case 1:
        {
            if (![self isChooseJiShi]) {
                [XMHProgressHUD showOnlyText:@"有项目没有选择技师"];
                return;
            }
            LFWDNoticeView * notice = [[LFWDNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [notice showWithTitle:@"温馨提示" content:@"亲，此次服务已经完成，请确认服务时长" input:_timeTotal leftBtnTitle:@"取消" rightBtnTitle:@"确定"];
            notice.LFWDNoticeViewBlock = ^(NSInteger index, NSString *time) {
                if (!(time.length > 0)) {
                    [XMHProgressHUD showOnlyText:@"请确定服务时间"];
                    return ;
                }
                if ([time isEqualToString:@"0"]) {
                    [XMHProgressHUD showOnlyText:@"服务时长不能为0"];
                    return ;
                }
                if (index == 1) {
                    [_commitDic setValue:time forKey:@"z_shichang"];
                    FWDController *VC = [[FWDController alloc]init];
                    VC.user_id = _user_id;
                    VC.name = _name;
                    VC.mobile = _mobile;
                    _commitDic[@"serv_type"] = @"0";
                    VC.commitDic = _commitDic;
                    [self.navigationController pushViewController:VC animated:NO];
                }
            };
        }
            break;
        case 2:{
            if (![self isChooseJiShi]) {
                [XMHProgressHUD showOnlyText:@"有项目没有选择技师"];
                return;
            }
            LFWDNoticeView * notice = [[LFWDNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [notice showWithTitle:@"温馨提示" content:@"亲，此次服务已经完成，请确认服务时长" input:_timeTotal leftBtnTitle:@"取消" rightBtnTitle:@"确定"];
            notice.LFWDNoticeViewBlock = ^(NSInteger index, NSString *time) {
                if (!(time.length > 0)) {
                    [XMHProgressHUD showOnlyText:@"请确定服务时间"];
                    return ;
                }
                if (index == 1) {
                    [_commitDic setValue:time forKey:@"z_shichang"];
                    FWDController *VC = [[FWDController alloc]init];
                    VC.user_id = _user_id;
                    VC.name = _name;
                    VC.mobile = _mobile;
                    _commitDic[@"z_shichang"] = time;
                    _commitDic[@"serv_type"] = @"1";
                    VC.commitDic = _commitDic;
                    [self.navigationController pushViewController:VC animated:NO];
                }
            };
        }
            break;
    }
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"hidden"]&& !_bgView.hidden) {
        _arrJishi = _copyArr;
        [_jsTb reloadData];
    }
}
#pragma mark ---------默认显示技师----------
-(void)chooseMrJs:(NSMutableDictionary*)dict
{
    self.selectArray = [NSMutableArray array];
    if ([[RolesTools getUserAllRoles]containsObject:@"8"]||[[RolesTools getUserAllRoles]containsObject:@"9"]||[[RolesTools getUserAllRoles]containsObject:@"10"]) {
        self.jisModel.name =[ShareWorkInstance shareInstance].share_data.name;
        self.jisModel.account=[ShareWorkInstance shareInstance].share_data.account;
        self.jisModel.ID=[ShareWorkInstance shareInstance].share_data.ID;
        [self.selectArray addObject:self.jisModel];
        [_dictCell setValue:self.selectArray forKey:@"jis"];
        
    }
}
- (void)dealloc
{
    [_bgView removeObserver:self forKeyPath:@"hidden"];
}
@end
