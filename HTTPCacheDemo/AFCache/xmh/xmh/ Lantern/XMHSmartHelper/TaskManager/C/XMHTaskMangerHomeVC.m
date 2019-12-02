//
//  XMHTaskMangerHomeVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTaskMangerHomeVC.h"
#import "XMHTaskMangerHomeCell.h"
#import "XMHSmartManagerEnum.h"
#import "XMHTaskManagerHomeListModel.h"
#import "XMHRefreshGifHeader.h"
#import "XMHFormTaskDetailVC.h"
#import "XMHFormTaskCreateVC.h"

@interface XMHTaskMangerHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHBaseTableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)XMHTaskManagerCellType cellType;
@property (nonatomic, assign)BOOL isMore;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)XMHRefreshGifHeader *gifHeader;
@end

@implementation XMHTaskMangerHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isMore = NO;
    _page = 1;
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
    [self requestListData];
    [self requestTaskRead];
}
- (void)initSubViews
{
    WeakSelf
    [self.navView setNavViewTitle:@"日常任务管理" backBtnShow:YES rightBtnTitle:@"编辑"];
    
    self.navView.NavViewRightBlock = ^{
        weakSelf.navView.rightBtn.selected = !weakSelf.navView.rightBtn.selected;
        [weakSelf.navView.rightBtn setTitle:@"完成" forState:UIControlStateSelected];
        [weakSelf.navView.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        if (weakSelf.navView.rightBtn.selected) {
            weakSelf.cellType = XMHTaskManagerCellLook;
        }else{
            weakSelf.cellType = XMHTaskManagerCellEdit;
        }
        [weakSelf.tbView reloadData];
    };
    
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.tbView];
    
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[XMHBaseTableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.emptyEnable = YES;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = [UIColor clearColor];;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self refreshTbData];
        }];
    }
    return _gifHeader;
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestListData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * cellName = @"XMHTaskMangerHomeCell";
    XMHTaskMangerHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = loadNibName(@"XMHTaskMangerHomeCell");
    }
    /** 开关事件 */
    cell.XMHTaskMangerHomeCellSwitchBlock = ^(XMHTaskManagerHomeModel * obj,BOOL on) {
       
        if (obj.status == 3) {
            [[[MzzHud alloc]initWithTitle:@"" message:@"是否重新执行" leftButtonTitle:@"否" rightButtonTitle:@"是" click:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf requestCloseTaskModel:obj];
                }
            }]show];
        }
        if (obj.status == 1) {
            [[[MzzHud alloc]initWithTitle:@"" message:@"是否确认关闭" leftButtonTitle:@"否" rightButtonTitle:@"是" click:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf requestCloseTaskModel:obj];
                }
            }]show];
        }
        
    };
    [cell updateCellModel:_dataSource[indexPath.row]];
    [cell updateCellType:_cellType];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 79.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHTaskManagerHomeModel * model = _dataSource[indexPath.row];
    /** 跳转详情页 */
    if (_cellType == XMHTaskManagerCellLook) {
        if (model.status == 3 || model.status == 2) {/** 编辑界面 */
            XMHFormTaskCreateVC *vc = [[XMHFormTaskCreateVC alloc] initWithForm:nil style:UITableViewStylePlain];
            vc.type = XMHFormTaskCreateVCTypeSystemEdit;
            vc.taskID = model.taskID;
            [self.navigationController pushViewController:vc animated:YES];
        }else{/** 详情页面 */
            XMHFormTaskDetailVC *vc = [[XMHFormTaskDetailVC alloc] initWithForm:nil style:UITableViewStylePlain];
            vc.taskId = model.taskID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark ------网络请求------
/** 列表数据 */
- (void)requestListData
{
    [XMHProgressHUD showGifImage];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 技师账号 */
    [param setValue:account?account:@"" forKey:@"account"];
    /** 页码 */
    [param setValue:@(_page) forKey:@"page"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_TASHKMANAGER_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        [self endRefreshing];
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            XMHTaskManagerHomeListModel *model = [XMHTaskManagerHomeListModel yy_modelWithDictionary:obj.data];
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{
            
        }
    }];
}
/** 关闭执行任务 */
- (void)requestCloseTaskModel:(XMHTaskManagerHomeModel *)model
{
    [XMHProgressHUD showGifImage];
//    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
//    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 技师账号 */
//    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:model.taskID forKey:@"id"];
    NSString * status = @"";
    if (model.status == 1 ||model.status == 3) {
        status = @"3";
    }
    [param setValue:status?status:@"" forKey:@"status"];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_CLOSETASK_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            
        }else{
            [XMHProgressHUD showOnlyText:obj.msg];
            [self performSelector:@selector(refreshTbData) withObject:nil afterDelay:2];
        }
        
    }];
}
- (void)requestTaskRead
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_TASKREAD_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        
    }];
}
@end
