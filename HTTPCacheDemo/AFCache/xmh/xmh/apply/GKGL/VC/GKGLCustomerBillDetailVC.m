//
//  GKGLCustomerBillDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillDetailVC.h"
#import "SPPageMenu.h"
#import "GKGLCustomerBillDetailSubVC.h"
#define pageMenuH 44
#define scrollViewHeight (SCREEN_HEIGHT - Heigh_Nav - pageMenuH)
@interface GKGLCustomerBillDetailVC ()<SPPageMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;
@end

@implementation GKGLCustomerBillDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    [self.navView setNavViewTitle:@"顾客订单" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    _dataArr = @[@"销售订单",@"服务订单"];
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
        GKGLCustomerBillDetailSubVC * vc = [[GKGLCustomerBillDetailSubVC alloc] init];
        vc.userid = _userid;
        [self addChildViewController:vc];
        vc.tag = i;
        vc.GKGLCustomerBillDetailSubVCBlock = ^(NSString * _Nonnull count) {
            if (vc.tag == 0) {
                [weakSelf.pageMenu setTitle:[NSString stringWithFormat:@"销售订单（%@）",count] forItemAtIndex:0];
            }
            if (vc.tag == 1) {
                [weakSelf.pageMenu setTitle:[NSString stringWithFormat:@"服务订单（%@）",count] forItemAtIndex:1];
            }
        };
        [self.myChildViewControllers addObject:vc];
    }
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        GKGLCustomerBillDetailSubVC *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0, SCREEN_WIDTH, scrollViewHeight);
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.dataArr.count*SCREEN_WIDTH, 0);
    }
}
- (void)createPageMenu
{
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.selectedItemTitleColor = kColorTheme;
    pageMenu.unSelectedItemTitleColor = kColor6;
    pageMenu.selectedItemTitleFont = FONT_BOLD_SIZE(15);
    pageMenu.unSelectedItemTitleFont = FONT_SIZE(15);
    pageMenu.trackerWidth = 40;
    pageMenu.tracker.backgroundColor = kColorTheme;
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
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
    
    GKGLCustomerBillDetailSubVC *targetViewController = self.myChildViewControllers[toIndex];
    targetViewController.tag = toIndex;
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(SCREEN_WIDTH * toIndex, 0, SCREEN_WIDTH, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
    
    
}
@end
