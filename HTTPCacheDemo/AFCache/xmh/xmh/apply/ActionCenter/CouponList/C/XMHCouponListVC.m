//
//  XMHCouponListVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponListVC.h"
#import "JasonSearchView.h"
#import "XMHCouponVC.h"
#import "XMHActionCenterRequest.h"
#import "XMHPickerView.h"
#import "XMHFormVC.h"

@interface XMHCouponListVC ()<UIScrollViewDelegate,XMHPickerViewResultDelegate>

@property (nonatomic, strong) JasonSearchView *searchView;
/** 投放状态按钮 */
@property (nonatomic, strong) UIButton *statusBtn;
/** 创建时间按钮 */
@property (nonatomic, strong) UIButton *createTimeBtn;
/** 创建优惠券按钮 */
@property (nonatomic, strong) UIButton *creatCounpontBtn;
/** 下划线 */
@property (nonatomic, strong) UIView *indicatorView;
/** 选中优惠券按钮 */
@property (nonatomic, strong) UIButton *selectBtn;
/** 优惠券按钮数组 */
@property (nonatomic, strong) NSMutableArray *couponArr;
/** <##> */
@property (nonatomic, strong) UIScrollView *scrollView;
/** */
@property (nonatomic, strong) UIView *counponBgView;
/** 类型3:现金券 4：折扣券 5：礼品券 */
@property (nonatomic, assign)NSInteger type;
/** 搜索 优惠券名称 */
@property (nonatomic, copy) NSString *searchText;
/** 3：未投放 4:已投放 5:已过期 all:全部 */
@property (nonatomic, copy)NSString *status;
/** 正序：asc 倒叙：desc */
@property (nonatomic, copy)NSString *sore;
/** 从 1 开始 不传默认第一页 */
@property (nonatomic, assign)NSInteger page;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *list;
/** 默认选中第一列 */
@property (nonatomic,assign)NSInteger selectComponent;
/**控制器*/
@property (nonatomic, strong) NSMutableArray *couponVCs;

@end

@implementation XMHCouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView setNavViewTitle:@"优惠券列表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    self.view.backgroundColor = Color_NormalBG;
    [self createSubViews];
    [self initValue];
    [self requestData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];

}

/**
 初始化值
 */
- (void)initValue
{
    self.list = [NSMutableArray array];
    self.status = @"all";
    self.sore = @"desc";
    self.type = 3;
    self.page = 1;
    self.searchText = nil;
}
- (void)createSubViews
{
    [self createHeaderView];
    [self createContentView];
}
- (void)createContentView
{
    //内容
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.counponBgView.bottom  ,SCREEN_WIDTH , self.view.frame.size.height - self.counponBgView.bottom)];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = YES;
    _scrollView.scrollEnabled = NO;
    _scrollView.pagingEnabled = YES;
    _couponVCs = [NSMutableArray array];
    
    for (int i = 0; i < self.couponArr.count; i ++) {
        XMHCouponVC *couponVC = [[XMHCouponVC alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,_scrollView.height )];
        couponVC.type = i + self.couponArr.count;
        couponVC.nc = self.navigationController;
        couponVC.tableView.contentSize = CGSizeMake(0, _scrollView.height);
        couponVC.view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH,_scrollView.height );
        [_scrollView addSubview:couponVC.view];
        [_couponVCs safeAddObject:couponVC];
    }
     _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _couponVCs.count,0);
}
- (void)createHeaderView
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, SCREEN_WIDTH, 63)];
    bgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bgView];
    
    CGFloat btnBgW = SCREEN_WIDTH / 2;
    self.statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.statusBtn setTitle:@"全部  " forState:UIControlStateNormal];
    [self.statusBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [self.statusBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.statusBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.statusBtn.tag = 2;
    [self.statusBtn setImage:[UIImage imageNamed:@"huodongzhongxin_youjiantou"] forState:UIControlStateNormal];
    self.statusBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft; // 左右翻转
    self.statusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; // 内容靠右
    self.statusBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 靠左，以显示label后边的空格间距
    self.statusBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:self.statusBtn];
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnBgW * 0.5);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(bgView);
    }];
    
    self.createTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.createTimeBtn setTitle:@"创建时间 " forState:UIControlStateNormal];
    [self.createTimeBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [self.createTimeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.createTimeBtn.tag = 1;
    self.createTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.createTimeBtn setImage:[UIImage imageNamed:@"daoxu"] forState:UIControlStateNormal];
    [self.createTimeBtn setImage:[UIImage imageNamed:@"zhengxu"] forState:UIControlStateSelected];
    self.createTimeBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft; // 左右翻转
    self.createTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; // 内容靠右
    self.createTimeBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 靠左，以显示label后边的空格间距
    self.createTimeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:self.createTimeBtn];
    [self.createTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnBgW * 0.5);
        make.right.mas_equalTo(self.statusBtn.mas_left);
        make.top.bottom.mas_equalTo(bgView);
    }];
    
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH * 0.5 , 34)withPlaceholder:@"请输入名称"];
    _searchView.limitLength = 20;
    _searchView.layer.cornerRadius = 3;
    _searchView.layer.masksToBounds = YES;
    [bgView addSubview:_searchView];
    _searchView.line1.hidden = YES;
    WeakSelf;
    __weak JasonSearchView  *tempsearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        weakSelf.searchText = tempsearchView.searchBar.text;
        [weakSelf requestData];
    };
    _searchView.searchBar.btnleftBlock = ^{
        weakSelf.searchText = @"";
        [weakSelf requestData];
    };
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.bottom, SCREEN_WIDTH, kSeparatorHeight)];
    line.backgroundColor = kSeparatorColor;
    [self.view addSubview:line];
    
    UIView *createBgView = [[UIView alloc]initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, 90)];
    createBgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:createBgView];
    
    
    self.creatCounpontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.creatCounpontBtn setTitle:@"  创建优惠券 " forState:UIControlStateNormal];
    [self.creatCounpontBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [self.creatCounpontBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.creatCounpontBtn.tag = 3;
    self.creatCounpontBtn.backgroundColor = Color_NormalBG;
    self.creatCounpontBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.creatCounpontBtn setImage:[UIImage imageNamed:@"huodongzhongxin_tianjiayouhuiquan"] forState:UIControlStateNormal];
    self.creatCounpontBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [createBgView addSubview:self.creatCounpontBtn];
    [self.creatCounpontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-20);
    }];
    
    UIView *counponBgView = [[UIView alloc]initWithFrame:CGRectMake(0, createBgView.bottom + 10, SCREEN_WIDTH, 44)];
    counponBgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:counponBgView];
    
    self.couponArr = [NSMutableArray array];
    CGFloat btnW = SCREEN_WIDTH / 3;
    CGFloat btnH = 41;
    NSArray *titles = @[@"现金券",@"折扣券",@"礼品券"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(counponBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 100;
        [counponBgView addSubview:btn];
        [self.couponArr safeAddObject:btn];
        if (i == 0) {
            [btn setTitleColor:[ColorTools colorWithHexString:@"#EA007A"] forState:UIControlStateNormal];
            self.selectBtn = btn;
        }
    }
    
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = [ColorTools colorWithHexString:@"#EA007A"];
    _indicatorView.layer.cornerRadius = 3 * 0.5;
    _indicatorView.bounds = CGRectMake(0, 0, 25 , 3);
    _indicatorView.center = CGPointMake(self.selectBtn.center.x, 43);
    [counponBgView addSubview:_indicatorView];
    self.counponBgView = counponBgView;
}

#pragma mark-- 内部

/**
 切换票券

 @param sender 菜单栏
 */
- (void)counponBtnClick:(UIButton *)sender
{
    [self resetState];

    if (sender.tag == 100) { //现金券
        self.type = 3;
    }else if (sender.tag == 101){ //折扣券
         self.type = 4;
    }else if (sender.tag == 102){ //礼品券
         self.type = 5;
    }
    for (UIButton *btn in self.couponArr ) {
        if (sender.tag == btn.tag) {
            [btn setTitleColor:[ColorTools colorWithHexString:@"#EA007A"] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        }
    }
    self.selectBtn = sender;
    [UIView animateWithDuration:(0.05) animations:^{
        _indicatorView.center = CGPointMake(self.selectBtn.center.x, 43);
    }];
    
     [self requestData];
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (sender.tag - 100) , 0) animated:NO];
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.tag == 1) { //创建时间
        if (btn.selected) {
            self.sore = @"asc";
        }else{
             self.sore = @"desc";
        }
         [self requestData];
    }else if (btn.tag == 2){ //投放状态
        
        XMHPickerView *pickerView = [[XMHPickerView alloc]init];
        pickerView.type = PickerViewTypeStatus;
        pickerView.delegate = self;
        pickerView.selectComponent = _selectComponent;
        [self.view addSubview:pickerView];

    }else if (btn.tag == 3){//创建优惠券
        XMHFormVC *vc = XMHFormVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}
#pragma mark -- request
- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [params setValue:joinCode forKey:@"join_code"];
    [params setValue:@(self.type) forKey:@"type"];
    [params setValue:self.searchText ? self.searchText:@"" forKey:@"name"];
    [params setValue:self.status ? self.status:@"" forKey:@"status"];
    [params setValue:self.sore ? self.sore:@"" forKey:@"sore"];
    [params setValue:@(1) forKey:@"page"];
    XMHCouponVC *vc = [_couponVCs safeObjectAtIndex:self.type - 3];
    [vc.dataArr removeAllObjects];
    vc.page = 1;
    [vc requestListDataParmas:params];
    /** 类型3:现金券 4：折扣券 5：礼品券 */
    if (vc.tableView.numberOfSections) {
        [vc.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0] atScrollPosition: UITableViewScrollPositionTop animated:NO];
    }
    [vc.tableView setContentOffset:CGPointMake(0,0) animated:NO];
}
#pragma mark -- XMHPickerViewResultDelegate
-(void)pickerView:(UIView *)pickerView result:(NSString *)string{
     [self.statusBtn setTitle:[NSString stringWithFormat:@"%@ ",string] forState:UIControlStateNormal];
    if ([string isEqualToString:@"全部"]) {
        self.status = @"all";
        _selectComponent = 0;
    }else if ([string isEqualToString:@"未投放"]){
        self.status = @"3";
        _selectComponent = 2;
    }else if ([string isEqualToString:@"已投放"]){
        self.status = @"4";
         _selectComponent = 1;
    }else if ([string isEqualToString:@"已过期"]){
        self.status = @"5";
        _selectComponent = 3;
    }
    [self requestData];

}

/**
 重置状态
 */
- (void)resetState{

    self.searchText = _searchView.searchBar.text = nil;
    [_searchView.searchBar resignFirstResponder];
    self.sore = @"desc";
    self.status = @"all";
    _selectComponent = 0;
    self.createTimeBtn.selected = NO;
    [self.statusBtn setTitle:@"全部 " forState:UIControlStateNormal];
  
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
