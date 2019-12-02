//
//  MzzCustomerDetailsController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzCustomerDetailsController.h"
#import "MzzCustomerDetailsHeaderView.h"
#import "MzzShijianCardCell.h"
#import "MzzBillController.h"
#import "MzzSelectorCell.h"
#import "MzzGenjinViewController.h"
#import "MzzGuKeChuFangCell.h"
#import "MzzXiaoFeiJiLuCell.h"
#import "MzzXiaoHaoJiLuCell.h"
#import "MzzChuZhiCardCell.h"
#import "MzzRenXuanCell.h"
#import "MzzXiangMuCell.h"
#import "MzzCustomerRequest.h"
#import "MzzUserInfoModel.h"
#import "ShareWorkInstance.h"
#import "MzzChanpinCell.h"
#import "MzzPiaoquanCell.h"
#import "MzzZhanghuCell.h"
#import "BeautyRequest.h"
#import "MzzUserInfoModel.h"
#import "MzzUser_salesModel.h"
#import "MzzConsumptionListModel.h"
#import "MzzConsumption_salesListModel.h"
#import "MzzPujiModel.h"
#import "MzzPujiCell.h"
#import "MzzPujiDetailController.h"
#import "MzzXiaoFeiYinDaoController.h"
#import "MzzJiSuanViewController.h"
#import "ChuFangDetailViewController.h"
#import "UserManager.h"
#import "MzzPortraitView.h"
#import "MzzAddPortraitViewController.h"
#import "MzzMessageTwoSectionCell.h"
#import "MzzSelectModel.h"
#import "MzzPortraitModel.h"
#import "MzzIndicatorsViewController.h"

typedef NS_ENUM(NSUInteger){
    MzzGukexinxi,
    MzzChuzhiCard,
    MzzRenxuanCard,
    MzzShiJianCard,
    MzzXiangmuCard,
    MzzChanPinCard,
    MzzPiaoQuanCard,
    MzzZhangHuCard,
    MzzTicketCouponCard,
    
    MzzChuFang,
    MzzXiaoFeiJiLu,
    MzzXiaoHaoJiLu,
    MzzKaXiangPuJi,
}CellType;

@interface MzzCustomerDetailsController ()<UITableViewDelegate,UITableViewDataSource,MzzCustomerDetailsHeaderViewDelegate>


@property (nonatomic ,strong)UICollectionViewFlowLayout *scrollLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (nonatomic ,strong)NSArray *dataList;
@property (nonatomic ,strong)UICollectionView *scrollview;
@property (weak, nonatomic) IBOutlet UITableView *cardTableView;
@property (weak,nonatomic)MzzCustomerDetailsHeaderView *headerView;
@property (assign , nonatomic)CGFloat height;
//记录index
@property (assign , nonatomic)NSInteger index1;
@property (assign , nonatomic)NSInteger index2;
@property (assign ,nonatomic)CellType cellType;

@property (nonatomic ,strong)MzzUserInfoModel *userInfoModel;
@property (nonatomic ,strong)MzzUser_salesModel *user_salesModel;
@property (nonatomic ,strong)MzzPortraitModel *user_PortraitModel;
@property (nonatomic ,strong)MzzSelectModel *selectModel;
@property (nonatomic ,strong)GuKeChuFangList *guKeChuFangModel;
@property (nonatomic ,strong)MzzConsumption_salesListModel *consumption_salesListModel;
@property (nonatomic ,strong)MzzConsumptionListModel *consumptionListModel;
@property (nonatomic ,strong)PujiModel *pujiModel;
@property (nonatomic ,strong)NSMutableArray *kaleipuji;
@property (nonatomic ,strong)NSMutableArray *ishave;
@property (nonatomic ,copy)NSString *kaxiangpuji;
@property (nonatomic ,copy)NSString *xiangmupuji;
@property (nonatomic ,copy)NSString *chanpinpuji;
@property (nonatomic ,assign)int sectionOneHeight;//第一个section的高度
@property (nonatomic ,assign)BOOL isSelect;//第一个section是否展开
@property (nonatomic ,assign)int sectionTneHeight;//第二个section的高度

@property (nonatomic ,copy)UIView *twoSectionView;//第二个section的heard
@property (nonatomic ,copy)UIScrollView *titleScrollView;
@property (nonatomic ,copy)UILabel *titleLable;
@property (nonatomic ,copy)NSArray *twoCellArray;//第二个section的数据
@property (nonatomic ,assign)NSInteger btnSelect;//第二个section的heard标题哪个被选中

@property (nonatomic ,assign) BOOL refreshStatus;
@property (nonatomic ,assign) BOOL clickmore;
@property (nonatomic ,assign)int oneheight;
@end

@implementation MzzCustomerDetailsController
{
    UIView * _line;
    UIView *toplineVivew;
    UIView *botomlineVivew;
    BOOL isSucessTitle;
}
static NSString *reuseIdentifier = @"reuseIdentifier";
static NSString *sReuseIdentifier = @"sReuseIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionOneHeight = 100;
    WeakSelf
    self.navView.NavViewRightBlock = ^{
        MzzXiaoFeiYinDaoController *vc = [[MzzXiaoFeiYinDaoController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    };
    _navHeight.constant = Heigh_Nav;
    [self creatHeaderWithHeight:0];
    
    [self.navView setNavViewTitle:@"顾客详情" backBtnShow:YES rightBtnTitle:@"消费引导"];
    [self.view bringSubviewToFront:_cardTableView];
}
-(NSArray *)twoCellArray
{
    if (!_twoCellArray) {
        _twoCellArray = [NSArray array];
    }
    return _twoCellArray;
}
//身体信息sectionView
-(UIView *)twoSectionView
{
    if (!_twoSectionView) {
        _twoSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
        _twoSectionView.backgroundColor=[UIColor whiteColor];
        UIView *lineVivew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineVivew.backgroundColor = kBackgroundColor;
        [_twoSectionView addSubview:lineVivew];
        [_twoSectionView addSubview:self.titleLable];
        [_twoSectionView addSubview:self.titleScrollView];
        
    }
    return _twoSectionView;
}
//身体信息标题
-(UIScrollView *)titleScrollView
{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame: CGRectMake(0, 54, SCREEN_WIDTH, 44)];
        _titleScrollView.backgroundColor=[UIColor whiteColor];
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        toplineVivew = [[UIView alloc]init];
        toplineVivew.backgroundColor = kBackgroundColor;
        [_titleScrollView addSubview:toplineVivew];
        botomlineVivew = [[UIView alloc]init];
        botomlineVivew.backgroundColor = kBackgroundColor;
        [_titleScrollView addSubview:botomlineVivew];
        UIView *redLine = [[UIView alloc]initWithFrame:CGRectMake(0, 41, 25, 2)];
        redLine.backgroundColor = kBtn_Commen_Color;
        _line = redLine;
        [_titleScrollView addSubview:redLine];
    }
    return _titleScrollView;
}

/**
 网络请求结束后刷新身体信息sectionView
 */
-(void)refreshView{
    toplineVivew.frame = CGRectMake(0, 0, _user_PortraitModel.list.count/5.0*SCREEN_WIDTH, 1);
    botomlineVivew.frame = CGRectMake(0, 43, _user_PortraitModel.list.count/5.0*SCREEN_WIDTH, 1);
    _titleScrollView.contentSize=CGSizeMake(_user_PortraitModel.list.count/5.0*SCREEN_WIDTH, 0);
    for (int i = 0; i < _user_PortraitModel.list.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*i, 0, SCREEN_WIDTH/5, 40)];
        NSString *title = [NSString stringWithFormat:@"%@",_user_PortraitModel.list[i].parts_name];
        NSLog(@".......%@",title);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(14);
        if (isSucessTitle == NO) {
            [self.titleScrollView addSubview:btn];
        }
        btn.tag = 100+i;
        if (i == 0) {
            [self change: btn];
        }
        [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)change:(id)sender{
    _sectionTneHeight = 0;
    UIButton *btn = (UIButton *)sender;
    for (int i=0; i<_user_PortraitModel.list.count; i++) {
        UIButton *btn =  [_titleScrollView viewWithTag:100+i];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    }
    UIButton *selectBtn =[_titleScrollView viewWithTag:btn.tag];
    [selectBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    _twoCellArray =_user_PortraitModel.list[btn.tag - 100].content_list;
    for (int i=0; i<_twoCellArray.count; i++) {
        MzzPortraitListModel *model= _twoCellArray[i];
        if (model.is_select == 1) {
            _sectionTneHeight += 68;
        }else{
            _sectionTneHeight += 48;
        }
    }
    //标题超出一个屏幕标题scrollview滚动
    if (selectBtn.tag>103) {
        _titleScrollView.contentOffset = CGPointMake(SCREEN_WIDTH/2+SCREEN_WIDTH/5*((selectBtn.tag - 100)-4), 44);
    }else{
        _titleScrollView.contentOffset = CGPointMake(0, 44);
    }
    _titleScrollView.contentSize=CGSizeMake(_user_PortraitModel.list.count/5.0*SCREEN_WIDTH, 0);
    _btnSelect=btn.tag-100;
    _line.centerX =selectBtn.centerX;
    [_cardTableView reloadData];
}

-(UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
        _titleLable.text = @"身体信息";
        _titleLable.textColor = kLabelText_Commen_Color_3;
        _titleLable.font = FONT_SIZE(15);
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}
- (IBAction)push:(UIButton *)sender {
    MzzGenjinViewController * vc = [[MzzGenjinViewController alloc] init];
    [vc setJis:_userInfoModel.jis andUser_id:[NSString stringWithFormat:@"%ld",_userInfoModel.ID] andUname:_userInfoModel.name];
    [self.navigationController pushViewController:vc animated:NO];
}

-(void )creatHeaderWithHeight:(CGFloat )height{
    
    if (height == 0) {
        height =555-54;
    }
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    backView.backgroundColor = [UIColor clearColor];
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MzzCustomerDetailsHeaderView" owner:nil options:nil] lastObject];
    [_headerView setindex1:_index1 andIndex2:_index2];
    [backView addSubview:_headerView];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    _headerView.delegate = self;
    if (height < 540) {
        [_headerView setOneCollection:YES];
    }
    if (_userInfoModel) {
        [_headerView setUserInfoModel:_userInfoModel];
    }
    _cardTableView.tableHeaderView  = backView;
    _cardTableView.backgroundColor = [UIColor clearColor];
    
    //    _cardTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [_cardTableView.mj_header endRefreshing];
    //    }];
    //    _cardTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    //        [_cardTableView.mj_footer endRefreshing];
    //    }];
}
-(void)customerdetailsHeaderView:(MzzCustomerDetailsHeaderView *)headView andIndex1:(NSInteger)index1 andIndex2:(NSInteger)index2{
    _index1 = index1;
    _index2 = index2;
}
- (void)customerdetailsHeaderView:(MzzCustomerDetailsHeaderView *)headView atCollectionView:(NSInteger)index onlickAtIndexPath:(NSIndexPath *)indexpath{
    if (index==0) {
        //点击的第一行
        if (indexpath.item == 1) {
            [self creatHeaderWithHeight:550];
        }else {
            [self creatHeaderWithHeight:555 - 54];
        }
        switch (indexpath.item) {
            case 0:{
                _cellType = MzzGukexinxi;
                
            }
                break;
            case 1:
                if (_index2 == 0) {
                    _cellType = MzzChuzhiCard;
                }else if (_index2 == 1) {
                    _cellType = MzzRenxuanCard;
                }else if (_index2 == 2) {
                    _cellType = MzzShiJianCard;
                }else if (_index2 == 3) {
                    _cellType = MzzXiangmuCard;
                }else if (_index2 == 4) {
                    _cellType = MzzChanPinCard;
                }else if (_index2 == 5) {
                    _cellType = MzzPiaoQuanCard;
                }else if (_index2 == 6) {
                    _cellType = MzzZhangHuCard;
                }
                break;
            case 2:
            {
                _cellType = MzzChuFang;
            }
                
                break;
            case 3:
            {
                _cellType = MzzXiaoFeiJiLu;
            }
                
                break;
            case 4:
            {
                _cellType = MzzXiaoHaoJiLu;
            }
                
                break;
            case 5:
            {
                _cellType = MzzKaXiangPuJi;
            }
                break;
                
            default:
                break;
        }
    }else{
        //点击的第二行
        [self creatHeaderWithHeight:550];
        switch ( indexpath.item) {
            case 0:
            {
                _cellType = MzzChuzhiCard;
            }
                break;
            case 1:
            {
                _cellType = MzzRenxuanCard;
            }
                break;
            case 2:
            {
                _cellType = MzzShiJianCard;
            }
                break;
            case 3:
            {
                _cellType = MzzXiangmuCard;
            }
                
                break;
            case 4:
            {
                _cellType = MzzChanPinCard;
            }
                
                break;
            case 5:
            {
                _cellType = MzzPiaoQuanCard;
            }
                
                break;
            case 6:
            {
                _cellType = MzzZhangHuCard;
            }
                
                break;
            case 7:
            {
                _cellType = MzzTicketCouponCard;
            }
                
                break;
        }
    }
    [self refreshData];
}
- (void)refreshData{
    switch (_cellType) {
        case MzzGukexinxi:
        {
            [self requsetPortrait];
        }
            break;
        case MzzChuFang:
        {
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
            params[@"user_id"] = _user_id;
            //顾客处方
            [[[BeautyRequest alloc] init] requestGuKeChuFang:_user_id resultBlock:^(GuKeChuFangList *guKeChuFangList, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _guKeChuFangModel = guKeChuFangList;
                    [_cardTableView reloadData];
                }
            }];
        }
            break;
        case MzzXiaoFeiJiLu:
        {
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
            params[@"user_id"] = _user_id;
            //消费记录
            [MzzCustomerRequest requestConsumptionSalesParams:params resultBlock:^(MzzConsumption_salesListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _consumption_salesListModel = model;
                    [_cardTableView reloadData];
                }
            }];
        }
            break;
        case MzzXiaoHaoJiLu:
        {
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
            params[@"user_id"] = _user_id;
            //消耗记录
            [MzzCustomerRequest requestConsumptionParams:params resultBlock:^(MzzConsumptionListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _consumptionListModel = model;
                    [_cardTableView reloadData];
                }
            }];
        }
            break;
        case MzzKaXiangPuJi:
        {
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
            params[@"user_id"] = _user_id;
            //卡项普及
            [MzzCustomerRequest requestCardPujiParams:params resultBlock:^(PujiModel *homeListModel, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _pujiModel = homeListModel;
                    _kaleipuji = [NSMutableArray array];
                    [_kaleipuji addObjectsFromArray:_pujiModel.card_time];
                    [_kaleipuji addObjectsFromArray:_pujiModel.card_exper];
                    [_kaleipuji addObjectsFromArray:_pujiModel.stored_card];
                    [_kaleipuji addObjectsFromArray:_pujiModel.card_num];
                    [_kaleipuji addObjectsFromArray:_pujiModel.card_course];
                    [_cardTableView reloadData];
                }
            }];
        }
            break;
        default:
        {
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
            params[@"user_id"] = _user_id;
            //顾客账单
            [MzzCustomerRequest requestUserSalesParams:params resultBlock:^(MzzUser_salesModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _user_salesModel = model;
                    [_cardTableView reloadData];
                }
            }];
        }
            break;
    }
}

-(void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"顾客详情" withleftImageStr:@"back" withRightStr:@"消费引导"];
    nav.btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnRight addTarget:self action:@selector(xiaofeiyindao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)xiaofeiyindao{
    MzzXiaoFeiYinDaoController *vc = [[MzzXiaoFeiYinDaoController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)followUpBtn:(UIButton *)sender {
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_cellType) {
        case MzzGukexinxi:
        {
            
            return self.sectionTneHeight;
        }
            break;
        case MzzShiJianCard:
        {
            
            return 140;
        }
            break;
        case MzzChuFang:
        {
            
            return 110;
        }
            break;
        case MzzXiaoFeiJiLu:
        {
            
            return 126;
        }
            break;
        case MzzChuzhiCard:
        {
            
            return 145;
        }
            break;
        case MzzXiaoHaoJiLu:
        {
            return 115;
        }
        case MzzRenxuanCard:
        {
            
            return 160;
        }
            break;
            
            break;
        case MzzXiangmuCard:
        {
            
            return 170;
        }
            break;
        case MzzChanPinCard:
        {
            return 190;
        }
            break;
        case MzzPiaoQuanCard:
        {
            return 175;
        }
            break;
        case MzzTicketCouponCard:
        {
            return 175;
        }
            break;
        case MzzZhangHuCard:
        {
            return 90;
        }
            break;
        case MzzKaXiangPuJi:
        {
            return 180;
        }
            break;
            
    }
    return 0;
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_cellType) {
        case MzzGukexinxi:
        {
            if (section == 0) {
                return 0;
            }else{
                return 1 ;//顾客身体信息列表
            }
        }
            break;
        case MzzChuzhiCard:
        {
            return _user_salesModel.stored_card.count;
        }
            break;
        case MzzRenxuanCard:
        {
            return _user_salesModel.card_num.count;
        }
            break;
        case MzzShiJianCard:
        {
            return _user_salesModel.card_time.count;
        }
            break;
        case MzzXiangmuCard:
        {
            return _user_salesModel.pro.count;
        }
            break;
        case MzzChanPinCard:
        {
            return  _user_salesModel.goods.count;
        }
            break;
        case MzzPiaoQuanCard:
        {
            return _user_salesModel.ticket.count;
        }
            break;
        case MzzZhangHuCard:
        {
            
            return _user_salesModel.bank.count;
        }
            break;
        case MzzTicketCouponCard:
        {
            
            return _user_salesModel.ticket_coupon.count;
        }
            break;
        case MzzChuFang:
        {
            return _guKeChuFangModel.list.count;
        }
            break;
        case MzzXiaoFeiJiLu:
        {
            return _consumption_salesListModel.list.count;
        }
            break;
        case MzzXiaoHaoJiLu:
        {
            return _consumptionListModel.list.count;
        }
            break;
            
        case MzzKaXiangPuJi:
        {
            return 3;
        }
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_cellType ==MzzGukexinxi ) {
        return 2;
    }
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        MzzPortraitView *portraitView = [[MzzPortraitView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.sectionOneHeight)withArray:_selectModel.list andWithSelect:self.isSelect];

        portraitView.cellCornerRadius = 5;
        
        WeakSelf;
        /**
         刷新顾客画像section的高度
         @param height 整个标签View的高度
         */
        portraitView.heightBlock = ^(int height) {
            NSLog(@",,,,,,%d",height);
            if (!self.clickmore) {
                if (height < 229) {
                    weakSelf.sectionOneHeight = height;
                }else{
                    weakSelf.sectionOneHeight = 229;
                }
                //判断获取到的collectionview的高度不相等时候刷新
                if (self.oneheight != self.sectionOneHeight) {
                    _refreshStatus = NO;
                }
                if (!_refreshStatus) {
                    _refreshStatus = YES;
                    [weakSelf.cardTableView reloadData];
                }
            }
        };
        
        portraitView.changeHeight = ^(int height, BOOL iselect) {
            self.clickmore = YES;
            self.isSelect = iselect;
            weakSelf.sectionOneHeight = height;
            [weakSelf.cardTableView reloadData];
        };
        /**
         跳转添加标签页面
         */
        portraitView.toPushAddPortrait = ^{
            MzzAddPortraitViewController *addPortraitVC = [[MzzAddPortraitViewController alloc]init];
            [addPortraitVC withUserId:_user_id andWithJsonCode:[ShareWorkInstance shareInstance].join_code andStroeCode:_store_code];
            [weakSelf.navigationController pushViewController:addPortraitVC animated:NO];
        };
        return portraitView;
    }else{
        
        return self.twoSectionView;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_cellType == MzzGukexinxi) {
        if (section == 0) {
            //self.oneheight标记动态获取到的collectionview的高度
            self.oneheight = self.sectionOneHeight;
            return self.sectionOneHeight;
        }else{
            return 98;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *shijiancell = @"shijiancard";
    static NSString *gukechufang = @"gukechufang";
    static NSString *xiaofei = @"xiaofeijilu";
    static NSString *xiaohao = @"xiaohaojilu";
    static NSString *chuzhicard = @"chuzhicard";
    static NSString *renxuan = @"renxuan";
    static NSString *xiangmu = @"xiangmu";
    static NSString *chanpin = @"chanpin";
    static NSString *piaoquan = @"piaoquan";
    static NSString *zhanghu = @"zhanghu";
    static NSString *puji = @"puji";
    WeakSelf;
    switch (_cellType) {
        case MzzGukexinxi:
        {
            MzzMessageTwoSectionCell * cell = [[MzzMessageTwoSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MzzMessageTwoSectionCell"];
            [cell cellWithModel:_user_PortraitModel andWithBtnSelect:_btnSelect andWithViewHeight:_sectionTneHeight];
            WeakSelf;
            cell.toIndicatorsVC = ^(NSString *title, NSString *reference, NSString *suggest, NSInteger ID) {
                MzzIndicatorsViewController *indicatorsVC = [[MzzIndicatorsViewController alloc] initWithNibName:@"MzzIndicatorsViewController" bundle:nil];
                indicatorsVC.uid = _user_id;
                indicatorsVC.joinCode = [ShareWorkInstance shareInstance].join_code;
                indicatorsVC.storeCode = _store_code;
                indicatorsVC.indexId = [NSString stringWithFormat:@"%ld",ID];
                [indicatorsVC indicatorsWithTitle:title andWithRefrence:reference andSuggest:suggest];
                [weakSelf.navigationController pushViewController:indicatorsVC animated:NO];
            };
            return cell;
        }
        case MzzChuzhiCard:
        {
            MzzChuZhiCardCell *cell = [tableView dequeueReusableCellWithIdentifier:chuzhicard];
            if (!cell)
            {
                cell = [[MzzChuZhiCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chuzhicard];
            }
            if (_user_salesModel) {
                MzzStored_CardModel *model = [_user_salesModel.stored_card objectAtIndex:indexPath.row];
                [cell setStoredModel:model];
            }
            return cell;
        }
        case MzzRenxuanCard:
        {
            MzzRenXuanCell *cell = [tableView dequeueReusableCellWithIdentifier:renxuan];
            if (!cell)
            {
                cell = [[MzzRenXuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:renxuan];
            }
            if (_user_salesModel){
                MzzCard_NumModel *model =[_user_salesModel.card_num objectAtIndex:indexPath.row];
                [cell setModel:model];
            }
            return cell;
        }
            break;
        case MzzShiJianCard:
        {
            MzzShijianCardCell *cell = [tableView dequeueReusableCellWithIdentifier:shijiancell];
            if (!cell)
            {
                cell = [[MzzShijianCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shijiancell];
            }
            if (_user_salesModel){
                MzzCard_TimeModel *model = [_user_salesModel.card_time objectAtIndex:indexPath.row];
                [cell setModel:model];
            }
            return cell;
        }
            break;
        case MzzXiangmuCard:
        {
            MzzXiangMuCell *cell = [tableView dequeueReusableCellWithIdentifier:xiangmu];
            if (!cell)
            {
                cell = [[MzzXiangMuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xiangmu];
            }
            if (_user_salesModel){
                MzzProModel *model = [_user_salesModel.pro objectAtIndex:indexPath.row];
                [cell setModel:model];
            }
            return cell;
        }
            break;
        case MzzChanPinCard:
        {
            MzzChanpinCell *cell = [tableView dequeueReusableCellWithIdentifier:chanpin];
            if (!cell)
            {
                cell = [[MzzChanpinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chanpin];
            }
            if (_user_salesModel){
                MzzGoodsModel *model = [_user_salesModel.goods objectAtIndex:indexPath.row];
                [cell setModel:model];
                [cell setUser_id:_user_id];
                [cell setReFresh:^{
                    [weakSelf refreshData];
                }];
            }
            return cell;
        }
            break;
        case MzzPiaoQuanCard:
        {
            MzzPiaoquanCell *cell = [tableView dequeueReusableCellWithIdentifier:piaoquan];
            if (!cell)
            {
                cell = [[MzzPiaoquanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:piaoquan];
            }
            if (_user_salesModel){
                MzzTicketModel *model = [_user_salesModel.ticket objectAtIndex:indexPath.row];
                [cell setModel:model];
                [cell setUser_id:_user_id];
                [cell setReFresh:^{
                    [weakSelf refreshData];
                }];
            }
            return cell;
        }
            break;
        case MzzTicketCouponCard:
        {
            MzzPiaoquanCell *cell = [tableView dequeueReusableCellWithIdentifier:piaoquan];
            if (!cell)
            {
                cell = [[MzzPiaoquanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:piaoquan];
            }
            if (_user_salesModel){
                MzzTicketCouponModel *model = [_user_salesModel.ticket_coupon objectAtIndex:indexPath.row];
                [cell updateCellModel:model];
//                [cell setModel:model];
//                [cell setUser_id:_user_id];
                [cell setReFresh:^{
                    [weakSelf refreshData];
                }];
            }
            return cell;
        }
            break;
        case MzzZhangHuCard:
        {
            MzzZhanghuCell *cell = [tableView dequeueReusableCellWithIdentifier:zhanghu];
            if (!cell)
            {
                cell = [[MzzZhanghuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:zhanghu];
            }
            if (_user_salesModel){
                MzzBankModel *model =[_user_salesModel.bank objectAtIndex:indexPath.row];
                [cell setModel:model];
            }
            return cell;
        }
            break;
            
        case MzzChuFang:
        {
            MzzGuKeChuFangCell *chufang = [tableView dequeueReusableCellWithIdentifier:gukechufang];
            if (!chufang)
            {
                chufang = [[MzzGuKeChuFangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gukechufang];
            }
            GuKeChuFang *model =  [_guKeChuFangModel.list objectAtIndex:indexPath.row];
            [chufang setModel:model];
            return chufang;
        }
            break;
        case MzzXiaoFeiJiLu:
        {
            MzzXiaoFeiJiLuCell *cell = [tableView dequeueReusableCellWithIdentifier:xiaofei];
            if (!cell)
            {
                cell = [[MzzXiaoFeiJiLuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xiaofei];
            }
            [cell setModel:[_consumption_salesListModel.list objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case MzzXiaoHaoJiLu:
        {
            MzzXiaoHaoJiLuCell *cell = [tableView dequeueReusableCellWithIdentifier:xiaohao];
            if (!cell)
            {
                cell = [[MzzXiaoHaoJiLuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xiaohao];
            }
            MzzConsumptionModel *model =  [_consumptionListModel.list objectAtIndex:indexPath.row];
            [cell setModel:model];
            return cell;
        }
            break;
        case MzzKaXiangPuJi:
        {
            switch (indexPath.row) {
                case 0:
                {
                    MzzPujiCell *pujiCell = [tableView dequeueReusableCellWithIdentifier:puji  forIndexPath:indexPath];
                    
                    NSInteger haveNum  = 0;
                    NSInteger num  = 0;
                    _ishave = [NSMutableArray array];
                    NSMutableArray *nothave = [NSMutableArray array];
                    for (int i = 0; i <_kaleipuji.count; i ++) {
                        num ++;
                        PujiCard *pujiCard = [_kaleipuji objectAtIndex:i];
                        if (pujiCard.is_have) {
                            [_ishave addObject:pujiCard];
                            haveNum ++;
                        }else{
                            [nothave addObject:pujiCard];
                        }
                    }
                    [_ishave addObjectsFromArray:nothave];
                    [pujiCell setCtArr:_ishave];
                    _kaxiangpuji =[NSString stringWithFormat:@"卡项普及(%ld/%ld)",haveNum,num];
                    [pujiCell.name setText:_kaxiangpuji];
                    return pujiCell;
                }
                    break;
                case 1:
                {
                    MzzPujiCell *pujiCell = [tableView dequeueReusableCellWithIdentifier:puji  forIndexPath:indexPath];
                    [pujiCell setCtArr:_pujiModel.pro];
                    NSInteger haveNum  = 0;
                    NSInteger num  = 0;
                    for (int i = 0; i <_pujiModel.pro.count; i ++) {
                        num ++;
                        PujiCard *pujiCard = [_pujiModel.pro objectAtIndex:i];
                        if (pujiCard.is_have) {
                            haveNum ++;
                        }
                    }
                    _xiangmupuji = [NSString stringWithFormat:@"项目普及(%ld/%ld)",haveNum,num];
                    [pujiCell.name setText:_xiangmupuji];
                    return pujiCell;
                }
                    break;
                case 2:
                {
                    MzzPujiCell *pujiCell = [tableView dequeueReusableCellWithIdentifier:puji  forIndexPath:indexPath];
                    [pujiCell setCtArr:_pujiModel.goods];
                    NSInteger haveNum  = 0;
                    NSInteger num  = 0;
                    for (int i = 0; i <_pujiModel.goods.count; i ++) {
                        num ++;
                        PujiCard *pujiCard = [_pujiModel.goods objectAtIndex:i];
                        if (pujiCard.is_have) {
                            haveNum ++;
                        }
                    }
                    _chanpinpuji = [NSString stringWithFormat:@"产品普及(%ld/%ld)",haveNum,num];
                    [pujiCell.name setText:_chanpinpuji];
                    return pujiCell;
                }
                    break;
            }
            
        }
            break;
    }
    MzzRenXuanCell *xiaohaoc = [tableView dequeueReusableCellWithIdentifier:renxuan  forIndexPath:indexPath];
    return xiaohaoc;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MzzBillController *billVc = [[MzzBillController alloc] init];
    billVc.user_id = _user_id;
    NSString *cardType;
    NSInteger cardID = -1;
    NSString *cardName;
    switch (_cellType) {
        case MzzGukexinxi:
        {

        }
            break;
        case MzzChuzhiCard:
        {
            MzzStored_CardModel *model = [_user_salesModel.stored_card objectAtIndex:indexPath.row];
            cardType = @"stored_card";
            cardID = model.user_card_id;
            cardName = model.stored_card_name;
        }
            break;
        case MzzRenxuanCard:
        {
            MzzCard_NumModel *model =[_user_salesModel.card_num objectAtIndex:indexPath.row];
            cardType = @"card_num";
            cardID = model.user_card_id;
            cardName = model.name;
        }
            break;
            
        case MzzShiJianCard:
        {
            MzzCard_TimeModel *model = [_user_salesModel.card_time objectAtIndex:indexPath.row];
            cardType = @"card_time";
            cardID = model.ID;
            cardName = model.name;
        }
            break;
        case MzzXiangmuCard:
        {
            MzzProModel *model = [_user_salesModel.pro objectAtIndex:indexPath.row];
            cardType = @"pro";
            cardID = model.pro_id;
            cardName = model.name;
        }
            break;
        case MzzChanPinCard:
        {
            MzzGoodsModel *model = [_user_salesModel.goods objectAtIndex:indexPath.row];
            cardType = @"goods";
            cardID = model.goods_id;
            cardName = model.name;
        }
            break;
        case MzzPiaoQuanCard:
        {
            MzzTicketModel *model = [_user_salesModel.ticket objectAtIndex:indexPath.row];
            cardType = @"ticket";
            cardID = model.ID;
            cardName = model.name;
        }
            break;
        case MzzZhangHuCard:
        {
            cardType = @"bank";
            //            if (_user_salesModel.bank.count > 0) {
            MzzBankModel *bank = [_user_salesModel.bank objectAtIndex:indexPath.row];
            cardID =  bank.ID;
            //            }
        }
            break;
        case MzzTicketCouponCard: {
            return;
            break;
        }
        case MzzChuFang:
        {
            GuKeChuFang *chufang =[_guKeChuFangModel.list objectAtIndex:indexPath.row];
            ChuFangDetailViewController *vc = [[ChuFangDetailViewController alloc]init];
            LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
            NSString    *token = model.data.token;
            vc.billNum = chufang.ordernum;
            vc.token = token;
            [self.navigationController pushViewController:vc animated:NO];
            return;
        }
            break;
        case MzzXiaoFeiJiLu:
        {
            MzzConsumption_salesModel *model =  [_consumption_salesListModel.list objectAtIndex:indexPath.row];
            MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
            if ([model.jump_type isEqualToString:@"sales"]) {
                [vc setOrderNum:model.ordernum andYemianStyle:YemianXiangQing andType:model.type andUid:[NSString stringWithFormat:@"%@",model.uid] withName:nil];
            }else if ([model.jump_type isEqualToString:@"serv"]){
                [vc setOrderNum:model.ordernum andZt:@"2"];
            }else{
                
            }
            [self.navigationController pushViewController:vc animated:NO];
            return;
        }
            break;
        case MzzXiaoHaoJiLu:
        {
            MzzConsumptionModel *model =  [_consumptionListModel.list objectAtIndex:indexPath.row];
            MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
            [vc setOrderNum:model.ordernum andZt:@"1"];
            [self.navigationController pushViewController:vc animated:NO];
            return;
        }
    
        case  MzzKaXiangPuJi:
        {
            MzzPujiDetailController *vc = [[MzzPujiDetailController alloc] init];
            switch (indexPath.row) {
                case 0:
                {
                    [vc setupPujiArr:_ishave andTitle:_kaxiangpuji];
                }
                    break;
                case 1:
                {
                    [vc setupPujiArr:_pujiModel.pro andTitle:_xiangmupuji];
                }
                    break;
                case 2:
                {
                    [vc setupPujiArr:_pujiModel.goods andTitle:_chanpinpuji];
                }
                    break;
            }
            [self.navigationController pushViewController:vc animated:NO];
            return;
        }
            break;
    }
    
    [billVc setUserID:_userInfoModel.ID andType:cardType andTypeID:cardID andCardName:cardName];
    [self.navigationController pushViewController:billVc animated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requsetData];
    [self requsetPortrait];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _refreshStatus =  NO;
    _clickmore = NO;
}
#pragma mark -- 数据请求相关
-(void)requsetData{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"user_id"] = _user_id;
    
    //网络请求
    [MzzCustomerRequest requestUserInfoParams:params resultBlock:^(MzzUserInfoModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            //刷新上面信息
            _userInfoModel = model;
            [_headerView setUserInfoModel:model];
        }
    }];
}

-(void)requsetPortrait{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"user_id"] = _user_id;
    params[@"store_code"] = _store_code;
    WeakSelf;
    
    //顾客身体信息
    [MzzCustomerRequest requestPortraitSalesParams:params resultBlock:^(MzzPortraitModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _user_PortraitModel = model;
            [weakSelf refreshView];
            isSucessTitle = YES;
        }
    }];
    //顾客画像
    [MzzCustomerRequest requestSelectParams:params resultBlock:^(MzzSelectModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _selectModel = model;
        [weakSelf.cardTableView reloadData];
    }];
}

@end
