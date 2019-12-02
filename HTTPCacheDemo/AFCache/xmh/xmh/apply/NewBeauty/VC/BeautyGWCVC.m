//
//  BeautyGWCVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyGWCVC.h"
#import "choiseCustomerHeader.h"
#import "BeautyCardCell.h"
#import "BeautySubCell.h"
#import "BeautyDesignDownView.h"
#import "BeautyGouWuCheView.h"
#import "BeautyDesignFourthViewController.h"
#import "BeautyRequest.h"
#import "LiaoChengXiangMuList.h"
#import "LiaoChengXiangMuModel.h"
#import "LiaoChengXiangMuInfo.h"
#import "JasonSearchView.h"
#import "ThrowLineTool.h"
#import "BeautyCardModel.h"
#import "ShareWorkInstance.h"
#import <objc/runtime.h>
#import "BeautyDesignMethod.h"
#import "BeautyDesignRightSectionHeader.h"
#import "BeautyProjectModel.h"
#import "ShareWorkInstance.h"
#import "BeautyGWCCommitVC.h"
#import "BeautyProgressView.h"
typedef NS_ENUM(NSInteger, BeautyCardType) {
    Card_time_type,
    Card_num_type,
    Card_sorde_type
};
@interface BeautyGWCVC ()<UITableViewDelegate,UITableViewDataSource,ThrowLineToolDelegate>{
    UITableView *_tbLeftView;
    UITableView *_tbRighView;
    choiseCustomerHeader *_tbHeaderView;
    CGFloat _tbRighViewWidth;
    BeautyDesignDownView *_downView;
    BeautyGouWuCheView *_gouWuCheView;
    
    UIView  *_searchBG;
    
    UILabel * _lb1;
    UIButton *_btn1;
    UILabel * _lb2;
    UIButton *_btn2;
    UIView * _indicate1;
    UIView * _indicate2;
    UIImageView *_xiala;
    UIImage     *_xialaImage;
    UIImage     *_shangImage;
    UIImage     *_sanjiaoImage;
    UIImageView *_sanjiaoImageView;
    UIImageView *_line2;
    BOOL      _btn1Selected;
    BOOL      _btn2Selected;
    
    BeautyRequest       *_liaoChengXiangMuRequest;
    JasonSearchView     *_searchView;
    NSIndexPath         *_lastindexPath;
    BeautyCardModel     *_beautyCardModel;
    BeautyRequest       *_beautyCardRequest;
    
    NSArray      *_liaoChengXiangMuList;
    NSArray      *_arrLeftCard_time;
    NSArray      *_arrLeftCard_num;
    NSArray      *_arrLeftStore_card;
    
    NSMutableArray      *_CommitLiaoChengXiangMu;
    NSMutableArray      *_CommitCard_time;
    NSMutableArray      *_CommitCard_num;
    NSMutableArray      *_CommitStore_card;
    
//    NSArray             *_arrRightSource;
    NSString            *_leftCellTitle;
    
    BeautyDesignRightSectionHeader *rightHeader;
    
    BeautyCardType      _cardType;
    
    //sectionheader赋值用到
    Card_Time   *_cardtimeModel;
    Card_Num    *_cardnumModel;
    Stored_Card *_storedModel;
    
    NSInteger   _storedPrice;
    
    NSMutableArray  *_searchArr;//搜索数据
    
    BOOL _isSearch;
    
}
@property (nonatomic, strong)NSArray * arrRightSource;
/** 搜索结果数据 */
@property (nonatomic, strong)NSMutableArray * searchResultArr;
/** 原始数据数据 */
@property (nonatomic, strong)NSMutableArray * sourceData;
/** 搜索 */
@property (nonatomic, assign) BOOL isSureSearch;
@property (nonatomic, strong)UITableView *tbRighView;
@property (nonatomic, strong)BeautyProgressView * beautyProgressView;
@property (nonatomic, assign)NSInteger ywlMaxNum;
@property (nonatomic, strong)NSMutableArray * ywlArr;
@end

@implementation BeautyGWCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    _tbRighViewWidth = (SCREEN_WIDTH - 130*WIDTH_SALE_BASE);
    _ywlArr = [[NSMutableArray alloc] init];
    _CommitLiaoChengXiangMu = [[NSMutableArray alloc]init];
    _CommitCard_time = [[NSMutableArray alloc]init];
    _CommitCard_num = [[NSMutableArray alloc]init];
    _CommitStore_card = [[NSMutableArray alloc]init];
    _searchArr = [[NSMutableArray alloc]init];
    
    _CommitCard_time  = [[NSMutableArray alloc]init];
    _CommitCard_num  = [[NSMutableArray alloc]init];
    _CommitStore_card  = [[NSMutableArray alloc]init];
    
    _liaoChengXiangMuRequest = [[BeautyRequest alloc] init];
    _beautyCardRequest = [[BeautyRequest alloc]init];
    
    _searchResultArr = [[NSMutableArray alloc] init];
    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
    if (!arr) {
        arr = [[NSMutableArray alloc]init];
    } else{
        [arr removeAllObjects];
    }
    [ShareWorkInstance shareInstance].BeautyProjectList = arr;
    _btn1Selected = YES;
    _btn2Selected = NO;
    _xialaImage = [UIImage imageNamed:@"changguitika_jiantou-1"];
    _shangImage = [UIImage imageNamed:@"gengduo"];
    _sanjiaoImage = [UIImage imageNamed:@"beautysanjiao"];
    [ThrowLineTool sharedTool].delegate = self;
    [self creatNav];
    [self initSubviews];
}
- (void)creatNav{
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"美丽定制" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
//    nav.backgroundColor = kBtn_Commen_Color;
//    nav.lbTitle.textColor = [UIColor whiteColor];
//    [nav.btnRight addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
//    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
    
    [self.navView setNavViewTitle:@"美丽定制" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
}
- (BeautyProgressView *)beautyProgressView
{
    if (!_beautyProgressView) {
        _beautyProgressView = loadNibName(@"BeautyProgressView");
        _beautyProgressView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100);
    }
    return _beautyProgressView;
}
- (void)initSubviews{
    WeakSelf
    _tbHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"choiseCustomerHeader" owner:nil options:nil] firstObject];
    _tbHeaderView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 105);
//    [_tbHeaderView reFreshchoiseCustomerHeader:3];
//    [self.view addSubview:_tbHeaderView];
    [self.view addSubview:self.beautyProgressView];
    [_beautyProgressView updateBeautyProgressViewIndex:3];
    
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, _beautyProgressView.bottom, SCREEN_WIDTH, kSeparatorHeight);
    line.backgroundColor = kColorE5E5E5;
    
    _tbLeftView = [[UITableView alloc] initWithFrame:CGRectMake(0, line.bottom ,130*WIDTH_SALE_BASE,SCREEN_HEIGHT - line.bottom-50) style:UITableViewStylePlain];
    _tbLeftView.separatorColor = [UIColor clearColor];
    _tbLeftView.backgroundColor = kBackgroundColor;
    _tbLeftView.delegate = self;
    _tbLeftView.dataSource = self;
    [self.view addSubview:_tbLeftView];
    
    _searchBG = [[UIView alloc]initWithFrame:CGRectMake(_tbLeftView.right, _tbLeftView.top, _tbRighViewWidth, 60)];
    _searchBG.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchBG];
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 10 ,_tbRighViewWidth, 45)withPlaceholder:@"请输入要查询的商品"];
    _searchView.line1.hidden = YES;
    _searchView.searchBar.layer.masksToBounds = YES;
    _searchView.searchBar.layer.cornerRadius = _searchView.searchBar.height/2;
    _searchView.searchBar.backgroundColor = kBackgroundColor;
    [_searchBG addSubview:_searchView];
    
    __block JasonSearchView    *tempsearchView = _searchView;
    
        _searchView.searchBar.btnRightBlock = ^{
             __block NSMutableArray *tempOrginArr = weakSelf.sourceData;
            [weakSelf.searchResultArr removeAllObjects];
            for (int i = 0; i < tempOrginArr.count; i ++) {
                id model1 = tempOrginArr[i];
                if ([model1 isKindOfClass:[LiaoChengXiangMuModel class]]) {
                    LiaoChengXiangMuModel * model = (LiaoChengXiangMuModel *)model1;
                    if ([model.info.name containsString:tempsearchView.searchBar.text]) {
                        [weakSelf.searchResultArr addObject:model];
                    }
                }
                if ([model1 isKindOfClass:[BeautyCardRange class]]) {
                    BeautyCardRange * model = (BeautyCardRange *)model1;
                    if ([model.name containsString:tempsearchView.searchBar.text]) {
                        [weakSelf.searchResultArr addObject:model];
                    }
                }
                
                if (tempsearchView.searchBar.text.length > 0) {
                    weakSelf.arrRightSource = weakSelf.searchResultArr;
                }else{
                    weakSelf.arrRightSource = tempOrginArr;
                }
                
            }
            [weakSelf.tbRighView reloadData];
        };
        _searchView.searchBar.btnleftBlock = ^{
            [weakSelf.tbRighView reloadData];
        };
    
    _tbRighView = [[UITableView alloc] initWithFrame:CGRectMake(_tbLeftView.right,_searchBG.bottom -10,_tbRighViewWidth,_tbLeftView.height - 70 + 10) style:UITableViewStylePlain];
    _tbRighView.separatorColor = [UIColor clearColor];
    _tbRighView.backgroundColor = [UIColor whiteColor];
    _tbRighView.delegate = self;
    _tbRighView.dataSource = self;
    [self.view addSubview:_tbRighView];
    
    _downView = [[[NSBundle mainBundle]loadNibNamed:@"BeautyDesignDownView" owner:nil options:nil] firstObject];
    _downView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
    [_downView reFreshBeautyDesignDownView:[ShareWorkInstance shareInstance].BeautyProjectList.count];
    [_downView.btn2 addTarget:self action:@selector(GouWuCheEvent) forControlEvents:UIControlEventTouchUpInside];
    [_downView.btn1 addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downView];
    [self requestNetData];
}
- (UIImageView *)redView
{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.backgroundColor = kBtn_Commen_Color;
        UILabel *lb = [[UILabel alloc]init];
        lb.text = @"1";
        lb.font = FONT_BOLD_SIZE(11);
        lb.textColor = [UIColor whiteColor];
        [lb sizeToFit];
        lb.frame = CGRectMake((20-lb.width)/2.0, (20-lb.height)/2.0, lb.width, lb.height);
        [_redView addSubview:lb];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}

- (void)GouWuCheEvent{
    WeakSelf
    if (!_gouWuCheView) {
        _gouWuCheView = [[[NSBundle mainBundle]loadNibNamed:@"BeautyGouWuCheView" owner:nil options:nil] firstObject];
        _gouWuCheView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        [self.view addSubview:_gouWuCheView];
    }else{
        _gouWuCheView.hidden = !_gouWuCheView.hidden;
    }
    __block BeautyDesignDownView *tempdownView = _downView;
    __block UITableView *tempRightTb = _tbRighView;
    
    __block NSArray *templiaoChengXiangMuList = _liaoChengXiangMuList;
    __block NSArray *tempTimeList = _arrLeftCard_time;
    __block NSArray *tempCardNumList = _arrLeftCard_num;
    __block NSArray *tempStoreList = _arrLeftStore_card;
    
    
    _gouWuCheView.BeautyGouWuCheViewDelBlock = ^{
        [tempdownView reFreshBeautyDesignDownView:0];
        
        for (LiaoChengXiangMuModel *liaochengmodel in templiaoChengXiangMuList) {
            liaochengmodel.numDisplay = 0;
        }
        for (Card_Time *timeModel in tempTimeList) {
            for (BeautyCardRange *range in timeModel.info.range) {
                range.numDisplay = 0;
            }
        }
        for (Card_Num *numModel in tempCardNumList) {
            for (BeautyCardRange *temprange in numModel.info.range) {
                temprange.numDisplay = 0;
            }
        }
        for (Stored_Card *storeModel in tempStoreList) {
            for (BeautyCardRange *range in storeModel.info.range) {
                range.numDisplay = 0;
            }
        }
        [tempRightTb reloadData];
    };
    __block BeautyGouWuCheView *TempgouWuCheView = _gouWuCheView;
    
    _gouWuCheView.BeautGouWuCheAddBlock = ^(BeautyProjectModel *model) {
        if (model.pro) {
            for (LiaoChengXiangMuModel *liaochengmodel in templiaoChengXiangMuList) {
                if ((model.outsideID == liaochengmodel.uid) && (model.insideID == liaochengmodel.info.uid)) {
                    if (model.num < liaochengmodel.num) {
                        model.num++;
                        liaochengmodel.numDisplay = model.num;
                    }else{
//                        [MzzHud toastWithTitle:@"温馨提示" message:@"次数不足，请重新选择"];
                        [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有此处，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }]show];
                    }
                    break;
                }
            }
        }
        if (model.time) {
            for (Card_Time *timeModel in tempTimeList) {
                if (model.ID == timeModel.ID) {
                    for (BeautyCardRange *range in timeModel.info.range) {
                        if (model.rights == range.rights) {
                            model.num ++ ;
                            range.numDisplay = model.num;
                            break;
                        }
                    }
                }
            }
        }
        
        if (model.numType) {
            for (Card_Num *numModel in tempCardNumList) {
                if ([model.ordernum isEqualToString:numModel.ordernum]) {
                    for (BeautyCardRange *temprange in numModel.info.range) {
                        if (temprange.rights == model.rights) {
                            NSInteger fixed = temprange.fixed;
                            NSInteger max_num = temprange.max_num;
//                            NSInteger numType = temprange.num;
                            NSInteger canUseNum = 0;
                            if (fixed == 0) {
                                
                                if (max_num > _cardnumModel.num - _cardnumModel.num1) {
                                    canUseNum = _cardnumModel.num - _cardnumModel.num1;
                                }else{
                                    canUseNum = max_num;
                                }
                                if (temprange.numDisplay >= canUseNum) {
                                    //                            [MzzHud toastWithTitle:@"温馨提示" message:@"本项目次数不足"];
                                    [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有次数，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                                        
                                    }]show];
                                    return ;
                                }
                                
                            }else if (fixed == 1){
                                NSInteger numTotal = numModel.num - numModel.num1;
//                                NSInteger shengyuNum_max = 0;
//                                NSInteger fix0deNum = 0;
//                                NSInteger fix1deUsedNum = 0;
                                canUseNum = numTotal;
                                if (temprange.numDisplay >= canUseNum) {
                                    [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有次数，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                                        
                                    }]show];
                                    return;
                                }
                            }
                            if(![weakSelf addModel:temprange]){
                                [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有次数，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                                    
                                }]show];
                                return;
                            }
                            model.num ++ ;
                            temprange.numDisplay = model.num;
                            
                            break;
                        }
                    }
                    break;
                }
            }
        }
        
        if (model.stored) {
            for (Stored_Card *storeModel in tempStoreList) {
                if (storeModel.ID == model.ID) {
                    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
                    NSInteger totalPrice = 0;
                    for ( BeautyProjectModel *tempModel in arr) {
                        if (tempModel.ID == model.ID)
                        {
                            totalPrice += tempModel.price*tempModel.num;
                        }
                    }
                    if (totalPrice+model.price > [storeModel.money integerValue]) {
//                        [MzzHud toastWithTitle:@"温馨提示" message:@"金额不足，请重新选择"];
                        [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客已有卡项金额，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }]show];
                        return ;
                    }
                    for (BeautyCardRange *range in storeModel.info.range) {
                        if (model.rights == range.rights) {
                            model.num ++ ;
                            range.numDisplay = model.num;
                            break;
                        }
                    }
                }
            }
        }
        
        [tempRightTb reloadData];
        [TempgouWuCheView refreshBeautyGouWuCheView];
        [tempdownView reFreshBeautyDesignDownView:[ShareWorkInstance shareInstance].BeautyProjectList.count];
    };
    _gouWuCheView.BeautGouWuCheReduceBlock = ^(BeautyProjectModel *model) {
        if (model.pro) {
            for (LiaoChengXiangMuModel *liaochengmodel in templiaoChengXiangMuList) {
                if ((model.outsideID == liaochengmodel.uid) && (model.insideID == liaochengmodel.info.uid)) {
                    model.num--;
                    liaochengmodel.numDisplay = model.num;
                    if (model.num == 0) {
                        NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
                        [arr removeObject:model];
                        [ShareWorkInstance shareInstance].BeautyProjectList = arr;
                    }
                    break;
                }
            }
        }
        if (model.time) {
            for (Card_Time *timeModel in tempTimeList) {
                if (model.ID == timeModel.ID) {
                    for (BeautyCardRange *range in timeModel.info.range) {
                        if (model.rights == range.rights) {
                            model.num -- ;
                            range.numDisplay = model.num;
                            if (model.num == 0) {
                                NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
                                [arr removeObject:model];
                                [ShareWorkInstance shareInstance].BeautyProjectList = arr;
                            }
                            break;
                        }
                    }
                }
            }
        }
        
        if (model.numType) {
            for (Card_Num *numModel in tempCardNumList) {
                if ([model.ordernum isEqualToString:numModel.ordernum]) {
                    for (BeautyCardRange *range in numModel.info.range) {
                        if (range.rights == model.rights) {
                            model.num -- ;
                            range.numDisplay = model.num;
                            if (model.num == 0) {
                                NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
                                [arr removeObject:model];
                                [ShareWorkInstance shareInstance].BeautyProjectList = arr;
                            }
                            break;
                        }
                    }
                    break;
                }
            }
        }
        
        if (model.stored) {
            for (Stored_Card *storeModel in tempStoreList) {
                if (model.ID == storeModel.ID) {
                    for (BeautyCardRange *range in storeModel.info.range) {
                        if (model.rights == range.rights) {
                            model.num -- ;
                            range.numDisplay = model.num;
                            if (model.num == 0) {
                                NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
                                [arr removeObject:model];
                                [ShareWorkInstance shareInstance].BeautyProjectList = arr;
                            }
                            break;
                        }
                    }
                }
            }
        }
        [tempRightTb reloadData];
        [TempgouWuCheView refreshBeautyGouWuCheView];
        [tempdownView reFreshBeautyDesignDownView:[ShareWorkInstance shareInstance].BeautyProjectList.count];
    };
    [_gouWuCheView refreshBeautyGouWuCheView];
}
- (void)nextEvent{
    
    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
    if (arr.count == 0) {
        [MzzHud toastWithTitle:@"" message:@"请先选择商品"];
        return;
    }
    
    NSMutableDictionary *plan = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *timedic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *storeddic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *prodic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *numdic = [[NSMutableDictionary alloc]init];
    
    for (BeautyProjectModel *model in arr) {
        if (model.pro) {
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
            [dic1 setValue:[NSString stringWithFormat:@"%@",@(model.outsideID)] forKey:@"id"];
            [dic1 setValue:[NSString stringWithFormat:@"%@",@(model.num)] forKey:@"num"];
            [prodic setValue:dic1 forKey:[NSString stringWithFormat:@"%@",@(model.outsideID)]];
        }
        
        if (model.numType) {
            NSArray *arrdicname = [numdic allKeys];
            NSMutableDictionary *dic2;
            if ([arrdicname containsObject:model.ordernum]) {
                dic2 = numdic[model.ordernum];
            } else {
                dic2 = [[NSMutableDictionary alloc]init];
                [numdic setValue:dic2 forKey:model.ordernum];
            }
            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
            [tempdic setValue:[NSString stringWithFormat:@"%@",@(model.rights)] forKey:@"id"];
            [tempdic setValue:[NSString stringWithFormat:@"%@",@(model.num)] forKey:@"num"];
            [dic2 setValue:tempdic forKey:[NSString stringWithFormat:@"%@",@(model.rights)]];
        }
        
        if (model.stored) {
            NSArray *arrdicname = [storeddic allKeys];
            NSMutableDictionary *dic3;
            if ([arrdicname containsObject:[NSString stringWithFormat:@"%@",@(model.ID)]]) {
                dic3 = storeddic[[NSString stringWithFormat:@"%@",@(model.ID)]];
            } else {
                dic3 = [[NSMutableDictionary alloc]init];
                [storeddic setValue:dic3 forKey:[NSString stringWithFormat:@"%@",@(model.ID)]];
            }
            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
            [tempdic setValue:[NSString stringWithFormat:@"%@",@(model.rights)] forKey:@"id"];
            [tempdic setValue:[NSString stringWithFormat:@"%@",@(model.num)] forKey:@"num"];
            [dic3 setValue:tempdic forKey:[NSString stringWithFormat:@"%@",@(model.rights)]];
        }
        
        if (model.time) {
            NSArray *arrdicname = [timedic allKeys];
            NSMutableDictionary *dic4;
            if ([arrdicname containsObject:[NSString stringWithFormat:@"%@",@(model.ID)]]) {
                dic4 = timedic[[NSString stringWithFormat:@"%@",@(model.ID)]];
            } else {
                dic4 = [[NSMutableDictionary alloc]init];
                [timedic setValue:dic4 forKey:[NSString stringWithFormat:@"%@",@(model.ID)]];
            }
            NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
            [tempdic setValue:[NSString stringWithFormat:@"%@",@(model.rights)] forKey:@"id"];
            [tempdic setValue:[NSString stringWithFormat:@"%@",@(model.num)] forKey:@"num"];
            [dic4 setValue:tempdic forKey:[NSString stringWithFormat:@"%@",@(model.rights)]];
        }
    }
    
    [plan setValue:timedic forKey:@"time"];
    [plan setValue:storeddic forKey:@"stored"];
    [plan setValue:prodic forKey:@"pro"];
    [plan setValue:numdic forKey:@"num"];
    
    [ShareWorkInstance shareInstance].plan = plan;
    BeautyGWCCommitVC *vc = [[BeautyGWCCommitVC alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)requestNetData{
    NSString *join_code = [ShareWorkInstance shareInstance].join_code;
    NSString *user_id = [NSString stringWithFormat:@"%@",@([ShareWorkInstance shareInstance].uid)];
    
    [_liaoChengXiangMuRequest requestLiaoChengXiangMu:user_id join_code:join_code resultBlock:^(LiaoChengXiangMuList *liaoChengXiangMuList, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _arrRightSource = _liaoChengXiangMuList = liaoChengXiangMuList.list;
            _sourceData = [[NSMutableArray alloc] initWithArray:_arrRightSource];
            [_tbRighView reloadData];
        }
    }];
    [_beautyCardRequest requestBeautyCard:join_code user_id:user_id resultBlock:^(BeautyCardModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _beautyCardModel = model;
            if (_beautyCardModel.data.card_time && (_beautyCardModel.data.card_time &&_beautyCardModel.data.card_time.count > 0)) {
                _arrLeftCard_time = _beautyCardModel.data.card_time;
                for (Card_Time *timeModel in _arrLeftCard_time) {
                    for (BeautyCardRange *range in timeModel.info.range) {
                        range.typeName = @"时间卡";
                    }
                }
            }
            if (_beautyCardModel.data.card_num && (_beautyCardModel.data.card_num && _beautyCardModel.data.card_num.count > 0)) {
                _arrLeftCard_num = _beautyCardModel.data.card_num;
                for (Card_Num *numModel in _arrLeftCard_num) {
                    for (BeautyCardRange *temprange in numModel.info.range) {
                        temprange.typeName = @"任选卡";
                    }
                }
            }
            if (_beautyCardModel.data.stored_card && (_beautyCardModel.data.stored_card && _beautyCardModel.data.stored_card.count > 0)) {
                _arrLeftStore_card = _beautyCardModel.data.stored_card;
                for (Stored_Card *storeModel in _arrLeftStore_card) {
                    for (BeautyCardRange *range in storeModel.info.range) {
                        range.typeName = @"储值卡";
                    }
                }
            }
        }
    }];
}
- (void)getNamepropertyMyClass:(Class)className{
    u_int count;
    objc_property_t * properties  = class_copyPropertyList(className, &count);
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *charname = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:charname];
        if (propertyName) {
        }
    }
    free(properties);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbLeftView) {
        static NSString *BeautyCardCellindentifier = @"BeautyCardCellindentifier";
        BeautyCardCell *cell = [tableView dequeueReusableCellWithIdentifier:BeautyCardCellindentifier];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BeautyCardCell" owner:nil options:nil] lastObject];
        }
        if (indexPath.row < _arrLeftCard_time.count) {
            Card_Time *cardtimeModel = _arrLeftCard_time[indexPath.row];
            [cell reFreshBeautyCardCell:cardtimeModel.info.name];
        }else if ((_arrLeftCard_time.count <= indexPath.row) && (indexPath.row < (_arrLeftCard_time.count + _arrLeftCard_num.count))){
            Card_Num *cardnumModel = _arrLeftCard_num[indexPath.row - _arrLeftCard_time.count];
            [cell reFreshBeautyCardCell:cardnumModel.info.name];
        }else if (((_arrLeftCard_time.count + _arrLeftCard_num.count) <= indexPath.row) && (indexPath.row) < _arrLeftCard_time.count + _arrLeftCard_num.count + _arrLeftStore_card.count){
            Stored_Card *storedModel = _arrLeftStore_card[indexPath.row - (_arrLeftCard_time.count + _arrLeftCard_num.count)];
            [cell reFreshBeautyCardCell:storedModel.info.name];
        }
        [cell resetimagebgWidth:120];
        return cell;
    } else {
        static NSString *BeautySubCellindentifier = @"BeautySubCellindentifier";
        BeautySubCell *cell = [tableView dequeueReusableCellWithIdentifier:BeautySubCellindentifier];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BeautySubCell" owner:nil options:nil] lastObject];
        }
        //        if (_isSearch) {
        //            if (indexPath.row < _searchArr.count) {
        //                if ( _btn1Selected) {
        //                    LiaoChengXiangMuModel *model = _searchArr[indexPath.row];
        //                    [cell reFreshBeautySubCell:model];
        //                }else{
        //                    BeautyCardRange *model = _searchArr[indexPath.row];
        //                    [cell reFreshBeautySubCell1:model];
        //                }
        //            }
        //        } else {
        if (indexPath.row < _arrRightSource.count) {
            if ( _btn1Selected) {
                id m = _arrRightSource[indexPath.row];
                if ([m isKindOfClass:[LiaoChengXiangMuModel class]]) {
                    LiaoChengXiangMuModel *model = _arrRightSource[indexPath.row];
                    [cell reFreshBeautySubCell:model];
                }
                if ([m isKindOfClass:[BeautyCardRange class]]) {
                    BeautyCardRange *model = _arrRightSource[indexPath.row];
                    [cell reFreshBeautySubCell1:model];
                }
              
            }else{
                id m = _arrRightSource[indexPath.row];
                if ([m isKindOfClass:[LiaoChengXiangMuModel class]]) {
                    LiaoChengXiangMuModel *model = _arrRightSource[indexPath.row];
                    [cell reFreshBeautySubCell:model];
                }
                if ([m isKindOfClass:[BeautyCardRange class]]) {
                    BeautyCardRange *model = _arrRightSource[indexPath.row];
                    [cell reFreshBeautySubCell1:model];
                }
            }
        }
        //        }
        
        __block BeautySubCell *tempCell = cell;
        WeakSelf
        //疗程项目的增加
        cell.BeautySubCellAddBlock = ^(LiaoChengXiangMuModel *model) {
            LiaoChengXiangMuModel *liaochengmodel = _arrRightSource[indexPath.row];
            if (liaochengmodel.numDisplay < model.num) {
                model.numDisplay ++;
            }
            else{
//                [MzzHud toastWithTitle:@"温馨提示" message:@"次数不足，请重新选择"];
                [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有次数，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                    
                }]show];
                return ;
            }
            CGRect fromeRect = [tempCell convertRect:tempCell.btn2.frame toView:weakSelf.view];
            CGRect toRect = [_downView convertRect:_downView.btn2.frame toView:weakSelf.view];
            [weakSelf.view addSubview:self.redView];
            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
            
            //保存数据
            BeautyProjectModel *addModel = [[BeautyProjectModel alloc]init];
            addModel.name = model.info.name;
            addModel.price = model.info.price;
            addModel.shichang = model.info.shichang;
            addModel.num = model.numDisplay;
            addModel.numTotal = model.num;
            addModel.pro = YES;
            addModel.outsideID = model.uid;
            addModel.insideID = model.info.uid;
            
            NSMutableArray *arradd = [ShareWorkInstance shareInstance].BeautyProjectList;
            NSMutableArray *arrTemp = [NSMutableArray arrayWithArray:arradd];
            BOOL isFind = NO;
            for (NSInteger i = 0; i<arrTemp.count; i++) {
                BeautyProjectModel *tempModel = arrTemp[i];
                if ((tempModel.outsideID == addModel.outsideID) && (tempModel.insideID == addModel.insideID)) {
                    isFind = YES;
                    BeautyProjectModel *Model = arradd[i];
                    Model.num ++;
                    break;
                }
            }
            if (!isFind) {
                [arradd addObject:addModel];
            }
            [ShareWorkInstance shareInstance].BeautyProjectList = arradd;
            [_tbRighView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        //疗程项目的减少
        cell.BeautySubCellReduceBlock = ^(LiaoChengXiangMuModel *model) {
            if (model.numDisplay > 0) {
                model.numDisplay --;
            }else{
                return ;
            }
            NSMutableArray *arradd = [ShareWorkInstance shareInstance].BeautyProjectList;
            NSMutableArray *arrTemp = [NSMutableArray arrayWithArray:arradd];
            if (arrTemp.count) {
                for (NSInteger i = 0; i<arrTemp.count; i++) {
                    BeautyProjectModel *tempModel = arrTemp[i];
                    if (tempModel.pro) {
                        if ((tempModel.outsideID == model.uid) && (tempModel.insideID == model.info.uid)) {
                            BeautyProjectModel *Model = arradd[i];
                            Model.num --;
                            if (Model.num == 0) {
                                [arradd removeObject:Model];
                            }
                            break;
                        }
                    }
                }
            }
            [ShareWorkInstance shareInstance].BeautyProjectList = arradd;
            [_tbRighView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [_downView reFreshBeautyDesignDownView:[ShareWorkInstance shareInstance].BeautyProjectList.count];
        };
        //卡的项目的增加
        cell.BeautySubCellCardAddBlock = ^(BeautyCardRange *range) {
            switch (_cardType) {
                case Card_time_type://时间卡无限制
                {
                    range.numDisplay ++;
                }
                    break;
                case Card_num_type:
                {
                    NSInteger fixed = range.fixed;
                    NSInteger max_num = range.max_num;
//                    NSInteger numType = range.num;
                    NSInteger canUseNum = 0;
                    /** fixed ==1 时能用的数量不能超过外层model的num - num1    fixed ==0 时取内层model的maxnum 但是不能超过外层model的num - num1*/
                    if (fixed == 0) {
                        if (max_num > _cardnumModel.num - _cardnumModel.num1) {
                            canUseNum = _cardnumModel.num - _cardnumModel.num1;
                        }else{
                            canUseNum = max_num;
                        }
                        if (range.numDisplay >= canUseNum) {
//                            [MzzHud toastWithTitle:@"温馨提示" message:@"本项目次数不足"];
                            [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有次数，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                                
                            }]show];
                            return ;
                        }
                    }else if (fixed == 1){
                        NSInteger numTotal = _cardnumModel.num - _cardnumModel.num1;
                        canUseNum = numTotal;
                        if (range.numDisplay >= canUseNum) {
                            [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有次数，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {

                            }]show];
                            return;
                        }
                    }
                    if(![weakSelf addModel:range]){
                        [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客应有次数，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }]show];
                        return;
                    }
                    range.numDisplay ++;
                    
                    
                }
                    break;
                case Card_sorde_type://储值卡，受金额限制
                {
                    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
                    NSInteger totalPrice = 0;
                    for ( BeautyProjectModel *tempModel in arr) {
                        if (tempModel.ID ==_storedModel.ID)
                        {
                            totalPrice += tempModel.price*tempModel.num;
                        }
                    }
                    if (totalPrice+range.price > _storedPrice) {
                        [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的次数超出顾客已有卡项金额，请重新选择" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
                            
                        }]show];
//                        [MzzHud toastWithTitle:@"温馨提示" message:@"金额不足，请重新选择"];
                        return ;
                    }
                    range.numDisplay ++;
                }
                    break;
                default:
                    break;
            }
            
            CGRect fromeRect = [tempCell convertRect:tempCell.btn2.frame toView:weakSelf.view];
            CGRect toRect = [_downView convertRect:_downView.btn2.frame toView:weakSelf.view];
            [weakSelf.view addSubview:self.redView];
            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
            
            //保存数据
            BeautyProjectModel *addModel = [[BeautyProjectModel alloc]init];
            addModel.rights = range.rights;
            addModel.name = range.name;
            addModel.price = range.price;
            addModel.shichang = range.shichang;
            addModel.num = range.numDisplay;
            
            switch (_cardType) {
                case Card_time_type:
                {
                    addModel.ID = _cardtimeModel.ID;
                    addModel.time = YES;
                }
                    break;
                case Card_num_type:
                {
                    addModel.ordernum = _cardnumModel.ordernum;
                    addModel.numType = YES;
                }
                    break;
                case Card_sorde_type:
                {
                    addModel.ID = _storedModel.ID;
                    addModel.stored = YES;
                }
                    break;
                default:
                    break;
            }
            
            NSMutableArray *arradd = [ShareWorkInstance shareInstance].BeautyProjectList;
            NSMutableArray *arrTemp = [NSMutableArray arrayWithArray:arradd];
            BOOL isFind = NO;
            for (NSInteger i = 0; i<arrTemp.count; i++) {
                BeautyProjectModel *tempModel = arrTemp[i];
                switch (_cardType) {
                    case Card_time_type:
                    {
                        if (tempModel.ID == _cardtimeModel.ID && tempModel.rights == range.rights) {
                            BeautyProjectModel *Model = arradd[i];
                            Model. num ++;
                            isFind = YES;
                            break;
                        }
                    }
                        
                        break;
                    case Card_num_type:
                    {
                        if ([tempModel.ordernum isEqualToString:_cardnumModel.ordernum] && tempModel.rights == range.rights) {
                            BeautyProjectModel *Model = arradd[i];
                            Model.num ++;
                            isFind = YES;
                            break;
                        }
                    }
                        break;
                    case Card_sorde_type:
                    {
                        if (tempModel.ID ==_storedModel.ID && tempModel.rights == range.rights) {
                            BeautyProjectModel *Model = arradd[i];
                            Model.num ++;
                            isFind = YES;
                            break;
                        }
                    }
                        break;
                    default:
                        break;
                }
            }
            if (!isFind) {
                [arradd addObject:addModel];
            }
            [ShareWorkInstance shareInstance].BeautyProjectList = arradd;
            [_tbRighView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        //卡的项目的减少
        cell.BeautySubCellCardReduceBlock = ^(BeautyCardRange *range) {
            if (range.numDisplay > 0) {
                range.numDisplay --;
                [weakSelf addModel:range];
            }else{
                return ;
            }
            NSMutableArray *arrdel = [ShareWorkInstance shareInstance].BeautyProjectList;
            if (!arrdel) {
                arrdel = [[NSMutableArray alloc]init];
            }
            NSMutableArray *arrTemp = [NSMutableArray arrayWithArray:arrdel];
            if (arrTemp.count) {
                for (NSInteger i = 0; i<arrTemp.count; i++) {
                    BeautyProjectModel *tempModel = arrTemp[i];
                    if (tempModel.rights == range.rights) {
                        BeautyProjectModel *Model = arrdel[i];
                        Model.num --;
                        if (Model.num == 0) {
                            [arrdel removeObject:Model];
                        }
                        break;
                    }
                }
            }
            [ShareWorkInstance shareInstance].BeautyProjectList = arrdel;
            [_tbRighView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [_downView reFreshBeautyDesignDownView:[ShareWorkInstance shareInstance].BeautyProjectList.count];
        };
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == _tbLeftView) {
        switch (section) {
            case 0:
            {
                if (!_lb1) {
                    _lb1 = [[UILabel alloc]init];
                    _lb1.text = @"疗程项目";
                    _lb1.font = FONT_BOLD_SIZE(16);
                    [_lb1 sizeToFit];
                    _lb1.frame =CGRectMake(15,(50-_lb1.height)/2.0, _lb1.width, _lb1.height);
                }
                if (!_indicate1) {
                    _indicate1 = [[UIView alloc] init];
                    _indicate1.backgroundColor = kColorTheme;
                    _indicate1.frame = CGRectMake(4, (50 - 16)/2, 3, 16);
                }
                if (!_btn1) {
                    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                    _btn1.frame = CGRectMake(0, 0, 130*WIDTH_SALE_BASE, 50);
                    [_btn1 addTarget:self action:@selector(leftHeaderBtn1Event) forControlEvents:UIControlEventTouchUpInside];
                    [_btn1 addSubview:_lb1];
                    [_btn1 addSubview:_indicate1];
                    
                }
                if (_btn1Selected) {
                    _lb1.textColor = kColorTheme;
                    _lb1.font = FONT_BOLD_SIZE(16);
                    _btn1.backgroundColor = [UIColor whiteColor];
                    _indicate1.hidden = NO;
                } else {
                    _lb1.textColor = kColor3;
                    _btn1.backgroundColor = kBackgroundColor;
                    _lb1.font = FONT_SIZE(16);
                    _indicate1.hidden = YES;
                }
                return _btn1;
            }
                break;
            case 1:
            {
                if (!_lb2) {
                    _lb2 = [[UILabel alloc]init];
                    _lb2.text = @"常规提卡";
                    _lb2.font = FONT_SIZE(16);
                    [_lb2 sizeToFit];
                    _lb2.frame =CGRectMake(15,(50-_lb2.height)/2.0, _lb2.width, _lb2.height);
                }
                if (!_indicate2) {
                    _indicate2 = [[UIView alloc] init];
                    _indicate2.backgroundColor = kColorTheme;
                    _indicate2.frame = CGRectMake(4, (50 - 16)/2, 3, 16);
                }
                if (!_btn2) {
                    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
                    _btn2.frame = CGRectMake(0, 0, 130*WIDTH_SALE_BASE, 50);
                    [_btn2 addTarget:self action:@selector(leftHeaderBtn2Event) forControlEvents:UIControlEventTouchUpInside];
                    [_btn2 addSubview:_lb2];
                    [_btn2 addSubview:_indicate2];
                }
                if (!_xiala) {
                    _xiala = [[UIImageView alloc]initWithFrame:CGRectMake(_lb2.right+25, (50-_xialaImage.size.height)/2.0, _xialaImage.size.width, _xialaImage.size.height)];
                    _xiala.contentMode=UIViewContentModeScaleAspectFit;
//                    _xiala.backgroundColor = [UIColor blueColor];
                    [_btn2 addSubview:_xiala];
                }
                if (!_sanjiaoImageView) {
                    _sanjiaoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,50-_sanjiaoImage.size.height, _sanjiaoImage.size.width, _sanjiaoImage.size.height)];
                    _sanjiaoImageView.contentMode=UIViewContentModeScaleAspectFit;
                    _sanjiaoImageView.image = _sanjiaoImage;
                    _sanjiaoImageView.backgroundColor = [UIColor redColor];
                    [_btn2 addSubview:_sanjiaoImageView];
                }
                if (!_line2) {
                    _line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, 130*WIDTH_SALE_BASE, 1)];
                    _line2.backgroundColor = kSeparatorColor;
                    [_btn2 addSubview:_line2];
                }
                if (_btn2Selected) {
                    _lb2.textColor = kColorTheme;
                    _lb2.font = FONT_BOLD_SIZE(16);
                    _btn2.backgroundColor = [UIColor whiteColor];
                    _xiala.image = _xialaImage;
                    CGAffineTransform transform =CGAffineTransformMakeRotation(0);
                    [_xiala setTransform:transform];
                    _sanjiaoImageView.hidden = YES;
                    _line2.hidden = YES;
                    _indicate2.hidden = NO;
                } else {
                    _lb2.textColor = kColor3;
                    _lb2.font = FONT_SIZE(16);
                    _btn2.backgroundColor = kBackgroundColor;
                    _xiala.image = _xialaImage;
                    CGAffineTransform transform =CGAffineTransformMakeRotation(-M_PI/2.0);
                    [_xiala setTransform:transform];
                    _sanjiaoImageView.hidden = YES;
                    _line2.hidden = NO;
                    _indicate2.hidden = YES;
                }
                return _btn2;
            }
                break;
            default:{
                return nil;
            }
                break;
        }
    } else {
        if (_btn1Selected) {
            return nil;
        }else{
            if (_arrRightSource.count > 0) {
                if (!rightHeader) {
                    rightHeader = [[[NSBundle mainBundle] loadNibNamed:@"BeautyDesignRightSectionHeader" owner:nil options:nil] lastObject];
                    rightHeader.frame = CGRectMake(0, 0, _tbRighViewWidth, 60);
                }
                switch (_cardType) {
                    case Card_time_type:
                    {
                        [rightHeader freshBeautyDesignRightSectionHeader:_cardtimeModel.info.name withstr2:[NSString stringWithFormat:@"截止日期：%@",_cardtimeModel.end_time]];
                    }
                        break;
                    case Card_num_type:
                    {
                        [rightHeader freshBeautyDesignRightSectionHeader:_cardnumModel.info.name withstr2:[NSString stringWithFormat:@"余%@次",@(_cardnumModel.num - _cardnumModel.num1)]];
                        _ywlMaxNum = _cardnumModel.num - _cardnumModel.num1;
                    }
                        break;
                    case Card_sorde_type:
                    {
                        [rightHeader freshBeautyDesignRightSectionHeader:_storedModel.info.name withstr2:[NSString stringWithFormat:@"余额%@元",_storedModel.money]];
                    }
                        break;
                    default:
                        break;
                }
                return rightHeader;
            } else {
                return nil;
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tbLeftView) {
        if (_lastindexPath) {
            BeautyCardCell *cell = [_tbLeftView cellForRowAtIndexPath:_lastindexPath];
            cell.lb1.textColor = kColor9;
        }
        BeautyCardCell *cell = [_tbLeftView cellForRowAtIndexPath:indexPath];
        cell.lb1.textColor = kColorTheme;
        _lastindexPath = indexPath;
        _leftCellTitle = cell.lb1.text;
        
        if (indexPath.row < _arrLeftCard_time.count) {
            _cardtimeModel = _arrLeftCard_time[indexPath.row];
            _arrRightSource = _cardtimeModel.info.range;
            _cardType = Card_time_type;
        }else if ((_arrLeftCard_time.count <= indexPath.row) && (indexPath.row < (_arrLeftCard_time.count + _arrLeftCard_num.count))){
            _cardnumModel = _arrLeftCard_num[indexPath.row - _arrLeftCard_time.count];
            _arrRightSource = _cardnumModel.info.range;
            _cardType = Card_num_type;
        }else if (((_arrLeftCard_time.count + _arrLeftCard_num.count) <= indexPath.row) && (indexPath.row) < _arrLeftCard_time.count + _arrLeftCard_num.count + _arrLeftStore_card.count){
            _storedModel = _arrLeftStore_card[indexPath.row - (_arrLeftCard_time.count + _arrLeftCard_num.count)];
            _arrRightSource = _storedModel.info.range;
            _storedPrice = [_storedModel.money integerValue];
            _cardType = Card_sorde_type;
        }
         _sourceData = [[NSMutableArray alloc] initWithArray:_arrRightSource];
        [_tbRighView reloadData];
    }
}
- (void)animationDidFinish{
    [self.redView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        _downView.btn2.transform = CGAffineTransformMakeScale(0.8, 0.8);
        _downView.lb1.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _downView.btn2.transform = CGAffineTransformMakeScale(1, 1);
            _downView.lb1.transform = CGAffineTransformMakeScale(1, 1);
            [_downView reFreshBeautyDesignDownView:[ShareWorkInstance shareInstance].BeautyProjectList.count];
        } completion:^(BOOL finished) {
        }];
    }];
}
- (void)leftHeaderBtn1Event{
    _btn1Selected = YES;
    _btn2Selected = NO;
    _arrRightSource = _liaoChengXiangMuList;
     _sourceData = [[NSMutableArray alloc] initWithArray:_arrRightSource];
    [_tbLeftView reloadData];
    [_tbRighView reloadData];
}
- (void)leftHeaderBtn2Event{
    _btn1Selected = NO;
    _btn2Selected = YES;
     _sourceData = [[NSMutableArray alloc] initWithArray:_arrRightSource];
    [_tbLeftView reloadData];
    if (_arrRightSource.count) {
        _arrRightSource = @[];
    }
    if ((_arrLeftCard_time.count + _arrLeftCard_num.count + _arrLeftStore_card.count) > 0) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        [self tableView:_tbLeftView didSelectRowAtIndexPath:index];
    }else{
        [_tbRighView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tbRighView) {
        if (_btn1Selected) {
            return 0;
        } else {
            if (_arrRightSource.count > 0) {
                return 60;
            } else {
                return 0;
            }
        }
    }else{
        return 50;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tbLeftView) {
        return 2;
    } else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbLeftView) {
        switch (section) {
            case 1:
                if (_btn2Selected) {
                    return (_arrLeftCard_time.count + _arrLeftCard_num.count + _arrLeftStore_card.count);
                } else {
                    return 0;
                }
                break;
            default:
                return 0;
                break;
        }
    } else {
       
        return _arrRightSource.count;
        
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbLeftView) {
        return 50;
    } else {
        return 116;
    }
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (BOOL)addModel:(BeautyCardRange *)model
{
    NSInteger count = 0;
    if (![_ywlArr containsObject:model]) {
        [_ywlArr addObject:model];
    }
    
    for (int i =0 ; i < _ywlArr.count; i ++) {
        BeautyCardRange * model = _ywlArr[i];
        count = count + model.numDisplay;
    }
    if (count >= _ywlMaxNum) {
        return NO;
    }
    return YES;
}

@end
