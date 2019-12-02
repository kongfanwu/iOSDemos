//
//  PassWordController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "PassWordController.h"
#import "MinePWCell.h"
#import "MineRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "NSString+DE.h"
@interface PassWordController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PassWordController
{
    UITableView * _tb;
    NSArray * _titles;
    NSString * _oldPw;
    NSString * _newPw;
    NSString * _sureNewPw;
    NSArray * _placeHs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    /** nav */
    [self.navView setNavViewTitle:@"修改密码" backBtnShow:YES rightBtnTitle:@"提交"];
    self.navView.NavViewRightBlock = ^{
        [weakSelf oneStep];
    };
    self.navView.backgroundColor = kBtn_Commen_Color;
    _titles = @[@"旧密码",@"新密码",@"确认新密码"];
    _placeHs = @[@"请输入旧密码",@"输入新密码",@"再次输入新密码"];
    [self initSubViews];
}
- (void)initSubViews
{
//    [self creatNav];
    [self createTb];
}
- (void)createTb
{
    UITableView * tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    tb.tableFooterView = [[UIView alloc] init];
    tb.dataSource = self;
    tb.delegate = self;
    tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    tb.backgroundColor = kBackgroundColor;
    _tb = tb;
    [self.view addSubview:tb];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"修改密码" withleftImageStr:@"back" withRightStr:@"提交"];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnRight addTarget:self action:@selector(oneStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)oneStep
{
    MzzLog(@".....%@.....%@......%@",_oldPw,_newPw,_sureNewPw);
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
//    NSString * framId = [NSString stringWithFormat:@"%ld",infomodel.data.join_code[0].fram_id];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    if (_oldPw.length > 0 && _newPw.length > 0 && _sureNewPw.length> 0) {
        [MineRequest requestModifyPwdUid:accountId oldPwd:[_oldPw encryptWithMd5] newPwd:[_newPw encryptWithMd5] resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            
        }];
    } else {
        [XMHProgressHUD showOnlyText:@"有参数为空"];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MinePWCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MinePWCell" owner:nil options:nil]lastObject];
    cell.lbName.text = _titles[indexPath.row];
    cell.lbContent.placeholder = _placeHs[indexPath.row];
    cell.MinePWCellBlock = ^(NSString *text) {
        if (indexPath.row ==0) {
            _oldPw = text;
            if (!(_oldPw.length > 0)) {
//                [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"旧密码不能为空"];
                [XMHProgressHUD showOnlyText:@"旧密码不能为空"];
            }
        }else if (indexPath.row ==1){
             _newPw = text;
            if (!(_newPw.length > 0)) {
//                [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"新密码不能为空"];
               [XMHProgressHUD showOnlyText:@"新密码不能为空"];
            }
        }else{
            _sureNewPw = text;
            if (![_newPw isEqualToString:_sureNewPw]) {
//            [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"密码不一致"];
                [XMHProgressHUD showOnlyText:@"密码不一致"];
            }
        }
    };
    return cell;
}
@end
