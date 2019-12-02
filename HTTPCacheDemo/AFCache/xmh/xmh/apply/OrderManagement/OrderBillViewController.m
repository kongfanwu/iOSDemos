//
//  OrderBillViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/7.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OrderBillViewController.h"
#import "JasonSearchView.h"
#import "BeautyCardCell.h"
#import "GuDiingKaiDanRightCell.h"


@interface OrderBillViewController (){
    
    JasonSearchView    *_searchView;
    NSIndexPath        *_lastindexPath;
    NSArray            *_arrLeft;
}

@property (weak, nonatomic) IBOutlet UIView *SearchBg;
@property (weak, nonatomic) IBOutlet UITableView *tbLeft;
@property (weak, nonatomic) IBOutlet UITableView *tbRight;

@end

@implementation OrderBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrLeft = @[@"项目疗程",@"产品",@"特惠卡",@"任选卡",@"储值卡",@"时间卡",@"票券"];
    [self creatNav];
    [self initSubviews];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"固定开单" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubviews{
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(5,5, _SearchBg.width - 10, 45)withPlaceholder:@"商品名称"];
    //    __block NSMutableArray *tempSourceArr = _sourceArr;
    //    __block NSArray *tempOrginArr = _orginsourceArr;
    //    __block UITableView *tempTable =_tbView;
//    __block JasonSearchView    *tempsearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        //        [tempSourceArr removeAllObjects];
        //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", tempsearchView.searchBar.text];
        //        NSArray *temp = [tempOrginArr filteredArrayUsingPredicate:predicate];
        //        [tempSourceArr addObjectsFromArray:temp];
        //        [tempTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    _searchView.searchBar.btnleftBlock = ^{
        //        [tempSourceArr removeAllObjects];
        //        [tempSourceArr addObjectsFromArray:tempOrginArr];
        //        [tempTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    };
    [_SearchBg addSubview:_searchView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbLeft) {
        static NSString *BeautyCardCellindentifier = @"BeautyCardCellindentifier";
        BeautyCardCell *cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BeautyCardCell" owner:nil options:nil] lastObject];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:BeautyCardCellindentifier];
        }
        cell.backgroundColor = kBackgroundColor;
        [cell reFreshBeautyCardCell:_arrLeft[indexPath.row]];
        return cell;
    } else {
        static NSString *GuDiingKaiDanRightCellindentifier = @"GuDiingKaiDanRightCellindentifier";
        GuDiingKaiDanRightCell *cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GuDiingKaiDanRightCell" owner:nil options:nil] lastObject];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:GuDiingKaiDanRightCellindentifier];
        }
//        [cell reFreshBeautyCardCell:_arrLeft[indexPath.row]];
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbLeft) {
        return _arrLeft.count;
    }else {
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbLeft) {
        return 50;
    } else {
        return 220;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tbLeft) {
        if (_lastindexPath) {
            BeautyCardCell *cell = [_tbLeft cellForRowAtIndexPath:_lastindexPath];
            cell.lb1.textColor = kLabelText_Commen_Color_9;
        }
        BeautyCardCell *cell = [_tbLeft cellForRowAtIndexPath:indexPath];
        cell.lb1.textColor = kLabelText_Commen_Color_3;
        _lastindexPath = indexPath;
        //        _leftCellTitle = cell.lb1.text;
        //        [_tbRighView reloadData];
    } else {
    }
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
