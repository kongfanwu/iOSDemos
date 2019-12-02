//
//  XMHTraceCustomerVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTraceCustomerVC.h"
#import "XMHTraceCustomerCell.h"
#import "MzzCustomerRequest.h"
#import "GKGLHomeCustomerListModel.h"
#import "YQNetworking.h"
@interface XMHTraceCustomerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHBaseTableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, copy)NSString  * userIDStr;
@property (nonatomic, strong)UILabel * lbNum;
@property (nonatomic, copy)NSString * num;
@end

@implementation XMHTraceCustomerVC

@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
    [self requestCustomerData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"追踪顾客" backBtnShow:YES];
    
    UIView * colorView = UIView.new;
    [self.view addSubview:colorView];
    colorView.backgroundColor = kColorTheme;
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(25);
    }];
    
    UILabel * lbNum = UILabel.new;
    lbNum.text = @"共5人，已经执行完毕N人";
    [self.view addSubview:lbNum];
    lbNum.backgroundColor = [UIColor whiteColor];
    lbNum.textAlignment = NSTextAlignmentCenter;
    lbNum.font = FONT_MEDIUM_SIZE(17);
    lbNum.textColor = kColor3;
    lbNum.layer.cornerRadius = 5;
    lbNum.layer.masksToBounds = YES;
    _lbNum = lbNum;
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.bottom);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    XMHBaseTableView * tbView = [[XMHBaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tbView.backgroundColor = [UIColor clearColor];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.emptyEnable = YES;
    _tbView= tbView;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tbView];
    [tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbNum.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHTraceCustomerCell";
    XMHTraceCustomerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = loadNibName(@"XMHTraceCustomerCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark ------网络请求------
/** 顾客列表数据 */
- (void)requestCustomerData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * type = [NSString stringWithFormat:@"%d",1];
    NSString * q = @"";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:@"-1" forKey:@"page"];
    [param setValue:@"1" forKey:@"sort"];
    [param setValue:type?type:@"1" forKey:@"type"];
    [param setValue:q?q:@"" forKey:@"q"];
    
    NSString * url = @"v5.user_new/user_new_list";
    [YQNetworking postWithUrl:[XMHHostUrlManager url:url] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
             GKGLHomeCustomerListModel *model = [GKGLHomeCustomerListModel yy_modelWithDictionary:obj.data];
            [self comparisonUserID:model.list];
        }else{
            
        }
    }];
    
}
/** 比对选择的顾客id  得出数据源 */
- (void)comparisonUserID:(NSArray *)arr;
{
    NSArray * userIDArr = [_userIDStr componentsSeparatedByString:@","];
    [arr enumerateObjectsUsingBlock:^(GKGLHomeCustomerModel * customrModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [userIDArr enumerateObjectsUsingBlock:^(NSString *ID, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([customrModel.uid isEqualToString:ID]) {
                [_dataSource addObject:customrModel];
            }
        }];
    }];
    _lbNum.text = [NSString stringWithFormat:@"共%ld人，已经执行完毕%ld人",userIDArr.count, userIDArr.count- _num.integerValue];
    [_tbView reloadData];
    
}

#pragma mark - XMHFormTaskNextVCProtocol

/**
 配置参数
 */
- (void)configParams:(NSDictionary *)params
{
    _userIDStr = [params[@"userIDs"] componentsJoinedByString:@","];
    _num =  params[@"track_user_num"];
}
@end
