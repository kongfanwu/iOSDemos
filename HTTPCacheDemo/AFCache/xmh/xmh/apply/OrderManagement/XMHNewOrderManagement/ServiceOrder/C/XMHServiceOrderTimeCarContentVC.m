//
//  XMHServiceOrderTimeCarContentVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderTimeCarContentVC.h"
#import "XMHServiceOrderProjectGoodTableView.h"

@interface XMHServiceOrderTimeCarContentVC ()
/** <##> */
@property (nonatomic, strong) XMHServiceOrderProjectGoodTableView *tableView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** <##> */
@property (nonatomic, strong) UIView *topView;
@end

@implementation XMHServiceOrderTimeCarContentVC

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
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.serviceLabel.bottom, self.view.width, 85)];
        [self.view addSubview:_topView];
        
        UILabel *titleLabel = [self createLabel];
        titleLabel.text = _timeCarModel.name;
        [_topView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
        }];
        
        UILabel *timeLabel = [self createLabel];
        timeLabel.text = [NSString stringWithFormat:@"截止日期：%@", _timeCarModel.end_time];
        [_topView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(titleLabel);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
        }];
        
        UILabel *numLabel = [self createLabel];
        numLabel.text = [NSString stringWithFormat:@"单次消耗：¥%@", _timeCarModel.price];
        [_topView addSubview:numLabel];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(titleLabel);
            make.top.equalTo(timeLabel.mas_bottom).offset(5);
        }];

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
    
    [self loadData];
}

/**
 将要隐藏
 */
- (void)viewWillDisappear {}

- (void)loadData {
    NSMutableArray *modelArray = NSMutableArray.new;
    [modelArray addObjectsFromArray:_timeCarModel.pro_list];
    [modelArray addObjectsFromArray:_timeCarModel.goods_list];
    self.tableView.modelArray = modelArray;
    [self.tableView reloadData];
}

- (UILabel *)createLabel {
    UILabel *titleLabel = UILabel.new;
    titleLabel.font = FONT_SIZE(16);
    titleLabel.textColor = kColor3;
    return titleLabel;
}

#pragma mark - Notification

- (void)reloadDataNotification:(NSNotification *)not {
    if (self.view.window) {
        [self.tableView reloadData];
    }
}
@end
