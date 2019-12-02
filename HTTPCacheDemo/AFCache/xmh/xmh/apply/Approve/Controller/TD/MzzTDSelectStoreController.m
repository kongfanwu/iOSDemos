//
//  MzzTDSelectStoreController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTDSelectStoreController.h"
#import "ShareWorkInstance.h"
#import "SPRequest.h"
#import "JasonSearchView.h"
#import "SPGetStoresModel.h"
#import "MzzSelectButtom.h"
@interface MzzTDSelectStoreController ()
@property (nonatomic ,strong)SPGetStoresModel *model;
@property (nonatomic ,strong)MzzSelectButtom *currentBtn;
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)JasonSearchView *searchView;
@property (nonatomic ,strong)UIView *bottomView;
@end

@implementation MzzTDSelectStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self creatNav];
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"选择门店" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self creatUi];
    [self requestDataWithKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"选择门店" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)requestDataWithKey:(NSString *)key{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    if (key) {
        params[@"keyword"] = key;
    }
    [SPRequest requestgetStoresParams:params resultBlock:^(SPGetStoresModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _model = model;
        [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self seutupScrollView];
    }];
}
- (void)creatUi{
    
//    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 10, SCREEN_WIDTH, 10)];
//    back.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:back];
    
    JasonSearchView *searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 60)withPlaceholder:@"输入调店顾客名称/手机号"];
    [searchView updateShenPiSearchFrame];
    __block JasonSearchView *BsearchView = searchView;
    searchView.searchBar.btnRightBlock = ^{
        [self requestDataWithKey:  BsearchView.searchBar.text];
    };
    searchView.searchBar.btnleftBlock = ^{
       
    };
    [self.view addSubview:searchView];
    _searchView = searchView;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 68, SCREEN_WIDTH, 68)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(68);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(12, 12, bottomView.width - 24, bottomView.height - 24);
    [sureBtn setBackgroundColor:kBtn_Commen_Color];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
    [sureBtn cornerRadius:3];
    _bottomView  =bottomView;
}
- (void)seutupScrollView{
    
    NSInteger dataCount = _model.list.count;
    CGFloat scrollViewH;
    if (CGRectGetMinY(_bottomView.frame)-CGRectGetMaxY(_searchView.frame) < dataCount * 40) {
        scrollViewH = CGRectGetMinY(_bottomView.frame)-CGRectGetMaxY(_searchView.frame);
    }else{
        scrollViewH = dataCount * 40 ;
    }
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
         [self.view addSubview:_scrollView];
    }
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_searchView.frame), SCREEN_WIDTH,scrollViewH);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, dataCount * 40);
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
   
    for (int i = 0; i <_model.list.count; i++) {
        SPStoresModel *storesModel = [_model.list objectAtIndex:i];
        MzzSelectButtom *tiaochu = [MzzSelectButtom buttonWithType:UIButtonTypeCustom];
        tiaochu.tag = i;
        [tiaochu setTitle:storesModel.name forState:UIControlStateNormal];
        [tiaochu setImage:[UIImage imageNamed:@"syspyyzhifuxuanzeweixuan"] forState:UIControlStateNormal];
        [tiaochu setTitle:storesModel.name forState:UIControlStateSelected];
        [tiaochu setImage:[UIImage imageNamed:@"syspyyzhifuxuanze"] forState:UIControlStateSelected];
        [tiaochu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tiaochu.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [tiaochu setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
        tiaochu.frame = CGRectMake(15, 10 + i *40, 200, 20);
        tiaochu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [tiaochu addTarget:self action:@selector(tiaochuOnclick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            _currentBtn = tiaochu;
            [_currentBtn setSelected:YES];
        }
        [_scrollView addSubview:tiaochu];
    }
}

- (void)tiaochuOnclick:(MzzSelectButtom *)tiaochu{
    if (tiaochu.selected) {
        return;
    }
    [tiaochu setSelected:YES];
    [_currentBtn setSelected:NO];
    _currentBtn = tiaochu;
}
- (void)sure{
    NSInteger index = _currentBtn.tag;
    if (self.sureOnclick) {
        self.sureOnclick([_model.list objectAtIndex:index]);
    }
    [self.navigationController popViewControllerAnimated:NO];
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
