//
//  BookProjectViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookProjectViewController.h"

#import "BookProjectSelectResultView.h"
#import "BookRequest.h"
#import "BookProjectTableViewCell.h"
#import "DaiYuYueListModel.h"
#import "DaiYuYueModel.h"
#import "BookChuFangCell.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "XMHRefreshGifHeader.h"
#import "BookProjectCell.h"
static NSString * BookProject = @"BookProjectTableViewCell";
static NSString * BookChuFang = @"BookChuFangCell";
@interface BookProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BookProjectViewController
{
    UITableView * _tb;
    //数据源
    NSMutableArray * _dataArr;
    //选择的项目数组
    NSMutableArray * _selectArr;
    //选择的行
    NSInteger  _selectRow;
    //底部选择数量显示View
    BookProjectSelectResultView * _result;
    // 是否全选
    UIButton * _selectAllBtn;
    
    NSString * _userId;
    
    
    
    
    
    
    
    
    NSMutableArray * _dateSource;
    NSInteger _currentPage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /** 初始化数据 */
    _selectArr = [[NSMutableArray alloc] init];
    _dataArr = [[NSMutableArray alloc] init];
    
    
    
    
    
    _currentPage = 0;
    _dateSource = [[NSMutableArray alloc] init];
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"待预约" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
   
    [self initSubViews];
    
    
    /** 数据请求 */
    [self requestProjectData];
//    [self test];
    
}
- (void)initSubViews
{
    [self createTableView];
    [self createProjectSelectView];
}
- (void)setModel:(CustomerModel *)model
{
    _model = model;
    _userId = [NSString stringWithFormat:@"%ld",model.uid];
    [self loadData];
}
-(void)setCModel:(CustomerMessageModel *)cModel
{
    _cModel = cModel;
    _userId = [NSString stringWithFormat:@"%ld",cModel.uid];
    [self loadData];
}
//加载数据
- (void)test
{
    for (int i = 0; i < 5; i ++) {
        DaiYuYueModel * model =  [[DaiYuYueModel alloc]init];
        model.name = [NSString stringWithFormat:@"%d",i + 100];
        model.type = @"pre";
        [_dataArr addObject:model];
    }
    [_tb reloadData];
}
- (void)requestProjectData
{
//    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
//    [params setValue:infomodel.data.account?infomodel.data.account:@"" forKey:@"inId"];
    [params setValue:_userID?_userID:@"" forKey:@"user_id"];
    [params setValue:@(_currentPage)?@(_currentPage):@"" forKey:@"page"];
    [BookRequest requestDaiYuYueParams:params resultBlock:^(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (listModel.list.count == 0) {
                [_tb.mj_footer endRefreshingWithNoMoreData];
            }else{
                
            }
            [_dateSource addObjectsFromArray:listModel.list];
            [_tb reloadData];
        }
        
    }];
}
- (void)loadData
{
    BookRequest * request = [[BookRequest alloc] init];
    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary * params = [@{@"user_id":_userId?_userId:@"",@"join_code":joincode?joincode:@""} mutableCopy];
    [request requestDaiYuYueParams:params resultBlock:^(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        _dataArr = listModel.list;
        [_tb reloadData];
    }];
}
- (void)createProjectSelectView
{
    BookProjectSelectResultView * result = [[[NSBundle mainBundle]loadNibNamed:@"BookProjectSelectResultView" owner:nil options:nil]lastObject];
    _result = result;
    result.frame = CGRectMake(0, self.view.height - 49 - kSafeAreaBottom, SCREEN_WIDTH, 49);
    [result.btn2 addTarget:self action:@selector(checkAll:) forControlEvents:UIControlEventTouchUpInside];
    [result.btn3 addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:result];
}
- (void)checkAll:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [_selectArr removeAllObjects];
    if (btn.selected) {
        for (DaiYuYueModel * model in _dateSource) {
            model.isSelected = YES;
        }
        [_tb reloadData];
        [_selectArr addObjectsFromArray:_dateSource];
    }else{
        for (DaiYuYueModel * model in _dateSource) {
            model.isSelected = NO;
        }
        [_tb reloadData];
        [_selectArr removeAllObjects];
    }
     _result.lb1.text = [NSString stringWithFormat:@"共:%lu个项目",(unsigned long)_selectArr.count];
     _selectAllBtn = btn;
}
- (void)submit
{
    NSMutableString * projectStr = [[NSMutableString alloc] init];
    NSInteger  maxTime = 0;
 
    for (int i = 0 ; i<_selectArr.count; i++) {
        DaiYuYueModel * model = _selectArr[i];
        if (model.shichang > maxTime) {
            maxTime = model.shichang;
        }
        [projectStr appendString:model.name];
        [projectStr appendString:@"、"];
    }
    if (projectStr.length > 1) {
         [projectStr replaceCharactersInRange:NSMakeRange(projectStr.length - 1, 1) withString:@""];
    }
    if (_BookProjectViewControllerBlock) {
        _BookProjectViewControllerBlock(_selectArr);
    }
    if (_BookProjectViewControllerProjectBlock) {
        _BookProjectViewControllerProjectBlock(projectStr,maxTime);
    }
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createTableView
{
    WeakSelf
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 44 - kSafeAreaBottom) style:UITableViewStylePlain];
    _tb.backgroundColor = [UIColor clearColor];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf refreshTbData];
//    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreData];
    }];
    [self.view addSubview:_tb];
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
    }
    return _gifHeader;
}
- (void)requestMoreData
{
    _currentPage ++;
    [self requestProjectData];
}
- (void)refreshTbData
{
    _currentPage = 0;
    [_dateSource removeAllObjects];
    [self requestProjectData];
}
- (void)endRefreshing{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kProjectCell = @"kProjectCell";
    BookProjectCell * projectCell = [tableView dequeueReusableCellWithIdentifier:kProjectCell];
    if (!projectCell) {
        projectCell = loadNibName(@"BookProjectCell");
    }
    [projectCell updateBookProjectCellModel:_dateSource[indexPath.row]];
    return projectCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DaiYuYueModel * model = _dateSource[indexPath.row];
    if ([model.type isEqualToString:@"pres"]) {
        return 138.0f;
    }else{
        return 98.0f;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DaiYuYueModel * model = _dateSource[indexPath.row];
    model.isSelected = !model.isSelected;
    [_tb reloadData];
    if([_selectArr containsObject:_dateSource[indexPath.row]]){
        [_selectArr removeObject:_dateSource[indexPath.row]];
    }else{
        [_selectArr addObject:_dateSource[indexPath.row]];
    }
    if (!(_selectArr.count == _dateSource.count)) {
        _result.btn2.selected = NO;
    }
    _result.lb1.text = [NSString stringWithFormat:@"共:%lu个项目",(unsigned long)_selectArr.count];
}

@end
