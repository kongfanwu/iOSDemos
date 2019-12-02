//
//  LanternSmartSearchVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternSmartSearchVC.h"
#import "LanternMTopView.h"
#import "LanternMCollectionCell.h"
#import "LanternMBottomView.h"
#import "LanternMResultVC.h"
#import "LanternMProVC.h"
#import "LanternMYuanGongVC.h"
#import "LanternMGuKeVC.h"
#define kCellMain @"cellMain"
@interface LanternSmartSearchVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, strong) NSArray *controllersClass;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
/** 四个标签 */
@property (nonatomic, strong) LanternMTopView * topView;
@property (nonatomic, strong) LanternMBottomView * bottomView;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic,assign) int lastPositionX;
@property (nonatomic,assign) BOOL scrollToRight;
@end

@implementation LanternSmartSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollIndex:) name:@"scroll" object:nil];
    _scrollToRight = YES;
    _lastPositionX = 0;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kColorE;
    [self initSubViews];
}
- (void)scrollIndex:(NSNotification *)not
{
    NSMutableDictionary * dict = (NSMutableDictionary *)not.object;
    NSInteger index = [dict[@"tag"]integerValue];
    [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (index == 0) {
        LanternMYuanGongVC * vc = (LanternMYuanGongVC *)_controllers[index];
        vc.searchID = [NSString stringWithFormat:@"%@",dict[@"id"]];
    }else if (index == 1){
        LanternMGuKeVC * vc = (LanternMGuKeVC *)_controllers[index];
        vc.searchID = [NSString stringWithFormat:@"%@",dict[@"id"]];
    }else if (index == 2){
        LanternMProVC * vc = (LanternMProVC *)_controllers[index];
        vc.searchID = [NSString stringWithFormat:@"%@",dict[@"id"]];
    }else{}
    _selectIndex = index;
    [self showBottomViewByIndex:index];
    [_topView updateLanternMTopViewIndex:index];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"智能检索" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
}
- (NSMutableArray *)controllers{
    if (!_controllers) {
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < _controllersClass.count; i ++) {
            Class className = _controllersClass[i];
            UIViewController *vc = [[className alloc] init];
            [self addChildViewController:vc];
            [controllers addObject:vc];
        }
        _controllers = controllers;
    }
    return _controllers;
}
- (instancetype)initWithControllersClass:(NSArray *)controllersClass
{
    if (self == [super init]) {
        self.controllersClass = controllersClass;
        [self.view addSubview:self.topView];
        [self.view addSubview:self.mainCollectionView];
        [self.view bringSubviewToFront:self.mainCollectionView];
        [self.view addSubview:self.bottomView];
    }
    return self;
}
- (LanternMTopView *)topView
{
    WeakSelf
    if (!_topView) {
        _topView = loadNibName(@"LanternMTopView");
        _topView.frame = CGRectMake(10, Heigh_Nav + 10, SCREEN_WIDTH - 20, 85);
        [_topView updateLanternMTopViewIndex:0];
        _topView.LanternMTopViewBlock = ^(NSInteger index) {
            [weakSelf showBottomViewByIndex:index];
            weakSelf.bottomView.index = index;
            weakSelf.selectIndex = index;
            [weakSelf.mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            [weakSelf.mainCollectionView reloadData];
        };
    }
    return _topView;
}
- (LanternMBottomView *)bottomView
{
    WeakSelf
    if (!_bottomView) {
        _bottomView = loadNibName(@"LanternMBottomView");
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
        _bottomView.LanternMBottomViewSearchBlock = ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"Search" object:@(weakSelf.selectIndex)];
//            });
        };
        _bottomView.LanternMBottomViewResetBlock = ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reset" object:@(weakSelf.selectIndex)];
        };
    }
    return _bottomView;
}
- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10,_topView.bottom + 10 , SCREEN_WIDTH - 20 , SCREEN_HEIGHT - 10 - _topView.bottom) collectionViewLayout:layout];
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        _mainCollectionView.pagingEnabled = YES;
        _mainCollectionView.scrollEnabled = YES;
        _mainCollectionView.bounces = NO;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerClass:[LanternMCollectionCell class] forCellWithReuseIdentifier:kCellMain];
        _mainCollectionView.layer.cornerRadius = 5;
        _mainCollectionView.layer.masksToBounds = YES;
    }
    return _mainCollectionView;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LanternMCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellMain forIndexPath:indexPath];
    [cell setIndexController:self.controllers[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.controllers.count;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x ;
    int index = (x + (SCREEN_WIDTH) * 0.5) / (SCREEN_WIDTH);
    [_topView updateLanternMTopViewIndex:index];
    [self showBottomViewByIndex:index];
}
- (void)showBottomViewByIndex:(NSInteger)index
{
    if (index == 3) {
        _bottomView.hidden = YES;
    }else{
        _bottomView.hidden = NO;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.x;
    if (currentPostion - _lastPositionX > 5) {
        _scrollToRight = YES;
    }else if(currentPostion - _lastPositionX < -5){
        _scrollToRight = NO;
    }
    _lastPositionX = currentPostion;
}

- (void)updateLanternSmartSearchVCIndex:(NSInteger)index searchID:(NSString *)searchID {}
@end
