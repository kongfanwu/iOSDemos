//
//  CheckPlanVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CheckPlanVC.h"
#import "CheckPlanCell.h"
#import "MassgaeNoDataView.h"
#import "LanternRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "QFDatePickerView.h"
#import "LanternXSPlanVC.h"
#import "LanternXHPlanVC.h"
#import "UIScrollView+EmptyDataSet.h"
@interface CheckPlanVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)MassgaeNoDataView *noDataView;
@property (nonatomic, strong)NSString *year;
@end

@implementation CheckPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] init];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    _year = [formatter stringFromDate:currentDate];
    
    self.view.backgroundColor = kColorE;
    [self initSubViews];
    [self requestHistoryPlanData];
}
- (void)initSubViews
{
    WeakSelf
    [self.navView setNavViewTitle:@"查看计划" backBtnShow:YES rightBtnTitle:[NSString stringWithFormat:@"%@年",_year]];
    [self.navView.rightBtn setImage:UIImageName(@"zhinengguanjia_chakanjihua_xuanzeshijian_jiantou") forState:UIControlStateNormal];
    /** 文字居左图标居右 */
    self.navView.rightBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    self.navView.NavViewRightBlock = ^{
        QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initYearPickerWithView:weakSelf.view response:^(NSString *str) {
            weakSelf.year = str;
            [weakSelf requestHistoryPlanData];
            [weakSelf.navView.rightBtn setTitle:[NSString stringWithFormat:@"%@年",str] forState:UIControlStateNormal];
        }];
        [datePickerView show];
    };
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.noDataView];
}
- (MassgaeNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = loadNibName(@"MassgaeNoDataView");
        _noDataView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav);
        _noDataView.hidden = YES;
        [_noDataView updateMassgaeNoDataViewText:@"暂没有计划查看"];
    }
    return _noDataView;
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.emptyDataSetDelegate = self;
        _tbView.emptyDataSetSource = self;
    }
    return _tbView;
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCheckPlanCell = @"kCheckPlanCell";
    CheckPlanCell * checkPlanCell = [tableView dequeueReusableCellWithIdentifier:kCheckPlanCell];
    if (!checkPlanCell) {
        checkPlanCell = loadNibName(@"CheckPlanCell");
        __weak typeof(self) _self = self;
        checkPlanCell.CheckPlanCellXHBlock = ^(LanternHistoryPlanModel *model) {
            __strong typeof(_self) self = _self;
            LanternXHPlanVC * lanternXHPlanVC = [[LanternXHPlanVC alloc] init];
            lanternXHPlanVC.lanternHistoryPlanModel = model;
            lanternXHPlanVC.year = self.year;
            lanternXHPlanVC.comeFrom = DetailComeFromeHistory;
            [self.navigationController pushViewController:lanternXHPlanVC animated:NO];
        };

        checkPlanCell.CheckPlanCellXSBlock = ^(LanternHistoryPlanModel *model) {
            __strong typeof(_self) self = _self;
            LanternXSPlanVC * lanternXSPlanVC = [[LanternXSPlanVC alloc] init];
            lanternXSPlanVC.lanternHistoryPlanModel = model;
            lanternXSPlanVC.year = self.year;
            lanternXSPlanVC.comeFrom = DetailComeFromeHistory;
            [self.navigationController pushViewController:lanternXSPlanVC animated:NO];
        };
    }
    [checkPlanCell updateCheckPlanCellModel:_dataSource[indexPath.row]];
    return checkPlanCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"xmhdefault_zanwutishi"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"灯神温馨提示：";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: kColor9};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂没有计划查看";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: kColor9,
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
#pragma mark ------网络请求------
- (void)requestHistoryPlanData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:_year?_year:@"" forKey:@"year"];
    [LanternRequest requestHistoryPlan:param resultBlock:^(LanternHistoryPlanListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:model.list];
            [_tbView reloadData];
//            if (model.list.count == 0) {
//                _noDataView.hidden = NO;
//            }else{
//                _noDataView.hidden = YES;
//            }
        }else{}
    }];
}

@end
