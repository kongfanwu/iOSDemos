//
//  XMHRankDetailVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHRankDetailVC.h"
#import "XMHRankContentDetailVC.h"
@interface XMHRankDetailVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *saleBtn;
@property (nonatomic, strong) UIButton *expendBtn;
@property (nonatomic, strong) UIView *underLine;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation XMHRankDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView setNavViewTitle:@"排名详情" backBtnShow:YES];
    [self createSubViews];
   
}

- (void)createSubViews
{
    [self createHeaderView];
    [self createScrollView];
}
- (void)createHeaderView
{
    WeakSelf
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, SCREEN_WIDTH, 44)];
    bgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bgView];
    
    self.saleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saleBtn setTitle:@"销售" forState:UIControlStateNormal];
    self.saleBtn.titleLabel.font = FONT_SIZE(15);
    [self.saleBtn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
    self.saleBtn.selected = YES;
    [self.saleBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    [self.saleBtn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.saleBtn.selected = YES;
            weakSelf.expendBtn.selected = NO;
            weakSelf.underLine.frame = CGRectMake(weakSelf.saleBtn.x, 41, 32, 3);
            [weakSelf.contentView setContentOffset:CGPointMake(0, 0) animated:NO];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.saleBtn];
    
    self.expendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.expendBtn setTitle:@"消耗" forState:UIControlStateNormal];
    self.expendBtn.titleLabel.font = FONT_SIZE(15);
    [self.expendBtn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
    [self.expendBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    [self.expendBtn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.saleBtn.selected = NO;
            weakSelf.expendBtn.selected = YES;
            weakSelf.underLine.frame = CGRectMake(weakSelf.expendBtn.x, 41, 32, 3);
            [weakSelf.contentView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.expendBtn];
    
    self.underLine = UIView.new;
    self.underLine.layer.cornerRadius = 1.5;
    self.underLine.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
    [bgView addSubview:self.underLine];
    
    CGFloat x = (SCREEN_WIDTH * 0.5) - 40 - 32;
    self.saleBtn.frame = CGRectMake(x, 13, 32, 18);
    self.expendBtn.frame = CGRectMake((SCREEN_WIDTH * 0.5) + 40, 13, 32, 18);
    self.underLine.frame = CGRectMake(self.saleBtn.x, 41, 32, 3);
    
}

- (void)createScrollView
{
    //内容
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,44 + KNaviBarHeight  ,SCREEN_WIDTH , self.view.height - 44)];
    [self.view addSubview:_contentView];
    _contentView.delegate = self;
    _contentView.scrollsToTop = NO;
    _contentView.scrollEnabled = YES;
    [self.view addSubview:_contentView];
    
    XMHRankContentDetailVC *saleVc = [[XMHRankContentDetailVC alloc]init];
    saleVc.contentType =  XMHRankContentTypeSale;
    [saleVc requestRankDataWithParams:_param];
    XMHRankContentDetailVC *expendVc = [[XMHRankContentDetailVC alloc]init];
    expendVc.contentType =  XMHRankContentTypExpend;
    [expendVc requestRankDataWithParams:_param];
    [self addChildViewController:saleVc];
    [self addChildViewController:expendVc];
   
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        XMHRankContentDetailVC *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, _contentView.width, self.view.height - 44);
        [_contentView addSubview:vc.view];
    }
    _contentView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, self.view.height - 44);
    [self.contentView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   NSInteger page =  scrollView.contentOffset.x / SCREEN_WIDTH;
    if (page == 0) {

        self.saleBtn.selected = YES;
        self.expendBtn.selected = NO;
        self.underLine.frame = CGRectMake(self.saleBtn.x, 41, 32, 3);
    }else{
        self.saleBtn.selected = NO;
        self.expendBtn.selected = YES;
        self.underLine.frame = CGRectMake(self.expendBtn.x, 41, 32, 3);
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
