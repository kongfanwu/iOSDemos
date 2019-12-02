//
//  TJGuKeCardSelectCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeCardSelectCell.h"
#import "TJAlertCell.h"
@interface TJGuKeCardSelectCell ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation TJGuKeCardSelectCell
{
    UIView * _alertView;
    UITableView * _tb;
    NSArray * _titles;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _titles = @[@"活动顾客",@"有效顾客",@"新增顾客",@"休眠顾客",@"流失顾客"];
    [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self initSubViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initSubViews
{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIWindow * w = [UIApplication sharedApplication].keyWindow;
        [w addSubview:_alertView];
        _alertView.hidden = YES;
    }
    [self initBlackGroundView];
    [self createTableView];
}
- (void)initBlackGroundView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    view.backgroundColor = [UIColor darkGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [view addGestureRecognizer:tap];
    view.alpha = 0.7;
    [_alertView addSubview:view];
}
- (void)click
{
    _alertView.hidden = NO;
    
}
- (void)tap{
    _alertView.hidden = YES;
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2) style:UITableViewStylePlain];
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.tableFooterView = [[UIView alloc] init];
    [_alertView addSubview:_tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_topModel.type ==3) {
        return _titles.count;
    }
    if (_topModel.type ==5) {
        return _topModel.list.count - 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cell";
    TJAlertCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TJAlertCell" owner:nil options:nil]lastObject];
    }
    if (_topModel.type ==3) {
        cell.lbTitle.text = _titles[indexPath.row];
    }else{
       cell.lbTitle.text = _topModel.list[indexPath.row + 1].key;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJAlertCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [_btn setTitle:cell.lbTitle.text forState:UIControlStateNormal];
    if (_TJGuKeCardSelectCellBlock) {
        _TJGuKeCardSelectCellBlock([NSString stringWithFormat:@"%ld",indexPath.row]);
    }
    _alertView.hidden = YES;
}
- (void)setTopModel:(TJGuKeTopModel *)topModel
{
    _topModel = topModel;
    NSInteger type = topModel.type;
    if (type ==5) {
        _lb.hidden = YES;
        [_btn setTitle:@"列表排序" forState:UIControlStateNormal];
        _right.constant = SCREEN_WIDTH/2 - 50;
    }else{
        _lb.hidden = NO;
        [_btn setTitle:@"卡项选择" forState:UIControlStateNormal];
        _right.constant = 15;
        _titles = [topModel.card_type componentsSeparatedByString:@","];
    }
    [_tb reloadData];
}

@end
