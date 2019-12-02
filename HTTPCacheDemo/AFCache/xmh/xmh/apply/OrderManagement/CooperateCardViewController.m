//
//  CooperateCardViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CooperateCardViewController.h"
#import "JasonSearchView.h"
#import "tempModel.h"
#import "LOrderDetailCell.h"
#import "ShareWorkInstance.h"
#import "SLRequest.h"
#import "SLCooperateModel.h"
#import "UserManager.h"
#import "LDatePickView.h"
#import "MzzJiSuanViewController.h"
#import "FWDDetailViewController.h"
@interface CooperateCardViewController (){
    LDatePickView * _dateHeaderView;
    NSString *cstartTime;
    NSString *cendTime;
    JasonSearchView    *_searchView;
    __weak IBOutlet UIView *middleView;
    __weak IBOutlet UITableView *tbView;
    __weak IBOutlet UIView *searchBackGround;
    __weak IBOutlet UIView *lineView;
    NSMutableArray *_arrSource;
    NSString * _other;
    NSString * _belong;
    NSString * _page;
    NSString * _q;
    SLCooperateModel * _cooperateModel;
}

@end

@implementation CooperateCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isSale) {
        customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"配合消费" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
        nav.backgroundColor = kBtn_Commen_Color;
        nav.lbTitle.textColor = [UIColor whiteColor];
        [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nav];
    }else{
        customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"配合消耗" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
        nav.backgroundColor = kBtn_Commen_Color;
        nav.lbTitle.textColor = [UIColor whiteColor];
        [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nav];
    }
    [self initSubViews];
    [self requestTableViewData];
    _arrSource = [[NSMutableArray alloc]init];
    [tbView reloadData];
    
}
- (void)requestTableViewData
{
//    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
//    NSString * inId = infomodel.data.account;
    
    if (_isSale) {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [param setValue:_model.joinCode?_model.joinCode:@"" forKey:@"join_code"];
        [param setValue:_model.oneClick?_model.oneClick:@"" forKey:@"fram_id"];
        [param setValue:cstartTime?cstartTime:@"" forKey:@"start_time"];
        [param setValue:cendTime?cendTime:@"" forKey:@"end_time"];
        [param setValue:_model.inId?_model.inId:@"" forKey:@"inId"];

        param[@"yeji"] = _belong?_belong:@"0";
        param[@"other"] = _other?_other:@"0";
        param[@"page"] = _page?_page:@"1";
        param[@"q"] = _q?_q:@"";
        WeakSelf
        [SLRequest requestCooperateSaleParams:param resultBlock:^(SLCooperateModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [_arrSource removeAllObjects];
            _cooperateModel = model;
            for (NSInteger i = 0; i<model.list.count; i++) {
                tempModel *model = [[tempModel alloc]init];
                [_arrSource addObject:model];
            }
            [weakSelf refreshLabel];
            [tbView reloadData];
        }];
    }else{
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [param setValue:_model.joinCode?_model.joinCode:@"" forKey:@"join_code"];
        [param setValue:_model.oneClick?_model.oneClick:@"" forKey:@"fram_id"];

        [param setValue:cstartTime?cstartTime:@"" forKey:@"start_time"];
        [param setValue:cendTime?cendTime:@"" forKey:@"end_time"];
        [param setValue:_model.inId?_model.inId:@"" forKey:@"inId"];

        param[@"belong"] = _belong?_belong:@"0";
        param[@"other"] = _other?_other:@"0";
        param[@"page"] = _page?_page:@"1";
        param[@"q"] = _q?_q:@"";
        WeakSelf
        [SLRequest requestCooperateParams:param resultBlock:^(SLCooperateModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [_arrSource removeAllObjects];
            _cooperateModel = model;
            for (NSInteger i = 0; i<model.list.count; i++) {
                tempModel *model = [[tempModel alloc]init];
                [_arrSource addObject:model];
            }
            [weakSelf refreshLabel];
            [tbView reloadData];
        }];
    }
   
    
}
- (void)refreshLabel
{
    for (UIView *tempView in middleView.subviews) {
        if (tempView.tag < 2000) {
            if ([tempView isKindOfClass:[UILabel class]]) {
                UILabel *temp = (UILabel *)tempView;
                if (temp.tag ==1000) {
                    temp.text = [NSString stringWithFormat:@"%.2f",_cooperateModel.all];
                }else if (temp.tag ==1001){
                     temp.text = [NSString stringWithFormat:@"%.2f",_cooperateModel.shouqian];
                }else if (temp.tag ==1002){
                     temp.text = [NSString stringWithFormat:@"%.2f",_cooperateModel.shouzhong];
                }else if (temp.tag ==1003){
                     temp.text = [NSString stringWithFormat:@"%.2f",_cooperateModel.shouhou];
                }
            }
        }
    }
}
- (IBAction)btnBenAndWaiEvent:(UIButton *)sender {
    
    for (UIView *tempView in middleView.subviews) {
        if (tempView.tag >1500) {
            if ([tempView isKindOfClass:[UIButton class]]) {
                if (tempView.tag == sender.tag) {
                    sender.selected = YES;
                    lineView.center = CGPointMake(sender.center.x, lineView.center.y);
                    _other = [NSString stringWithFormat:@"%ld",sender.tag - 2000];
                    [self requestTableViewData];
                } else {
                    UIButton *temp = (UIButton *)tempView;
                    temp.selected = NO;
                }
            }
        }
    }
}
- (IBAction)btnEvent:(UIButton *)sender {
    for (UIView *tempView in middleView.subviews) {
        if (tempView.tag <2000) {
            if ([tempView isKindOfClass:[UIButton class]]) {
                if (tempView.tag == sender.tag) {
                    sender.selected = YES;
                    _belong = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
                    [self requestTableViewData];
                    //                _redLine.center = CGPointMake(sender.center.x, _redLine.center.y);
                } else {
                    UIButton *temp = (UIButton *)tempView;
                    temp.selected = NO;
                }
            }
            if ([tempView isKindOfClass:[UILabel class]]) {
                if (tempView.tag == sender.tag) {
                    UILabel *temp = (UILabel *)tempView;
                    temp.textColor = kBtn_Commen_Color;
                } else {
                    UILabel *temp = (UILabel *)tempView;
                    temp.textColor = kLabelText_Commen_Color_9;
                }
            }
        }
    }
}
- (void)initSubViews{
    WeakSelf
    _dateHeaderView = [[LDatePickView alloc] initWithFrame:CGRectMake(15, Heigh_Nav+10, SCREEN_WIDTH-30, 44) dateBlock:^(NSString *start, NSString *end) {
        cstartTime = start;
        cendTime = end;
        [weakSelf requestTableViewData];
    }];
    _dateHeaderView.backgroundColor = [UIColor whiteColor];
    _dateHeaderView.layer.shadowColor= RGBColorWithAlpha(51, 51, 51, 0.14).CGColor;
    _dateHeaderView.layer.shadowOpacity = 1;
    _dateHeaderView.layer.shadowRadius = 30;
    _dateHeaderView.layer.cornerRadius = 10;
    _dateHeaderView.btn.frame = CGRectMake(_dateHeaderView.frame.size.width - 18, (_dateHeaderView.frame.size.height - 15)/2, 8, 15);
    [self.view addSubview:_dateHeaderView];
    
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH, 45)withPlaceholder:@"姓名/手机号"];
        _searchView.searchBar.layer.cornerRadius = 3;
        _searchView.searchBar.layer.masksToBounds = YES;
        [searchBackGround addSubview:_searchView];
    }
    __block JasonSearchView    *tempsearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        _q = tempsearchView.searchBar.text;
        [weakSelf requestTableViewData];
    };
    [_searchView updateHaoKaFrame];
    _searchView.searchBar.btnleftBlock = ^{
        _q = @"";
        [weakSelf requestTableViewData];
    };
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OrderServiceCellindentifier = @"OrderServiceCellindentifier";
    LOrderDetailCell *cell;
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LOrderDetailCell" owner:nil options:nil] firstObject];
    }else{
        cell  = [tableView dequeueReusableCellWithIdentifier:OrderServiceCellindentifier];
    }
    cell.v1.tag = indexPath.row;
    UITapGestureRecognizer * tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDown:)];
    [cell.v1 addGestureRecognizer: tap];
    if (indexPath.row < _arrSource.count) {
        tempModel *model = _arrSource[indexPath.row];
        [cell refreshLOrderDetailCell:model];
    }
    if (_isSale){
        cell.cooperateModel = _cooperateModel.list[indexPath.row];
    }else{
        cell.haokacooperateModel = _cooperateModel.list[indexPath.row];
    }
    
    return cell;
}
- (void)tapDown:(UITapGestureRecognizer *)gesture
{
    UIView * view = gesture.view;
    if (view.tag < _arrSource.count) {
        tempModel *model = _arrSource[view.tag];
        model.isShow = !model.isShow;
    }
    [tbView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<_arrSource.count) {
        tempModel *model = _arrSource[indexPath.row];
        return 44 + 170 *model.isShow;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLCooperate * model = _cooperateModel.list[indexPath.row];
    if (_isSale) {
        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        [vc setOrderNum:model.ordernum andYemianStyle:YemianXiangQing andType:model.type andUid:[NSString stringWithFormat:@"%ld",model.user_id]withName:@""];
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        FWDDetailViewController * next = [[FWDDetailViewController alloc] init];
        next.ordernum = model.ordernum;
        next.comeFrom = @"DDGL";
        [self.navigationController pushViewController:next animated:NO];
    }
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
