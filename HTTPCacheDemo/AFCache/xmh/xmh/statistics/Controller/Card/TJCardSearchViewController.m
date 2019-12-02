//
//  TJCardSearchViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJCardSearchViewController.h"
#import "JasonSearchView.h"
#import "TJRequest.h"
#import "TJCardCell.h"
#import "TJCardListModel.h"
@interface TJCardSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJCardSearchViewController
{
    JasonSearchView * _searchView;
    UITableView * _tb;
    TJCardListModel * _listModel;
    UILabel * _lbNotice;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}
- (void)initSubViews
{
    WeakSelf
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH - 60, 45)withPlaceholder:@"搜索卡项名称"];
    [self.view addSubview:_searchView];
    _searchView.searchBar.btnleftBlock = ^{
        
    };
    _searchView.searchBar.btnRightBlock = ^{
        [weakSelf searchData];
    };
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(_searchView.right + 10, 20, 40, 45);
    cancelBtn.titleLabel.font = FONT_SIZE(14);
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    
    _lbNotice = [[UILabel alloc] init];
    _lbNotice.text = @"未查找到您要搜索的卡项";
    _lbNotice.font = FONT_SIZE(15);
    [_lbNotice sizeToFit];
    _lbNotice.textColor = kLabelText_Commen_Color_9;
    _lbNotice.textAlignment = NSTextAlignmentCenter;
    _lbNotice.frame = CGRectMake(0, _searchView.bottom + 40, SCREEN_WIDTH, _lbNotice.height);
    _lbNotice.hidden = YES;
    [self.view addSubview:_lbNotice];
    [self createTableView];
}
- (void)cancel
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)setModel:(StructureModel *)model
{
    _model = model;
}
- (void)searchData
{
    MzzLog(@"....%@",_searchView.searchBar.text);
    [TJRequest requestCardSearchOneClick:_model.oneClick twoClick:_model.twoClick twoListId:_model.twoListId inId:_model.inId joinCode:_model.joinCode startTime:_model.startTime endTime:_model.endTime q:_searchView.searchBar.text resultBlock:^(TJCardListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _listModel = model;
            if (model.list.count ==0) {
                _lbNotice.hidden = NO;
                _tb.hidden = YES;
            }else{
                _lbNotice.hidden = YES;
                _tb.hidden = NO;
            }
            [_tb reloadData];
        }
    }];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _searchView.bottom)
                                       style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableFooterView = [[UIView alloc] init];
    _tb.hidden = YES;
    [self.view addSubview:_tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listModel.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell3Commen3 = @"cell3Commen3";
    TJCardCell * cell = [tableView dequeueReusableCellWithIdentifier:cell3Commen3];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TJCardCell" owner:nil options:nil]lastObject];
    }
    cell.model = _listModel.list[indexPath.row];
    return cell;
}
@end
