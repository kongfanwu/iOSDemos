//
//  GKGLBillVerifyVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLBillVerifyVC.h"
#import "GKGLBillVerifyCell.h"
#import "GKGLBillVerifySectionHeaderView.h"
#import "GKGLBillVerifySectionFooterView.h"
@interface GKGLBillVerifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)GKGLBillVerifySectionHeaderView *sectionHeaderView;
@property (nonatomic, strong)GKGLBillVerifySectionFooterView *sectionFooterView;
@end

@implementation GKGLBillVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    [self.navView setNavViewTitle:@"顾客处方" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        [_tbView.mj_header beginRefreshing];
    }
    return _tbView;
}
- (GKGLBillVerifySectionFooterView *)sectionFooterView
{
//    if (!_sectionFooterView) {
        _sectionFooterView = loadNibName(@"GKGLBillVerifySectionFooterView");
        _sectionFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 5);
//    }
    return _sectionFooterView;
}
- (GKGLBillVerifySectionHeaderView *)sectionHeaderView
{
//    if (!_sectionHeaderView) {
        _sectionHeaderView = loadNibName(@"GKGLBillVerifySectionHeaderView");
        _sectionHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 54);
//    }
    return _sectionHeaderView;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLBillVerifyCell = @"kGKGLBillVerifyCell";
    GKGLBillVerifyCell * billVerifyCell = [tableView dequeueReusableCellWithIdentifier:kGKGLBillVerifyCell];
    if (!billVerifyCell) {
        billVerifyCell =  loadNibName(@"GKGLBillVerifyCell");
    }
    if (indexPath.section == 0) {
        [billVerifyCell updateCellParam:_paramDic[@"stored_card"][indexPath.row] type:@"stored_card"];
    }else if (indexPath.section == 0) {
        [billVerifyCell updateCellParam:_paramDic[@"card_time"][indexPath.row] type:@"card_time"];
    }else if (indexPath.section == 0) {
        [billVerifyCell updateCellParam:_paramDic[@"card_num"][indexPath.row] type:@"card_num"];
    }else if (indexPath.section == 0) {
        [billVerifyCell updateCellParam:_paramDic[@"pro"][indexPath.row] type:@"pro"];
    }else if (indexPath.section == 0) {
        [billVerifyCell updateCellParam:_paramDic[@"goods"][indexPath.row] type:@"goods"];
    }else if (indexPath.section == 0) {
        [billVerifyCell updateCellParam:_paramDic[@"ticket"][indexPath.row] type:@"ticket"];
    }
    return billVerifyCell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 54.0;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        if (_paramDic[@"stored_card"] != nil) {
            return [_paramDic[@"stored_card"] count];
        }
        return 0;
    }else if (section == 1) {
        if (_paramDic[@"card_time"] != nil) {
            return [_paramDic[@"card_time"] count];
        }
        return 0;
    }else if (section == 2) {
        if (_paramDic[@"card_num"] != nil) {
            return [_paramDic[@"card_num"] count];
        }
        return 0;
    }else if (section == 3) {
        if (_paramDic[@"pro"] != nil) {
            return [_paramDic[@"pro"] count];
        }
        return 0;
    }else if (section == 4) {
        if (_paramDic[@"goods"] != nil) {
            return [_paramDic[@"goods"] count];
        }
        return 0;
    }else if (section == 5) {
        if (_paramDic[@"ticket"] != nil) {
            return [_paramDic[@"ticket"] count];
        }
        return 0;
    }else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _sectionHeaderView = loadNibName(@"GKGLBillVerifySectionHeaderView");
    _sectionHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 54);
    [_sectionHeaderView updateTitle:@"" index:section];
    return _sectionHeaderView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.sectionFooterView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 105;
    }
    if (indexPath.section == 1) {
        return 105;
    }
    if (indexPath.section == 2) {
        return 145;
    }
    if (indexPath.section == 3) {
        return 145;
    }
    if (indexPath.section == 4) {
        return 145;
    }
    if (indexPath.section == 5) {
        return 85;
    }
    return 145.0f;
}
@end
