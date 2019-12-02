//
//  MzzTDJoinListController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTDJoinListController.h"
#import "ShareWorkInstance.h"
#import "SPRequest.h"
#import "SPGetStoreModel.h"
#import "MzzTDCustomerController.h"
#import "MzzSelectButtom.h"
#define LineH 20
#define LIneMarge 15
@interface MzzTDJoinListController ()
@property (nonatomic ,strong)SPGetStoreModel *getStoreModel;
@property (nonatomic ,strong)MzzSelectButtom *currentBtn;
@end

@implementation MzzTDJoinListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self creatNav];
    [self.navView setNavViewTitle:@"会员调店审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self requsetNet];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"会员调店审批" withleftImageStr:@"back" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)requsetNet{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    params[@"token"] = @"6f37c20a0ca26bc82f9533203f79afc6";
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"fram_id"] = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    [SPRequest requestGetStoreParams:params resultBlock:^(SPGetStoreModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _getStoreModel = model;
        [self setupUI];
    }];
}

- (void)setupUI{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH , 42)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(14, 8, 150, 20)];
    title.textColor = kColor3;
    title.font = FONT_SIZE(16);
    [title setText:@"选择调出门店"];
    [backView addSubview:title];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, backView.width, kSeparatorHeight)];
    [line setBackgroundColor:kSeparatorColor];
    [backView addSubview:line];
    CGFloat scrollH = 0;
    CGFloat costH = SCREEN_HEIGHT - 68 - line.y;
    if ( costH< _getStoreModel.list.count * LineH + (_getStoreModel.list.count +1 ) * LIneMarge) {
        scrollH = costH;
    }else{
        scrollH = _getStoreModel.list.count * LineH + (_getStoreModel.list.count +1 ) * LIneMarge;
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, backView.y + backView.height, SCREEN_WIDTH, scrollH)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollH);
    [self.view addSubview:scrollView];
    
    for (int i = 0; i<_getStoreModel.list.count; i++) {
        SPStoreModel *storeModel = [_getStoreModel.list objectAtIndex:i];
        MzzSelectButtom *tiaochu = [MzzSelectButtom buttonWithType:UIButtonTypeCustom];
        tiaochu.tag = i;
        [tiaochu setTitle:storeModel.name forState:UIControlStateNormal];
        [tiaochu setImage:[UIImage imageNamed:@"syspyyzhifuxuanzeweixuan"] forState:UIControlStateNormal];
        [tiaochu setTitle:storeModel.name forState:UIControlStateSelected];
        [tiaochu setImage:[UIImage imageNamed:@"syspyyzhifuxuanze"] forState:UIControlStateSelected];
        [tiaochu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tiaochu.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [tiaochu setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
        tiaochu.frame = CGRectMake(15, LIneMarge + i *(LineH + LIneMarge), 200, LineH);
        tiaochu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [tiaochu addTarget:self action:@selector(tiaochuOnclick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            _currentBtn = tiaochu;
            [_currentBtn setSelected:YES];
        }
        [scrollView addSubview:tiaochu];
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 68, SCREEN_WIDTH, 68)];
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
    if (!_currentBtn) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择"];
        return;
    }
    SPStoreModel *storeModel = [_getStoreModel.list objectAtIndex:_currentBtn.tag];
    MzzTDCustomerController *customerVc = [[MzzTDCustomerController alloc] init];
    [customerVc getStoreData:storeModel];
    [self.navigationController pushViewController:customerVc animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
