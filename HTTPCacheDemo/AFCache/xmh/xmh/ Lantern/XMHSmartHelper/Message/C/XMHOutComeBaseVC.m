//
//  XMHOutComeBaseVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOutComeBaseVC.h"

@interface XMHOutComeBaseVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XMHOutComeBaseVC
/**
 *  下面这句话会自动生成实现的协议的属性对应的成员变量。
 */
@synthesize cute_hand_rec_id = _cute_hand_rec_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView setNavViewTitle:@"执行结果" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self createTablView];
}
- (void)createTablView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tableView.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100.f;
    [self.view addSubview:_tableView];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self tableView:tableView subNumberOfRowsInSection: section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //! 子类处理
    return [self tableView:tableView subCellForRowAtIndexPath: indexPath];
    
}

#pragma mark -- UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self tableView:tableView subHeightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self tableView:tableView subViewForHeaderInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    //! 子类处理
    [self tableView:tableView subDidSelectRowAtIndexPath: indexPath];
}

/**
 * @brief 子类重写cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView subCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCell.new;
}

/**
 * @brief 子类重写didselected
 */
- (void)tableView:(UITableView *)tableView subDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

/**
 * @brief 子类重写numberOfRows
 */
- (NSInteger)tableView:(UITableView *)tableView subNumberOfRowsInSection:(NSInteger)section { return 0; }

/**
 * @brief 子类重写heightForRow
 */
- (CGFloat)tableView:(UITableView *)tableView subHeightForRowAtIndexPath:(NSIndexPath *)indexPath { return 0; }

/**
 * @brief 子类重写viewForHeader
 */
- (UIView *)tableView:(UITableView *)tableView subViewForHeaderInSection:(NSInteger)section { return nil; }

/**
 * @brief 子类重写heightForHeader
 */
- (CGFloat)tableView:(UITableView *)tableView subHeightForHeaderInSection:(NSInteger)section { return 0; }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
