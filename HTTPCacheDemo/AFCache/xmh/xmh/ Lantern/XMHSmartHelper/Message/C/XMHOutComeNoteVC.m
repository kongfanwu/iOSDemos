//
//  XMHOutComeNoteVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOutComeNoteVC.h"
#import "XMHOutComeNoteInfoCell.h"
#import "XMHOutComeNoteContentCell.h"
#import "XMHExecutionResultModel.h"
@interface XMHOutComeNoteVC ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) XMHExecutionResultModel *model;

@end

@implementation XMHOutComeNoteVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self requestListData];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView subNumberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView subCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    
        XMHOutComeNoteInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];//运用这个就可以禁止复用了
        if (!cell){
            cell = [[XMHOutComeNoteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHOutComeNoteInfoCell"];
            
        }
        [cell configureWithModel:_model];
        return cell;
    }
    XMHOutComeNoteContentCell *cell = [tableView cellForRowAtIndexPath:indexPath];//运用这个就可以禁止复用了
    if (!cell){
        cell = [[XMHOutComeNoteContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHOutComeNoteContentCell"];
    }
    [cell configureWithModel:_model];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView subHeightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView subDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -- XMHUMPushRespManagerDelegate
- (void)managerDidRecvMessageMediaTextObject:(XMHUMPushObject *)object
{
    
}

#pragma mark ------网络请求------
/** 列表数据 */
- (void)requestListData
{
    [XMHProgressHUD showGifImage];
    
    _dataSource = [NSMutableArray array];;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:self.cute_hand_rec_id?self.cute_hand_rec_id : @"" forKey:@"cute_hand_rec_id"];

    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_SMS_REMINDSMS_REMINM_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            _model = [XMHExecutionResultModel yy_modelWithDictionary:obj.data];
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
