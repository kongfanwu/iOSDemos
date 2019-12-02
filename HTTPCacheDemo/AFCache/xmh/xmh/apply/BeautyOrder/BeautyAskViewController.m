//
//  BeautyAskViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyAskViewController.h"
#import "choiseCustomerHeader.h"
#import "BeautyAskCell.h"
#import "BeautyDesignViewController.h"
#import "OneStepView.h"
#import "ShareWorkInstance.h"
@interface BeautyAskViewController ()<UITableViewDelegate,UITableViewDataSource>{
    __block UITableView *_tbView;
    choiseCustomerHeader *_tbHeaderView;
    OneStepView  *_tbFooter;
}

@end

@implementation BeautyAskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self initSubviews];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"美丽问诊" withleftImageStr:@"stgkgl_fanhui" withRightStr:@"下一步"];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnRight addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubviews{
    _tbHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"choiseCustomerHeader" owner:nil options:nil] firstObject];
    _tbHeaderView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 110);
    [_tbHeaderView reFreshchoiseCustomerHeader:2];
    [self.view addSubview:_tbHeaderView];
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _tbHeaderView.bottom,SCREEN_WIDTH,Heigh_View_normal-_tbHeaderView.height) style:UITableViewStylePlain];
    _tbView.separatorColor = [UIColor clearColor];
    _tbView.backgroundColor = kBackgroundColor;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    _tbFooter = [[[NSBundle mainBundle]loadNibNamed:@"OneStepView" owner:nil options:nil] firstObject];
//    _tbFooter.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 70);
//    [_tbFooter.btn setTitle:@"确定" forState:UIControlStateNormal];
//    [_tbFooter.btn setTitle:@"确定" forState:UIControlStateHighlighted];
//    _tbView.tableFooterView = _tbFooter;
//    [_tbFooter.btn addTarget:self action:@selector(btnCommitEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BeautyAskCellindentifier = @"BeautyAskCellindentifier";
    BeautyAskCell *cell = [tableView dequeueReusableCellWithIdentifier:BeautyAskCellindentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BeautyAskCell" owner:nil options:nil] lastObject];
    }
    switch (indexPath.row) {
        case 0:
            [cell reFreshBeautyAskCell:@"处方诉求：" withContext:@"" withPlaceText:@"顾客的肌肤或身体表现症状，以及顾客要改善的目标在此填写即可。" withhidden:NO];
            break;
            case 1:
            [cell reFreshBeautyAskCell:@"处方理念：" withContext:@"" withPlaceText:@"将此次处方搭配理念，包括此次处方搭配完后可以实现的效果填写此处即可。" withhidden:NO];
            break;
        default:
            break;
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)nextEvent{
    [self btnCommitEvent];
}
- (void)btnCommitEvent{
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
    BeautyAskCell *cell1 = [_tbView cellForRowAtIndexPath: indexPath1];
    BeautyAskCell *cell2 = [_tbView cellForRowAtIndexPath: indexPath2];
    [ShareWorkInstance shareInstance].symptom = cell1.text1.text;
    [ShareWorkInstance shareInstance].target = cell2.text1.text;
    //暂时保存，后面打总提交
    BeautyDesignViewController *vc = [[BeautyDesignViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
