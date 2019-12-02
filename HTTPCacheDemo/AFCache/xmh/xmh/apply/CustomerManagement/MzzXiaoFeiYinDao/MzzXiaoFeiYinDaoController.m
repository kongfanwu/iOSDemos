//
//  MzzXiaoFeiYinDaoController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzXiaoFeiYinDaoController.h"
#import "MzzgoumaineirongCell.h"
#import "MzzChixukaCell.h"
#import "MzzGukexiaohaoCell.h"
#import "MzzCustomerRequest.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "MzzGuideModel.h"




#import "MzzXFYDtbSectionHeader.h"
#import "XFYDtbSectionHeaderModel.h"
#import "MzzXFYDtbSectionFooter.h"
@interface MzzXiaoFeiYinDaoController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tabView;
@property (nonatomic ,strong)MzzGuideModel *model;
@end

@implementation MzzXiaoFeiYinDaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self creatNav];
    [self creatTableView];
    [self requestData];
}
- (void)creatNav{
    
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"消费引导" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nav];
    
}

- (void)requestData{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"user_id"] = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    [MzzCustomerRequest requestGuideParams:params resultBlock:^(MzzGuideModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _model = model;
        [_tabView reloadData];
    }];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatTableView{
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal) style:UITableViewStylePlain];
    _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabView.dataSource = self;
    _tabView.delegate = self;
    _tabView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tabView];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MzzXFYDtbSectionHeader * sectionHeader = loadNibName(@"MzzXFYDtbSectionHeader");
    switch (section) {
        case 0:
        {
            [sectionHeader updateSectionHeaderModel:[XFYDtbSectionHeaderModel createModelLeftName:@"可购买内容" middleName:@"所属类型" rightName:@"普及率"]];
        }
            break;
        case 1:
        {
            [sectionHeader updateSectionHeaderModel:[XFYDtbSectionHeaderModel createModelLeftName:@"待续卡内容" middleName:@"" rightName:@""]];
        }
            break;
        case 2:
        {
             [sectionHeader updateSectionHeaderModel:[XFYDtbSectionHeaderModel createModelLeftName:@"顾客消耗达标情况" middleName:@"" rightName:@""]];
        }
        break;
    }
    return sectionHeader;;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MzzXFYDtbSectionFooter * sectionFooter = loadNibName(@"MzzXFYDtbSectionFooter");
    return sectionFooter;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
       case 1:
            return _model.stored_card.count;
            break;
        case 2:
            return _model.xiaohao.count;
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            MzzgoumaineirongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"0"];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"MzzgoumaineirongCell" owner:nil options:nil].lastObject;
            }
            switch (indexPath.row) {
                case 0:
                    {
                        [cell.lb1 setText:_model.guiji.name];
                        [cell.lb2 setText:@"轨迹"];
                        [cell.lb3 setText:[NSString stringWithFormat:@"%ld%%",_model.guiji.bfb]];
                    }
                    break;
                case 1:
                {
                    [cell.lb1 setText:_model.guanlian.name];
                    [cell.lb2 setText:@"关联"];
                    [cell.lb3 setText:[NSString stringWithFormat:@"%ld%%",_model.guanlian.bfb]];
                }
                    break;
                case 2:
                {
                    [cell.lb1 setText:_model.fugou.name];
                    [cell.lb2 setText:@"复购"];
                    [cell.lb3 setText:[NSString stringWithFormat:@"%ld%%",_model.fugou.bfb]];
                }
                    break;
            }
            return cell;
        }
            break;
        case 1:
        {
            MzzChixukaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"MzzChixukaCell" owner:nil options:nil].lastObject;
            }
            MzzStored_card *model = [_model.stored_card objectAtIndex:indexPath.row];
            [cell updateCellModel:model];
            return cell;
        }
            break;
        case 2:
        {
            MzzGukexiaohaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"2"];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"MzzGukexiaohaoCell" owner:nil options:nil].lastObject;
            }
            MzzXiaohao *model = [_model.xiaohao objectAtIndex:indexPath.row];
            [cell.lb1 setText:model.name];
            [cell.lb2 setText:[NSString stringWithFormat:@"%f",model.ave]];
            [cell.lb3 setText:[NSString stringWithFormat:@"%f",model.shiji]];
            return cell;
        }
            break;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 30;
            break;
        case 1:
            return 45;
            break;
        case 2:
            return 66;
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
@end
