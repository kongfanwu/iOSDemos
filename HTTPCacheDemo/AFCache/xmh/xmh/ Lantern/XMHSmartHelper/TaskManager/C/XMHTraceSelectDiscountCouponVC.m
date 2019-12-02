//
//  XMHTraceSelectDiscountCouponVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTraceSelectDiscountCouponVC.h"
#import "XMHTraceSelectDiscountCouponSubVC.h"
#import "XMHCouponModel.h"
#import "SPPageMenu.h"
#define pageMenuH 44
#define scrollViewHeight (SCREEN_HEIGHT - Heigh_Nav - pageMenuH - 69- kSafeAreaBottom)
@interface XMHTraceSelectDiscountCouponVC ()<SPPageMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *selectArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;
@property (nonatomic, strong) UIButton * btnSelect;
@property (nonatomic, strong) NSMutableArray * selectCashArr;
@property (nonatomic, strong) NSMutableArray * selectDiscountArr;
@property (nonatomic, strong) NSMutableArray * selectGiftArr;
@property (nonatomic, strong) NSArray * selectCouponIDArr;

@end

@implementation XMHTraceSelectDiscountCouponVC

@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView setNavViewTitle:@"优惠券列表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    NSArray * arr = @[@[],@[],@[]];
    _selectArr = [[NSMutableArray alloc] initWithArray:arr];
    _selectCashArr = [[NSMutableArray alloc] init];
    _selectDiscountArr = [[NSMutableArray alloc] init];
    _selectGiftArr = [[NSMutableArray alloc] init];
    _dataArr = @[@"现金券",@"折扣券",@"礼品券"];
    [self initSubViews];
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Heigh_Nav+pageMenuH, SCREEN_WIDTH, scrollViewHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return  _scrollView;
}
- (NSMutableArray *)myChildViewControllers {
    
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
    }
    return _myChildViewControllers;
}
- (void)initSubViews
{
    WeakSelf
    [self createPageMenu];
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < _dataArr.count; i++) {
        XMHTraceSelectDiscountCouponSubVC * vc = [[XMHTraceSelectDiscountCouponSubVC alloc] init];
        if (_selectCouponIDArr) {
            vc.cellType = XMHTraceDiscountCouponCellTypeEdit;
        }else{
            vc.cellType = XMHTraceDiscountCouponCellTypeLook;
        }
        
        vc.tag = i;
        vc.paramArr = _selectCouponIDArr;
        __weak typeof(self) _self = self;
        vc.XMHTraceSelectDiscountCouponSubVCBlock = ^(NSMutableArray * _Nonnull selectArr, NSInteger tag) {
            __strong typeof(_self) self = _self;
            
            [self.selectArr replaceObjectAtIndex:tag withObject:selectArr];
//            [_selectArr removeObjectsInArray:selectArr];
//            [_selectArr addObjectsFromArray:selectArr];
            
            
//            if (tag == 0) {
//                [_selectCashArr removeAllObjects];
//                [_selectCashArr addObjectsFromArray:selectArr];
//            }else if (tag == 1){
//                [_selectDiscountArr removeAllObjects];
//                [_selectDiscountArr addObjectsFromArray:selectArr];
//            }else if (tag == 2){
//                [_selectGiftArr removeAllObjects];
//                [_selectGiftArr addObjectsFromArray:selectArr];
//            }else{}
//            [weakSelf.selectArr removeObjectsInArray:weakSelf.selectCashArr];
//            [weakSelf.selectArr removeObjectsInArray:weakSelf.selectGiftArr];
//            [weakSelf.selectArr removeObjectsInArray:weakSelf.selectDiscountArr];
//            [weakSelf.selectArr addObjectsFromArray:weakSelf.selectCashArr];
//            [weakSelf.selectArr addObjectsFromArray:weakSelf.selectDiscountArr];
//            [weakSelf.selectArr addObjectsFromArray:weakSelf.selectGiftArr];
            [weakSelf updateBtn];
        };
        [self addChildViewController:vc];
        [self.myChildViewControllers addObject:vc];
    }
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        XMHTraceSelectDiscountCouponSubVC *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0, SCREEN_WIDTH, scrollViewHeight);
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.dataArr.count*SCREEN_WIDTH, 0);
    }
    UIView * commitView = UIView.new;
    [self.view addSubview:commitView];
    commitView.backgroundColor = [UIColor whiteColor];
    [commitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(69 + kSafeAreaBottom);
    }];
    
    UIButton * btn = UIButton.new;
    _btnSelect = btn;
    [btn setTitle:@"选择优惠券" forState:UIControlStateNormal];
    btn.backgroundColor = kColorTheme;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    __weak typeof(self) _self = self;
    [btn bk_addEventHandler:^(UIButton * sender) {
        __strong typeof(_self) self = _self;
        sender.selected = YES;
        if ([sender.currentTitle containsString:@"添加"]) {
            [self mergeDiscountCouponData];
            [self.navigationController popViewControllerAnimated:NO];
        }
        [self updateBtn];
    } forControlEvents:UIControlEventTouchUpInside];
    [commitView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(commitView.mas_right).mas_offset(-15);
        make.left.mas_equalTo(commitView.mas_left).mas_offset(15);
        make.top.mas_equalTo(commitView).mas_offset(15);
        make.height.mas_equalTo(44);
    }];
    
}
- (void)createPageMenu
{
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.selectedItemTitleColor = kColorTheme;
    pageMenu.unSelectedItemTitleColor = kColor6;
    pageMenu.selectedItemTitleFont = FONT_MEDIUM_SIZE(15);
    pageMenu.unSelectedItemTitleFont = FONT_SIZE(15);
    pageMenu.trackerWidth = 25;
    pageMenu.tracker.backgroundColor = kColorTheme;
    pageMenu.dividingLine.hidden = YES;
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.delegate = self;
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}
#pragma mark - SPPageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    //    if (self.myChildViewControllers.count > 0) {
    //      GKGLMemberBenefitsSubVC * subVC = self.myChildViewControllers[toIndex];
    //    }
    if (!self.scrollView.isDragging) { // 判断用户是否在拖拽scrollView
        // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
        if (labs(toIndex - fromIndex) >= 2) {
            [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH* toIndex, 0) animated:NO];
        } else {
            [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:YES];
        }
    }
    
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    XMHTraceSelectDiscountCouponSubVC *targetViewController = self.myChildViewControllers[toIndex];
    targetViewController.tag = toIndex;
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(SCREEN_WIDTH * toIndex, 0, SCREEN_WIDTH, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
}
- (void)updateBtn
{
    if (([_selectArr[0] count]  + [_selectArr[1] count] + [_selectArr[2] count]) == 0 ) {
        _btnSelect.backgroundColor = kColor9;
        _btnSelect.enabled = NO;
    }else{
        _btnSelect.backgroundColor = kColorTheme;
        _btnSelect.enabled = YES;
    }
    
    [_btnSelect setTitle:[NSString stringWithFormat:@"添加/%ld张",[_selectArr[0] count]  + [_selectArr[1] count] + [_selectArr[2] count]] forState:UIControlStateNormal];
    for (int i = 0; i < self.myChildViewControllers.count; i++) {
        XMHTraceSelectDiscountCouponSubVC *targetViewController = self.myChildViewControllers[i];
        targetViewController.cellType = XMHTraceDiscountCouponCellTypeEdit;
    }
}
- (void)mergeDiscountCouponData
{
    NSMutableArray * discountCouponArr = [[NSMutableArray alloc] init];
    [_selectArr[0] enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [discountCouponArr addObject:model];
    }];
    [_selectArr[1] enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [discountCouponArr addObject:model];
    }];
    [_selectArr[2] enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [discountCouponArr addObject:model];
    }];
    
//    NSMutableArray *array = NSMutableArray.new;
    NSMutableArray *ids = NSMutableArray.new;
    [discountCouponArr enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
//        [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:model.uid displayText:model.name]];
        [ids addObject:model.uid];
    }];
    self.rowDescriptor.value = ids;
    self.rowDescriptor.action.nextParams = @{@"couponList" : ids};
}

#pragma mark - XMHFormTaskNextVCProtocol

/**
 配置参数
 */
- (void)configParams:(NSDictionary *)params {
    NSArray *couponList = params[@"couponList"];
    _selectCouponIDArr = couponList;
//    for (int i = 0; i < self.myChildViewControllers.count; i++) {
//        XMHTraceSelectDiscountCouponSubVC *targetViewController = self.myChildViewControllers[i];
//        targetViewController.cellType = XMHTraceDiscountCouponCellTypeEdit;
//        targetViewController.paramArr = couponList;
//    }
//    NSLog(@"%@", couponList);
    
}
@end
