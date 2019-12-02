//
//  XMHCouponDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponDetailView.h"
#import "ABSegmentTitleView.h"
#import "XMHAvailableCouponsTableView.h"
#import "XMHUnAvailableCouponsUITableView.h"
#import "SATicketListModel.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHCouponDetailView()<ABSegmentTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) ABSegmentTitleView *titleView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XMHAvailableCouponsTableView *availableView;
@property (nonatomic, strong) XMHUnAvailableCouponsUITableView *unAvailableView;
@property (nonatomic, strong) NSMutableArray *availaArr;
@property (nonatomic, strong) NSMutableArray *unAvailaArr;

@property (nonatomic, strong) UIButton *availaBtn;
@property (nonatomic, strong) UIButton *unAvailaBtn;
@property (nonatomic, strong) UIView *indicatorView;


@end

@implementation XMHCouponDetailView

- (instancetype)initWithFrame:(CGRect)frame availaCouponArr:(nonnull NSMutableArray *)availaCouponArr unAavailaCouponArr:(nonnull NSMutableArray *)unAavailaCouponArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.availaArr = [NSMutableArray arrayWithArray:availaCouponArr] ;
        self.unAvailaArr = [NSMutableArray arrayWithArray:unAavailaCouponArr];
        [self initLayout];
    }
    return self;
}
- (void)setModel:(SATicketModel *)model
{
    _model = model;
    _availableView.model = _model;
}
- (void)initLayout
{
   
    self.backgroundColor = [UIColor whiteColor];
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = self.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.layer.mask = cornerRadiusLayer;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.top.mas_equalTo(kMargin);
    }];
    
    UILabel *couponLab = [[UILabel alloc]init];
    couponLab.text = @"优惠券";
    couponLab.font = [UIFont systemFontOfSize:15];
    couponLab.textColor = kLabelText_Commen_Color_3;
    couponLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:couponLab];
    
    [couponLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.centerY.mas_equalTo(closeBtn.mas_centerY);
    }];
    
    UIView *line =[[UIView alloc]init];
    line.backgroundColor = Separator_LineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44);
        make.height.mas_equalTo(Separator_Line_Height);
        make.right.left.mas_equalTo(self);
    }];
    
    
    UIView *segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 68)];
    [self addSubview:segmentView];
    
    self.availaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.availaBtn.frame = CGRectMake(0, (segmentView.height - 21) * 0.5, SCREEN_WIDTH * 0.5, 21);
    self.availaBtn.tag = 100;
    self.availaBtn.selected = YES;
    [self.availaBtn setTitle:[NSString stringWithFormat:@"可用优惠券(%ld)", _availaArr.count] forState:UIControlStateNormal];
    [self.availaBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    [self.availaBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    self.availaBtn.titleLabel.font = FONT_SIZE(15);
    [self.availaBtn addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:self.availaBtn];
    
    self.unAvailaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unAvailaBtn.tag = 101;
    self.unAvailaBtn.frame = CGRectMake(self.availaBtn.width, (segmentView.height - 21) * 0.5, SCREEN_WIDTH * 0.5, 21);
    [self.unAvailaBtn setTitle:[NSString stringWithFormat:@"不可用优惠券(%ld)", _unAvailaArr.count] forState:UIControlStateNormal];
    [self.unAvailaBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    [self.unAvailaBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    self.unAvailaBtn.titleLabel.font = FONT_SIZE(15);
    [self.unAvailaBtn addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:self.unAvailaBtn];
    
    self.indicatorView.frame = CGRectMake(0, self.availaBtn.bottom + 1, 36, 3);
    self.indicatorView.center = CGPointMake(self.availaBtn.center.x, self.availaBtn.bottom + 6);
    self.indicatorView.backgroundColor = kBtn_Commen_Color;
    [segmentView addSubview:self.indicatorView];
    
    
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(segmentView.bottom);
        make.right.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    XMHAvailableCouponsTableView *availableView = [[XMHAvailableCouponsTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height - segmentView.bottom) style:UITableViewStylePlain];
    availableView.selectedCouponsModel = ^(SATicketModel * _Nonnull ticketModel) {
        self.model = ticketModel;
        [self closeBtnClick];
    };
    XMHUnAvailableCouponsUITableView *unAvailableView = [[XMHUnAvailableCouponsUITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height - segmentView.bottom)style:UITableViewStylePlain];
    [self.scrollView addSubview:availableView];
    [self.scrollView addSubview:unAvailableView];
    
    self.availableView =availableView;
    self.unAvailableView = unAvailableView;
    
    self.availableView.dataArr = self.availaArr;
    self.unAvailableView.dataArr = self.unAvailaArr;
    
    [self.availableView reloadData];
    [self.unAvailableView reloadData];
    
    
}

#pragma mark -- ABSegmentTitleViewDelegate
- (void)ABSegmentTitleView:(ABSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    if (endIndex == 0) {
        self.availaBtn.selected = YES;
        self.unAvailaBtn.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        self.unAvailaBtn.selected = YES;
        self.availaBtn.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{    //页码
    
    UIButton *btn;
    int page= scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (page == 0) {
        
        self.availaBtn.selected = YES;
        self.unAvailaBtn.selected = NO;
        btn = self.availaBtn;
    }else{
        
        self.availaBtn.selected = NO;
        self.unAvailaBtn.selected = YES;
        btn = self.unAvailaBtn;
    }
    [UIView animateWithDuration:(0.05) animations:^{
        self.indicatorView.bounds = CGRectMake(0, 0, 36 , 3);
        self.indicatorView.center = CGPointMake(btn.center.x, btn.bottom + 6);
    } completion:^(BOOL finished) {
    }];
}


- (void)changeClick:(UIButton *)sender {
    
    if (sender.tag == 100) {
        self.availaBtn.selected = YES;
        self.unAvailaBtn.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }else {
        self.availaBtn.selected = NO;
        self.unAvailaBtn.selected = YES;
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    }
    [UIView animateWithDuration:(0.05) animations:^{
        
        self.indicatorView.center = CGPointMake(sender.center.x, sender.bottom + 6);
        self.indicatorView.bounds = CGRectMake(0, 0, 36 , 3);//长度不需要和文字等长indicatorWidth
        
    } completion:^(BOOL finished) {

    }];
}

#pragma mark --event
- (void)closeBtnClick
{
    if (_selectedCouponsModel) {
        _selectedCouponsModel(self.model);
    }
    [self removeFromSuperview];
    
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
        _indicatorView.layer.cornerRadius = 3 * 0.5;
        [self.scrollView addSubview:_indicatorView];
    }
    return _indicatorView;
}
@end
