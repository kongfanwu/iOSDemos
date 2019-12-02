//
//  XMHServiceOrderChuFangContentVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderChuFangContentVC.h"
#import "XMHServiceOrderCell.h"
#import "XMHShoppingCartManager.h"
#import "UITableView+XMHEmptyData.h"
@interface XMHServiceOrderChuFangContentVC () <UITableViewDelegate, UITableViewDataSource>
/** <##> */
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation XMHServiceOrderChuFangContentVC

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
        self.dataArray = self.modelArray;
        [self.tableView reloadData];
    }];
    
    [self setStartSearchBlock:^{
        __strong typeof(_self) self = _self;
        self.dataArray = self.searchResultArray;
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

    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, self.view.width, self.view.height - self.searchView.height - self.serviceLabel.height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [self.view addSubview:self.tableView];

        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    self.dataArray = _modelArray;
    [self.tableView reloadData];
}

/**
 将要隐藏
 */
- (void)viewWillDisappear {}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    [tableView tableViewDisplayWithMsg:@"" ifNecessaryForRowCount:_dataArray.count];
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        return 1;
    }
    XMHServiceChuFangModel *chuFangModel = _dataArray[section];
    return chuFangModel.pro_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHServiceProjectModel *model;
    if (self.isSearch) {
        model = _dataArray[indexPath.section];
    } else {
        XMHServiceChuFangModel *chuFangModel = _dataArray[indexPath.section];
        model = chuFangModel.pro_list[indexPath.row];
    }
    
    XMHServiceOrderCell *cell = [XMHServiceOrderCell createCellWithTable:tableView];
    cell.indexPath = indexPath;
    [cell configureWithModel:model];
    // 点击处方服务，处方服务下的选择数量+1
    [cell setDidChangeBlock:^(XMHNumberView * _Nonnull numberView) {
//        if (serviceProjectModel.type == XMHServiceOrderTypeChuFang || serviceProjectModel.type == XMHServiceOrderTypeProject || serviceProjectModel.type == XMHServiceOrderTypeGoods) {
//            // 使用次数不能大于剩余次数
//            if (numberView.currentNumber > serviceProjectModel.num) {
//                [MzzHud toastWithTitle:@"提示" message:@"购买次数不能大于剩余次数"];
//                numberView.currentNumber = serviceProjectModel.selectCount;
//                return;
//            }
//        }
//        serviceProjectModel.selectCount = numberView.currentNumber;
//        [tableView reloadData];
//
//        // 选择数量为0，从购物车中移除
//        if (serviceProjectModel.selectCount == 0) {
//            [XMHShoppingCartManager.sharedInstance deleteModel:serviceProjectModel];
//        } else {
//            [XMHShoppingCartManager.sharedInstance addModel:serviceProjectModel];
//        }
        
        if (numberView.currentNumber > model.num) {
            [XMHProgressHUD showOnlyText:@"库存不足"];
            --numberView.currentNumber;
            return;
        }
        
        // model 记录购买数量
        if ([model respondsToSelector:@selector(setSelectCount:)]) {
            [model setSelectCount:numberView.currentNumber];
        }
       
    }];
    
    [cell setDidAddToShopCartBlock:^{
        // 选择数量为0，从购物车中移除
        if (model.selectCount == 0) {
            [XMHShoppingCartManager.sharedInstance deleteModel:model];
        } else {
            [XMHShoppingCartManager.sharedInstance addModel:model];
        }
        
        // 使用次数不能大于剩余次数
//        if (model.type == XMHServiceOrderTypeChuFang || model.type == XMHServiceOrderTypeProject || model.type == XMHServiceOrderTypeGoods) {
//            // 最大购买数
//            NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:model];
//            // 限制最大购买
//            if (model.selectCount > maxNum) {
//                [XMHProgressHUD showOnlyText:@"库存不足"];
//                return;
//            }
//        }
//
//        [XMHShoppingCartManager.sharedInstance addModel:model];
    }];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        return CGFLOAT_MIN;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        return UIView.new;
    }
    
    XMHServiceChuFangModel *chuFangModel = _dataArray[section];
    
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = UIColor.whiteColor;
    
    UIButton *trueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [trueButton setTitle:chuFangModel.name forState:UIControlStateNormal];
    [trueButton setTitleColor:kColor3 forState:UIControlStateNormal];
    trueButton.titleLabel.font = FONT_SIZE(16);
    [trueButton setImage:UIImageName(@"duoxuan-weixuanze") forState:UIControlStateNormal];
    [trueButton setImage:UIImageName(@"duoxuan-yixuanze") forState:UIControlStateSelected];
    [trueButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    trueButton.tag = section;
    [headerView addSubview:trueButton];
    [trueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView);
        make.top.equalTo(headerView).offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(25);
    }];
    trueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [trueButton setTitleEdgeInsets:UIEdgeInsetsMake(0, trueButton.imageView.frame.size.width-10, 0.0,0.0)];
    trueButton.selected = chuFangModel.selectType;
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(15);
        make.right.bottom.equalTo(headerView);
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return UIView.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Event
- (void)selectEvent:(UIButton *)sender {
    // 点击勾选后，处方内包含的所有商品都加1
    XMHServiceChuFangModel *chuFangModel = _dataArray[sender.tag];
    chuFangModel.selectType = !chuFangModel.selectType;
    for (XMHServiceProjectModel *serviceProjectModel in chuFangModel.pro_list) {
        if (chuFangModel.selectType) {
            // 使用次数不能大于剩余次数
            if (serviceProjectModel.selectCount > serviceProjectModel.num) {
                continue;
            }

            [XMHShoppingCartManager.sharedInstance addModel:serviceProjectModel];
        } else {
            NSString *modelId = [NSString stringWithFormat:@"%@%@", serviceProjectModel.ID, serviceProjectModel.code];
            // 遍历购物车中是否有此section 下的model 有就移除。
            NSMutableArray *deleteArray = NSMutableArray.new;
            NSArray *shoppingArray = XMHShoppingCartManager.sharedInstance.dataArray;
            for (id model in shoppingArray) {
                if ([model isKindOfClass:[XMHServiceProjectModel class]]) {
                    XMHServiceProjectModel *shoppingModel = (XMHServiceProjectModel *)model;
                    NSString *shoppingId = [NSString stringWithFormat:@"%@%@", shoppingModel.ID, shoppingModel.code];
                    if ([modelId isEqualToString:shoppingId]) {
                        [deleteArray addObject:shoppingModel];
                    }
                }
            }
            
            for (id model in deleteArray) {
                [XMHShoppingCartManager.sharedInstance deleteModel:model];
            }
        }
    }
    
    
//    for (XMHServiceProjectModel *serviceProjectModel in chuFangModel.pro_list) {
//        if (chuFangModel.selectType) {
//            // 使用次数不能大于剩余次数
//            if (serviceProjectModel.selectCount >= serviceProjectModel.num) {
//                continue;
//            }
//            serviceProjectModel.selectCount++;
//        } else {
//            serviceProjectModel.selectCount--;
//        }
//
//        // 选择数量为0，从购物车中移除
//        if (serviceProjectModel.selectCount == 0) {
//            [XMHShoppingCartManager.sharedInstance deleteModel:serviceProjectModel];
//        } else {
//            [XMHShoppingCartManager.sharedInstance addModel:serviceProjectModel];
//        }
//    }
    [self.tableView reloadData];
}

#pragma mark - Notification

- (void)reloadDataNotification:(NSNotification *)not {
    if (self.view.window) {
        [self.tableView reloadData];
    }
}

@end
