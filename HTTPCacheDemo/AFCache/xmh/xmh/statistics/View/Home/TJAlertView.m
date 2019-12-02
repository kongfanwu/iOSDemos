//
//  TJAlertView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJAlertView.h"
#import "TJAlertCell.h"
@interface TJAlertView ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation TJAlertView
{
    UITableView * _tb;
    NSArray * _dataSource;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    [self initBlackGroundView];
    [self createTableView];
}
- (void)initBlackGroundView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
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
+ (void)show
{
    TJAlertView * alert = [[TJAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIWindow * w = [UIApplication sharedApplication].keyWindow;
    [w addSubview:alert];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2) style:UITableViewStylePlain];
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.tableFooterView = [[UIView alloc] init];
    [self addSubview:_tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cell";
    TJAlertCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TJAlertCell" owner:nil options:nil]lastObject];
    }
    cell.lbTitle.text = @"你好";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)setData:(NSArray *)data
{
    _dataSource = data;
}

@end
