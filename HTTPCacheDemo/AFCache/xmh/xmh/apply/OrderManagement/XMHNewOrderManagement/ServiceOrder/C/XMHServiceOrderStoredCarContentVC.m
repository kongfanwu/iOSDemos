//
//  XMHServiceOrderStoredCarContentVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderStoredCarContentVC.h"
#import "XMHServiceOrderProjectGoodTableView.h"

@interface XMHServiceOrderStoredCarContentVC ()
/** <##> */
@property (nonatomic, strong) XMHServiceOrderProjectGoodTableView *tableView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** <##> */
@property (nonatomic, strong) UIView *topView;
/** <##> */
@property (nonatomic, strong) UIButton *projectButton, *goodsButton;
@end

@implementation XMHServiceOrderStoredCarContentVC

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
    
    if (!self.topView) {
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, self.view.width, 45)];
        [self.view addSubview:_topView];
    
        UIButton *projectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.projectButton = projectButton;
        [projectButton setTitle:@"项目" forState:UIControlStateNormal];
        [projectButton setTitleColor:kColor3 forState:UIControlStateNormal];
        projectButton.titleLabel.font = FONT_SIZE(16);
        [projectButton setImage:UIImageName(@"duoxuan-weixuanze") forState:UIControlStateNormal];
        [projectButton setImage:UIImageName(@"duoxuan-yixuanze") forState:UIControlStateSelected];
        [projectButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:projectButton];
        [projectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView).offset(10);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(25);
            make.width.equalTo(_topView).multipliedBy(0.5);
        }];
        projectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [projectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, projectButton.imageView.frame.size.width-10, 0.0,0.0)];
        
        UIButton *goodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.goodsButton = goodsButton;
        [goodsButton setTitle:@"产品" forState:UIControlStateNormal];
        [goodsButton setTitleColor:kColor3 forState:UIControlStateNormal];
        goodsButton.titleLabel.font = FONT_SIZE(16);
        [goodsButton setImage:UIImageName(@"duoxuan-weixuanze") forState:UIControlStateNormal];
        [goodsButton setImage:UIImageName(@"duoxuan-yixuanze") forState:UIControlStateSelected];
        [goodsButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:goodsButton];
        [goodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(projectButton);
            make.left.equalTo(_topView.mas_centerX);
        }];
        goodsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [goodsButton setTitleEdgeInsets:UIEdgeInsetsMake(0, goodsButton.imageView.frame.size.width-10, 0.0,0.0)];
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = kColorE5E5E5;
        [_topView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(15);
            make.right.bottom.equalTo(_topView);
        }];
    }
    
    if (!self.tableView) {
        self.tableView = [[XMHServiceOrderProjectGoodTableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, self.view.width, self.view.height - self.searchView.height - self.serviceLabel.height - _topView.height) style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
        
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    [self selectEvent:_projectButton];
}

/**
 将要隐藏
 */
- (void)viewWillDisappear {}

#pragma mark - Event

- (void)selectEvent:(UIButton *)sender {
    if (sender == _projectButton) {
        _projectButton.selected = YES;
        _goodsButton.selected = NO;
        [self loadData];
    } else {
        _projectButton.selected = NO;
        _goodsButton.selected = YES;
        [self loadData];
    }
}

- (void)loadData {
    if (_projectButton.selected == YES) {
        self.tableView.modelArray = _storedCardModel.pro_list;
    } else {
        self.tableView.modelArray = _storedCardModel.goods_list;
    }
    [self.tableView reloadData];
}

#pragma mark - Notification

- (void)reloadDataNotification:(NSNotification *)not {
    if (self.view.window) {
        [self.tableView reloadData];
    }
}
@end
