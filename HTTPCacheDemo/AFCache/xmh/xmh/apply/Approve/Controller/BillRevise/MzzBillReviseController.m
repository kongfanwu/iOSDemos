//
//  MzzBillReviseController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzBillReviseController.h"
#import "JasonSearchView.h"
#import "ShareWorkInstance.h"
#import "SPRequest.h"
#import "SPSearchStoreUserModel.h"
#import "MzzTDCustomerCell.h"
#import "UserManager.h"
#import "MzzTDDetailInfoController.h"
#import "MzzBillReviseDetailController.h"
#import "NSString+Check.h"
@interface MzzBillReviseController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UIView *bottomView;
@property (nonatomic ,strong)SPSearchUserModel *model;
@property (nonatomic ,strong)SPStoreModel *storeModel;
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,assign)int pageNumber;
@property (nonatomic ,assign)CGFloat scrollH;
@property (nonatomic ,copy)NSString *keyword;
@end

@implementation MzzBillReviseController
{
    UIImageView * _selectImgV;
    SPUserModel * _userModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
    [self setupUI];
    [self loadData];
}
- (void)loadData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"account"] = infomodel.data.account;
    params[@"fram_id"] = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    params[@"keyword"] = @"1";
    [SPRequest requestSearchUserParams:params resultBlock:^(SPSearchUserModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _model = model;
        [self updateCollectionViewFrame];
        [_collectionView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"账单校正审批" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setupUI{
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 10, SCREEN_WIDTH, 120)];
    _backView = backView;
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 20)];
    [titleLbl setText:@"选择顾客"];
    [titleLbl setTextAlignment:NSTextAlignmentLeft];
    [backView addSubview:titleLbl];
    
    JasonSearchView *searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 45)withPlaceholder:@"输入调店顾客名称/手机号"];
    searchView.searchBar.btnRightBlock = ^{
        _keyword =searchView.searchBar.text;
        if (!(_keyword.length > 0)) {
            _keyword = @"1";
        }
        LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"account"] = infomodel.data.account;
        params[@"fram_id"] = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
        params[@"keyword"] =  _keyword;
        [SPRequest requestSearchUserParams:params resultBlock:^(SPSearchUserModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            _model = model;
            [self updateCollectionViewFrame];
            [_collectionView reloadData];
        }];
        
    };
    searchView.searchBar.btnleftBlock = ^{
        
    };

    [backView addSubview:searchView];
    
//    UIButton *all = [UIButton buttonWithType:UIButtonTypeCustom];
//    [all setTitle:@"全选" forState:UIControlStateNormal];
//    [all setImage:[UIImage imageNamed:@"stspyytdquanxuan"] forState:UIControlStateNormal];
//    [all setTitle:@"全选" forState:UIControlStateSelected];
//    [all setImage:[UIImage imageNamed:@"stspyytddanxuan"] forState:UIControlStateSelected];
//    [all setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [all.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [all setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
//    all.frame = CGRectMake(15, 100, 100, 20);
//    all.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    all.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    [all addTarget:self action:@selector(allOnclick:) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:all];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 68, SCREEN_WIDTH, 68)];
    _bottomView = bottomView;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(12, 12, bottomView.width - 24, bottomView.height - 24);
    [sureBtn setBackgroundColor:kBtn_Commen_Color];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
    
     [self setupCollectionView];
}
- (void)updateCollectionViewFrame{
    int col = 5;
    //    CGFloat itemW = 65;
    CGFloat itemH = 70;
    CGFloat minLinMargin = 20;
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
    CGFloat itemW = 65;
    CGFloat itemH = 70;
    CGFloat minLinMargin = 20;
    CGFloat scrollH = 0;
    CGFloat maxH =CGRectGetMinY(_bottomView.frame) - CGRectGetMaxY(_backView.frame);
    CGFloat maxDataH =( _model.list.count / col ) * (itemH + minLinMargin) + minLinMargin + ( (_model.list.count % col) ? 1 : 0 ) * (itemH + minLinMargin);
    scrollH = (maxH <maxDataH )? maxH :maxDataH;
    _scrollH = scrollH;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake(itemW, itemH);
    layout.minimumInteritemSpacing =(SCREEN_WIDTH - col * itemW) / (col - 1);
    layout.minimumLineSpacing = minLinMargin;
    //2.初始化collectionView
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_backView.frame), SCREEN_WIDTH, scrollH) collectionViewLayout:layout];
    if (scrollH <30) {
        [_collectionView setHeight:30];
    }
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];

    [_collectionView registerNib:[UINib nibWithNibName:@"MzzTDCustomerCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
   
}

-(void)allOnclick:(UIButton *)all{
    [all setSelected:!all.selected];
    if (_model.list.count ==0) {
        return;
    }
    for (int i = 0; i <_model.list.count; i++) {
        SPUserModel *userModel = [_model.list objectAtIndex:i];
        userModel.isSelected = all.isSelected;
        [_collectionView reloadData];
    }
}

- (void)sure{
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *user_idArr = [NSMutableArray array];
    for (int i = 0; i < _model.list.count; i++) {
        SPUserModel *userModel = [_model.list objectAtIndex:i];
        if (userModel.isSelected) {
            [arr addObject:userModel];
            [user_idArr addObject:[NSString stringWithFormat:@"%ld",userModel.ID]];
        }
    }
    //TODOr
    if (arr.count ==0) {
        [[[MzzHud alloc] initWithTitle:@"提示" message:@"顾客不能为空" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
            
        }]show];
    }else{
        NSLog(@"%@",user_idArr);
        MzzBillReviseDetailController *detailVc = [[MzzBillReviseDetailController alloc] init];
        detailVc.userModel = arr[0];
        [self.navigationController pushViewController:detailVc animated:NO];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.list.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MzzTDCustomerCell *cell = (MzzTDCustomerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell setBillData: [_model.list objectAtIndex:indexPath.item]];

    cell.MzzTDCustomerCellBlock = ^(UIImageView *imgV,SPUserModel *model) {
        _userModel.isSelected = NO;
        model.isSelected = YES;
        _userModel = model;
        [_collectionView reloadData];
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

