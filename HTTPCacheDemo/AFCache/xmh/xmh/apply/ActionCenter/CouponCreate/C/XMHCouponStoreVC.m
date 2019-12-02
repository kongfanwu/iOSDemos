//
//  XMHCouponStoreVC.m
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponStoreVC.h"
#import "XMHOrderContentSearchView.h"
#import "XMHCouponStoreCell.h"
#import "XMHCouponRequest.h"

@interface XMHCouponStoreVC () <UITableViewDelegate, UITableViewDataSource>

/** <##> */
@property (nonatomic, strong) UIView *topBgView;
/** <##> */
@property (nonatomic, strong) XMHOrderContentSearchView *searchView;
/** <##> */
@property (nonatomic, strong) UIButton *selectButton;
/** <##> */
@property (nonatomic, strong) XMHBaseTableView *tableView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** <##> */
@property (nonatomic, copy) NSString *keyword;
/** <##> */
@property (nonatomic) BOOL isSearch;
@end

@implementation XMHCouponStoreVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _edit = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadTopView];
    
    self.tableView = [[XMHBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topBgView.mas_bottom);
        make.bottom.mas_equalTo(-kSafeAreaBottom);
    }];
    
    [self getData];
}

/* 获取门店列表数据 */
+ (void)getDataComplete:(void(^)(NSArray <XMHCouponStoreModel *> *dataArray))complete {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    [XMHCouponRequest requestStoresParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        NSMutableArray *dataArray = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[XMHCouponStoreModel class] json:model.data[@"list"]];
        if (complete) complete(dataArray);
    }];
}

- (void)getData {
    [self.view endEditing:YES];
    
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"keyword"] = _keyword;
    [XMHCouponRequest requestStoresParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        self.dataArray = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[XMHCouponStoreModel class] json:model.data[@"list"]];
        
        if (self.isSearch || _selectArray.count) {
            if (_dataArrayAll) {
                for (XMHCouponStoreModel *acouponStoreModel in self.dataArray) {
                    acouponStoreModel.isSelect = YES;
                }
            } else {
                // 搜索完，将上次选中的标识选中状态
                for (XMHCouponStoreModel *couponStoreModel in _selectArray) {
                    for (XMHCouponStoreModel *acouponStoreModel in self.dataArray) {
                        if ([couponStoreModel.code isEqualToString:acouponStoreModel.code]) {
                            acouponStoreModel.isSelect = YES;
                        }
                    }
                }
            }
        } else {
            if (_dataArrayAll) {
                for (XMHCouponStoreModel *acouponStoreModel in self.dataArray) {
                    acouponStoreModel.isSelect = YES;
                }
            } else {
                NSMutableArray *newSelectArray = NSMutableArray.new;
                // 设置默认选中项
                for (XMHCouponStoreModel *couponStoreModel in _selectArray) {
                    for (XMHCouponStoreModel *acouponStoreModel in self.dataArray) {
                        if ([couponStoreModel.code isEqualToString:acouponStoreModel.code]) {
                            acouponStoreModel.isSelect = YES;
                            [newSelectArray addObject:acouponStoreModel];
                        }
                    }
                }
                if (!self.edit) {
                    // 查看状态，只显示已选中的
                    self.dataArray = newSelectArray;
                }
            }
        }
        
        [self changeSelectAllButtonState];
        [_tableView reloadData];
    }];
}

- (void)loadTopView {
    UIView *topBgView = UIView.new;
    self.topBgView = topBgView;
    [self.view addSubview:topBgView];
    
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(kSafeAreaTop);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = FONT_SIZE(15);
    [topBgView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(0);
    }];
    __weak typeof(self) _self = self;
    [cancelBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    sureBtn.titleLabel.font = FONT_SIZE(15);
    [topBgView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(0);
    }];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kSeparatorColor;
    [topBgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(cancelBtn.mas_bottom);
    }];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    searchBtn.titleLabel.font = FONT_SIZE(15);
    [topBgView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 53));
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(lineView.mas_bottom);
    }];
    [searchBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self startSearchData];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.searchView = [[XMHOrderContentSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 44 - 15 - 5, 53)];
    
    self.searchView.textField.placeholder = @"请输入门店名称";
    self.searchView.textField.layer.cornerRadius = 3;
    self.searchView.textField.backgroundColor = RGBColor(245, 245, 245);
    [topBgView addSubview:_searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(searchBtn.mas_left);
        make.height.mas_equalTo(53);
    }];
    // 搜索回调
    [_searchView setSearchBlock:^(XMHOrderContentSearchView * _Nonnull searchView, NSString * _Nonnull text) {
        __strong typeof(_self) self = _self;
        self.keyword = text;
        [self startSearchData];
    }];
    // 结束搜索
    [_searchView setClearSearchTextBlock:^(XMHOrderContentSearchView * _Nonnull searchView) {
        __strong typeof(_self) self = _self;
        self.isSearch = NO;
        self.keyword = nil;
        [self getData];
        
        self.selectButton.hidden = NO;
        [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 25));
            make.left.mas_equalTo(15);
            make.top.equalTo(self.searchView.mas_bottom).offset(5);
        }];
//
        [topBgView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.selectButton.mas_bottom).offset(25);
            make.height.mas_equalTo(133);
        }];
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.topBgView.mas_bottom);
            make.bottom.mas_equalTo(-kSafeAreaBottom);
        }];
    }];
    
    [_searchView setChangeSearchTextBlock:^(XMHOrderContentSearchView * _Nonnull searchView) {
        __strong typeof(_self) self = _self;
        self.isSearch = YES;
        self.keyword = searchView.textField.text;
    }];
    
    [_searchView.textField setBk_didBeginEditingBlock:^(UITextField *tf) {
        __strong typeof(_self) self = _self;
        self.isSearch = YES;
    }];
   
    
    UIButton *falseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectButton = falseButton;
    [falseButton setTitle:@"全部门店" forState:UIControlStateNormal];
    [falseButton setTitleColor:kColor3 forState:UIControlStateNormal];
    falseButton.titleLabel.font = FONT_SIZE(13);
    [falseButton setImage:UIImageName(@"coupon_weixuan") forState:UIControlStateNormal];
    [falseButton setImage:UIImageName(@"coupon_xuanzhong") forState:UIControlStateSelected];
    [falseButton addTarget:self action:@selector(selectStoreEvent:) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:falseButton];
    [falseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 25));
        make.left.mas_equalTo(15);
        make.top.equalTo(_searchView.mas_bottom).offset(5);
    }];
    falseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [falseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, falseButton.imageView.frame.size.width - 5, 0.0,0.0)];
    
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(falseButton.mas_bottom).offset(25);
        make.height.mas_equalTo(133);
    }];
    
    if (!_edit) {
        [topBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lineView.mas_bottom);
        }];
        
        self.selectButton.hidden = YES;
        _searchView.hidden = YES;
        searchBtn.hidden = YES;
        sureBtn.hidden = YES;
        
        [cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(0);
        }];
    }
}

- (void)startSearchData {
    [self getData];
    
    self.selectButton.hidden = YES;
    [self.topBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.bottom.equalTo(self.searchView.mas_bottom).offset(25);
        make.height.mas_equalTo(103);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topBgView.mas_bottom);
        make.bottom.mas_equalTo(-kSafeAreaBottom);
    }];
}

- (void)sureBtnClick:(UIButton *)sender {
    
    NSMutableArray *selectList = [self getSelectStoreArray];
    // hidden状态为搜索状态，搜索状态没有全之功能，所以 NO
    BOOL isAll = self.selectButton.hidden ? NO : self.selectButton.selected;
    if (self.selectBlock) self.selectBlock(selectList,  isAll);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectStoreEvent:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (XMHCouponStoreModel *storeModel in _dataArray) {
        storeModel.isSelect = sender.selected;
    }
    [_tableView reloadData];
    
    if (sender.selected) {
        self.dataArrayAll = YES;
        [_selectArray removeAllObjects];
        _selectArray = [_dataArray mutableCopy];
    } else {
        self.dataArrayAll = NO;
        [_selectArray removeAllObjects];
    }
}

/**
 处理按钮全选/非全选情况。 设置全选按钮状态
 */
- (void)changeSelectAllButtonState {
    BOOL isSelectAll = YES;
    for (XMHCouponStoreModel *storeModel in _dataArray) {
        if (!storeModel.isSelect) {
            isSelectAll = NO;
            break;
        }
    }
    self.selectButton.selected = isSelectAll;
}

- (NSMutableArray <XMHCouponStoreModel *>*)getSelectStoreArray {
    NSMutableArray *selectList = NSMutableArray.new;
    for (XMHCouponStoreModel *storeModel in _selectArray) {
        [selectList addObject:storeModel];
    }
    return selectList;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCouponStoreCell *cell = [XMHCouponStoreCell createCellWithTable:tableView];
    cell.edit = _edit;
    [cell configureWithModel:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_edit) return;
    
    XMHCouponStoreModel *storeModel = _dataArray[indexPath.row];
    storeModel.isSelect = !storeModel.isSelect;
    [tableView reloadData];
    
    [self changeSelectAllButtonState];
    
    if (storeModel.isSelect) {
        [self lastSelectListAddModel:storeModel];
    } else {
        [self lastSelectListDeleteModel:storeModel];
    }
}

/**
 存储model
 */
- (void)lastSelectListAddModel:(XMHCouponStoreModel *)storeModel {
    BOOL isYES = YES;
    for (XMHCouponStoreModel *model in _selectArray) {
        if ([model.code isEqualToString:storeModel.code]) {
            isYES = NO;
            break;
        }
    }
    if (isYES) {
        [self.selectArray addObject:storeModel];
    }
}

/**
 删除model
 */
- (void)lastSelectListDeleteModel:(XMHCouponStoreModel *)storeModel {
    XMHCouponStoreModel *delModel;
    for (XMHCouponStoreModel *model in _selectArray) {
        if ([model.code isEqualToString:storeModel.code]) {
            delModel = model;
            break;
        }
    }
    if (delModel) {
        [self.selectArray removeObject:delModel];
        
        // 只要有一次删除操作，就取消掉全选
        if (self.dataArrayAll) {
            self.dataArrayAll = NO;
        }
    }
}




@end
