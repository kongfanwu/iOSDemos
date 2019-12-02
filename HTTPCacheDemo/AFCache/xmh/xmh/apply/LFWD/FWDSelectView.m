//
//  FWDSelectView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDSelectView.h"
#import "FWDSelectCell.h"
#import "LSelectBaseModel.h"
#import "SLRequest.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"

@interface FWDSelectView ()<UITableViewDelegate,UITableViewDataSource>
/** <##> */
@property (nonatomic, copy) NSString * q;
@end
@implementation FWDSelectView
{
    UITableView * _tb;
    LSelectBaseModel * _selectModel;
    UILabel * _lbTitle;
    NSArray * _dataArr;
    UIView * _header;
//    NSString * _q;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _dataArr = [[NSArray alloc] init];
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    [self createBG];
    [self createContainer];
}
- (void)createBG
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor darkGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [view addGestureRecognizer:tap];
    view.alpha = 0.7;
    [self addSubview:view];
}
- (void)tap
{
    self.hidden = YES;
}
- (void)createContainer
{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UILabel * lb = [[UILabel alloc] init];
    lb.font = FONT_SIZE(15);
    lb.text = @"请选择服务技师";
    [lb sizeToFit];
    _lbTitle = lb;
    lb.frame = CGRectMake(15, 18, lb.width, lb.height);
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH - 60, 15, 60, 15);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FONT_SIZE(14);
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(SCREEN_WIDTH - 60 * 2 - 15, 15, 60, 15);
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    btn1.titleLabel.font = FONT_SIZE(14);
    [btn1 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lb.bottom + 10, self.width, kSeparatorHeight)];
    lineView.backgroundColor = kSeparatorColor;
    
    
    JasonSearchView * serach = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, btn.bottom + 10, SCREEN_WIDTH, 45)withPlaceholder:@"搜索外店技师，请输入姓名/手机号"];
    _search = serach;
    WeakSelf
    serach.searchBar.btnRightBlock = ^{
        weakSelf.q = weakSelf.search.searchBar.text;
        [weakSelf selectMetaData:weakSelf.q];
    };
    [serach updateFrame];
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, lb.bottom + 15 + 45)];
    _header = header;
    [header addSubview:lineView];
    [header addSubview:lb];
    [header addSubview:btn];
    [header addSubview:btn1];
    [header addSubview:serach];
    [view addSubview:header];
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT/2 - header.bottom) style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource =self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.rowHeight = UITableViewAutomaticDimension;
    _tb.estimatedRowHeight = UITableViewAutomaticDimension;
    [view addSubview:_tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"FWDSelectCell";
    FWDSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FWDSelectCell" owner:nil options:nil]lastObject];
    }
    cell.model = _dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (void)click:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"确认"]) {
        if (_FWDSelectViewBlock) {
            _FWDSelectViewBlock(_selectModel);
        }
        self.hidden = YES;
    }else{
        self.hidden = YES;
    }
}
//- (void)setJisListModel:(MLJishiSearchModel *)jisListModel
//{13
//    _jisListModel = jisListModel;
//    [_tb reloadData];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSelectBaseModel * model = _dataArr[indexPath.row];
    _selectModel.isSelect = NO;
    model.isSelect = YES;
    _selectModel = model;
    [_tb reloadData];
}
- (void)setListModel:(id)listModel
{
    if ([listModel isKindOfClass:[MLJishiSearchModel class]]) {
        _lbTitle.text = @"请选择技师";
        _dataArr = ((MLJishiSearchModel *)listModel).list;
    }else if ([listModel isKindOfClass:[SLSearchManagerModel class]]){
        _lbTitle.text = @"请选择店长";
        _dataArr = ((SLSearchManagerModel *)listModel).list;
    }else if ([listModel isKindOfClass:[NSArray class]]){
        _lbTitle.text = @"请选择业绩归属";
        _dataArr = (NSArray *)listModel;
    }else{
        _lbTitle.text = @"请选择门店";
        _dataArr = ((MzzStoreList *)listModel).list;
    }
    if ([_lbTitle.text isEqualToString:@"请选择技师"]) {
        _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, _lbTitle.bottom + 15 + 45);
        _search.hidden = NO;
    }else{
        _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, _lbTitle.bottom + 15);
        _search.hidden = YES;
    }
    _tb.frame = CGRectMake(0, _header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT/2 - _header.bottom);
    [_tb reloadData];
}
- (void)selectMetaData:(NSString *)q
{
    if (q.length== 0) {
        [_tb reloadData];
        return;
    }
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
    }
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    if (token) {
        [parms setValue:token forKey:@"token"];
    }
    NSString * framId = [NSString stringWithFormat:@"%ld",model.data.join_code[0].fram_id];
    [parms setValue:framId?framId:@"" forKey:@"fram_id"];
    [parms setValue:q forKey:@"q"];
    
    [SLRequest requesSearchJisParams:parms resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _dataArr = model.list;
            [_tb reloadData];
        }
    }];
}
@end
