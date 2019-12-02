//
//  XMHDataReportResultVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDataReportResultVC.h"
#import "XMHDataReportResultBaseCell.h"
#import "XMHNoteCell.h"
#import "XMHReportCouponCell.h"
#import "XMHSubscribeCell.h"
#import "XMHExecutionResultModel.h"
#import "XMHDataReportListModel.h"
#define kLogoViewH  138

@interface XMHDataReportResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tbView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger nextPage;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) XMHDataReportModel *headerModel;

@end

@implementation XMHDataReportResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubViews];
    [self requestListData];
}
- (void)createSubViews
{
    self.view.backgroundColor = kColorF5F5F5;
    UIView *logoView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 35)];
    logoView.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
    [self.view addSubview:logoView];
    //设置title
    [self.navView setNavViewTitle:@"执行结果" backBtnShow:YES];
    self.navView.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
    [self createHeaderView];
    [self createTabelView];
    self.dataArr = [NSMutableArray array];
}
- (void)createHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 69)];
    headerView.backgroundColor = UIColor.clearColor;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 69)];
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.cornerRadius = 5;
    [headerView addSubview:bgView];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, bgView.width, 18)];
    _nameLab.font = FONT_SIZE(16);
    _nameLab.textColor = kLabelText_Commen_Color_3;
    [bgView addSubview:_nameLab];
    
    _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(15, _nameLab.bottom + 5, bgView.width, 16)];
    _detailLab.font = FONT_SIZE(13);
    _detailLab.textColor = kLabelText_Commen_Color_9;
    [bgView addSubview:_detailLab];
    
    [self.view addSubview:headerView];
    
     self.headerView = headerView;
}
- (void)createTabelView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.headerView.bottom) style:UITableViewStylePlain];
    _tbView.backgroundColor = kColorF5F5F5;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.estimatedRowHeight = 100.f;
    _tbView.tableFooterView = [UIView new];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tbView];
    
//    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        self.nextPage++;
//        [self requestListData];
//    }];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHExecutionResultModel *resultModel = [self.dataArr safeObjectAtIndex:indexPath.row];
    XMHDataReportResultBaseCell *cell;
    NSString *cellIdentifier;
    cellIdentifier = resultModel.cellIdentifier;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell resetMarkLine];
    [cell configureWithModel:resultModel];
    if ((self.dataArr.count - 1) == indexPath.row) {
        [cell updataMarkLine];
    }
    return cell;
}
#pragma mark -- UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,19)];
    headerView.backgroundColor = UIColor.clearColor;
 
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 19;//空隙部分的高度
}

- (void)registerCell
{
    [_tbView registerClass:[XMHNoteCell class] forCellReuseIdentifier:NSStringFromClass([XMHNoteCell class])];
    [_tbView registerClass:[XMHReportCouponCell class] forCellReuseIdentifier:NSStringFromClass([XMHReportCouponCell class])];
    [_tbView registerClass:[XMHSubscribeCell class] forCellReuseIdentifier:NSStringFromClass([XMHSubscribeCell class])];
}


#pragma mark -- request
- (void)endRefreshing{
    [_tbView.mj_footer endRefreshing];
}
-(void)requestListData{

    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:self.cute_hand_rec_id? self.cute_hand_rec_id :@"" forKey:@"cute_hand_id"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_REMIND_REPORT_INFO_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess){
            [self endRefreshing];
            NSDictionary *dic = obj.data;

            XMHExecutionResultListModel * model = [XMHExecutionResultListModel yy_modelWithDictionary:dic];
            [_dataArr safeAddObjectsFromArray:model.list];
            _nameLab.text = model.name;
            _detailLab.text = [NSString stringWithFormat:@"共设置%@次任务,执行%@次",model.all,model.zhi];
            [self registerCell];  //注册cell
            [self.tbView reloadData];
        }
        
    }];

}

- (void)requestReadState
{
    /** 如果是未读 请求接口 */
    if (_model.read) {
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        [param setValue:self.cute_hand_rec_id? self.cute_hand_rec_id :@"" forKey:@"cute_hand_id"];
        
        [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_RESULTREAD_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
            [XMHProgressHUD dismiss];
            
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
