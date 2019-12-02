//
//  XMHExperienceOrderContentVC.m
//  xmh
//
//  Created by KFW on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHExperienceOrderContentVC.h"
#import "UIViewController+XMHSegment.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "XMHOrderContentSearchView.h"
#import "XMHExperienceOrderContentTableView.h"
#import "XMHProjectDetailGoodsVC.h"

@interface XMHExperienceOrderContentVC ()
/** <##> */
@property (nonatomic, strong) XMHOrderContentSearchView *searchView;
/** <##> */
@property (nonatomic, strong) XMHExperienceOrderContentTableView *tableView;
/** 搜索状态 */
@property (nonatomic) BOOL isSearch;
/** <##> */
@property (nonatomic, strong) NSArray *searchResultArray;
@end

@implementation XMHExperienceOrderContentVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edit = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 将要显示
 */
- (void)viewWillAppear {
    // 此方法self.view frame才是显示的大小
    // 每次切换会调用此方法，防止多次创建
    
    // 不可编辑状态
    if (!_edit) {
        return;
    }
    
    if (!self.searchView) {
        WeakSelf
        self.searchView = [[XMHOrderContentSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 53)];
        [self.view addSubview:_searchView];
        // 搜索回调
        [_searchView setSearchBlock:^(XMHOrderContentSearchView * _Nonnull searchView, NSString * _Nonnull text) {
            [weakSelf searchText:text];
        }];
        // 结束搜索
        [_searchView setClearSearchTextBlock:^(XMHOrderContentSearchView * _Nonnull searchView) {
            weakSelf.isSearch = NO;
            [weakSelf configData];
        }];
    }
    
    if (!self.tableView) {
        self.tableView = [[XMHExperienceOrderContentTableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, self.view.width, self.view.height - _searchView.height) style:UITableViewStylePlain];
        _tableView.type = _type;
        [self.view addSubview:_tableView];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        WeakSelf
        [_tableView setDidSelectRowAtIndexPathBlock:^(XMHExperienceOrderContentTableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            id model = tableView.dataArray[indexPath.row];
            XMHProjectDetailGoodsVC *detailVC = XMHProjectDetailGoodsVC.new;
            detailVC.selectUserModel = weakSelf.selectUserModel;
            detailVC.model = model;
            [weakSelf.view.window.rootViewController presentViewController:detailVC animated:YES completion:nil];
        }];
        
        [self configData];
    }
}

/**
 将要隐藏
 */
- (void)viewWillDisappear {}

- (void)configData {
    if (_type == XMHExperienceOrderTypeProject) {
        _tableView.dataArray = _projectModel.list; // SLS_Pro
        // 绑定服务类型
        for (SLS_Pro *model in _tableView.dataArray) {
            model.type = XMHExperienceOrderTypeProject;
        }
    } else if (_type == XMHExperienceOrderTypeGoods) {
        _tableView.dataArray = _goodModel.list; // SLGoodModel
        // 绑定服务类型
        for (SLS_Pro *model in _tableView.dataArray) {
            model.type = XMHExperienceOrderTypeGoods;
        }
    } else if (_type == XMHExperienceOrderTypeExperience) {
        // 拼接项目，商品model 类型不一致
        NSMutableArray *models = [_courseExperList.pro_list mutableCopy];
        [models addObjectsFromArray:_courseExperList.goods_list];
        _tableView.dataArray = models; // SLPro_ListM SLGoods_ListM
        // 绑定服务类型
        for (SLS_Pro *model in _tableView.dataArray) {
            model.type = XMHExperienceOrderTypeExperience;
        }
    }
    [_tableView reloadData];
}

- (void)searchText:(NSString *)text {
    [self.view endEditing:YES];
    _isSearch = YES;
    //定义谓词
    NSString *searchStr = [NSString stringWithFormat:@"name LIKE '*%@*'", text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchStr];
    self.searchResultArray = [_searchDataArray filteredArrayUsingPredicate:predicate];
    
    _tableView.dataArray = _searchResultArray;
    [_tableView reloadData];
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
