//
//  XMHServiceOrderNumCarContentVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderNumCarContentVC.h"
#import "XMHServiceOrderProjectGoodTableView.h"
#import "XMHShoppingCartManager.h"
#import "XMHServiceProjectModel.h"
#import "XMHServiceGoodsModel.h"

@interface XMHServiceOrderNumCarContentVC ()
/** <##> */
@property (nonatomic, strong) XMHServiceOrderProjectGoodTableView *tableView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** <##> */
@property (nonatomic, strong) UIView *topView;
/** <##> */
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation XMHServiceOrderNumCarContentVC

@synthesize tableView = _tableView;

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
        
        UILabel *titleLabel = UILabel.new;
        titleLabel.font = FONT_SIZE(16);
        titleLabel.textColor = kColor3;
        titleLabel.text = _numCarModel.name;
        [_topView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(_topView);
        }];
        
        UILabel *numLabel = UILabel.new;
        self.numLabel = numLabel;
        numLabel.font = FONT_SIZE(16);
        numLabel.textColor = kColor3;
        numLabel.text = [NSString stringWithFormat:@"余%@次", @(_numCarModel.numUpdate).stringValue];
        [_topView addSubview:numLabel];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(_topView);
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
        __weak typeof(self) _self = self;
        [self.tableView setShoppingCartAddModelBlcok:^BOOL(XMHServiceProjectModel * _Nonnull model) {
            __strong typeof(_self) self = _self;
            // 0库存，不允许添加购物车
            if (self.numCarModel.numUpdate == 0) {
                return NO;
            }
            self.numCarModel.numUpdate = self.numCarModel.numUpdate - 1;
            self.numLabel.text = [NSString stringWithFormat:@"余%@次", @(self.numCarModel.numUpdate).stringValue];
            return YES;
        }];
    }
    
    [self loadData];
}

/**
 将要隐藏
 */
- (void)viewWillDisappear {}

- (void)loadData {
    NSMutableArray *modelArray = NSMutableArray.new;
    [modelArray addObjectsFromArray:_numCarModel.pro_list];
    [modelArray addObjectsFromArray:_numCarModel.goods_list];
    self.tableView.modelArray = modelArray;
    [self.tableView reloadData];
}


#pragma mark - Notification

- (void)shoppingCartUpdateNotification:(NSNotification *)not {
    [super shoppingCartUpdateNotification:not];
    
    // 任选卡总数量 - 已经购买数量
//    _numCarModel.numUpdate = _numCarModel.num - shoppingCount;
//    self.numLabel.text = [NSString stringWithFormat:@"余%@次", @(self.numCarModel.numUpdate).stringValue];
//    return;
    /**
     任选卡里项目，添加/移除到购物车，改变任选卡项目总数
     */
    NSArray *dataArray = not.userInfo[@"data"];
    // 购物车购买此任选卡的数量
    NSInteger shoppingCount = 0;
    
    for (id model in dataArray) {
        // 任选卡类型项目
        if ([model isKindOfClass:[XMHServiceProjectModel class]] || [model isKindOfClass:[XMHServiceGoodsModel class]]) {
            XMHServiceProjectModel *aModel = (XMHServiceProjectModel *)model;
            // 拼接唯一id
            NSString *numCarId = [NSString stringWithFormat:@"%@%@", aModel.ID, aModel.code];
            
            // 拼接任选卡下产品 + 项目列表
            NSMutableArray *goodsArray = NSMutableArray.new;
            [goodsArray addObjectsFromArray:_numCarModel.pro_list];
            [goodsArray addObjectsFromArray:_numCarModel.goods_list];
            for (XMHServiceProjectModel *proModel in goodsArray) {
                NSString *proCarId = [NSString stringWithFormat:@"%@%@", proModel.ID, proModel.code];
                // 寻找购物车中添加此任选卡的商品
                if ([numCarId isEqualToString:proCarId]) {
                    // 计算此任选卡购买的数量
                    shoppingCount = shoppingCount + aModel.selectCount;
                    // 将购物车购买数量selectCount赋值给列表相同model selectCount。需求： 购物车更新selectCount数量，列表也要更新。
                    proModel.selectCount = aModel.selectCount;
                }
            }
        }
    }
    
    // 任选卡总数量 - 已经购买数量
    _numCarModel.numUpdate = _numCarModel.num - shoppingCount;
    self.numLabel.text = [NSString stringWithFormat:@"余%@次", @(self.numCarModel.numUpdate).stringValue];
    
    if (self.view) {
        [self.tableView reloadData];
    }
}

@end
