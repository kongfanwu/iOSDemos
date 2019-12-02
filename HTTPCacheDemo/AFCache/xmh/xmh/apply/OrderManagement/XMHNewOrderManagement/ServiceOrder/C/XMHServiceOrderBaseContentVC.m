//
//  XMHServiceOrderBaseContentVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderBaseContentVC.h"
#import "XMHShoppingCartManager.h"

@interface XMHServiceOrderBaseContentVC ()

@end

@implementation XMHServiceOrderBaseContentVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edit = YES;
        // 当购物车移除商品，或修改购物车商品数量。有时UI需要更新。
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartUpdateNotification:) name:kXMHShoppingCartUpdateNotification object:nil];
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
        self.searchView = [[XMHOrderContentSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 53)];
        [self.view addSubview:_searchView];
        
        __weak typeof(self) _self = self;
        // 搜索回调
        [self.searchView setSearchBlock:^(XMHOrderContentSearchView * _Nonnull searchView, NSString * _Nonnull text) {
            __strong typeof(_self) self = _self;
            [self searchText:text];
        }];
        // 结束搜索
        [self.searchView setClearSearchTextBlock:^(XMHOrderContentSearchView * _Nonnull searchView) {
            __strong typeof(_self) self = _self;
            self.isSearch = NO;
            if (self.endSearchBlock) self.endSearchBlock();
        }];
    }
    
    if (!self.serviceLabel) {
        self.serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _searchView.bottom, self.view.width, 30)];
        self.serviceLabel.textColor = kColor3;
        self.serviceLabel.font = FONT_SIZE(17);
//        [self.view addSubview:self.serviceLabel];
        self.serviceLabel.backgroundColor = UIColor.orangeColor;
        self.serviceLabel.text = [self serviceTitle];
    }
}

- (NSString *)serviceTitle {
    NSString *title = @"";
    switch (_type) {
        case XMHServiceOrderTypeChuFang:{
            title = @"处方服务";
            break;
        }
        case XMHServiceOrderTypeProject:{
            title = @"项目服务";
            break;
        }
        case XMHServiceOrderTypeGoods:{
            title = @"产品服务";
            break;
        }
        case XMHServiceOrderTypeTiKaStordeCar:{
            title = @"提卡服务";
            break;
        }
        case XMHServiceOrderTypeTiKaNumCar:{
            title = @"提卡服务";
            break;
        }
        case XMHServiceOrderTypeTiKaTimeCar:{
            title = @"提卡服务";
            break;
        }
        default:
            break;
    }
    return title;
}

- (void)searchText:(NSString *)text {
    [self.view endEditing:YES];
    if (text.length <= 0) {
        return;
    }
    _isSearch = YES;
    //定义谓词
    NSString *searchStr = [NSString stringWithFormat:@"name LIKE '*%@*'", text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchStr];
    self.searchResultArray = [self.searchDataArray filteredArrayUsingPredicate:predicate];
    
    if (self.startSearchBlock) self.startSearchBlock();
}

#pragma mark - Notification

- (void)shoppingCartUpdateNotification:(NSNotification *)not {
    if (self.view) {
        [self.tableView reloadData];        
    }
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
