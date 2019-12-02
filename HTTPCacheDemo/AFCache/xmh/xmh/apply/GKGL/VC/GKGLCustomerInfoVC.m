//
//  GKGLCustomerInfoVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerInfoVC.h"
#import "GKGLCustomerInfoEditVC.h"
#import "GKGLAddCustomerCell.h"
#import "MzzCustomerRequest.h"
#import "RolesTools.h"
@interface GKGLCustomerInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSDictionary * resultDic;
@end

@implementation GKGLCustomerInfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    WeakSelf
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    [self.navView setNavViewTitle:@"基本信息" backBtnShow:YES rightBtnTitle:@"编辑"];
    self.navView.NavViewRightBlock = ^{
        if ([RolesTools workPushToTJGKVC]) {
            GKGLCustomerInfoEditVC * customerInfoEditVC = [[GKGLCustomerInfoEditVC alloc] init];
            //        customerInfoEditVC.store_code = weakSelf.resultDic[@"store_code"];
            //        customerInfoEditVC.userid = weakSelf.resultDic[@"id"];
            
            customerInfoEditVC.param = weakSelf.resultDic;
            [weakSelf.navigationController pushViewController:customerInfoEditVC animated:NO];
        }else{
            //弹窗
            [XMHProgressHUD showOnlyText:@"您没有权限使用此模块,如有疑问请联系管理员"];
        }

    };
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
//    [self requestCustomerInfoData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestCustomerInfoData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT -  Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        if (@available(iOS 11.0, *)) {
//            _tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//        }
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLAddCustomerCell = @"kGKGLAddCustomerCell";
    GKGLAddCustomerCell * addCustomer = [tableView dequeueReusableCellWithIdentifier:kGKGLAddCustomerCell];
    if (!addCustomer) {
        addCustomer =  loadNibName(@"GKGLAddCustomerCell");
    }
    [addCustomer updateCellCustomerInfoParam:_resultDic indexPath:indexPath];
    return addCustomer;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 4;
    }else if (section == 3){
        return 4;
    }else{}
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[UIView alloc] init];
    footer.backgroundColor = kColorE;
    return footer;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.navView.backgroundColor = kColorTheme;
}
#pragma mark ------网络请求------
/** 获取顾客基本信息 */
- (void)requestCustomerInfoData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userid?_userid:@"" forKey:@"id"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CUSTOMERINFO_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _resultDic = resultDic;
            [_tbView reloadData];
        }else{}
    }];
}
@end
