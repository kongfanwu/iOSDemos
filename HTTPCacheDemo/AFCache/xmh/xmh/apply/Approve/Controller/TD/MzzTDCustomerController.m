//
//  MzzTDCustomerController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTDCustomerController.h"
#import "JasonSearchView.h"
#import "ShareWorkInstance.h"
#import "SPRequest.h"
#import "SPSearchStoreUserModel.h"
#import "MzzTDCustomerCell.h"
#import "UserManager.h"
#import "MzzTDDetailInfoController.h"
@interface MzzTDCustomerController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UIView *bottomView;
@property (nonatomic ,strong)SPSearchStoreUserModel *model;
@property (nonatomic ,strong)SPStoreModel *storeModel;
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,assign)int pageNumber;
@property (nonatomic ,assign)CGFloat scrollH;
@property (nonatomic ,copy)NSString *keyword;
/** <##> */
@property (nonatomic, strong) UIView *bgView;
@end

@implementation MzzTDCustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self creatNav];
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"会员调店审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 68, SCREEN_WIDTH, 68)];
    _bottomView = bottomView;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(68);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 3;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(12, 12, bottomView.width - 24, bottomView.height - 24);
    [sureBtn setBackgroundColor:kBtn_Commen_Color];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, kSafeAreaTop + kNavigationBarHeight + 10, self.view.width - 20, kNavContentHeight - bottomView.height - 10)];
    _bgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_bgView];
    [_bgView cornerRadius:10];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"会员调店审批" withleftImageStr:@"back" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"会员调店审批" withleftImageStr:@"back" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setupUI{
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.width, 130)];
    _backView = backView;
    [backView setBackgroundColor:[UIColor whiteColor]];
//    backView.layer.cornerRadius = 5;
//    backView.layer.masksToBounds = YES;
    [_bgView addSubview:backView];
    
    [UIView addRadiusWithView:backView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 20)];
    titleLbl.font = FONT_SIZE(16);
    titleLbl.textColor = kColor3;
    [titleLbl setText:@"选择调店顾客"];
    [titleLbl setTextAlignment:NSTextAlignmentLeft];
    [backView addSubview:titleLbl];
    
    JasonSearchView *searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, titleLbl.bottom, backView.width, 40 + 20)withPlaceholder:@"输入调店顾客名称/手机号"];
    [searchView updateShenPiFrame];
    searchView.searchBar.btnRightBlock = ^{
        //搜索
        _keyword =searchView.searchBar.text;
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
        params[@"store_code"] = _storeModel.code;
        params[@"keyword"] =  _keyword;
        _pageNumber =0;
        params[@"pageNumber"] = [NSString stringWithFormat:@"%d",_pageNumber ];
        [SPRequest requestSearchStoreUserParams:params resultBlock:^(SPSearchStoreUserModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            _model = model;
            [self updateCollectionViewFrame];
            [_collectionView reloadData];
        }];
    };
    searchView.searchBar.btnleftBlock = ^{
       
    };
    [backView addSubview:searchView];
    
    UIButton *all = [UIButton buttonWithType:UIButtonTypeCustom];
    [all setTitle:@"全选" forState:UIControlStateNormal];
    [all setImage:[UIImage imageNamed:@"stspyytdquanxuan"] forState:UIControlStateNormal];
    [all setTitle:@"全选" forState:UIControlStateSelected];
    [all setImage:[UIImage imageNamed:@"stspyytddanxuan"] forState:UIControlStateSelected];
    [all setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [all.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [all setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    all.frame = CGRectMake(15, searchView.bottom + 10, 100, 20);
    all.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    all.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [all addTarget:self action:@selector(allOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:all];
    
    
    
}
- (void)updateCollectionViewFrame{
//    return;
    int col = 5;
//    CGFloat itemW = 65;
    CGFloat itemH = 70;
    CGFloat minLinMargin = 10;
    CGFloat scrollH = 0;
    CGFloat maxH =CGRectGetMinY(_bottomView.frame) - CGRectGetMaxY(_backView.frame);
    CGFloat maxDataH =( _model.list.count / col ) * (itemH + minLinMargin) + minLinMargin + ( (_model.list.count % col) ? 1 : 0 ) * (itemH + minLinMargin);
    scrollH = (maxH <maxDataH )? maxH :maxDataH;
    if (_scrollH !=scrollH) {
        [_collectionView setHeight:scrollH];
        if (scrollH <30) {
            [_collectionView setHeight:30];
        }
    }
}
- (void)setupCollectionView{
    int col = 5;
    CGFloat itemW = 70;
    CGFloat itemH = 70;
    CGFloat minLinMargin = 10;
    CGFloat scrollH = 0;
    CGFloat maxH =CGRectGetMinY(_bottomView.frame) - CGRectGetMaxY(_backView.frame);
    CGFloat maxDataH =( _model.list.count / col ) * (itemH + minLinMargin) + minLinMargin + ( (_model.list.count % col) ? 1 : 0 ) * (itemH + minLinMargin);
    scrollH = (maxH <maxDataH )? maxH :maxDataH;
    
    scrollH -= 5; // 上拉刷新，漏出了。减去
    
    _scrollH = scrollH;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake(itemW, itemH);
    layout.minimumInteritemSpacing =(SCREEN_WIDTH - col * itemW - 30) / (col - 1);
    layout.minimumLineSpacing = minLinMargin;
    //2.初始化collectionView
    

//    CGFloat collectonViewHeight = _bgView.height - _bottomView.height; //kNavContentHeight - _backView.height - _bottomView.height;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_backView.frame), SCREEN_WIDTH - 20, _scrollH) collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.redColor;
    if (scrollH <30) {
        [_collectionView setHeight:30];
    }
    [_bgView addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
//    [_collectionView registerClass:[MzzTDCustomerCell class] forCellWithReuseIdentifier:@"cellID"];
    [_collectionView registerNib:[UINib nibWithNibName:@"MzzTDCustomerCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
//    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    
    WeakSelf;
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
   
//    [UIView addRadiusWithView:_collectionView roundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
}

- (void)requestMoreNetData{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"store_code"] = _storeModel.code;
    params[@"keyword"] =  _keyword;
    _pageNumber = _pageNumber + 1;
    params[@"pageNumber"] = [NSString stringWithFormat:@"%d",_pageNumber];
    [SPRequest requestSearchStoreUserParams:params resultBlock:^(SPSearchStoreUserModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [_model.list addObjectsFromArray:model.list];
        [self updateCollectionViewFrame];
        [_collectionView reloadData];
        [_collectionView.mj_footer endRefreshing];
    }];
}
- (void)requestNetData{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"store_code"] = _storeModel.code;
     params[@"keyword"] =  _keyword;
    _pageNumber =0;
    params[@"pageNumber"] = [NSString stringWithFormat:@"%d",_pageNumber ];
    [SPRequest requestSearchStoreUserParams:params resultBlock:^(SPSearchStoreUserModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _model = model;
        [self setupCollectionView];
    }];
}
-(void)getStoreData:(SPStoreModel *)model{
    _storeModel = model;
    [self requestNetData];
}

-(void)allOnclick:(UIButton *)all{
    [all setSelected:!all.selected];
    if (_model.list.count ==0) {
        return;
    }
    for (int i = 0; i <_model.list.count; i++) {
        SPStoreUserModel *userModel = [_model.list objectAtIndex:i];
        userModel.isSelected = all.isSelected;
        [_collectionView reloadData];
    }
}

- (void)sure{
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *user_idArr = [NSMutableArray array];
    for (int i = 0; i < _model.list.count; i++) {
        SPStoreUserModel *userModel = [_model.list objectAtIndex:i];
        if (userModel.isSelected) {
            [arr addObject:userModel];
            [user_idArr addObject:[NSString stringWithFormat:@"%ld",userModel.ID]];
        }
    }
    //TODO
    if (arr.count ==0) {
        [[[MzzHud alloc] initWithTitle:@"提示" message:@"调店顾客不能为空" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
            
        }]show];
    }else{
        LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString * account = infomodel.data.account;
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
        params[@"store_code"] = _storeModel.code;
        params[@"chType"] =  @"1";
        params[@"account"] =  account;
        params[@"user_id"] =  [user_idArr componentsJoinedByString:@","];
        NSLog(@"%@",params);
        [SPRequest requestChangeStoreParams:params resultBlock:^(SPChangeStoreModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess && model) {
                //跳转调店详细页
                MzzTDDetailInfoController *detailVc = [[MzzTDDetailInfoController alloc] init];
                [detailVc setupOutCode:_storeModel.code];
                [detailVc setupData:model];
                [self.navigationController pushViewController:detailVc animated:NO];
            }else{
                [MzzHud toastWithTitle:@"tips" message:@"请稍后再试"];
            }
        }];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.list.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MzzTDCustomerCell *cell = (MzzTDCustomerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
    [cell setData: [_model.list objectAtIndex:indexPath.item]];
    return cell;
}


@end
