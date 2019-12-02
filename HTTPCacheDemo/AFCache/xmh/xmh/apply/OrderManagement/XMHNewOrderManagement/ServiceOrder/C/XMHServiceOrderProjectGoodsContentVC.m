//
//  XMHServiceOrderProjectGoodsContentVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderProjectGoodsContentVC.h"
#import "XMHServiceOrderProjectGoodTableView.h"

@interface XMHServiceOrderProjectGoodsContentVC ()
/** <##> */
@property (nonatomic, strong) XMHServiceOrderProjectGoodTableView *tableView;
@end

@implementation XMHServiceOrderProjectGoodsContentVC

 @synthesize tableView = _tableView;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataNotification:) name:XMHReloadDataNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) _self = self;
    [self setEndSearchBlock:^{
        __strong typeof(_self) self = _self;
        [self loadData];
    }];
    
    [self setStartSearchBlock:^{
        __strong typeof(_self) self = _self;
        self.tableView.modelArray = self.searchResultArray;
        [self.tableView reloadData];
    }];
}

/**
 将要显示
 */
- (void)viewWillAppear {
    [super viewWillAppear];
    // 此方法self.view frame才是显示的大小
    // 每次切换会调用此方法，防止多次创建
    
    // 不可编辑状态
    if (!self.edit) {
        return;
    }
    
    if (!self.searchView) {
//        WeakSelf
        // 搜索回调
        [self.searchView setSearchBlock:^(XMHOrderContentSearchView * _Nonnull searchView, NSString * _Nonnull text) {
            //            [weakSelf searchText:text];
        }];
        // 结束搜索
        [self.searchView setClearSearchTextBlock:^(XMHOrderContentSearchView * _Nonnull searchView) {
            //            weakSelf.isSearch = NO;
            //            [weakSelf configData];
        }];
    }
    
    if (!self.tableView) {
        self.tableView = [[XMHServiceOrderProjectGoodTableView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, self.view.width, self.view.height - self.searchView.height - self.serviceLabel.height) style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
        
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    [self loadData];
}

- (void)loadData {
    if (self.type == XMHServiceOrderTypeProject) {
        self.tableView.modelArray = _projectList;
    } else if (self.type == XMHServiceOrderTypeGoods) {
        self.tableView.modelArray = _goodsList;
    }
    [self.tableView reloadData];
}

/**
 将要隐藏
 */
- (void)viewWillDisappear {}

#pragma mark - Notification

- (void)reloadDataNotification:(NSNotification *)not {
    if (self.view.window) {
        [_tableView reloadData];
    }
}

@end
