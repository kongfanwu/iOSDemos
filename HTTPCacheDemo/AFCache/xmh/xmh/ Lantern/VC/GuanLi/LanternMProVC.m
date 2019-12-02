//
//  LanternMProVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMProVC.h"
#import "JasonSearchView.h"
#import "LanternMProCell.h"
#import "LanternMProHeaderView.h"
#import "LanternRequest.h"
#import "LanternMSearchVC.h"
#import "LanternMResultVC.h"
#define kCellMain @"cellMain"

@interface LanternMProVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSArray * nameSource;
@property (nonatomic, strong)NSArray * keySource;
@property (nonatomic, strong)NSMutableArray * showSections;
@property (nonatomic, strong)UICollectionViewFlowLayout * flowLayout;
@property (nonatomic, assign)NSInteger selectIndex;
@property (nonatomic, assign)NSInteger selectSection;
@property (nonatomic, assign)BOOL isFromHistory;
/** 选中的一项 */
@property (nonatomic, strong)NSMutableDictionary * selectParam;
@end

@implementation LanternMProVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [ShareWorkInstance shareInstance].showW = 20;
    _dataSource = [[NSMutableArray alloc] init];
    _showSections = [[NSMutableArray alloc] init];
    _nameSource = @[@"销售业绩占比",@"成交人数占比",@"试做人数占比",@"普及率",@"复购率"];
    _keySource = @[@"xiaoshou",@"chengjiao",@"shizuo",@"pujilv",@"fugoulv"];
    _isFromHistory = NO;
    [self initSubViews];
    [self requestProData];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Search" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reset" object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchTapNotice:) name:@"Search" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reset:) name:@"reset" object:nil];
     MzzLog(@"page............LanternMProVC");
   
}
- (void)setSearchID:(NSString *)searchID
{
    _searchID = searchID;
    _isFromHistory = YES;
    [self requestProData];
}
- (void)reset:(NSNotification *)not
{
    if ([not.object integerValue]== 2){
        [[[MzzHud alloc] initWithTitle:@"" message:@"是否清空选择内容" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
            if (index == 1) {
//                dispatch_async(dispatch_get_main_queue(), ^{
                    [self requestProData];
//                });
            }
        }]show];
    }
}
- (void)searchTapNotice:(NSNotification *)not
{
    if ([not.object integerValue] ==2) {
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < _keySource.count; i ++) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            NSMutableArray * customArr = [[NSMutableArray alloc] init];
            NSMutableArray * sysArr = [[NSMutableArray alloc] init];
            NSArray * tempArr = _dataSource[i][@"list"];
            for (int j = 0; j< tempArr.count; j++) {
                NSMutableDictionary * tempDic = tempArr[j];
                if ([tempDic[@"select"] boolValue]) {
                    if ([tempDic.allKeys containsObject:@"custom"]) {
                        [customArr addObject:tempDic[@"name"]];
                    }else{
                        [sysArr addObject:@(j + 1)];
                    }
                }
            }
            [dict setValue:customArr forKey:@"custom"];
            [dict setValue:sysArr forKey:@"sys"];
            [param setValue:dict forKey:_keySource[i]];
        }
        LanternMResultVC * resultVC = [[LanternMResultVC alloc] init];
        resultVC.search_where = param.jsonData;
        resultVC.searchDataSource = _dataSource;
        resultVC.searchType = LanternSearchTypePro;
        [self.navigationController pushViewController:resultVC animated:NO];
    }
}
- (void)initSubViews
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.mainCollectionView];
    
}
- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 10 * 2, 65);
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, 12, _topView.width - 15 - 55, _topView.height - 12 * 2) withPlaceholder:@"请输入项目名称"];
        search.layer.cornerRadius = 3;
        search.layer.masksToBounds = YES;
        search.searchBar.frame = search.bounds;
        [_topView addSubview:search];
        search.userInteractionEnabled = NO;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.frame = CGRectMake(search.right, 0, 55, _topView.height);
        btn.userInteractionEnabled = NO;
        [_topView addSubview:btn];
        _topView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTap:)];
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.height - 1, _topView.width, 1)];
        line.backgroundColor = kColorE;
        [_topView addGestureRecognizer:tap];
        [_topView addSubview:line];
    }
    return _topView;
}
- (void)searchTap:(UITapGestureRecognizer *)tap
{
    LanternMSearchVC * nextVC = [[LanternMSearchVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:NO];
}
- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20 - 15 *5) / 4, 30);
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.minimumLineSpacing = 10;
//        layout.minimumInteritemSpacing = 10;
        _flowLayout = layout;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,_topView.bottom , SCREEN_WIDTH - 20 , SCREEN_HEIGHT - 150 - 70 - 65) collectionViewLayout:layout];
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        _mainCollectionView.scrollEnabled = YES;
        _mainCollectionView.bounces = NO;
        
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerNib:[UINib nibWithNibName:@"LanternMProCell" bundle:nil] forCellWithReuseIdentifier:@"LanternMProCell"];
        [_mainCollectionView registerNib:[UINib nibWithNibName:@"LanternMProHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    }
    return _mainCollectionView;
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    WeakSelf
    if (kind == UICollectionElementKindSectionHeader) {
        LanternMProHeaderView *headerView = (LanternMProHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.LanternMProHeaderViewClickBlock = ^(NSMutableDictionary * _Nonnull param) {
            if ([weakSelf.dataSource containsObject:param]) {
                [weakSelf.dataSource replaceObjectAtIndex:[weakSelf.dataSource indexOfObject:param] withObject:param];
            }
            for (int i = 0; i < weakSelf.dataSource.count; i++) {
                NSInteger index = [weakSelf.dataSource indexOfObject:param];
                if (i != index) {
                    weakSelf.dataSource[i][@"selected"] = @"0";
                }
            }
            [weakSelf.mainCollectionView reloadData];
        };
        
        [headerView updateViewParam:weakSelf.dataSource[indexPath.section]];
        reusableView = headerView;
    }
    
    return reusableView;
}
#pragma mark - UICollectionViewDelegateFlowLayout
// 设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(SCREEN_WIDTH - 20, 50);
    return size;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LanternMProCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanternMProCell" forIndexPath:indexPath];
    NSMutableArray * tempArr = _dataSource[indexPath.section][@"list"];
    if (indexPath.row == tempArr.count - 1) {
        [cell updateCellParam:_dataSource[indexPath.section][@"list"][indexPath.row] islast:YES];
    }else{
       [cell updateCellParam:_dataSource[indexPath.section][@"list"][indexPath.row] islast:NO];
    }
    cell.LanternMProCellBlock = ^(NSMutableDictionary * _Nonnull param) {
        [tempArr replaceObjectAtIndex:indexPath.row withObject:param];
        NSMutableArray * tempArr = _dataSource[indexPath.section][@"list"];
        for (int i = 0; i < tempArr.count; i++) {
            if (i != [tempArr indexOfObject:param]) {
                NSMutableDictionary * tempDic = tempArr[i];
                tempDic[@"select"] = @(NO);
            }
            
        }
        [_mainCollectionView performBatchUpdates:^{
            [_mainCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        } completion:nil];
    };
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([_dataSource[section][@"selected"] boolValue]) {
        NSArray * tempArr = _dataSource[section][@"list"];
        return tempArr.count;
    }else{
        return 0;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"list"][indexPath.row];
    if ([currentDic isEqual:_selectParam]) {
        if ([currentDic[@"select"] boolValue]) {
            currentDic[@"select"] = @(NO);
        }else{
            currentDic[@"select"] = @(YES);
        }
    }else{
        _selectParam[@"select"] = @(NO);
        currentDic[@"select"] = @(YES);
        _selectParam = currentDic;
    }
    [_mainCollectionView performBatchUpdates:^{
        [_mainCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    } completion:nil];
}
/** 获取检索条件 */
- (void)requestProData
{
    [_dataSource removeAllObjects];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (_searchID.length > 0) {
        [param setValue:_searchID?_searchID:@"" forKey:@"id"];
    }else{
        [param setValue:@"default" forKey:@"id"];
    }
    [param setValue:@"3" forKey:@"type"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_SEARCHRESULT_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            for (NSString * key in resultDic.allKeys) {
                [_dataSource addObjectsFromArray:resultDic[key]];
            }
            for (int i = 0; i< _nameSource.count; i++) {
                _dataSource[i][@"name"] = _nameSource[i];
            }
            /** 默认第一个展开 */
            if (_isFromHistory) {
                [_dataSource[0]setValue:@"0" forKey:@"selected"];
            }else{
                [_dataSource[0]setValue:@"1" forKey:@"selected"];
            }
            
            [_mainCollectionView reloadData];
        }else{}
    }];
}

@end
