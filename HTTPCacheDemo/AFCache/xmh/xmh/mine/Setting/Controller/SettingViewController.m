//
//  SettingViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/14.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SettingViewController.h"
#import "MineSettingCell.h"
#import "LFileManager.h"
#import "AboutUsController.h"
#import "PassWordController.h"
#import "Availability.h"
#import <StoreKit/StoreKit.h>
#import "UserInfoRequest.h"
#import "LoginViewController.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "XMHUserManager.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tb;
    NSArray * _titles;
}
@property (nonatomic ,copy)NSString *currentVersion;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navView setNavViewTitle:@"设置" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self initSubViews];
}
- (void)initSubViews
{
    [self createTb];
    _titles = @[@[@"修改密码"],@[@"清除本地缓存",@"当前版本"],@[@"关于神灯妈妈",@"为神灯妈妈打分"]];
//    [self creatNav];
   CGFloat size = [LFileManager getCacheSize];
    MzzLog(@"........%.2f",size);
}
- (void)createTb
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStyleGrouped];
    _tb.backgroundColor = Color_NormalBG;
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.sectionHeaderHeight = 10.f;
    _tb.sectionFooterHeight = 0.0f;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIButton * quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    quitBtn.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 44);
    quitBtn.titleLabel.font = FONT_SIZE(16);
    [quitBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    quitBtn.backgroundColor = [UIColor whiteColor];
    quitBtn.layer.borderWidth = kBorderWidth;
    quitBtn.layer.cornerRadius =2;
    quitBtn.layer.masksToBounds = YES;
    quitBtn.layer.borderColor = [ColorTools colorWithHexString:@"#cccccc"].CGColor;
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 100)];
    [footer addSubview:quitBtn];
    footer.backgroundColor = Color_NormalBG;
    _tb.tableFooterView = footer;
    [self.view addSubview:_tb];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"设置" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnRight addTarget:self action:@selector(oneStep) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)oneStep
{
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titles[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineSettingCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MineSettingCell" owner:nil options:nil]lastObject];
    cell.lbName.text = _titles[indexPath.section][indexPath.row];
    if (indexPath.section ==1) {
        cell.lbContent.hidden = NO;
        if (indexPath.row ==0) {
            cell.lbContent.text = [NSString stringWithFormat:@"%.2fM",[LFileManager getCacheSize]];
        }else{
            NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
            cell.lbContent.text = [NSString stringWithFormat:@"%@",currentVersion];
            _currentVersion = currentVersion;
            cell.btnMore.hidden = YES;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            PassWordController * next = [[PassWordController alloc] init];
            [self.navigationController pushViewController:next animated:NO];
        }
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            MzzHud * hub = [[MzzHud alloc] initWithTitle:@"确定清除缓存吗" message:@"" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
                if (index ==1) {
                    [LFileManager clearCacheresultBlock:^(BOOL isSuccess) {
                        if (isSuccess) {
                            [XMHProgressHUD showOnlyText:@"缓存清除成功"];
                            NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:1];//刷新
                            [_tb reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];[_tb reloadData];
                        }
                    }];
                }
            }];
            [hub show];
        }else{

        }
    }else{
        if (indexPath.row ==0) {
            AboutUsController * next = [[AboutUsController alloc] init];
            [self.navigationController pushViewController:next animated:NO];
        }else{
           
            if (Above10) {
                [SKStoreReviewController requestReview];
            }else{
                NSString *str = @"https://itunes.apple.com/cn/app/神灯智能/id1376509234?mt=8";
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
#pragma clang diagnostic pop
                
            }
        }
    }
}
- (void)quit
{
    [UserInfoRequest requestLoginOutresultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {

            [[XMHUserManager sharedXMHUserManager]logOut];
            LoginViewController * login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:NO];
            [YFKeychainTool deleteKeychainValue:@"userName"];
            [YFKeychainTool deleteKeychainValue:@"password"];
            [UserManager setObjectUserDefaults:nil key:userLogInInfo];
            [ShareWorkInstance releaseInstance];
//            [self.navigationController popToRootViewControllerAnimated:NO];
//            [[NSNotificationCenter defaultCenter] postNotificationName:AppDelegate_ChooseRoot object:nil];
////            [weakSelf showLoginController];
        }
    }];
}
- (void)newVersionCheck{
    NSString *urlString=@"http://itunes.apple.com/lookup?id=1376509234"; //自己应用在App Store里的地址
    
    NSURL *url = [NSURL URLWithString:urlString];//这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    解析json数据
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *array = json[@"results"];
    
    for (NSDictionary *dic in array) {
        
        NSString *  newVersion = [dic valueForKey:@"version"]; // appStore 的版本号
//        newVersion = @"2.0.4";
//        NSLog(@"%@",newVersion);
        if ([_currentVersion isEqualToString:newVersion]) {
            //最新版本
            [[[MzzHud alloc] initWithTitle:@"检查更新" message:@"您当前已是最新版本" centerButtonTitle:@"关闭" click:^(NSInteger index) {
                
            }]show];
        }else{
            NSString *message = [NSString stringWithFormat:@"我们推出了%@版本，进行了多处更新优 化快升级体验吧",newVersion];
            [[[MzzHud alloc] initWithTitle:@"检查更新" message:message leftButtonTitle:@"关闭" rightButtonTitle:@"升级" click:^(NSInteger index) {
                if (index == 0) {
                    
                }else{
                    //升级
                    NSString *str = @"https://itunes.apple.com/cn/app/%E7%A5%9E%E7%81%AF%E6%99%BA%E8%83%BD/id1376509234";
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
            }]show];
        }
    }
}
@end

#pragma clang diagnostic pop
