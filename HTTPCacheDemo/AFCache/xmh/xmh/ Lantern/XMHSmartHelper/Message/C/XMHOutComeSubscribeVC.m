//
//  XMHOutComeSubscribeVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOutComeSubscribeVC.h"
#import "XMHTraceCustomerCell.h"
#import "XMHOutComeSubscribeInfoCell.h"
#import "XMHSmartManagerEnum.h"
#import "GKGLHomeCustomerListModel.h"
#import "XMHExecutionResultModel.h"
#import "BookFastVC.h"
#import "BookParamModel.h"
@interface XMHOutComeSubscribeVC ()
@property (nonatomic, strong) XMHExecutionResultModel *model;
@end

@implementation XMHOutComeSubscribeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestListData];
    self.tableView.rowHeight = 96.0f;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView subNumberOfRowsInSection:(NSInteger)section
{
    return _model.user_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView subCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHTraceCustomerCell";
    XMHTraceCustomerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = loadNibName(@"XMHTraceCustomerCell");
    }
    GKGLHomeCustomerModel *model = [_model.user_list safeObjectAtIndex:indexPath.row];
    [cell updateCellModel:model];
    [cell updateCellType:XMHTraceCustomerCellTypeLook];
    return cell;
  
}


#pragma mark -- UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView subViewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 164)];
    headerView.backgroundColor = kBackgroundColor;
    XMHOutComeSubscribeInfoCell *cell = cell = [[XMHOutComeSubscribeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHOutComeSubscribeInfoCell"];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 164);
    [cell configureWithModel:_model];
    [headerView addSubview:cell];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView subHeightForHeaderInSection:(NSInteger)section
{
    return 164;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GKGLHomeCustomerModel *model = [_model.user_list safeObjectAtIndex:indexPath.row];
    if ([model.is_appo integerValue] == 1) {
        return;
    }
    BookFastVC * bookFastVC= [[BookFastVC alloc] init];
    BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"执行结果" type:@"zxjg" orderNum:nil userID:model.uid];
    bookFastVC.paramModel = paramModel;
    [self.navigationController pushViewController:bookFastVC animated:NO];
    
}

#pragma mark ------网络请求------
/** 列表数据 */
- (void)requestListData
{
    [XMHProgressHUD showGifImage];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    
    [param setValue:self.cute_hand_rec_id?self.cute_hand_rec_id : @"" forKey:@"cute_hand_rec_id"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_APPO_REMINM_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(id obj, BOOL isSuccess, NSError *error) {
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
