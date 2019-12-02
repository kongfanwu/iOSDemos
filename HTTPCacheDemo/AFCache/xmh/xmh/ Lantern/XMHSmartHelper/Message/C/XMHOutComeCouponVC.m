//
//  XMHOutComeCouponVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOutComeCouponVC.h"
#import "XMHOutComeCouponInfoCell.h"
#import "XMHTraceDiscountCouponCell.h"
#import "XMHSmartManagerEnum.h"
#import "XMHExecutionResultModel.h"
#import "XMHCouponListModel.h"
#import "XMHCouponModel.h"

@interface XMHOutComeCouponVC ()
@property (nonatomic, strong) XMHExecutionResultModel *model;
@end

@implementation XMHOutComeCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestListData];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView subNumberOfRowsInSection:(NSInteger)section
{
  return  _model.ticket_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView subCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHTraceDiscountCouponCell";
    XMHTraceDiscountCouponCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = loadNibName(@"XMHTraceDiscountCouponCell");
    }
    XMHCouponModel *couponModel = [_model.ticket_list safeObjectAtIndex:indexPath.row];
    [cell updateCellModel:couponModel];
    [cell updateCellType:XMHTraceDiscountCouponCellTypeLook];
    return cell;
  
}

#pragma mark -- UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView subViewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34 + 193)];
    headerView.backgroundColor = kBackgroundColor;
    XMHOutComeCouponInfoCell *cell = cell = [[XMHOutComeCouponInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHOutComeCouponInfoCell"];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 193);
    [cell configureWithModel:_model];
    [headerView addSubview:cell];
    
    UILabel *lab = UILabel.new;
    lab.text = @"优惠券";
    lab.font = FONT_SIZE(16);
    lab.textColor = kColor3;
    [headerView addSubview:lab];
    lab.frame  =CGRectMake(15, 193 + 15, 100, 18);
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView subHeightForHeaderInSection:(NSInteger)section
{
    return 34 + 193;
}

- (void)tableView:(UITableView *)tableView subDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ------网络请求------
/** 列表数据 */
- (void)requestListData
{
    [XMHProgressHUD showGifImage];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    
    [param setValue:self.cute_hand_rec_id?self.cute_hand_rec_id : @"" forKey:@"cute_hand_rec_id"];

   [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_TICKE_REMINM_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(id obj, BOOL isSuccess, NSError *error) {
    [XMHProgressHUD dismiss];
    if (isSuccess) {
        BaseModel *baseModel = (BaseModel *)obj;
        
        _model = [XMHExecutionResultModel yy_modelWithDictionary:baseModel.data];
        [self.tableView reloadData];
    }
}];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
