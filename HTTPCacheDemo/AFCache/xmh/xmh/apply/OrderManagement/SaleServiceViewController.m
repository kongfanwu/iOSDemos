//
//  SaleServiceViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//
#import "SaleServiceViewController.h"
#import "SLRequest.h"
#import "ShareWorkInstance.h"
#import "ServiceLeftCell.h"
#import "SerViceRightCell.h"
#import "JasonSearchView.h"
#import "OrderRightSectionHeader.h"

#import "SLServAppoModel.h"
#import "SLPresModel.h"
#import "SLServPro.h"
#import "SLGoodsModel.h"
#import "SLTi_CardModel.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"

#import "TiCardLeftCell.h"
#import "BillTiYanFuwuCell.h"
#import "BillTiYanFuwuRightCell.h"
#import "BeautyDesignDownView.h"
#import "BeautyGouWuCheView.h"
#import "UserManager.h"
#import "SaleServiceNextViewController.h"
#import "SaleListRequest.h"
#import "SALeftModelList.h"
#import "GuDingProOneCell.h"
#import "ShengKaXuKaCell.h"
#import "ShengKaXuKaProModel.h"
#import "ShengKaXuKaRenXuanKa.h"
#import "ShengKaXuKaChuZhiModel.h"
#import "ShengKaXuKaShiJianModel.h"
#import "SAZhiHuanPorListModel.h"
#import "SADepositListModel.h"
#import "SaleGouWuCheCell.h"
#import "SKXKProCell.h"
#import "ShengKaXuKaKeShengHuiYuanKa.h"
#import "CiShuModel.h"
#import "SATicketListModel.h"
#import "ThrowLineTool.h"
#import "ZheKouModel.h"
#import "BeautyDesignRightSectionHeader.h"
#import "YiGouZhiHuanFuckHeader.h"
#import "MzzGuDingZhiDanController.h"
#import "MzzYiGouZhiHuanController.h"
#import "MzzGeXingZhiDanController.h"
#import "MzzShengkaXukaController.h"
#import "BaoHanNeiRongView.h"
#import "SKXKProOneceModel.h"
#import "YiGouRenXuanCell.h"
#import "OrderVouchersCell.h"
#import "SellProTicketListModel.h"
typedef NS_ENUM(NSInteger, SaleServiceType) {
    Pres,
    tiCard,
    Pro,
    Goods,
    
    sell_Pro,
    sell_Goods,
    sell_TiYan
};

@interface SaleServiceViewController ()<ThrowLineToolDelegate,UITextFieldDelegate>{
    NSArray *_arrLeft;
    
    NSIndexPath     *_lastindexPath;
    NSInteger     _lastXiaLaindexPath;
    NSIndexPath     *_xiaoShouFuWuDanindexPath;
    
    SaleServiceType  _type;
    NSString        *_titlestr;
    SLServAppoModel *_ServApppModel;
    SLPresModel     *_SLPresModelmodel;
    SLTi_CardModel  *_SLTi_CardModelmodel;
    SLServPro       *_SLServPromodel;
    SLGoodsModel    *_SLGoodsModelmodel;
    SLS_ProModel    *_SLS_ProModelmodel;
    SLGoodListModel *_SLGoodListModelmodel;
    SLSCourseExper  *_SLSCourseExpermodel;
    
    NSInteger          _ServApppSection;
    JasonSearchView   *_searchView;
    
    TiCardType _blocktype;
    NSInteger _blockindex;
    NSInteger _blockwhice;
    
    BeautyGouWuCheView *_gouWuCheView;
    
    NSMutableDictionary *_commitDic;
    
    NSMutableArray  *_presArr;
    
    NSMutableArray  *_rec_proArr;
    NSMutableArray  *_rec_goodsArr;
    NSMutableArray  *_stored_cardArr;
    NSMutableArray  *_card_numArr;
    NSMutableArray  *_card_timeArr;
    
    NSMutableArray  *_proArr;
    NSMutableArray  *_goodsArr;
    NSMutableArray  *_course_experArr;
    
    NSMutableDictionary  *_SKXKproDic;
    NSMutableArray  *_cartArr;
    
    NSMutableArray  *_cartSubProArr;
    NSMutableArray  *_cartSubCardNumArr;
    NSMutableArray  *_cartSubTimeArr;
    NSMutableArray  *_cartSubStoreCardArr;
    
    NSMutableArray  *_zhiHuanChuZhiUserArr;
    
    
    
    SALeftModelList *_Gudingmodel;
    SALeftModelList *_Yigoumodel;
    SALeftModelList *_Gexingmodel;
    SALeftModelList *_Shengkamodel;
    SALeftModelList *_KaiShiZhiHuanmodel;
    
    
    NSString * join_code;
    
    NSMutableArray  *_rightArr;
    
    NSMutableDictionary *_dicRight;
    NSMutableDictionary *_SKXKTotaldic;
    
    NSString    *_typeStrRight;
    
    NSArray *_ShengKaXuKaProList;
    NSArray *_ShengKaXuKaRenXuanKaList;
    NSArray *_ShengKaXuKaChuZhiModelList;
    NSArray *_ShengKaXuKaShiJianModelList;
    
    NSArray *_ShengKaXuKaShengKaMuBiaoList;
    
    
    NSArray *_YiGouZhiHuanProList;
    NSArray *_YiGouZhiHuanGoodsList;
    NSArray *_YiGouZhiHuanRenXuanList;
    NSArray *_YiGouZhiHuanTimeList;
    NSArray *_YiGouZhiHuanPiaoQuanList;
    NSArray *_YiGouZhiHuanChuZhiList;
    NSArray *_YiGouZhiHuanDingJinDingDanList;
    
    NSInteger   skxkTbChoiseTag;
    
    UILabel *_lb18;
    UILabel *_lb7;
    
    NSMutableArray *_ZheKouList;
    NSMutableArray *_LiaoChengCiShuList;
    NSMutableArray *_SATicketList;
    NSMutableArray *_sellProTicketList;
    NSIndexPath *_ChangeindexPath;
    SaleModel *_ChangeSaleModelmodel;
    SLS_Pro *_vouchModel;//销售服务单项目抵用券model
    SLGoodModel *_goodVouchModel;//销售服务单产品抵用券model
    SLPro_ListM *_tiYanProVouchModel;//销售服务单体验服务中项目model
    SLGoods_ListM *_tiYanGoodsVouchMmodel;//销售服务单体验服务中产品model
    
    NSMutableArray *_GDKDProSelfTempArr;
    NSMutableArray *_GDKDGoodsSelfTempArr;
    NSMutableArray *_GDKDTeHuiSelfTempArr;
    NSMutableArray *_GDKDRenXuanSelfTempArr;
    NSMutableArray *_GDKDChuZhiSelfTempArr;
    NSMutableArray *_GDKDTimeSelfTempArr;
    NSMutableArray *_GDKDTicketSelfTempArr;
    
    NSMutableArray *_GXZDProSelfTempArr;
    NSMutableArray *_GXZDGoodsSelfTempArr;
    NSMutableArray *_GXZDTeHuiSelfTempArr;
    NSMutableArray *_GXZDRenXuanSelfTempArr;
    NSMutableArray *_GXZDTimeSelfTempArr;
    NSMutableArray *_GXZDTicketSelfTempArr;
    
    NSMutableArray *_YGZHProSelfTempArr;
    NSMutableArray *_YGZHGoodsSelfTempArr;
    NSMutableArray *_YGZHRenXuanSelfTempArr;
    NSMutableArray *_YGZHTimeSelfTempArr;
    NSMutableArray *_YGZHDingjinSelfTempArr;
    NSMutableArray *_YGZHTicketSelfTempArr;
    NSMutableArray *_YGZHChuZhiSelfTempArr;
    
    NSMutableArray *_CustomerTempArr;
    
    UIImageView *_redView;
    
    BeautyDesignRightSectionHeader *_rightHeader;
    
    NSInteger   _fuckHeight;
    
    YiGouZhiHuanFuckHeader *_fuckHeader;
    
    SAAccountModel *_SAAccountModelmodel;
    
    SaleServiceViewController*_VC7;
    
    NSInteger   _gouwucheNum;
    
    BOOL _isGuDingSearch;
    NSMutableArray *_GuDingSearchArr;
    
    BOOL _isGeXingSearch;
    NSMutableArray *_GeXingSearchArr;
    
    SKXKProOneceModel *_sKXKProOneceModel;
    
    ShengKaChuZhiList *_ShengKaChuZhiListmodel;
    
    ShengKaXuKaRenXuanData *_ShengKaXuKaRenXuanDataModel;
    
    ShengKaXuKaShiJianList *_ShengKaXuKaShiJianListModel;
    
    BOOL _isMustbeStop;
    
    NSInteger _searchSection;
    
    BOOL _isServApppSearch;
    NSMutableArray *_ServApppSearchArr;
    
    
    BOOL _isProSearch;
    NSMutableArray *_ProSearchArr;
    BOOL _isGoodsSearch;
    NSMutableArray *_GoodSearchArr;
    BOOL _issell_ProSearch;
    NSMutableArray *_sell_ProSearchArr;
    BOOL _issell_GoodsSearch;
    NSMutableArray *_sell_GoodsSearchArr;
    BOOL _issell_TiYanProSearch;
    NSMutableArray *_sell_TiYanProSearchArr;
    BOOL _issell_TiYanGoodsSearch;
    NSMutableArray *_sell_TiYanGoodsSearchArr;
    BOOL _isPresSearch;
    NSMutableArray *_PresSearchArr;
    BOOL _isstored_cardTypeProSearch;
    NSMutableArray *_stored_cardTypeProSearchArr;
    BOOL _isstored_cardTypeGoodsSearch;
    NSMutableArray *_stored_cardTypeGoodsSearchArr;
    BOOL _iscard_numTypeProSearch;
    NSMutableArray *_card_numTypeProSearchArr;
    BOOL _iscard_numTypegoodsSearch;
    NSMutableArray *_card_numTypeGoodsSearchArr;
    BOOL _iscard_timeTypeProSearch;
    NSMutableArray *_card_timeTypeProSearchArr;
    BOOL _iscard_timeTypeGoodsSearch;
    NSMutableArray *_card_timeTypeGoodsSearchArr;
    
    
    BOOL _isYiGouZhiHuanProSearch;
    NSMutableArray *_YiGouZhiHuanProSearchArr;
    BOOL _isYiGouZhiHuanGoodsSearch;
    NSMutableArray *_YiGouZhiHuanGoodsSearchArr;
    BOOL _isYiGouZhiHuanRenXuanSearch;
    NSMutableArray *_YiGouZhiHuanRenXuanSearchArr;
    BOOL _isYiGouZhiHuanTimeSearch;
    NSMutableArray *_YiGouZhiHuanTimeSearchArr;
    BOOL _isYiGouZhiHuanDingJinDingDanSearch;
    NSMutableArray *_YiGouZhiHuanDingJinDingDanSearchArr;
    BOOL _isYiGouZhiHuanPiaoQuanSearch;
    NSMutableArray *_YiGouZhiHuanPiaoQuanSearchArr;
    
    BOOL _isYiGouZhiHuanChuZhiSearch;
    NSMutableArray *_YiGouZhiHuanChuZhiSearchArr;
    
    BOOL _isYiGouZhiHuanSearch;
    NSMutableArray *_YiGouZhiHuanSearchArr;
    
    UIView *_searchBG;
    
    NSMutableArray *_isShowArray;//点击提卡项目数组
    NSInteger _tiyanId;//获取体验服务的ID
    NSMutableArray *_selectHuiyuanArray;
    NSMutableArray *_selectdiyongArray;
    NSMutableArray *_selectFdiyongArray;//销售服务单

    
    BOOL _select;
    
    SATicketModel * _selectTicketModel;
}
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UITableView *tbViewLeft;
@property (weak, nonatomic) IBOutlet UITableView *tbViewRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topviewlayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tbRightTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tbLeftTop;

@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UIImageView *im3;
@property (weak, nonatomic) IBOutlet UIImageView *im4;
@property (weak, nonatomic) IBOutlet UIImageView *im5;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *im1Top;

@property (weak, nonatomic) IBOutlet UITableView *tbGouWuChe;

@property (weak, nonatomic) IBOutlet UIButton *btnGouWu;
@property (weak, nonatomic) IBOutlet UILabel *lbGouWuNum;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnTopDark;
@property (weak, nonatomic) IBOutlet UIButton *btnCancle;
@property (weak, nonatomic) IBOutlet UILabel *lbMiddle;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UILabel *lbHuiShou;
@property (weak, nonatomic) IBOutlet UILabel *lbZhiHuan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewtop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbHuiShouTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbGouWuNumTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbGouWuNumLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameBackGroundHight;
@property (weak, nonatomic) IBOutlet UIView *nameView;

@end

@implementation SaleServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commitDic = [[NSMutableDictionary alloc]init];
    
    _presArr = [[NSMutableArray alloc]init];
    
    _rec_proArr = [[NSMutableArray alloc]init];
    _rec_goodsArr = [[NSMutableArray alloc]init];
    
    _stored_cardArr = [[NSMutableArray alloc]init];
    _card_numArr = [[NSMutableArray alloc]init];
    _card_timeArr = [[NSMutableArray alloc]init];
    
    _dicRight = [[NSMutableDictionary alloc]init];
    
    _proArr = [[NSMutableArray alloc]init];
    _goodsArr = [[NSMutableArray alloc]init];
    _course_experArr = [[NSMutableArray alloc]init];
    
    _SKXKproDic = [[NSMutableDictionary alloc]init];
    _cartArr = [[NSMutableArray alloc]init];
    _SKXKTotaldic = [[NSMutableDictionary alloc]init];
    
    _cartSubProArr = [[NSMutableArray alloc]init];
    _cartSubCardNumArr = [[NSMutableArray alloc]init];
    _cartSubTimeArr = [[NSMutableArray alloc]init];
    _cartSubStoreCardArr = [[NSMutableArray alloc]init];
    _LiaoChengCiShuList = [[NSMutableArray alloc]init];
    
    _GDKDProSelfTempArr = [[NSMutableArray alloc]init];
    _GDKDGoodsSelfTempArr = [[NSMutableArray alloc]init];
    _GDKDTeHuiSelfTempArr = [[NSMutableArray alloc]init];
    _GDKDRenXuanSelfTempArr = [[NSMutableArray alloc]init];
    _GDKDChuZhiSelfTempArr = [[NSMutableArray alloc]init];
    _GDKDTimeSelfTempArr = [[NSMutableArray alloc]init];
    _GDKDTicketSelfTempArr = [[NSMutableArray alloc]init];
    
    _zhiHuanChuZhiUserArr = [[NSMutableArray alloc]init];
    
    _GXZDProSelfTempArr = [[NSMutableArray alloc]init];
    _GXZDGoodsSelfTempArr = [[NSMutableArray alloc]init];
    _GXZDTeHuiSelfTempArr = [[NSMutableArray alloc]init];
    _GXZDRenXuanSelfTempArr = [[NSMutableArray alloc]init];
    _GXZDTimeSelfTempArr = [[NSMutableArray alloc]init];
    _GXZDTicketSelfTempArr = [[NSMutableArray alloc]init];
    
    _YGZHProSelfTempArr = [[NSMutableArray alloc]init];
    _YGZHGoodsSelfTempArr = [[NSMutableArray alloc]init];
    _YGZHRenXuanSelfTempArr = [[NSMutableArray alloc]init];
    _YGZHChuZhiSelfTempArr = [[NSMutableArray alloc]init];
    _YGZHTimeSelfTempArr = [[NSMutableArray alloc]init];
    _YGZHDingjinSelfTempArr = [[NSMutableArray alloc]init];
    _YGZHTicketSelfTempArr = [[NSMutableArray alloc]init];
    
    _GuDingSearchArr = [[NSMutableArray alloc]init];
    _GeXingSearchArr = [[NSMutableArray alloc]init];
    
    _ServApppSearchArr = [[NSMutableArray alloc]init];
    
    _ProSearchArr = [[NSMutableArray alloc]init];
    _GoodSearchArr = [[NSMutableArray alloc]init];
    _sell_ProSearchArr = [[NSMutableArray alloc]init];
    _sell_GoodsSearchArr = [[NSMutableArray alloc]init];
    _sell_TiYanProSearchArr = [[NSMutableArray alloc]init];
    _sell_TiYanGoodsSearchArr = [[NSMutableArray alloc]init];
    _PresSearchArr = [[NSMutableArray alloc]init];
    _stored_cardTypeProSearchArr = [[NSMutableArray alloc]init];
    _stored_cardTypeGoodsSearchArr = [[NSMutableArray alloc]init];
    _card_numTypeProSearchArr = [[NSMutableArray alloc]init];
    _card_numTypeGoodsSearchArr = [[NSMutableArray alloc]init];
    _card_timeTypeProSearchArr = [[NSMutableArray alloc]init];
    _card_timeTypeGoodsSearchArr = [[NSMutableArray alloc]init];
    
    _YiGouZhiHuanProSearchArr = [[NSMutableArray alloc]init];
    _YiGouZhiHuanGoodsSearchArr = [[NSMutableArray alloc]init];
    _YiGouZhiHuanRenXuanSearchArr = [[NSMutableArray alloc]init];
    _YiGouZhiHuanTimeSearchArr = [[NSMutableArray alloc]init];
    _YiGouZhiHuanDingJinDingDanSearchArr = [[NSMutableArray alloc]init];
    _YiGouZhiHuanPiaoQuanSearchArr = [[NSMutableArray alloc]init];
    _YiGouZhiHuanSearchArr = [[NSMutableArray alloc]init];
    _YiGouZhiHuanChuZhiSearchArr = [[NSMutableArray alloc]init];
    _isShowArray = [[NSMutableArray alloc]init];
    _CustomerTempArr = [[NSMutableArray alloc]init];
    _selectHuiyuanArray = [[NSMutableArray alloc]init];
    _selectdiyongArray = [[NSMutableArray alloc]init];
    _selectFdiyongArray = [[NSMutableArray alloc]init];

    [ThrowLineTool sharedTool].delegate = self;
    if (IS_IPHONE_X) {
        _viewtop.constant = 88;
    }
    _lbHuiShou.hidden = NO;
    
    _lbGouWuNum.text = @"20";
    _lbGouWuNum.backgroundColor = [UIColor whiteColor];
    _lbGouWuNum.font = FONT_SIZE(12);
    [_lbGouWuNum sizeToFit];
    _lbGouWuNum.textColor = kBtn_Commen_Color;
    _lbGouWuNum.layer.borderColor = [kBtn_Commen_Color CGColor];
    _lbGouWuNum.layer.borderWidth = 0.5;
    _lbGouWuNum.layer.cornerRadius = 7;
    _lbGouWuNum.textAlignment = NSTextAlignmentCenter;
    _lbGouWuNum.layer.masksToBounds = YES;
    _lbGouWuNumTop.constant = 5;
    _lbGouWuNumLeft.constant = _btnGouWu.center.x+5;
    _lbGouWuNum.text = @"0";
    _fuckHeight = 114;
    switch (_billType) {
        case 1:
        {
            _arrLeft = @[@"处方服务",@"提卡服务",@"项目服务",@"产品服务"];
            _titlestr = @"服务制单";
            _tbRightTop.constant = 65;
            [self initSubviews];
        }
            break;
        case 2:
        {
            _arrLeft = @[@"项目服务",@"产品服务",@"体验服务"];
            _titlestr = @"服务制单";
            _tbRightTop.constant = 65;
            [self initSubviews];
        }
            break;
        case 3:
        {
            _titlestr = @"固定制单";
            [self initSubviews];
        }
            break;
        case 4:
        {
            _titlestr = @"已购置换";
            _fuckHeight = 70+124;
            [self initSubviews];
            _tbLeftTop.constant = 70;
            _tbRightTop.constant = 70+55;
            [_btnNext setTitle:@"开始置换" forState:UIControlStateNormal];
            [self initFuckTheView];
            [_fuckHeader YiGouZhiHuanFuckHeader:1];
        }
            break;
        case 5:
        {
            _titlestr = @"个性制单";
            [self initSubviews];
        }
            break;
        case 6:
        {
            _titlestr = @"升卡续卡";
            _tbRightTop.constant = 0;
            _sKXKProOneceModel = [[SKXKProOneceModel alloc]init];
            _sKXKProOneceModel.save_old = @"2";
            _sKXKProOneceModel.to_type = @"1";
            _sKXKProOneceModel.up_type = @"2";
            _sKXKProOneceModel.award_del = @"1";
        }
            break;
        case 7:
        {
            _titlestr = @"已购置换";
            _fuckHeight = 70+124;
            [self initSubviews];
            _tbLeftTop.constant = 70;
            _tbRightTop.constant = 70+55;
            [self initFuckTheView];
            [_fuckHeader YiGouZhiHuanFuckHeader:2];
            _lbHuiShou.hidden = NO;
            _lbHuiShou.text = [NSString stringWithFormat:@"回收数量：%@个",_yigouNumStr];
        }
            break;
        default:
            break;
    }
    
    [self creatNav];
    _lbName.text = [NSString stringWithFormat:@"%@ (%@)",_name,_mobile];
    
    [self initData];
    
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
- (void)awakeFromNib {
    [super awakeFromNib];
    _lbGouWuNum.layer.masksToBounds = YES;
    _lbGouWuNum.layer.cornerRadius = 3;
    _lbGouWuNum.text = 0;
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:_titlestr withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initFuckTheView{
    
    _fuckHeader = [[[NSBundle mainBundle]loadNibNamed:@"YiGouZhiHuanFuckHeader" owner:nil options:nil] firstObject];
    _fuckHeader.frame = CGRectMake(0, 135, SCREEN_WIDTH, 70);
    [self.view insertSubview:_fuckHeader atIndex:0];
}
- (void)initSubviews{
    CGFloat h4= _tbViewLeft.top;
    switch (_billType) {
        case 4:{
            h4= _fuckHeight;
        }
            break;
        case 7:{
            h4= _fuckHeight;
        }
            break;
        default:
            break;
    }
    if (!_searchBG) {
        _searchBG = [[UIView alloc]initWithFrame:CGRectMake(_tbViewLeft.right,h4, SCREEN_WIDTH - _tbViewLeft.right, 65)];
        _searchBG.backgroundColor = [UIColor whiteColor];
        [self.view insertSubview:_searchBG atIndex:0];
    }
    CGFloat h=10;
    if (IS_IPHONE_X) {
        h=25;
    }
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0,h,SCREEN_WIDTH - _tbViewLeft.right, 35)withPlaceholder:@"商品名称"];
    [_searchBG addSubview:_searchView];
    [_searchView updateFrame];
    _searchView.line1.hidden=YES;
    
    [_searchView.searchBar addTarget:self action:@selector(searchBarValueChanged:) forControlEvents:UIControlEventEditingChanged];
    WeakSelf;
    __block JasonSearchView *tempJasonSearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        [weakSelf searchBarValueChanged:tempJasonSearchView.searchBar];
    };
    _searchView.searchBar.btnleftBlock = ^{
        
    };
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _searchView.bottom+10, SCREEN_WIDTH - _tbViewLeft.right, 11)];
    lineView.backgroundColor = Color_NormalBG;
    [_searchBG addSubview:lineView];
    
}
#pragma mark -------右侧搜索---------
- (void)searchBarValueChanged:(UITextField *)textField{
    
    [_GuDingSearchArr removeAllObjects];
    [_GeXingSearchArr removeAllObjects];
    [_ServApppSearchArr removeAllObjects];
    [_ProSearchArr removeAllObjects];
    [_GoodSearchArr removeAllObjects];
    [_sell_ProSearchArr removeAllObjects];
    [_sell_GoodsSearchArr removeAllObjects];
    [_sell_TiYanProSearchArr removeAllObjects];
    [_sell_TiYanGoodsSearchArr removeAllObjects];
    [_PresSearchArr removeAllObjects];
    [_stored_cardTypeProSearchArr removeAllObjects];
    [_stored_cardTypeGoodsSearchArr removeAllObjects];
    [_card_numTypeProSearchArr removeAllObjects];
    [_card_numTypeGoodsSearchArr removeAllObjects];
    [_card_timeTypeProSearchArr removeAllObjects];
    [_card_timeTypeGoodsSearchArr removeAllObjects];
    
    [_YiGouZhiHuanProSearchArr removeAllObjects];
    [_YiGouZhiHuanGoodsSearchArr removeAllObjects];
    [_YiGouZhiHuanRenXuanSearchArr removeAllObjects];
    [_YiGouZhiHuanTimeSearchArr removeAllObjects];
    [_YiGouZhiHuanDingJinDingDanSearchArr removeAllObjects];
    [_YiGouZhiHuanPiaoQuanSearchArr removeAllObjects];
    [_YiGouZhiHuanSearchArr removeAllObjects];
    [_YiGouZhiHuanChuZhiSearchArr removeAllObjects];
    
    if (textField.text && (![textField.text isEqualToString:@""])) {
        if (_isSale) {
            switch (_billType) {
                case 3:
                {
                    _isGuDingSearch = YES;
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                    NSArray *arr = _dicRight[_typeStrRight];
                    NSArray *temp = [arr filteredArrayUsingPredicate:predicate];
                    [_GuDingSearchArr addObjectsFromArray:temp];
                }
                    break;
                case 4:
                {
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        _isYiGouZhiHuanProSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                        NSArray *temp = [_YiGouZhiHuanProList filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanProSearchArr addObjectsFromArray:temp];
                    }else if ([_typeStrRight isEqualToString:@"goods"])
                    {
                        _isYiGouZhiHuanGoodsSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                        NSArray *temp = [_YiGouZhiHuanGoodsList filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanGoodsSearchArr addObjectsFromArray:temp];
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        _isYiGouZhiHuanRenXuanSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                        NSArray *temp = [_YiGouZhiHuanRenXuanList filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanRenXuanSearchArr addObjectsFromArray:temp];
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        _isYiGouZhiHuanTimeSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                        NSArray *temp = [_YiGouZhiHuanTimeList filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanTimeSearchArr addObjectsFromArray:temp];
                    }else if ([_typeStrRight isEqualToString:@"sales"])
                    {
                        _isYiGouZhiHuanDingJinDingDanSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.ordernum CONTAINS %@", textField.text];
                        NSArray *temp = [_YiGouZhiHuanDingJinDingDanList filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanDingJinDingDanSearchArr addObjectsFromArray:temp];
                        
                        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF.inper CONTAINS %@", textField.text];
                        NSArray *temp2 = [_YiGouZhiHuanDingJinDingDanList filteredArrayUsingPredicate:predicate2];
                        [_YiGouZhiHuanDingJinDingDanSearchArr addObjectsFromArray:temp2];
                    }else if ([_typeStrRight isEqualToString:@"ticket"])
                    {
                        _isYiGouZhiHuanPiaoQuanSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                        NSArray *temp = [_YiGouZhiHuanPiaoQuanList filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanPiaoQuanSearchArr addObjectsFromArray:temp];
                    }else if ([_typeStrRight isEqualToString:@"stored_card"]){
                        _isYiGouZhiHuanChuZhiSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                        NSArray *temp = [_YiGouZhiHuanChuZhiList filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanChuZhiSearchArr addObjectsFromArray:temp];
                    }
                }
                    break;
                case 5:
                {
                    _isGeXingSearch = YES;
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                    NSArray *arr = _dicRight[_typeStrRight];
                    NSArray *temp = [arr filteredArrayUsingPredicate:predicate];
                    [_GeXingSearchArr addObjectsFromArray:temp];
                }
                    break;
                case 7:
                {
                    if ([_typeStrRight isEqualToString:@"bank"]) {
                        
                    } else {
                        _isYiGouZhiHuanSearch = YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                        NSArray *arr = _dicRight[_typeStrRight];
                        NSArray *temp = [arr filteredArrayUsingPredicate:predicate];
                        [_YiGouZhiHuanSearchArr addObjectsFromArray:temp];
                    }
                }
                    break;
                default:
                    break;
            }
        }else{
            switch (_type) {
                case Pres:
                {
                    _isPresSearch = YES;
                    for (SLPresListModel *SLPresListModelmodel in _SLPresModelmodel.list) {
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.pro_name CONTAINS %@", textField.text];
                        NSArray *temp = [SLPresListModelmodel.pro_list filteredArrayUsingPredicate:predicate];
                        [_PresSearchArr addObjectsFromArray:temp];
                    }
                }
                    break;
                case tiCard:
                {
                    NSArray *arrstored_card = _SLTi_CardModelmodel.stored_card;
                    NSArray *arrcard_num = _SLTi_CardModelmodel.card_num;
                    NSArray *arrcard_time = _SLTi_CardModelmodel.card_time;
                    switch (_blocktype) {
                        case stored_cardType:
                        {
                            if (arrstored_card.count) {
                                SLStored_Card *model = arrstored_card[_blockindex];
                                switch (_blockwhice) {
                                    case 1:
                                    {
                                        _isstored_cardTypeProSearch = YES;
                                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                                        NSArray *temp = [model.pro_list filteredArrayUsingPredicate:predicate];
                                        [_stored_cardTypeProSearchArr addObjectsFromArray:temp];
                                    }
                                        break;
                                    case 2:
                                    {
                                        _isstored_cardTypeGoodsSearch = YES;
                                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                                        NSArray *temp = [model.goods_list filteredArrayUsingPredicate:predicate];
                                        [_stored_cardTypeGoodsSearchArr addObjectsFromArray:temp];
                                    }
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }
                            break;
                        case card_numType:
                        {
                            if (arrcard_num.count) {
                                SLCard_Num *model;
                                if (_blockindex < arrcard_num.count) {
                                    if (_blockindex!=0) {
                                        model = arrcard_num[_blockindex-1];
                                    }else{
                                        model = arrcard_num[_blockindex];
                                    }
                                }else{
                                    model = arrcard_num[_blockindex-arrstored_card.count];
                                }
                                switch (_blockwhice) {
                                    case 1:
                                    {
                                        _iscard_numTypeProSearch = YES;
                                        NSArray *proArray = model.pro_list;
                                        for (SLPro_List *model in proArray) {
                                            if ([model.name isEqualToString:textField.text]) {
                                                [_card_numTypeProSearchArr addObject:model];
                                                
                                            }
                                        }
                                        NSArray *goodArray = model.goods_list;
                                        for (SLGoods_List *model in goodArray) {
                                            if ([model.name isEqualToString:textField.text]) {
                                                [_card_numTypeProSearchArr addObject:model];
                                            }
                                        }
                                        
                                        
                                    }
                                        
                                        break;
                                        
                                    default:
                                        break;
                                }
                            }
                        }
                            break;
                        case card_timeType:
                        {
                            if (arrcard_time.count) {
                                SLCard_Time *model;
                                if (_blockindex <arrcard_time.count) {
                                    if (_blockindex!=0) {
                                        model = arrcard_time[_blockindex-1];
                                    }else{
                                        model = arrcard_time[_blockindex];
                                    }
                                }else{
                                    model = arrcard_time[_blockindex-arrstored_card.count-arrcard_num.count];
                                }
                                switch (_blockwhice) {
                                    case 1:
                                    {
                                        _iscard_timeTypeProSearch = YES;
                                        NSArray *proArray = model.pro_list;
                                        for (SLPro_List *model in proArray) {
                                            if ([model.name isEqualToString:textField.text]) {
                                                [_card_timeTypeProSearchArr addObject:model];
                                                
                                            }
                                        }
                                        NSArray *goodArray = model.goods_list;
                                        for (SLGoods_List *model in goodArray) {
                                            if ([model.name isEqualToString:textField.text]) {
                                                [_card_timeTypeProSearchArr addObject:model];
                                            }
                                        }
                                    }
                                        break;
                                        
                                    default:
                                        break;
                                }
                            }
                        }
                            break;
                        default:
                            break;
                    }
                }
                    break;
                case Pro:
                {
                    _isProSearch = YES;
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                    NSArray *temp = [_SLServPromodel.list filteredArrayUsingPredicate:predicate];
                    [_ProSearchArr addObjectsFromArray:temp];
                }
                    break;
                case Goods:
                {
                    _isGoodsSearch = YES;
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                    NSArray *temp = [_SLGoodsModelmodel.list filteredArrayUsingPredicate:predicate];
                    [_GoodSearchArr addObjectsFromArray:temp];
                }
                    break;
                case sell_Pro:
                {
                    _issell_ProSearch = YES;
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                    NSArray *temp = [_SLS_ProModelmodel.list filteredArrayUsingPredicate:predicate];
                    [_sell_ProSearchArr addObjectsFromArray:temp];
                }
                    break;
                case sell_Goods:
                {
                    _issell_GoodsSearch = YES;
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                    NSArray *temp = [_SLGoodListModelmodel.list filteredArrayUsingPredicate:predicate];
                    [_sell_GoodsSearchArr addObjectsFromArray:temp];
                }
                    break;
                case sell_TiYan:
                {
                    SLCourseExperList *model;
                    if (_blockindex < _SLSCourseExpermodel.list.count) {
                        model = _SLSCourseExpermodel.list[_blockindex];
                    }
                    switch (_blockwhice) {
                        case 1:
                        {
                            _issell_TiYanProSearch = YES;
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                            NSArray *temp = [model.pro_list filteredArrayUsingPredicate:predicate];
                            [_sell_TiYanProSearchArr addObjectsFromArray:temp];
                        }
                            break;
                        case 2:
                        {
                            _issell_TiYanGoodsSearch = YES;
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
                            NSArray *temp = [model.goods_list filteredArrayUsingPredicate:predicate];
                            [_sell_TiYanGoodsSearchArr addObjectsFromArray:temp];
                        }
                            break;
                        default:
                            break;
                    }
                }
                    break;
                default:
                    break;
            }
        }
    } else {
        _isGuDingSearch = NO;
        _isGeXingSearch = NO;
        _isServApppSearch = NO;
        
        _isProSearch = NO;
        _isGoodsSearch = NO;
        _issell_ProSearch = NO;
        _issell_GoodsSearch = NO;
        _issell_TiYanProSearch = NO;
        _issell_TiYanGoodsSearch = NO;
        _isPresSearch = NO;
        _isstored_cardTypeProSearch = NO;
        _isstored_cardTypeGoodsSearch = NO;
        _iscard_numTypeProSearch = NO;
        _iscard_numTypegoodsSearch = NO;
        _iscard_timeTypeProSearch = NO;
        _iscard_timeTypeGoodsSearch = NO;
        
        _isYiGouZhiHuanProSearch = NO;
        _isYiGouZhiHuanGoodsSearch = NO;
        _isYiGouZhiHuanRenXuanSearch = NO;
        _isYiGouZhiHuanTimeSearch = NO;
        _isYiGouZhiHuanDingJinDingDanSearch = NO;
        _isYiGouZhiHuanPiaoQuanSearch = NO;
        _isYiGouZhiHuanSearch = NO;
        _isYiGouZhiHuanChuZhiSearch = NO;
    }
    [_tbViewRight reloadData];
}
- (void)GouWuCheEvent{
    if (!_gouWuCheView) {
        _gouWuCheView = [[[NSBundle mainBundle]loadNibNamed:@"BeautyGouWuCheView" owner:nil options:nil] firstObject];
        _gouWuCheView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        [self.view addSubview:_gouWuCheView];
    }else{
        _gouWuCheView.hidden = !_gouWuCheView.hidden;
    }
    //    __block BeautyGouWuCheView *tempdownView = _gouWuCheView;
    _gouWuCheView.BeautyGouWuCheViewDelBlock = ^{
        //        [tempdownView reFreshBeautyDesignDownView:0];
    };
    [_gouWuCheView refreshBeautyGouWuCheView];
}
#pragma mark ---------获取左侧tableview数据------------
- (void)initData{
    join_code = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
        [_commitDic setValue:join_code forKey:@"join_code"];
    }
    if (_user_id) {
        [parms setValue:[NSString stringWithFormat:@"%@",@(_user_id)] forKey:@"user_id"];
        [_commitDic setValue:[NSString stringWithFormat:@"%@",@(_user_id)] forKey:@"user_id"];
        
    }
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    if (token) {
        [_commitDic setValue:token forKey:@"token"];
    }
    switch (_billType) {
        case 1:
        {
            _type = Pres;
            //处方服务
            [SLRequest requestPresParams:parms resultBlock:^(SLPresModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _SLPresModelmodel = model;
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self tableView:_tbViewLeft didSelectRowAtIndexPath:index];
                }
            }];
            
            //提卡服务
            [SLRequest requesTtiCardParams:parms resultBlock:^(SLTi_CardModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _SLTi_CardModelmodel = model;
                }
            }];
            //项目服务
            [SLRequest requestServProParams:parms resultBlock:^(SLServPro *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _SLServPromodel = model;
                }
            }];
            //产品服务
            [SLRequest requestServGoodsParams:parms resultBlock:^(SLGoodsModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _SLGoodsModelmodel = model;
                }
            }];
        }
            break;
        case 2:
        {
            //销售服务单-项目服务
            [SLRequest requesSProParams:parms resultBlock:^(SLS_ProModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _SLS_ProModelmodel = model;
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self tableView:_tbViewLeft didSelectRowAtIndexPath:index];
                }
            }];
            //销售服务单-产品服务
            [SLRequest requesSGoodParams:parms resultBlock:^(SLGoodListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _SLGoodListModelmodel = model;
                }
            }];
            //销售服务单-体验服务
            [SLRequest requesCourseExperParams:parms resultBlock:^(SLSCourseExper *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _SLSCourseExpermodel = model;
                }
            }];
        }
            break;
        case 3:
        {
            //-----------左侧-----------
            //固定制单
            [SaleListRequest requestLeftJoinCode:join_code type:@"1" resultBlock:^(SALeftModelList *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _Gudingmodel = model;
                    [_tbViewLeft reloadData];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self tableView:_tbViewLeft didSelectRowAtIndexPath:index];
                }
            }];
        }
            break;
        case 4:{
            //已购置换
            [SaleListRequest requestLeftJoinCode:join_code type:@"2" resultBlock:^(SALeftModelList *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _Yigoumodel = model;
                    [_tbViewLeft reloadData];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self tableView:_tbViewLeft didSelectRowAtIndexPath:index];
                }
            }];
        }
            break;
        case 5:{
            //个性制单
            [SaleListRequest requestLeftJoinCode:join_code type:@"3" resultBlock:^(SALeftModelList *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _Gexingmodel = model;
                    [_tbViewLeft reloadData];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self tableView:_tbViewLeft didSelectRowAtIndexPath:index];
                }
            }];
        }
            break;
        case 6:{
            //升卡续卡
            [SaleListRequest requestLeftJoinCode:join_code type:@"4" resultBlock:^(SALeftModelList *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _Shengkamodel = model;
                    [_tbViewLeft reloadData];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self tableView:_tbViewLeft didSelectRowAtIndexPath:index];
                }
            }];
        }
            break;
        case 7:{
            //开始置换
            [SaleListRequest requestLeftJoinCode:join_code type:@"5" resultBlock:^(SALeftModelList *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _KaiShiZhiHuanmodel = model;
                    [_tbViewLeft reloadData];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self tableView:_tbViewLeft didSelectRowAtIndexPath:index];
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)requestRightData:(NSString *)typeStr{
    NSArray *arr = _dicRight[typeStr];
    if (arr &&(arr.count > 0)) {
        [_tbViewRight reloadData];
        return;
    }
    [SaleListRequest requestSaleListJoinCode:join_code store_code:_store_code type:typeStr user_id:_user_id resultBlock:^(SASaleListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if (model.list && (model.list.count > 0)) {
                [_dicRight setValue:model.list forKey:typeStr];
            }
            if (_billType== 7) {
                [_zhiHuanChuZhiUserArr addObjectsFromArray:model.list];
                [_tbViewRight reloadData];
            }
            if (_billType==6) {
                if([_typeStrRight isEqualToString:@"stored_card"]){
                    [SaleListRequest requestShengKaXuKaChuZhiKauser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code resultBlock:^(ShengKaXuKaChuZhiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                        if (isSuccess) {
                            if (model.data.list.count) {
                                if (_zhiHuanChuZhiUserArr.count) {
                                    [_zhiHuanChuZhiUserArr removeAllObjects];
                                }
                                for (ShengKaChuZhiList *listModel in model.data.list) {
                                    SaleModel *tmpModel = [[SaleModel alloc]init];
                                    tmpModel.isShow = listModel.isShow;
                                    tmpModel.code = listModel.code;
                                    tmpModel.money = listModel.money;
                                    tmpModel.price = listModel.price;
                                    tmpModel.is_have = listModel.is_have;
                                    tmpModel.name = listModel.name;
                                    tmpModel.card_id = listModel.card_id;
                                    tmpModel.user_card_id = listModel.user_card_id;
                                    [_zhiHuanChuZhiUserArr addObject:tmpModel];
                                }
                                [_tbViewRight reloadData];
                            } else {
                                [_tbViewRight reloadData];
                            }
                        }
                    }];
                }
            }else{
                [_tbViewRight reloadData];
            }
            [_tbViewRight reloadData];
        }
    }];
}
#pragma mark ---------获取已购置换右侧tableview对应的数据----------------
- (void)requstYiGouZhiHuanRightData:(NSString *)typeStr{
    if ([_typeStrRight isEqualToString:@"pro"]) {
        if (_YiGouZhiHuanProList && _YiGouZhiHuanProList.count > 0) {
            [_tbViewRight reloadData];
        }else{
            [SaleListRequest requestProJoinCode:join_code userId:[NSString stringWithFormat:@"%ld",_user_id] resultBlock:^(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _YiGouZhiHuanProList = model.list;
                    [_tbViewRight reloadData];
                }
            }];
        }
    }else if ([_typeStrRight isEqualToString:@"goods"])
    {
        if (_YiGouZhiHuanGoodsList && _YiGouZhiHuanGoodsList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestGoodsJoinCode:join_code userId:[NSString stringWithFormat:@"%ld",_user_id] resultBlock:^(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _YiGouZhiHuanGoodsList = model.list;
                [_tbViewRight reloadData];
            }
        }];
    }else if ([_typeStrRight isEqualToString:@"card_num"])
    {
        if (_YiGouZhiHuanRenXuanList && _YiGouZhiHuanRenXuanList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestRenXuanCardJoinCode:join_code userId:[NSString stringWithFormat:@"%ld",_user_id] resultBlock:^(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _YiGouZhiHuanRenXuanList = model.list;
                [_tbViewRight reloadData];
            }
        }];
    }else if ([_typeStrRight isEqualToString:@"card_time"])
    {
        if (_YiGouZhiHuanTimeList && _YiGouZhiHuanTimeList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestTimeCardJoinCode:join_code userId:[NSString stringWithFormat:@"%ld",_user_id] resultBlock:^(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _YiGouZhiHuanTimeList = model.list;
                [_tbViewRight reloadData];
            }
        }];
        
    }else if ([_typeStrRight isEqualToString:@"sales"])
    {
        if (_YiGouZhiHuanDingJinDingDanList && _YiGouZhiHuanDingJinDingDanList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestDepositJoinCode:join_code userId:[NSString stringWithFormat:@"%ld",_user_id] resultBlock:^(SADepositListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _YiGouZhiHuanDingJinDingDanList = model.data.sales;
                [_tbViewRight reloadData];
            }
        }];
        
    }else if ([_typeStrRight isEqualToString:@"ticket"])
    {
        if (_YiGouZhiHuanPiaoQuanList && _YiGouZhiHuanPiaoQuanList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestZhiHuanPiaoQuanUserId:[NSString stringWithFormat:@"%ld",_user_id] JoinCode:join_code resultBlock:^(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _YiGouZhiHuanPiaoQuanList = model.list;
                [_tbViewRight reloadData];
            }
        }];
    }else if ([_typeStrRight isEqualToString:@"stored_card"]){
        if (_YiGouZhiHuanChuZhiList && _YiGouZhiHuanChuZhiList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestZhiHuanChuZhiUserId:[NSString stringWithFormat:@"%ld",_user_id] JoinCode:join_code resultBlock:^(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _YiGouZhiHuanChuZhiList = model.list;
                [_tbViewRight reloadData];
            }
            
        }];
        
    }
}
- (void)chuzhikaMuBiao:(NSString *)typeStr code:(NSString *)code{
    [SaleListRequest requestShengKaXuKaKeShengHuiYuanuser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code code:code resultBlock:^(ShengKaXuKaKeShengHuiYuanKa *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _ShengKaXuKaShengKaMuBiaoList = model.data.list;
        }
        [_tbGouWuChe reloadData];
    }];
}
- (void)requestShengKaXuKaRightData:(NSString *)typeStr{
    
    if ([_typeStrRight isEqualToString:@"pro"]) {
        if (!_ShengKaXuKaProList || _ShengKaXuKaProList.count == 0) {
            [SaleListRequest requestShengKaXuKaProuser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code resultBlock:^(ShengKaXuKaProModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    _ShengKaXuKaProList = model.data.list;
                    [_tbViewRight reloadData];
                }
            }];
        }else{
            [_tbViewRight reloadData];
        }
        [SaleListRequest requestShengKaXuKaKeShengHuiYuanuser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code code:nil resultBlock:^(ShengKaXuKaKeShengHuiYuanKa *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _ShengKaXuKaShengKaMuBiaoList = model.data.list;
            }
            [_tbGouWuChe reloadData];
        }];
    }else if ([_typeStrRight isEqualToString:@"card_num"])
    {
        [SaleListRequest requestShengKaXuKaKeShengHuiYuanuser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code code:nil resultBlock:^(ShengKaXuKaKeShengHuiYuanKa *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _ShengKaXuKaShengKaMuBiaoList = model.data.list;
            }
            [_tbGouWuChe reloadData];
        }];
        if (_ShengKaXuKaRenXuanKaList && _ShengKaXuKaRenXuanKaList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestShengKaXuKaRenXuanKauser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code resultBlock:^(ShengKaXuKaRenXuanKa *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _ShengKaXuKaRenXuanKaList = model.data.list;
                [_tbViewRight reloadData];
            }
        }];
    }else if ([_typeStrRight isEqualToString:@"stored_card"])
    {
        if (_ShengKaXuKaChuZhiModelList && _ShengKaXuKaChuZhiModelList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestShengKaXuKaChuZhiKauser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code resultBlock:^(ShengKaXuKaChuZhiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _ShengKaXuKaChuZhiModelList = model.data.list;
                [_tbViewRight reloadData];
            }
        }];
    }else if ([_typeStrRight isEqualToString:@"card_time"])
    {
        [SaleListRequest requestShengKaXuKaKeShengHuiYuanuser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code code:nil resultBlock:^(ShengKaXuKaKeShengHuiYuanKa *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _ShengKaXuKaShengKaMuBiaoList = model.data.list;
            }
            [_tbGouWuChe reloadData];
        }];
        if (_ShengKaXuKaShiJianModelList && _ShengKaXuKaShiJianModelList.count > 0) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestShengKaXuKaShiJiankauser_id:[NSString stringWithFormat:@"%ld",_user_id] join_code:join_code resultBlock:^(ShengKaXuKaShiJianModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _ShengKaXuKaShiJianModelList = model.data.list;
                [_tbViewRight reloadData];
            }
        }];
    }
}
- (void)requestKaiShiZhiHuanRightData:(NSString *)typeStr{
    
    if ([_typeStrRight isEqualToString:@"bank"]) {
        if (_SAAccountModelmodel) {
            [_tbViewRight reloadData];
            return;
        }
        [SaleListRequest requestGoodsAccountUserId:[NSString stringWithFormat:@"%ld",_user_id] resultBlock:^(SAAccountModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _SAAccountModelmodel = model;
                [_tbViewRight reloadData];
            }
        }];
    }else {
        [self requestRightData:typeStr];
    }
}
#pragma mark --------获取抵用券数据----------------

- (void)requestDiYongQuan:(NSString *)SearchId type:(NSString *)type code:(NSString *)code{
    if ([type isEqualToString:@"sell_Pro"]) {
        NSString * framId = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
        [SaleListRequest requestSellProTicketSearchId:SearchId userId:[NSString stringWithFormat:@"%ld",_user_id] type:type joinCode:join_code code:code framID:framId  resultBlock:^(SellProTicketListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _sellProTicketList = [NSMutableArray array];
                [_sellProTicketList removeAllObjects];
                [_sellProTicketList addObjectsFromArray: model.list];
                SLS_Pro  *selectModel = [_SLS_ProModelmodel.list mutableCopy][_ChangeindexPath.row];//这个对象选择了抵用券
                NSArray *arr =[_SLS_ProModelmodel.list mutableCopy];
                for(int i = 0 ; i<arr.count ; i++){
                    SLS_Pro *selectModel =arr[i];
                    if (selectModel.diyongStr.length!=0) {
                        if (![_selectFdiyongArray containsObject:selectModel]) {
                            [_selectFdiyongArray addObject:selectModel];
                        }
                    }
                }
                if (_selectFdiyongArray.count) {
                    for (int i = 0 ; i<_selectFdiyongArray.count ; i++) {
                        SLS_Pro *model =_selectFdiyongArray[i];
                        if (selectModel.diyongStr.length!=0) {
                            for(SATicketModel * Card in _sellProTicketList){
                                if (![Card.name isEqualToString:selectModel.diyongStr]) {
                                    if ([model.diyongStr isEqualToString:Card.name]) {
                                        [_sellProTicketList removeObject:Card];
                                        break;
                                    }
                                }else{
                                    Card.selected = YES;
                                }
                            }
                        }else{
                            for(SATicketModel * Card in _sellProTicketList){
                                if ([model.diyongStr isEqualToString:Card.name]) {
                                    [_sellProTicketList removeObject:Card];
                                    break;
                                }
                            }
                        }
                        
                    }
                }
                if (_sellProTicketList.count>0) {
                    [self btnQuanChoiceEvent];
                } else {
                    [MzzHud toastWithTitle:@"温馨提示" message:@"暂无抵用券"];
                }
            }
        }];
    }else{
        [SaleListRequest requestBasicTicketSearchId:SearchId userId:[NSString stringWithFormat:@"%ld",_user_id] type:type joinCode:join_code code:code  resultBlock:^(SATicketListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _SATicketList = [NSMutableArray array];
                [_SATicketList removeAllObjects];
                [_SATicketList addObjectsFromArray: model.ticket];
                SaleModel *selectModel = _dicRight[_typeStrRight][_ChangeindexPath.row];//这个对象选择了抵用券
                NSArray *arr =_dicRight[_typeStrRight];
                for(int i = 0 ; i<arr.count ; i++){
                    SaleModel *selectModel =arr[i];
                    if (selectModel.diyongName.length!=0) {
                        if (![_selectdiyongArray containsObject:selectModel]) {
                            [_selectdiyongArray addObject:selectModel];
                        }
                    }
                }
                if (_selectdiyongArray.count) {
                    for (int i = 0 ; i<_selectdiyongArray.count ; i++) {
                        SaleModel *model =_selectdiyongArray[i];
                        if (selectModel.diyongName.length!=0) {
                            for(SATicketModel * Card in _SATicketList){
                                if (![Card.name isEqualToString:selectModel.diyongName]) {
                                    if ([model.diyongName isEqualToString:Card.name]) {
                                        [_SATicketList removeObject:Card];
                                        break;
                                    }
                                }else{
                                    Card.selected = YES;
                                }
                            }
                        }else{
                            for(SATicketModel * Card in _SATicketList){
                                if ([model.diyongName isEqualToString:Card.name]) {
                                    [_SATicketList removeObject:Card];
                                    break;
                                }
                            }
                        }
                        
                    }
                }
                
                for (int i = 0; i < _SATicketList.count; i++) {
                    SATicketModel * temp = _SATicketList[i];
                    if (_selectTicketModel) {
                        if (temp.mark == _selectTicketModel.mark) {
                            temp.selected = YES;
                            _selectTicketModel = temp;
                        }else{
                            temp.selected = NO;
                        }
                    }
                    
                }
                
                if (_SATicketList.count>0) {
                    [self btnQuanChoiceEvent];
                } else {
                    [MzzHud toastWithTitle:@"温馨提示" message:@"暂无抵用券"];
                }
            }
        }];
    }
}
- (void)btnzhekouChoiceEvent{
    [self btnZheKouEvent];
}
- (void)btnCiShuChoiceEvent{
    [self btnCiShuMethod];
}
- (void)btnQuanChoiceEvent{
    [self DiYongQuanMethod];
}
- (void)XiangXiShuoMingEvent:(NSString *)endtimeStr{
    NSString *displayStr = [NSString stringWithFormat:@"1、本代金券不得兑换现金。\n2、本代金券有效期至%@。\n3、本代金券只限一人使用一次，消费前请出示本券。\n4、本代金券不可与企业的其他优惠活动同时使用，恕不提醒。",endtimeStr];
    MzzHud * hud =  [[MzzHud alloc]initWithTitle:@"温馨提示" message:displayStr centerButtonTitle:@"我知道了" click:^(NSInteger index) {
    }];
    [hud show];
    [hud.contentTipView afterFreshHeight:300];
}
- (void)BaoHanNeiRongMethod{
    BaoHanNeiRongView *baohanweb = [[BaoHanNeiRongView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:baohanweb];
    
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    [baohanweb freshBaoHanNeiRongViewCode:_ChangeSaleModelmodel.code Num:[NSString stringWithFormat:@"%@",@(_ChangeSaleModelmodel.addnum)] sjCode:join_code token:token name:_ChangeSaleModelmodel.name];
    [baohanweb freshBaoHanNeiRongViewSecondjsonText:_ChangeSaleModelmodel.baohanJsonStr];
    __block BaoHanNeiRongView *tmpweb = baohanweb;
    baohanweb.BaoHanNeiRongViewBuanbiBlock = ^(NSString *baohanStr){
        _ChangeSaleModelmodel.baohanJsonStr = baohanStr;
        _ChangeSaleModelmodel.isBaoHan = YES;
        [tmpweb removeFromSuperview];
        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    };
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ServiceLeftCellindentifier = @"ServiceLeftCellindentifier";
    static NSString *SerViceRightCellindentifier = @"SerViceRightCellindentifier";
    static NSString *BillTiYanFuwuRightCellindentifier = @"BillTiYanFuwuRightCellindentifier";
    
    if (tableView == _tbViewLeft) {
        switch (_billType) {
            case 1:
            {
                switch (indexPath.row) {
                    case 1:
                    {
                        TiCardLeftCell*cell = [[[NSBundle mainBundle] loadNibNamed:@"TiCardLeftCell" owner:nil options:nil] firstObject];
                        cell.indexArr = _isShowArray;
                        [cell freshTiCardLeftCell:_SLTi_CardModelmodel];
                        [cell.btn addTarget:self action:@selector(cellBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
                        cell.btnTiCardLeftCellBlock = ^(TiCardType type, NSInteger index, NSInteger whice) {
                            _blocktype = type;
                            _blockindex = index;
                            _blockwhice = whice;
                            [_tbViewRight reloadData];
                        };
                        cell.btnShowLeftCellBlock = ^(TiCardType type, NSMutableArray *index, NSInteger row) {
                            if (type != stored_cardType) {
                                _blocktype = type;
                                _blockindex = row;
                                _blockwhice = 1;
                                [_tbViewRight reloadData];
                            }
                            _type = tiCard;
                            _isShowArray = index;
                            [_tbViewLeft reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        return cell;
                    }
                        break;
                    default:{
                        ServiceLeftCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:ServiceLeftCellindentifier];
                        }
                        if (indexPath.row<_arrLeft.count) {
                            NSString *leftStr = _arrLeft[indexPath.row];
                            cell.lbTitle.text = leftStr;
                        }
                        return cell;
                    }
                        break;
                }
            }
                break;
            case 2:
            {
                switch (indexPath.row) {
                    case 2:
                    {
                        BillTiYanFuwuCell*cell = [[[NSBundle mainBundle] loadNibNamed:@"BillTiYanFuwuCell" owner:nil options:nil] firstObject];
                        [cell freshBillTiYanFuwuCell:_SLSCourseExpermodel];
                        [cell.btn addTarget:self action:@selector(BillTiYanFuwuCellBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
                        cell.btnBillTiYanFuwuCellBlock = ^(NSInteger index, NSInteger whice, NSInteger modelID) {
                            _blockindex = index;
                            _blockwhice = whice;
                            _tiyanId = modelID;
                            [_tbViewRight reloadData];
                        };
                        return cell;
                    }
                        break;
                        
                    default:{
                        ServiceLeftCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:ServiceLeftCellindentifier];
                        }
                        if (indexPath.row<_arrLeft.count) {
                            NSString *leftStr = _arrLeft[indexPath.row];
                            cell.lbTitle.text = leftStr;
                        }
                        return cell;
                    }
                        break;
                }
            }
                break;
            case 3:
            {
                ServiceLeftCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:ServiceLeftCellindentifier];
                }
                if (indexPath.row<_Gudingmodel.list.count) {
                    SALeftModel *model = _Gudingmodel.list[indexPath.row];
                    cell.lbTitle.text = model.name;
                }
                return cell;
            }
                break;
#pragma mark -----------销售单已购置换、左tableveiw-------------
            case 4:
            {
                ServiceLeftCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:ServiceLeftCellindentifier];
                }
                if (indexPath.row<_Yigoumodel.list.count) {
                    SALeftModel *model = _Yigoumodel.list[indexPath.row];
                    cell.lbTitle.text = model.name;
                }
                return cell;
            }
                break;
            case 5:
            {
                ServiceLeftCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:ServiceLeftCellindentifier];
                }
                if (indexPath.row<_Gexingmodel.list.count) {
                    SALeftModel *model = _Gexingmodel.list[indexPath.row];
                    cell.lbTitle.text = model.name;
                }
                return cell;
            }
                break;
            case 6:
            {
                ServiceLeftCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:ServiceLeftCellindentifier];
                }
                if (indexPath.row<_Shengkamodel.list.count) {
                    SALeftModel *model = _Shengkamodel.list[indexPath.row];
                    cell.lbTitle.text = model.name;
                }
                return cell;
            }
                break;
            case 7:
            {
                ServiceLeftCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:ServiceLeftCellindentifier];
                }
                if (indexPath.row<_KaiShiZhiHuanmodel.list.count) {
                    SALeftModel *model = _KaiShiZhiHuanmodel.list[indexPath.row];
                    cell.lbTitle.text = model.name;
                }
                return cell;
            }
                break;
            default:
                break;
        }
    }
    if(tableView == _tbViewRight){
#pragma mark ----------------销售单、固定开单-项目 ，右tableview
        static NSString *GuDingProOneCellindentifier = @"GuDingProOneCellindentifier";
        static NSString *ShengKaXuKaCellindentifier = @"ShengKaXuKaCellindentifier";
        if (_isSale) {
            switch (_billType) {
                case 3:
                {
                    GuDingProOneCell *cell;
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"GuDingProOneCell" owner:nil options:nil] firstObject];
                    }else{
                        cell  = [tableView dequeueReusableCellWithIdentifier:GuDingProOneCellindentifier];
                    }
                    __block GuDingProOneCell *tempCell = cell;
                    NSArray *arr;
                    if (_isGuDingSearch) {
                        arr = _GuDingSearchArr;
                    } else {
                        arr = _dicRight[_typeStrRight];
                    }
                    if (arr &&(arr.count > 0)) {
                        if (indexPath.row<arr.count) {
                            SaleModel *model = arr[indexPath.row];
                            if ([_typeStrRight isEqualToString:@"pro"]) {//固定制单-项目
                                [cell freshGuDingProOneCell:model];
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    if (model.isShow) {
                                        NSArray *arrNum = [model.price_list.pro_21.num componentsSeparatedByString:@","];
                                        NSString *cishu;
                                        if (_LiaoChengCiShuList.count > 0) {
                                            [_LiaoChengCiShuList removeAllObjects];
                                        }
                                        if (arrNum.count > 0) {
                                            cishu = arrNum[0];
                                            for (NSString *cishustr in arrNum) {
                                                CiShuModel *ciShuModel = [[CiShuModel alloc]init];
                                                ciShuModel.cishu = cishustr;
                                                [_LiaoChengCiShuList addObject:ciShuModel];
                                            }
                                        }
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                
                                cell.btnCiShuGDKDBlock = ^{
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    NSArray *arrNum = [model.price_list.pro_21.num componentsSeparatedByString:@","];
                                    NSString *cishu;
                                    if (_LiaoChengCiShuList.count > 0) {
                                        [_LiaoChengCiShuList removeAllObjects];
                                    }
                                    if (arrNum.count > 0) {
                                        cishu = arrNum[0];
                                        for (NSString *cishustr in arrNum) {
                                            CiShuModel *ciShuModel = [[CiShuModel alloc]init];
                                            ciShuModel.cishu = cishustr;
                                            [_LiaoChengCiShuList addObject:ciShuModel];
                                        }
                                    }
                                    [self btnCiShuChoiceEvent];
                                };
                                cell.btnZheKouGDKDBlock = ^{
                                    if ([tempCell.lb12.text isEqualToString:@"请选择抵用券"]) {
                                        _ChangeSaleModelmodel = model;
                                        _ChangeindexPath = indexPath;
                                        [self requestZheKouYouHuiSearchId:[NSString stringWithFormat:@"%ld",model.uid] proNum:tempCell.lb8.text type:_typeStrRight];
                                    }else{
                                        [MzzHud toastWithTitle:@"" message:@"会员卡优惠和抵用券不可同时使用"];
                                    }

                                };
                                
                                cell.btnQuanGDKDBlock = ^{
                                    if ([tempCell.lb10.text isEqualToString:@"请选择优惠卡"]) {
                                        _ChangeSaleModelmodel = model;
                                        _ChangeindexPath = indexPath;
                                        [self requestDiYongQuan:[NSString stringWithFormat:@"%ld",model.uid] type:_typeStrRight code:model.code];
                                    }else{
                                        [MzzHud toastWithTitle:@"" message:@"会员卡优惠和抵用券不可同时使用"];
                                    }
                                    
                                };
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (model.addnum == 0) {
                                                for (SaleModel *delmodel in _GDKDProSelfTempArr) {
                                                    if ([delmodel.code isEqualToString:model.code]) {
                                                        [_GDKDProSelfTempArr removeObject:delmodel];
                                                        [self reduceChangeNumMethod];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GDKDProSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GDKDProSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GDKDProSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    
                                };
                            }else if ([_typeStrRight isEqualToString:@"goods"])
                            {
                                [cell freshGuDingProChanPinCell:model];
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                    if (addflag == 1) {
                                        if (model.addnum == 0) {
                                            for (SaleModel *delmodel in _GDKDGoodsSelfTempArr) {
                                                if ([delmodel.code isEqualToString:model.code]) {
                                                    [_GDKDGoodsSelfTempArr removeObject:delmodel];
                                                    [self reduceChangeNumMethod];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnZheKouGDKDBlock = ^{
                                    if ([tempCell.lb12.text isEqualToString:@"请选择抵用券"]) {
                                        _ChangeSaleModelmodel = model;
                                        _ChangeindexPath = indexPath;
                                        [self requestZheKouYouHuiSearchId:[NSString stringWithFormat:@"%ld",model.uid] proNum:@"" type:_typeStrRight];
                                    }else{
                                        [MzzHud toastWithTitle:@"" message:@"会员卡优惠和抵用券不可同时使用"];
                                    }
                                    
                                };
                                cell.btnQuanGDKDBlock = ^{
                                    if ([tempCell.lb10.text isEqualToString:@"请选择优惠卡"]) {
                                        _ChangeSaleModelmodel = model;
                                        _ChangeindexPath = indexPath;
                                        [self requestDiYongQuan:[NSString stringWithFormat:@"%ld",model.uid] type:_typeStrRight code:model.code];
                                    }else{
                                        [MzzHud toastWithTitle:@"" message:@"会员卡优惠和抵用券不可同时使用"];
                                    }
                                    
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GDKDGoodsSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GDKDGoodsSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GDKDGoodsSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"card_course"]) //固定制单 特惠卡
                            {
                                [cell freshGuDingTeHuiKaCell:model];
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                    if (addflag == 1) {
                                        if (model.addnum == 0) {
                                            for (SaleModel *delmodel in _GDKDTeHuiSelfTempArr) {
                                                if ([delmodel.code isEqualToString:model.code]) {
                                                    [_GDKDTeHuiSelfTempArr removeObject:delmodel];
                                                    [self reduceChangeNumMethod];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnJiangzhengChoiseTeHuiKaBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    model.jiangzhengSelect = !model.jiangzhengSelect;
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnZheKouGDKDBlock = ^{
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    [self BaoHanNeiRongMethod];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    if (!model.isBaoHan) {
                                        [MzzHud toastWithTitle:@"" message:@"包含内容务必要填写"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GDKDTeHuiSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GDKDTeHuiSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GDKDTeHuiSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"card_num"])
                            {
                                [cell freshGuDingRenXuanCell:model];
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                    if (addflag == 1) {
                                        if (model.addnum == 0) {
                                            for (SaleModel *delmodel in _GDKDRenXuanSelfTempArr) {
                                                if ([delmodel.code isEqualToString:model.code]) {
                                                    [_GDKDRenXuanSelfTempArr removeObject:delmodel];
                                                    [self reduceChangeNumMethod];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GDKDRenXuanSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GDKDRenXuanSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GDKDRenXuanSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"stored_card"])
                            {
                                [cell freshGuDingChuZhiCell:model];
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                    if (addflag == 1) {
                                        if (model.addnum == 0) {
                                            for (SaleModel *delmodel in _GDKDChuZhiSelfTempArr) {
                                                if ([delmodel.code isEqualToString:model.code]) {
                                                    [_GDKDChuZhiSelfTempArr removeObject:delmodel];
                                                    [self reduceChangeNumMethod];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GDKDChuZhiSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GDKDChuZhiSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GDKDChuZhiSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"card_time"])
                            {
                                [cell freshGuDingshijianCell:model];
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    if (model.isShow) {
                                        
                                        
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                    if (addflag == 1) {
                                        if (model.addnum == 0) {
                                            for (SaleModel *delmodel in _GDKDTimeSelfTempArr) {
                                                if ([delmodel.code isEqualToString:model.code]) {
                                                    [_GDKDTimeSelfTempArr removeObject:delmodel];
                                                    [self reduceChangeNumMethod];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnZheKouGDKDBlock = ^{
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    [self requestZheKouYouHuiSearchId:[NSString stringWithFormat:@"%ld",model.uid] proNum:@"" type:_typeStrRight];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GDKDTimeSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GDKDTimeSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    [_GDKDTimeSelfTempArr addObject:model];
                                };
                            }else if ([_typeStrRight isEqualToString:@"ticket"])
                            {
                                [cell freshGuDingpiaoquanCell:model];
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    if (model.isShow) {
                                        
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                    if (addflag == 1) {
                                        if (model.addnum == 0) {
                                            for (SaleModel *delmodel in _GDKDTicketSelfTempArr) {
                                                if ([delmodel.code isEqualToString:model.code]) {
                                                    [_GDKDTicketSelfTempArr removeObject:delmodel];
                                                    [self reduceChangeNumMethod];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                WeakSelf;
                                cell.btnCiShuGDKDBlock = ^{
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    [weakSelf XiangXiShuoMingEvent:_ChangeSaleModelmodel.end_time];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GDKDTicketSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GDKDTicketSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    [_GDKDTicketSelfTempArr addObject:model];
                                };
                            }
                        }
                    }
                    return cell;
                }
                    break;
#pragma mark ----------------销售单已购置换、右tableveiw----------------------
                case 4:
                {
                    GuDingProOneCell *cell;
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"GuDingProOneCell" owner:nil options:nil] firstObject];
                    }else{
                        cell  = [tableView dequeueReusableCellWithIdentifier:GuDingProOneCellindentifier];
                    }
                    __block GuDingProOneCell *tempCell = cell;
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanProSearch) {
                            arr = _YiGouZhiHuanProSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanProList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        [cell freshYiGouZhiHuanProOneCell:model QuanBuState:NO];
                        cell.btnMoreYiGouZhiHuanBlock = ^(SAZhiHuanPorModel *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnYGZHReduiceAddBlock = ^(SAZhiHuanPorModel *model, NSInteger addflag) {
                            switch (addflag) {
                                case 1:
                                {
                                    if (model.numDisPlay == 0) {
                                        for (SAZhiHuanPorModel *delmodel in _YGZHProSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_YGZHProSelfTempArr removeObject:delmodel];
                                                [self reduceChangeNumMethod];
                                                break;
                                            }
                                        }
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnQauanBuYiGouZhiHuanBlock = ^(SAZhiHuanPorModel *model) {
                            
                            for (SAZhiHuanPorModel *delmodel in _YGZHProSelfTempArr) {
                                if ([delmodel.code isEqualToString:model.code]&&(delmodel.uid == model.uid)) {
                                    [_YGZHProSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            if (model.nums==0) {
                                model.numDisPlay=1;
                            }
                            model.isQuanBuHuiShou = YES;
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnQuanBu.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHProSelfTempArr addObject:model];
                            [self reduceChangeNumMethod];
                        };
                        cell.btnShopYiGouZhiHuanBlock = ^(SAZhiHuanPorModel *model) {
                            if (!model.numDisPlay) {
                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                return ;
                            }
                            for (SAZhiHuanPorModel *delmodel in _YGZHProSelfTempArr) {
                                if (delmodel.uid == model.uid) {
                                    [_YGZHProSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHProSelfTempArr addObject:model];
                        };
                        
                        return cell;
                    }else if ([_typeStrRight isEqualToString:@"goods"])
                    {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanGoodsSearch) {
                            arr = _YiGouZhiHuanGoodsSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanGoodsList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        [cell freshYiGouZhiHuanProOneCell:model QuanBuState:YES];
                        cell.btnMoreYiGouZhiHuanBlock = ^(SAZhiHuanPorModel *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnYGZHReduiceAddBlock = ^(SAZhiHuanPorModel *model, NSInteger addflag) {
                            switch (addflag) {
                                case 1:
                                {
                                    if (model.numDisPlay == 0) {
                                        for (SAZhiHuanPorModel *delmodel in _YGZHGoodsSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_YGZHGoodsSelfTempArr removeObject:delmodel];
                                                [self reduceChangeNumMethod];
                                                break;
                                            }
                                        }
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopYiGouZhiHuanBlock = ^(SAZhiHuanPorModel *model) {
                            if (!model.numDisPlay) {
                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                return ;
                            }
                            for (SAZhiHuanPorModel *delmodel in _YGZHGoodsSelfTempArr) {
                                if ([delmodel.code isEqualToString:model.code]) {
                                    [_YGZHGoodsSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHGoodsSelfTempArr addObject:model];
                        };
                        return cell;
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        static NSString *YiGouRenXuanCellindentifier = @"YiGouRenXuanCellindentifier";
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanRenXuanSearch) {
                            arr = _YiGouZhiHuanRenXuanSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanRenXuanList mutableCopy];
                        }
                        SAZhiHuanPorModel*model = arr[indexPath.row];
                        YiGouRenXuanCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"YiGouRenXuanCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:YiGouRenXuanCellindentifier];
                        }
                        __block YiGouRenXuanCell *temprenxuanCell = cell;
                        
                        [cell freshYiGouRenXuanCell:model withIfChuZhi:NO];
                        cell.btnMoreYiGouRenXuanCellBlock = ^(SAZhiHuanPorModel *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnReduceYiGouRenXuanCellBlock = ^(SAZhiHuanPorModel *model, NSInteger addFlag) {
                            switch (addFlag) {
                                case 1:
                                {
                                    if (model.numDisPlay == 0) {
                                        for (SAZhiHuanPorModel *delmodel in _YGZHRenXuanSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_YGZHRenXuanSelfTempArr removeObject:delmodel];
                                                [self reduceChangeNumMethod];
                                                break;
                                            }
                                        }
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnQuanBuYiGouRenXuanCellBlock = ^(SAZhiHuanPorModel *model) {
                            for (SAZhiHuanPorModel *delmodel in _YGZHRenXuanSelfTempArr) {
                                if ([delmodel.code isEqualToString:model.code]) {
                                    [_YGZHRenXuanSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            if (model.nums==0) {
                                model.numDisPlay=1;
                            }
                            model.isQuanBuHuiShou = YES;
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                            CGRect fromeRect = [temprenxuanCell convertRect:temprenxuanCell.btnQuanBu.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHRenXuanSelfTempArr addObject:model];
                            [self reduceChangeNumMethod];
                        };
                        cell.btnShopYiGouRenXuanCellBlock = ^(SAZhiHuanPorModel *model) {
                            if (!model.numDisPlay) {
                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                return ;
                            }
                            for (SAZhiHuanPorModel *delmodel in _YGZHRenXuanSelfTempArr) {
                                if ([delmodel.code isEqualToString:model.code]) {
                                    [_YGZHRenXuanSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            CGRect fromeRect = [temprenxuanCell convertRect:temprenxuanCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHRenXuanSelfTempArr addObject:model];
                        };
                        
                        return cell;
                        
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        ShengKaXuKaCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"ShengKaXuKaCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:ShengKaXuKaCellindentifier];
                        }
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanTimeSearch) {
                            arr = _YiGouZhiHuanTimeSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanTimeList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        [cell freshYiGouZhiHuanTime:model];
                        cell.btnMoreYiGouZhiHuanTimeBlock = ^(SAZhiHuanPorModel *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnYGZHReduiceAddTimeBlock = ^(SAZhiHuanPorModel *model, NSInteger addflag) {
                            switch (addflag) {
                                case 1:
                                {
                                    if (model.numDisPlay == 0) {
                                        for (SAZhiHuanPorModel *delmodel in _YGZHTimeSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_YGZHTimeSelfTempArr removeObject:delmodel];
                                                [self reduceChangeNumMethod];
                                                break;
                                            }
                                        }
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopYiGouZhiHuanTimeBlock = ^(SAZhiHuanPorModel *model) {
                            if (!model.numDisPlay) {
                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                return ;
                            }
                            if ([model.totalPrice integerValue]>model.price) {
                                [MzzHud toastWithTitle:@"" message:@"回收金额不能大于购买金额"];
                                return ;
                            }
                            for (SAZhiHuanPorModel *delmodel in _YGZHTimeSelfTempArr) {
                                if ([delmodel.code isEqualToString:model.code]) {
                                    [_YGZHTimeSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHTimeSelfTempArr addObject:model];
                        };
                        return cell;
                    }else if ([_typeStrRight isEqualToString:@"sales"])
                    {
                        GuDingProOneCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"GuDingProOneCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:GuDingProOneCellindentifier];
                        }
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanDingJinDingDanSearch) {
                            arr = _YiGouZhiHuanDingJinDingDanSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanDingJinDingDanList mutableCopy];
                        }
                        SADepositListModelSales *model = arr[indexPath.row];
                        [cell freshYiGouZhiHuanDingJinDingDanCell:model];
                        
                        cell.btnMoreYiGouZhiHuanDingJinBlock = ^(SADepositListModelSales *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnYGZHReduiceAddDingJinBlock = ^(SADepositListModelSales *model, NSInteger addflag) {
                            switch (addflag) {
                                case 1:
                                {
                                    if (model.numDisPlay == 0) {
                                        for (SADepositListModelSales *delmodel in _YGZHDingjinSelfTempArr) {
                                            if ([delmodel.ordernum isEqualToString:model.ordernum]) {
                                                [_YGZHDingjinSelfTempArr removeObject:delmodel];
                                                [self reduceChangeNumMethod];
                                                break;
                                            }
                                        }
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopDingJinBlock = ^(SADepositListModelSales *model) {
                            if (!model.numDisPlay) {
                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                return ;
                            }
                            for (SADepositListModelSales *delmodel in _YGZHDingjinSelfTempArr) {
                                if ([delmodel.ordernum isEqualToString:model.ordernum]) {
                                    [_YGZHDingjinSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            model.totalPrice = [NSString stringWithFormat:@"%@",@(model.numDisPlay * model.tk_amount)];
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHDingjinSelfTempArr addObject:model];
                        };
                        return cell;
                    }else if ([_typeStrRight isEqualToString:@"ticket"])
                    {
                        ShengKaXuKaCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"ShengKaXuKaCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:ShengKaXuKaCellindentifier];
                        }
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanPiaoQuanSearch) {
                            arr = _YiGouZhiHuanPiaoQuanSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanPiaoQuanList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        [cell freshYiGouZhiHuanPiaoQuan:model];
                        cell.btnMoreYiGouZhiHuanTimeBlock = ^(SAZhiHuanPorModel *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnYGZHReduiceAddTimeBlock = ^(SAZhiHuanPorModel *model, NSInteger addflag) {
                            switch (addflag) {
                                case 1:
                                {
                                    if (model.numDisPlay == 0) {
                                        for (SAZhiHuanPorModel *delmodel in _YGZHTicketSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_YGZHTicketSelfTempArr removeObject:delmodel];
                                                [self reduceChangeNumMethod];
                                                break;
                                            }
                                        }
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopYiGouZhiHuanTimeBlock = ^(SAZhiHuanPorModel *model) {
                            if (!model.numDisPlay) {
                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                return ;
                            }
                            for (SAZhiHuanPorModel *delmodel in _YGZHTicketSelfTempArr) {
                                if ([delmodel.code isEqualToString:model.code]) {
                                    [_YGZHTicketSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHTicketSelfTempArr addObject:model];
                        };
                        return cell;
                    }
#pragma mark ---------已购置换储值卡，右侧tableview
                    else if ([_typeStrRight isEqualToString:@"stored_card"])
                    {
                        static NSString *YiGouChuZhiCellindentifier = @"YiGouChuZhiCellindentifier";
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanChuZhiSearch) {
                            arr = _YiGouZhiHuanChuZhiSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanChuZhiList mutableCopy];
                        }
                        SAZhiHuanPorModel*model = arr[indexPath.row];
                        YiGouRenXuanCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"YiGouRenXuanCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:YiGouChuZhiCellindentifier];
                        }
                        __block YiGouRenXuanCell *temprenxuanCell = cell;
                        
                        [cell freshYiGouRenXuanCell:model withIfChuZhi:YES];
                        cell.btnMoreYiGouRenXuanCellBlock = ^(SAZhiHuanPorModel *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopYiGouRenXuanCellBlock = ^(SAZhiHuanPorModel *model) {
                            if ([model.totalPrice integerValue]>model.money) {
                                [MzzHud toastWithTitle:@"" message:@"回收金额不能大于剩余金额"];
                                return ;
                            }
                            for (SAZhiHuanPorModel *delmodel in _YGZHChuZhiSelfTempArr) {
                                if ([delmodel.code isEqualToString:model.code]) {
                                    [_YGZHChuZhiSelfTempArr removeObject:delmodel];
                                    break;
                                }
                            }
                            CGRect fromeRect = [temprenxuanCell convertRect:temprenxuanCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            [_YGZHChuZhiSelfTempArr addObject:model];
                        };
                        
                        return cell;
                    }
                    return cell;
                }
                    break;
                case 5:
                {
                    GuDingProOneCell *cell;
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"GuDingProOneCell" owner:nil options:nil] firstObject];
                    }else{
                        cell  = [tableView dequeueReusableCellWithIdentifier:GuDingProOneCellindentifier];
                    }
                    __block GuDingProOneCell *tempCell = cell;
                    NSArray *arr;
                    if (_isGeXingSearch) {
                        arr = _GeXingSearchArr;
                    } else {
                        arr = _dicRight[_typeStrRight];
                    }
                    if (arr &&(arr.count > 0)) {
                        if (indexPath.row<arr.count) {
                            SaleModel *model = arr[indexPath.row];
                            if ([_typeStrRight isEqualToString:@"pro"]) {
                                [cell freshGeXingProCell:model];
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (blockmodel.addnum == 0) {
                                                for (SaleModel *tempmodel in _GXZDProSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                        [_GXZDProSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GXZDProSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GXZDProSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GXZDProSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                                
                            }else if ([_typeStrRight isEqualToString:@"goods"])
                            {
                                [cell freshGeXingProCell:model];
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (blockmodel.addnum == 0) {
                                                for (SaleModel *tempmodel in _GXZDGoodsSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                        [_GXZDGoodsSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GXZDGoodsSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GXZDGoodsSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GXZDGoodsSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"card_course"])
                            {
                                [cell freshGeXingTeHuiKaCell:model];
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (blockmodel.addnum == 0) {
                                                for (SaleModel *tempmodel in _GXZDTeHuiSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                        [_GXZDTeHuiSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnQuanGDKDBlock = ^{
                                    _ChangeSaleModelmodel = model;
                                    _ChangeindexPath = indexPath;
                                    [self BaoHanNeiRongMethod];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    if (!model.isBaoHan) {
                                        [MzzHud toastWithTitle:@"" message:@"包含内容务必要填写"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GXZDTeHuiSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GXZDTeHuiSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GXZDTeHuiSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"card_num"])
                            {
                                [cell freshGeXingRenXuanCell:model];
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (blockmodel.addnum == 0) {
                                                for (SaleModel *tempmodel in _GXZDRenXuanSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                        [_GXZDRenXuanSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GXZDRenXuanSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GXZDRenXuanSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GXZDRenXuanSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"card_time"])
                            {
                                [cell freshGeXingShiJianCell:model];
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (blockmodel.addnum == 0) {
                                                for (SaleModel *tempmodel in _GXZDTimeSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                        [_GXZDTimeSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GXZDTimeSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GXZDTimeSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GXZDTimeSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }else if ([_typeStrRight isEqualToString:@"ticket"])
                            {
                                [cell freshGeXingPiaoQuanCell:model];
                                cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (blockmodel.addnum == 0) {
                                                for (SaleModel *tempmodel in _GXZDTicketSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                        [_GXZDTicketSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                                cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                    if (!model.addnum) {
                                        [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                        return ;
                                    }
                                    for (SaleModel *delmodel in _GXZDTicketSelfTempArr) {
                                        if ([delmodel.code isEqualToString:model.code]) {
                                            [_GXZDTicketSelfTempArr removeObject:delmodel];
                                            break;
                                        }
                                    }
                                    [_GXZDTicketSelfTempArr addObject:model];
                                    CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                };
                            }
                            cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                
                                [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                            };
                        }
                    }
                    return cell;
                }
                    break;
                case 6:
                {
#pragma mark --------销售单，升卡续卡右侧tableview
                    WeakSelf;
                    ShengKaXuKaCell *cell;
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShengKaXuKaCell" owner:nil options:nil] firstObject];
                    }else{
                        cell  = [tableView dequeueReusableCellWithIdentifier:ShengKaXuKaCellindentifier];
                    }
                    __block ShengKaXuKaCell *tempCell = cell;
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        [cell freshShengKaXuKaProCell:_sKXKProOneceModel];
                        [cell.btnMore addTarget:self action:@selector(btnMoreProEvent) forControlEvents:UIControlEventTouchUpInside];
                        [cell.btnMuBiao addTarget:self action:@selector(btnmubiaoEvent) forControlEvents:UIControlEventTouchUpInside];
                        cell.btnShopShengKaXuKaCellBlock = ^(NSString *ids,NSString *to_code,NSString *save_old, NSString *to_type, NSString *up_type, NSString *price,SKXKProOneceModel *model) {
                            [_cartSubProArr removeAllObjects];
                            [_SKXKproDic setValue:ids forKey:@"ids"];
                            [_SKXKproDic setValue:model.ShengKaXuKaProList forKey:@"old"];
                            [_SKXKproDic setValue:model.ShengKaXuKaShengKaMuBiaoListModel forKey:@"new"];
                            [_SKXKproDic setValue:to_code forKey:@"to_code"];
                            [_SKXKproDic setValue:@"pro" forKey:@"to_liexing"];
                            [_SKXKproDic setValue:save_old forKey:@"save_old"];
                            [_SKXKproDic setValue:to_type forKey:@"to_type"];
                            [_SKXKproDic setValue:up_type forKey:@"up_type"];
                            [_SKXKproDic setValue:price forKey:@"price"];
                            [_SKXKproDic setValue:@"项目疗程卡" forKey:@"name"];
                            [_SKXKproDic setValue:@"1" forKey:@"numDisplay"];
                            [_cartSubProArr addObject:_SKXKproDic];
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                        };
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        ShengKaXuKaRenXuanData *model = _ShengKaXuKaRenXuanKaList[indexPath.row];
                        [cell freshShengKaXuKaRenXuanCell:model];
                        cell.btnRenXuanmubiaoBlock = ^(ShengKaXuKaRenXuanData *model) {
                            _ShengKaXuKaRenXuanDataModel = model;
                            _ChangeindexPath = indexPath;
                            [weakSelf btnmubiaoEvent];
                        };
                        cell.btnMoreCardnumEventBlock = ^(ShengKaXuKaRenXuanData *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopShengKaXuKaCardNumCellBlock = ^(NSString *ids,NSString *to_code,NSString *award_del,NSString *save_old,NSString *to_type,NSString *up_type,NSString *price,NSString *name,NSString *numDisPlay,ShengKaXuKaRenXuanData *model) {
                            for (NSMutableDictionary *tempDic in _cartSubCardNumArr) {
                                if ([tempDic[@"ids"] isEqualToString:ids]) {
                                    [_cartSubCardNumArr removeObject:tempDic];
                                    break;
                                }
                            }
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            [dic setValue:ids forKey:@"ids"];
                            [dic setValue:model forKey:@"old"];
                            [dic setValue:model.ShengKaXuKaShengKaMuBiaoListModel forKey:@"new"];
                            [dic setValue:[NSString stringWithFormat:@"%ld",_ShengKaXuKaRenXuanDataModel.nums] forKey:@"numMax"];
                            [dic setValue:@"card_num" forKey:@"to_liexing"];
                            [dic setValue:to_code forKey:@"to_code"];
                            [dic setValue:award_del forKey:@"award_del"];
                            [dic setValue:save_old forKey:@"save_old"];
                            [dic setValue:to_type forKey:@"to_type"];
                            [dic setValue:up_type forKey:@"up_type"];
                            [dic setValue:price forKey:@"price"];
                            [dic setValue:name forKey:@"name"];
                            [dic setValue:numDisPlay forKey:@"numDisplay"];
                            [_cartSubCardNumArr addObject:dic];
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                        };
                    }else if ([_typeStrRight isEqualToString:@"stored_card"])
                    {
                        ShengKaChuZhiList *model = _ShengKaXuKaChuZhiModelList[indexPath.row];
                        [cell freshShengKaXuKaChuZhiCell:model];
                        cell.btnStoremubiaoBlock = ^(ShengKaChuZhiList *model) {
                            _ShengKaChuZhiListmodel = model;
                            _ChangeindexPath = indexPath;
                            [weakSelf chuzhikaMuBiao:@"stored_card" code:model.code];
                            [weakSelf btnmubiaoEvent];
                        };
                        cell.btnMoreStoreEventBlock = ^(ShengKaChuZhiList *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnSKXKStore_cardSXEventBlock = ^(ShengKaChuZhiList *model, NSInteger btnChoice) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopShengKaXuKaStoreCardCellBlock = ^(NSString *ids,NSString *to_code,NSString *award_del,NSString *save_old,NSString *to_type,NSString *up_type,NSString *price,NSString *name,NSString *numDisPlay,ShengKaChuZhiList *model) {
                            
                            for (NSMutableDictionary *tempDic in _cartSubStoreCardArr) {
                                if ([tempDic[@"ids"] isEqualToString:ids]) {
                                    [_cartSubStoreCardArr removeObject:tempDic];
                                    break;
                                }
                            }
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            [dic setValue:ids forKey:@"ids"];
                            [dic setValue:model forKey:@"old"];
                            if ([model.to_type isEqualToString:@"1"]) {
                                [dic setValue:model.ShengKaXuKaShengKaMuBiaoListModel forKey:@"new"];
                                [dic setValue:to_code forKey:@"to_code"];
                            } else if([model.to_type isEqualToString:@"2"]){
                                ShengKaXuKaKeShengHuiYuanKaList *tem = [[ShengKaXuKaKeShengHuiYuanKaList alloc]init];
                                model.ShengKaXuKaShengKaMuBiaoListModel = tem;
                                tem.name = model.name;
                                tem.code = model.code;
                                tem.card_id = model.card_id;
                                tem.denomination = model.money;
                                tem.price = price;
                                [dic setValue:model.code forKey:@"to_code"];
                                [dic setValue:tem forKey:@"new"];
                            }
                            [dic setValue:@"stored_card" forKey:@"to_liexing"];
                            [dic setValue:award_del forKey:@"award_del"];
                            [dic setValue:save_old forKey:@"save_old"];
                            [dic setValue:to_type forKey:@"to_type"];
                            [dic setValue:up_type forKey:@"up_type"];
                            [dic setValue:price forKey:@"price"];
                            [dic setValue:name forKey:@"name"];
                            [dic setValue:numDisPlay forKey:@"numDisplay"];
                            [_cartSubStoreCardArr addObject:dic];
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                        };
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        ShengKaXuKaShiJianList *model = _ShengKaXuKaShiJianModelList[indexPath.row];
                        [cell freshShengKaXuKashijianCell:model];
                        cell.btnTimemubiaoBlock = ^(ShengKaXuKaShiJianList *model) {
                            _ShengKaXuKaShiJianListModel = model;
                            _ChangeindexPath = indexPath;
                            [weakSelf btnmubiaoEvent];
                        };
                        cell.btnMoreTimeEventBlock = ^(ShengKaXuKaShiJianList *model) {
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        };
                        cell.btnShopShengKaXuKaTimeCellBlock = ^(NSString *ids,NSString *to_code,NSString *award_del,NSString *save_old,NSString *to_type,NSString *up_type,NSString *price,NSString *name,NSString *numDisPlay,ShengKaXuKaShiJianList *model){
                            for (NSMutableDictionary *tempDic in _cartSubTimeArr) {
                                if ([tempDic[@"ids"] isEqualToString:ids]) {
                                    [_cartSubTimeArr removeObject:tempDic];
                                    break;
                                }
                            }
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            [dic setValue:ids forKey:@"ids"];
                            [dic setValue:model forKey:@"old"];
                            [dic setValue:model.ShengKaXuKaShengKaMuBiaoListModel forKey:@"new"];
                            [dic setValue:to_code forKey:@"to_code"];
                            [dic setValue:@"card_time" forKey:@"to_liexing"];
                            [dic setValue:award_del forKey:@"award_del"];
                            [dic setValue:save_old forKey:@"save_old"];
                            [dic setValue:to_type forKey:@"to_type"];
                            [dic setValue:up_type forKey:@"up_type"];
                            [dic setValue:price forKey:@"price"];
                            [dic setValue:name forKey:@"name"];
                            [dic setValue:numDisPlay forKey:@"numDisplay"];
                            [_cartSubTimeArr addObject:dic];
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                        };
                    }
                    return cell;
                }
                    break;
                case 7:
                {
                    if ([_typeStrRight isEqualToString:@"bank"]){
                        GuDingProOneCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"GuDingProOneCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:GuDingProOneCellindentifier];
                        }
                        __block GuDingProOneCell *tempCell = cell;
                        [cell freshKSZHUserProOneCell:_SAAccountModelmodel userName:_name];
                        cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;
                        cell.btnShopKSZHUserBlock = ^(SAAccountModel *saamodel) {
                            [_CustomerTempArr removeAllObjects];
                            [_CustomerTempArr addObject:saamodel];
                            
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                        };
                        return cell;
                    }else{
                        GuDingProOneCell *cell;
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"GuDingProOneCell" owner:nil options:nil] firstObject];
                        }else{
                            cell  = [tableView dequeueReusableCellWithIdentifier:GuDingProOneCellindentifier];
                        }
                        __block GuDingProOneCell *tempCell = cell;
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanSearch) {
                            arr = _YiGouZhiHuanSearchArr;
                        } else {
                            arr = _dicRight[_typeStrRight];
                        }
                        if (arr &&(arr.count > 0)) {
                            if (indexPath.row<arr.count) {
                                SaleModel *model = arr[indexPath.row];
                                if ([_typeStrRight isEqualToString:@"pro"]) {
                                    cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;
                                    [cell freshGeXingProCell:model];
                                    cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                        switch (addflag) {
                                            case 1:
                                            {
                                                if (blockmodel.addnum == 0) {
                                                    for (SaleModel *tempmodel in _GXZDProSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                            [_GXZDProSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                                break;
                                            case 2:
                                            {
                                            }
                                                break;
                                            default:
                                                break;
                                        }
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                        if (!model.addnum) {
                                            [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                            return ;
                                        }
                                        for (SaleModel *delmodel in _GXZDProSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_GXZDProSelfTempArr removeObject:delmodel];
                                                break;
                                            }
                                        }
                                        [_GXZDProSelfTempArr addObject:model];
                                        CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    cell.textJiaGeBlock = ^(SaleModel *model) {
                                        
                                    };
                                }else if ([_typeStrRight isEqualToString:@"goods"])
                                {
                                    [cell freshGeXingProCell:model];
                                    cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;

                                    cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                        switch (addflag) {
                                            case 1:
                                            {
                                                if (blockmodel.addnum == 0) {
                                                    for (SaleModel *tempmodel in _GXZDGoodsSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                            [_GXZDGoodsSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                                break;
                                            case 2:
                                            {
                                            }
                                                break;
                                            default:
                                                break;
                                        }
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                        if (!model.addnum) {
                                            [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                            return ;
                                        }
                                        for (SaleModel *delmodel in _GXZDGoodsSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_GXZDGoodsSelfTempArr removeObject:delmodel];
                                                break;
                                            }
                                        }
                                        [_GXZDGoodsSelfTempArr addObject:model];
                                        CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    };
                                }else if ([_typeStrRight isEqualToString:@"card_course"])
                                {
                                    [cell freshGeXingTeHuiKaCell:model];
                                    cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;
                                    cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                        switch (addflag) {
                                            case 1:
                                            {
                                                if (blockmodel.addnum == 0) {
                                                    for (SaleModel *tempmodel in _GXZDTeHuiSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                            [_GXZDTeHuiSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                                break;
                                            case 2:
                                            {
                                            }
                                                break;
                                            default:
                                                break;
                                        }
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    cell.btnQuanGDKDBlock = ^{
                                        _ChangeSaleModelmodel = model;
                                        _ChangeindexPath = indexPath;
                                        [self BaoHanNeiRongMethod];
                                    };
                                    cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                        if (!model.addnum) {
                                            [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                            return ;
                                        }
                                        if (!model.isBaoHan) {
                                            [MzzHud toastWithTitle:@"" message:@"包含内容务必要填写"];
                                            return ;
                                        }
                                        for (SaleModel *delmodel in _GXZDTeHuiSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_GXZDTeHuiSelfTempArr removeObject:delmodel];
                                                break;
                                            }
                                        }
                                        [_GXZDTeHuiSelfTempArr addObject:model];
                                        CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    };
                                }else if ([_typeStrRight isEqualToString:@"card_num"])
                                {
                                    [cell freshGeXingRenXuanCell:model];
                                    cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;

                                    cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                        switch (addflag) {
                                            case 1:
                                            {
                                                if (blockmodel.addnum == 0) {
                                                    for (SaleModel *tempmodel in _GXZDRenXuanSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                            [_GXZDRenXuanSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                                break;
                                            case 2:
                                            {
                                            }
                                                break;
                                            default:
                                                break;
                                        }
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                        if (!model.addnum) {
                                            [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                            return ;
                                        }
                                        for (SaleModel *delmodel in _GXZDRenXuanSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_GXZDRenXuanSelfTempArr removeObject:delmodel];
                                                break;
                                            }
                                        }
                                        [_GXZDRenXuanSelfTempArr addObject:model];
                                        CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    };
                                }else if ([_typeStrRight isEqualToString:@"stored_card"])
                                {
                                    if (_zhiHuanChuZhiUserArr.count) {
                                        SaleModel *storedmodel = _zhiHuanChuZhiUserArr[indexPath.row];
                                        storedmodel.username = _name;
                                        [cell freshChuZhiUserCell:storedmodel];
                                        cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;

                                    } else {
                                        [cell freshGuDingChuZhiCell:model];
                                        cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                                            if (addflag == 1) {
                                                if (model.addnum == 0) {
                                                    for (SaleModel *delmodel in _GDKDChuZhiSelfTempArr) {
                                                        if ([delmodel.code isEqualToString:model.code]) {
                                                            [_GDKDChuZhiSelfTempArr removeObject:delmodel];
                                                            [self reduceChangeNumMethod];
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                        };
                                    }
                                    cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                        _ChangeSaleModelmodel = model;
                                        _ChangeindexPath = indexPath;
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    
                                    cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                        if (!_zhiHuanChuZhiUserArr.count) {
                                            if (!model.addnum) {
                                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                                return ;
                                            }
                                        }else{
                                            model.addnum=1;
                                        }
                                        for (SaleModel *delmodel in _GDKDChuZhiSelfTempArr) {
                                            if (_zhiHuanChuZhiUserArr.count) {
                                                if (delmodel.user_card_id == model.user_card_id) {
                                                    [_GDKDChuZhiSelfTempArr removeObject:delmodel];
                                                    break;
                                                }
                                            } else {
                                                if ([delmodel.code isEqualToString:model.code]) {
                                                    [_GDKDChuZhiSelfTempArr removeObject:delmodel];
                                                    break;
                                                }
                                            }
                                        }
                                        [_GDKDChuZhiSelfTempArr addObject:model];
                                        CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    };
                                }else if ([_typeStrRight isEqualToString:@"card_time"])
                                {
                                    [cell freshGeXingShiJianCell:model];
                                    cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;

                                    cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                        switch (addflag) {
                                            case 1:
                                            {
                                                if (blockmodel.addnum == 0) {
                                                    for (SaleModel *tempmodel in _GXZDTimeSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                            [_GXZDTimeSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                                break;
                                            case 2:
                                            {
                                            }
                                                break;
                                            default:
                                                break;
                                        }
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                        if (!model.addnum) {
                                            [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                            return ;
                                        }
                                        for (SaleModel *delmodel in _GXZDTimeSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_GXZDTimeSelfTempArr removeObject:delmodel];
                                                break;
                                            }
                                        }
                                        [_GXZDTimeSelfTempArr addObject:model];
                                        CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    };
                                }else if ([_typeStrRight isEqualToString:@"ticket"])
                                {
                                    [cell freshGeXingPiaoQuanCell:model];
                                    cell.textJiaGe.keyboardType = UIKeyboardTypeDefault;

                                    cell.btnGDKDReduiceAddBlock = ^(SaleModel *blockmodel, NSInteger addflag) {
                                        switch (addflag) {
                                            case 1:
                                            {
                                                if (blockmodel.addnum == 0) {
                                                    for (SaleModel *tempmodel in _GXZDTicketSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:blockmodel.code]) {
                                                            [_GXZDTicketSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                                break;
                                            case 2:
                                            {
                                            }
                                                break;
                                            default:
                                                break;
                                        }
                                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                    };
                                    cell.btnShopGDKDBlock = ^(SaleModel *model) {
                                        if (!model.addnum) {
                                            [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                            return ;
                                        }
                                        for (SaleModel *delmodel in _GXZDTicketSelfTempArr) {
                                            if ([delmodel.code isEqualToString:model.code]) {
                                                [_GXZDTicketSelfTempArr removeObject:delmodel];
                                                break;
                                            }
                                        }
                                        [_GXZDTicketSelfTempArr addObject:model];
                                        CGRect fromeRect = [tempCell convertRect:tempCell.btnShop.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    };
                                }
                                cell.btnMoreGuDingBlock = ^(SaleModel *model) {
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                };
                            }
                        }
                        return cell;
                    }
                }
                    break;
                default:
                    break;
            }
        } else {
            SerViceRightCell *cell;
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SerViceRightCell" owner:nil options:nil] firstObject];
            }else{
                cell  = [tableView dequeueReusableCellWithIdentifier:SerViceRightCellindentifier];
            }
            __block SerViceRightCell *tempCell = cell;
            switch (_type) {
#pragma mark ----------------服务单-------服务单处方服务右侧tableview-----------------
                case Pres:
                {
                    if (indexPath.section < _SLPresModelmodel.list.count) {
                        SLPresListModel *SLPresListModelmodel = _SLPresModelmodel.list[indexPath.section];
                        NSMutableArray *arr;
                        if (_isPresSearch) {
                            arr = _PresSearchArr;
                        } else {
                            arr = [SLPresListModelmodel.pro_list mutableCopy];
                        }
                        if (indexPath.row < arr.count) {
                            Pro_List *Pro_Listmodel = arr[indexPath.row];
                            [cell freshSerViceRightCellPro_List:Pro_Listmodel];
                            cell.btnSerViceRightCellPro_ListBlock = ^(Pro_List *model, NSInteger indexAdd) {
                                switch (indexAdd) {
                                    case 1:
                                    {
                                        if (model.numDisplay > 0) {
                                            model.numDisplay --;
                                            for (NSMutableDictionary *tempDic in _presArr) {
                                                if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                                                    if (model.numDisplay == 0) {
                                                        [_presArr removeObject:tempDic];
                                                    }else{
                                                        tempDic[@"numDisplay"] = @(model.numDisplay);
                                                        tempDic[@"num"] = @(model.numDisplay);
                                                    }
                                                    break;
                                                }
                                            }
                                            [self reduceChangeNumMethod];
                                        }else{
                                            return ;
                                        }
                                    }
                                        break;
                                    case 2:
                                    {
                                        if (model.numDisplay >= model.num - model.num1) {
                                            [MzzHud toastWithTitle:@"温馨提示" message:@"本项目次数不足"];
                                            return;
                                        }
                                        model.numDisplay++;
                                        BOOL isFind = NO;
                                        for (NSMutableDictionary *tempDic in _presArr) {
                                            if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                                                tempDic[@"numDisplay"] = @(model.numDisplay);
                                                tempDic[@"num"] = @(model.numDisplay);
                                                isFind = YES;
                                                break;
                                            }
                                        }
                                        if (!isFind) {
                                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                            dic[@"name"] = model.pro_name;
                                            dic[@"id"] = @(model.ID);
                                            dic[@"numMax"] = @(model.num);
                                            dic[@"num"] = @(model.numDisplay);
                                            dic[@"numDisplay"] = @(model.numDisplay);
                                            dic[@"n_price"] = model.price;
                                            dic[@"price"] = model.price;
                                            dic[@"pro_code"] = model.pro_code;
                                            dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                                            dic[@"type"] = @"处方服务";
                                            [_presArr addObject:dic];
                                        }
                                        CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                        CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                        [self.view addSubview:self.redView];
                                        [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                    }
                                        break;
                                    default:
                                        break;
                                }
                                [_tbViewRight reloadData];
                            };
                        }
                    }
                    return cell;
                }
                    break;
                case tiCard:
                {//提卡服务
                    NSArray *arrstored_card = _SLTi_CardModelmodel.stored_card;
                    NSArray *arrcard_num = _SLTi_CardModelmodel.card_num;
                    NSArray *arrcard_time = _SLTi_CardModelmodel.card_time;
                    switch (_blocktype) {
                        case stored_cardType:
                        {
                            if (!arrstored_card.count) {
                                return nil;
                            }
                            SLStored_Card *model = arrstored_card[_blockindex];
                            switch (_blockwhice) {
                                case 1:
                                {
                                    NSMutableArray *arr;
                                    if (_isstored_cardTypeProSearch) {
                                        arr = _stored_cardTypeProSearchArr;
                                    } else {
                                        arr = [model.pro_list mutableCopy];
                                    }
                                    if (indexPath.row < arr.count) {
                                        SLPro_List *SLPro_Listmodel = arr[indexPath.row];
                                        [cell freshSerViceRightCellSLPro_List:SLPro_Listmodel Id:model.ID Type:stored_cardType Whice:1];
                                        cell.btnSerViceRightCellSLPro_ListdBlock = ^(NSInteger cID, SLPro_List *cmodel, TiCardType type, NSInteger whice, NSInteger indexAdd) {
                                            if (type == stored_cardType) {
                                                if (whice == 1) {
                                                    switch (indexAdd) {
                                                        case 1:
                                                        {
                                                            if (cmodel.numDisplay > 0) {
                                                                cmodel.numDisplay --;
                                                                for (NSMutableDictionary *tempDic in _stored_cardArr) {
                                                                    NSString *tempdicID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                                                                    NSInteger tempdicIDValue = [tempdicID integerValue];
                                                                    if ((cID == tempdicIDValue)&&[tempDic[@"pro_code"] isEqualToString:cmodel.pro_code]) {
                                                                        if (cmodel.numDisplay == 0) {
                                                                            [_stored_cardArr removeObject:tempDic];
                                                                        }else{
                                                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                                [self reduceChangeNumMethod];
                                                            }else{
                                                                return ;
                                                            }
                                                        }
                                                            break;
                                                        case 2:
                                                        {
                                                            BOOL isBeyond = NO;
                                                            NSInteger totalValue = 0;
                                                            for (NSMutableDictionary *tempDic in _stored_cardArr) {
                                                                NSString *tempPrice = [NSString stringWithFormat:@"%@",tempDic[@"price"]];
                                                                NSString *tempNum = [NSString stringWithFormat:@"%@",tempDic[@"numDisplay"]];
                                                                NSInteger tempPriveValue = [tempPrice integerValue];
                                                                NSInteger tempNumValue = [tempNum integerValue];
                                                                totalValue += tempPriveValue *tempNumValue;
                                                            }
                                                            NSString *totalMoney = [NSString stringWithFormat:@"%@",model.money];
                                                            NSInteger totalMoneyValue = [totalMoney integerValue];
                                                            
                                                            if ((cmodel.price + totalValue) > totalMoneyValue) {
                                                                [MzzHud toastWithTitle:@"温馨提示" message:@"余额不足"];
                                                                isBeyond = YES;
                                                                return ;
                                                            }
                                                            BOOL isfind = NO;
                                                            cmodel.numDisplay ++;
                                                            if (!isBeyond) {
                                                                for (NSMutableDictionary *tempDic in _stored_cardArr) {
                                                                    NSString *tempdicID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                                                                    NSInteger tempdicIDValue = [tempdicID integerValue];
                                                                    if ((cID == tempdicIDValue)&&[tempDic[@"pro_code"] isEqualToString:cmodel.pro_code]) {
                                                                        tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                        tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        isfind = YES;
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                            if (!isfind) {
                                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                                dic[@"name"] = cmodel.name;
                                                                dic[@"id"] = @(cID);
                                                                dic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                dic[@"num"] = @(cmodel.numDisplay);
                                                                dic[@"numMax"] =@"10000";
                                                                dic[@"n_price"] = @(cmodel.price);
                                                                dic[@"price"] = @(cmodel.price);
                                                                dic[@"pro_code"] = cmodel.pro_code;
                                                                dic[@"diffid"] = [NSString stringWithFormat:@"%ld%@",cID,cmodel.pro_code];
                                                                cmodel.diffid=[NSString stringWithFormat:@"%ld%@",cID,cmodel.pro_code];
                                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                                                dic[@"type"] = @"提卡项目";
                                                                [_stored_cardArr addObject:dic];
                                                            }
                                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                                            [self.view addSubview:self.redView];
                                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                                        }
                                                            break;
                                                        default:
                                                            break;
                                                    }
                                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                }
                                            }
                                        };
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    NSMutableArray *arr;
                                    if (_isstored_cardTypeGoodsSearch) {
                                        arr = _stored_cardTypeGoodsSearchArr;
                                    } else {
                                        arr = [model.goods_list mutableCopy];
                                    }
                                    if (indexPath.row < arr.count) {
                                        SLGoods_List *SLGoods_Listmodel = arr[indexPath.row];
                                        [cell freshSerViceRightCellSLGoods_List:SLGoods_Listmodel Id:model.ID Type:stored_cardType Whice:2];
                                        cell.btnSerViceRightCellSLGoods_ListBlock = ^(NSInteger cID, SLGoods_List *cmodel, TiCardType type, NSInteger whice, NSInteger indexAdd) {
                                            if (type == stored_cardType) {
                                                if (whice == 2) {
                                                    switch (indexAdd) {
                                                        case 1:
                                                        {
                                                            if (cmodel.numDisplay > 0) {
                                                                cmodel.numDisplay --;
                                                                for (NSMutableDictionary *tempDic in _stored_cardArr) {
                                                                    NSString *tempdicID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                                                                    NSInteger tempdicIDValue = [tempdicID integerValue];
                                                                    if ((cID == tempdicIDValue)&&[tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                                                        if (cmodel.numDisplay == 0) {
                                                                            [_stored_cardArr removeObject:tempDic];
                                                                        }else{
                                                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                                [self reduceChangeNumMethod];
                                                            }else{
                                                                return ;
                                                            }
                                                        }
                                                            break;
                                                        case 2:
                                                        {
                                                            BOOL isBeyond = NO;
                                                            NSInteger totalValue = 0;
                                                            for (NSMutableDictionary *tempDic in _stored_cardArr) {
                                                                NSString *tempPrice = [NSString stringWithFormat:@"%@",tempDic[@"price"]];
                                                                NSString *tempNum = [NSString stringWithFormat:@"%@",tempDic[@"numDisplay"]];
                                                                NSInteger tempPriveValue = [tempPrice integerValue];
                                                                NSInteger tempNumValue = [tempNum integerValue];
                                                                totalValue += tempPriveValue *tempNumValue;
                                                            }
                                                            NSString *totalMoney = [NSString stringWithFormat:@"%@",model.money];
                                                            NSInteger totalMoneyValue = [totalMoney integerValue];
                                                            
                                                            if ((cmodel.price + totalValue) > totalMoneyValue) {
                                                                [MzzHud toastWithTitle:@"温馨提示" message:@"余额不足"];
                                                                isBeyond = YES;
                                                                return ;
                                                            }
                                                            BOOL isfind = NO;
                                                            cmodel.numDisplay ++;
                                                            if (!isBeyond) {
                                                                for (NSMutableDictionary *tempDic in _stored_cardArr) {
                                                                    NSString *tempdicID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                                                                    NSInteger tempdicIDValue = [tempdicID integerValue];
                                                                    if ((cID == tempdicIDValue)&&[tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                                                        tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                        tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        isfind = YES;
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                            if (!isfind) {
                                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                                dic[@"name"] = cmodel.name;
                                                                dic[@"id"] = @(cID);
                                                                dic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                dic[@"num"] = @(cmodel.numDisplay);
                                                                dic[@"numMax"] =@"10000";
                                                                dic[@"n_price"] = @(cmodel.price);
                                                                dic[@"price"] = @(cmodel.price);
                                                                dic[@"goods_code"] = cmodel.goods_code;
                                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                                                dic[@"type"] = @"提卡产品";
                                                                [_stored_cardArr addObject:dic];
                                                            }
                                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                                            [self.view addSubview:self.redView];
                                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                                        }
                                                            break;
                                                        default:
                                                            break;
                                                    }
                                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                }
                                            }
                                        };
                                    }
                                }
                                    break;
                                default:
                                    break;
                            }
                        }
                            break;
                        case card_numType:
                        {
                            if (!arrcard_num.count) {
                                return nil;
                            }
                            SLCard_Num *model;
                            if (_blockindex <arrcard_num.count) {
                                if (_blockindex!=0) {
                                    model = arrcard_num[_blockindex];
                                }else{
                                    model = arrcard_num[_blockindex];
                                }
                            }else{
                                model = arrcard_num[_blockindex-arrstored_card.count];
                            }
                            switch (_blockwhice) {
                                case 1:
                                {
                                    NSMutableArray *arr;
                                    NSMutableArray *goodArray;
                                    if (_iscard_numTypeProSearch) {
                                        arr = _card_numTypeProSearchArr;
                                    } else {
                                        arr = [model.pro_list mutableCopy];
                                        goodArray = [model.goods_list mutableCopy];
                                    }
                                    if (indexPath.row < arr.count) {
                                        SLPro_List *SLPro_Listmodel = arr[indexPath.row];
                                        [cell freshSerViceRightCellSLPro_List:SLPro_Listmodel Id:model.ID Type:card_numType Whice:1];
                                        cell.btnSerViceRightCellSLPro_ListdBlock = ^(NSInteger cID, SLPro_List *cmodel, TiCardType type, NSInteger whice, NSInteger indexAdd) {
                                            if (type == card_numType) {
                                                if (whice == 1) {
                                                    switch (indexAdd) {
                                                        case 1:
                                                        {
                                                            if (cmodel.numDisplay > 0) {
                                                                cmodel.numDisplay --;
                                                                for (NSMutableDictionary *tempDic in _card_numArr) {
                                                                    if ([tempDic[@"pro_code"] isEqualToString:cmodel.pro_code]) {
                                                                        if (cmodel.numDisplay == 0) {
                                                                            [_card_numArr removeObject:tempDic];
                                                                        }else{
                                                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                                [self reduceChangeNumMethod];
                                                            }else{
                                                                return ;
                                                            }
                                                        }
                                                            break;
                                                        case 2:
                                                        {
                                                            BOOL isBeyond = NO;
                                                            NSInteger hadtotalNum = 0;
                                                            for (NSMutableDictionary *tempDic in _card_numArr) {
                                                                NSString *tempNum = [NSString stringWithFormat:@"%@",tempDic[@"numDisplay"]];
                                                                NSInteger tempNumValue = [tempNum integerValue];
                                                                hadtotalNum += tempNumValue;
                                                            }
                                                            NSInteger totalNum = model.num;
                                                            if (hadtotalNum >= totalNum) {
                                                                [MzzHud toastWithTitle:@"温馨提示" message:@"次数不足"];
                                                                isBeyond = YES;
                                                                return ;
                                                            }
                                                            BOOL isfind = NO;
                                                            cmodel.numDisplay ++;
                                                            if (!isBeyond) {
                                                                for (NSMutableDictionary *tempDic in _card_numArr) {
                                                                    if ([tempDic[@"pro_code"] isEqualToString:cmodel.pro_code]) {
                                                                        tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                        tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        isfind = YES;
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                            if (!isfind) {
                                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                                dic[@"name"] = cmodel.name;
                                                                dic[@"id"] = @(cID);
                                                                dic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                dic[@"num"] = @(cmodel.numDisplay);
                                                                dic[@"numMax"] =@"10000";
                                                                dic[@"n_price"] = @(cmodel.price);
                                                                dic[@"price"] = @(cmodel.price);
                                                                dic[@"pro_code"] = cmodel.pro_code;
                                                                dic[@"diffid"] = [NSString stringWithFormat:@"%ld%@",cID,cmodel.pro_code];;
                                                                cmodel.diffid=[NSString stringWithFormat:@"%ld%@",cID,cmodel.pro_code];
                                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                                                dic[@"type"] = @"提卡项目";
                                                                [_card_numArr addObject:dic];
                                                            }
                                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                                            [self.view addSubview:self.redView];
                                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                                        }
                                                            break;
                                                        default:
                                                            break;
                                                    }
                                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                }
                                            }
                                        };
                                    }else{
                                        SLGoods_List *SLGoods_Listmodel = goodArray[indexPath.row-arr.count];
                                        [cell freshSerViceRightCellSLGoods_List:SLGoods_Listmodel Id:model.ID Type:card_numType Whice:2];
                                        cell.btnSerViceRightCellSLGoods_ListBlock = ^(NSInteger cID, SLGoods_List *cmodel, TiCardType type, NSInteger whice, NSInteger indexAdd) {
                                            if (type == card_numType) {
                                                if (whice == 2) {
                                                    switch (indexAdd) {
                                                        case 1:
                                                        {
                                                            if (cmodel.numDisplay > 0) {
                                                                cmodel.numDisplay --;
                                                                for (NSMutableDictionary *tempDic in _card_numArr) {
                                                                    if ([tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                                                        if (cmodel.numDisplay == 0) {
                                                                            [_card_numArr removeObject:tempDic];
                                                                        }else{
                                                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                                [self reduceChangeNumMethod];
                                                            }else{
                                                                return ;
                                                            }
                                                        }
                                                            break;
                                                        case 2:
                                                        {
                                                            BOOL isBeyond = NO;
                                                            NSInteger hadtotalNum = 0;
                                                            for (NSMutableDictionary *tempDic in _card_numArr) {
                                                                NSString *tempNum = [NSString stringWithFormat:@"%@",tempDic[@"numDisplay"]];
                                                                NSInteger tempNumValue = [tempNum integerValue];
                                                                hadtotalNum += tempNumValue;
                                                            }
                                                            NSInteger totalNum = model.num;
                                                            if (hadtotalNum >= totalNum) {
                                                                [MzzHud toastWithTitle:@"温馨提示" message:@"次数不足"];
                                                                isBeyond = YES;
                                                                return ;
                                                            }
                                                            BOOL isfind = NO;
                                                            cmodel.numDisplay ++;
                                                            if (!isBeyond) {
                                                                for (NSMutableDictionary *tempDic in _card_numArr) {
                                                                    if ([tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                                                        tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                        tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        isfind = YES;
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                            if (!isfind) {
                                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                                dic[@"name"] = cmodel.name;
                                                                dic[@"id"] = @(cID);
                                                                dic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                dic[@"num"] = @(cmodel.numDisplay);
                                                                dic[@"numMax"] =@"10000";
                                                                dic[@"n_price"] = @(cmodel.price);
                                                                dic[@"price"] = @(cmodel.price);
                                                                dic[@"goods_code"] = cmodel.goods_code;
                                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                                                dic[@"type"] = @"提卡产品";
                                                                [_card_numArr addObject:dic];
                                                            }
                                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                                            [self.view addSubview:self.redView];
                                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                                        }
                                                            break;
                                                        default:
                                                            break;
                                                    }
                                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                }
                                            }
                                        };
                                    }
                                }
                                    break;
                                
                                default:
                                    break;
                            }
                        }
                            break;
                        case card_timeType:
                        {
                            if (!arrcard_time.count) {
                                return nil;
                            }
                            SLCard_Time *model;
                            if (_blockindex <arrcard_time.count) {
                                if (_blockindex!=0) {
                                    model = arrcard_time[_blockindex-1];
                                }else{
                                    model = arrcard_time[_blockindex];
                                }
                            }else{
                                model = arrcard_time[_blockindex-arrstored_card.count-arrcard_num.count];
                            }
                            switch (_blockwhice) {
                                case 1:
                                {
                                    NSMutableArray *arr;
                                    NSMutableArray *goodArray;
                                    if (_iscard_timeTypeProSearch) {
                                        arr = _card_timeTypeProSearchArr;
                                    } else {
                                        arr = [model.pro_list mutableCopy];
                                        goodArray = [model.goods_list mutableCopy];
                                    }
                                    if (indexPath.row < arr.count) {
                                        SLPro_List *SLPro_Listmodel = arr[indexPath.row];
                                        [cell freshSerViceRightCellSLPro_List:SLPro_Listmodel Id:model.ID Type:card_timeType Whice:1];
                                        cell.btnSerViceRightCellSLPro_ListdBlock = ^(NSInteger cID, SLPro_List *cmodel, TiCardType type, NSInteger whice, NSInteger indexAdd) {
                                            if (type == card_timeType) {
                                                if (whice == 1) {
                                                    switch (indexAdd) {
                                                        case 1:
                                                        {
                                                            if (cmodel.numDisplay > 0) {
                                                                cmodel.numDisplay --;
                                                                for (NSMutableDictionary *tempDic in _card_timeArr) {
                                                                    if ([tempDic[@"pro_code"] isEqualToString:cmodel.pro_code]) {
                                                                        if (cmodel.numDisplay == 0) {
                                                                            [_card_timeArr removeObject:tempDic];
                                                                        }else{
                                                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                                [self reduceChangeNumMethod];
                                                            }else{
                                                                return ;
                                                            }
                                                        }
                                                            break;
                                                        case 2:
                                                        {
                                                            BOOL isfind = NO;
                                                            cmodel.numDisplay ++;
                                                            for (NSMutableDictionary *tempDic in _card_timeArr) {
                                                                if ([tempDic[@"pro_code"] isEqualToString:cmodel.pro_code]) {
                                                                    tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                    tempDic[@"num"] = @(cmodel.numDisplay);
                                                                    isfind = YES;
                                                                    break;
                                                                }
                                                            }
                                                            if (!isfind) {
                                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                                dic[@"name"] = cmodel.name;
                                                                dic[@"id"] = @(cID);
                                                                dic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                dic[@"numMax"] =@"10000";
                                                                dic[@"num"] = @(cmodel.numDisplay);
                                                                dic[@"n_price"] = @(cmodel.price);
                                                                dic[@"price"] = @(cmodel.price);
                                                                dic[@"pro_code"] = cmodel.pro_code;
                                                                dic[@"diffid"] = [NSString stringWithFormat:@"%ld%@",cID,cmodel.pro_code];
                                                                cmodel.diffid=[NSString stringWithFormat:@"%ld%@",cID,cmodel.pro_code];
                                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                                                dic[@"type"] = @"提卡项目";
                                                                [_card_timeArr addObject:dic];
                                                            }
                                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                                            [self.view addSubview:self.redView];
                                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                                        }
                                                            break;
                                                        default:
                                                            break;
                                                    }
                                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                }
                                            }
                                        };
                                    }else{
                                        SLGoods_List *SLGoods_Listmodel = goodArray[indexPath.row-goodArray.count];
                                        [cell freshSerViceRightCellSLGoods_List:SLGoods_Listmodel Id:model.ID Type:card_timeType Whice:2];
                                        cell.btnSerViceRightCellSLGoods_ListBlock = ^(NSInteger cID, SLGoods_List *cmodel, TiCardType type, NSInteger whice, NSInteger indexAdd) {
                                            if (type == card_timeType) {
                                                if (whice == 2) {
                                                    switch (indexAdd) {
                                                        case 1:
                                                        {
                                                            if (cmodel.numDisplay > 0) {
                                                                cmodel.numDisplay --;
                                                                for (NSMutableDictionary *tempDic in _card_timeArr) {
                                                                    if ([tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                                                        if (cmodel.numDisplay == 0) {
                                                                            [_card_timeArr removeObject:tempDic];
                                                                        }else{
                                                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                                                        }
                                                                        break;
                                                                    }
                                                                }
                                                                [self reduceChangeNumMethod];
                                                            }else{
                                                                return ;
                                                            }
                                                        }
                                                            break;
                                                        case 2:
                                                        {
                                                            BOOL isfind = NO;
                                                            cmodel.numDisplay ++;
                                                            for (NSMutableDictionary *tempDic in _card_timeArr) {
                                                                if ([tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                                                    tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                    tempDic[@"num"] = @(cmodel.numDisplay);
                                                                    isfind = YES;
                                                                    break;
                                                                }
                                                            }
                                                            if (!isfind) {
                                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                                dic[@"name"] = cmodel.name;
                                                                dic[@"id"] = @(cID);
                                                                dic[@"numDisplay"] = @(cmodel.numDisplay);
                                                                dic[@"numMax"] =@"10000";
                                                                dic[@"num"] = @(cmodel.numDisplay);
                                                                dic[@"n_price"] = @(cmodel.price);
                                                                dic[@"price"] = @(cmodel.price);
                                                                dic[@"goods_code"] = cmodel.goods_code;
                                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                                                dic[@"type"] = @"提卡产品";
                                                                [_card_timeArr addObject:dic];
                                                            }
                                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                                            [self.view addSubview:self.redView];
                                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                                        }
                                                            break;
                                                        default:
                                                            break;
                                                    }
                                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                }
                                            }
                                        };
                                    }
                                }
                                    break;
                               
                                default:
                                    break;
                            }
                        }
                            break;
                        default:
                            break;
                    }
                    
                    return cell;
                }
                    break;
                case Pro:
                {//项目服务
                    NSMutableArray *arr;
                    if (_isProSearch) {
                        arr = _ProSearchArr;
                    } else {
                        arr = [_SLServPromodel.list mutableCopy];
                    }
                    if (indexPath.row < arr.count) {
                        SLProModel *SLProModelmodel = arr[indexPath.row];
                        [cell freshSerViceRightCellSLProModel:SLProModelmodel];
                        cell.btnSerViceRightCellSLProModelBlock = ^(SLProModel *cmodel, NSInteger indexAdd) {
                            switch (indexAdd) {
                                case 1:
                                {
                                    if (cmodel.numDisplay > 0) {
                                        cmodel.numDisplay --;
                                        for (NSMutableDictionary *tempDic in _rec_proArr) {
                                            if ([tempDic[@"id"] integerValue] == cmodel.ID) {
                                                if (cmodel.numDisplay == 0) {
                                                    [_rec_proArr removeObject:tempDic];
                                                }else{
                                                    tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                    tempDic[@"num"] = @(cmodel.numDisplay);
                                                }
                                                break;
                                            }
                                        }
                                        [self reduceChangeNumMethod];
                                    }else{
                                        return ;
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    if (cmodel.numDisplay >= cmodel.num) {
                                        [MzzHud toastWithTitle:@"温馨提示" message:@"本项目次数不足"];
                                        return;
                                    }
                                    cmodel.numDisplay++;
                                    BOOL isFind = NO;
                                    for (NSMutableDictionary *tempDic in _rec_proArr) {
                                        if ([tempDic[@"id"] integerValue] == cmodel.ID) {
                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                            isFind = YES;
                                            break;
                                        }
                                    }
                                    if (!isFind) {
                                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                        dic[@"name"] = cmodel.name;
                                        dic[@"id"] = @(cmodel.ID);
                                        dic[@"numMax"] = @(cmodel.num);
                                        dic[@"num"] = @(cmodel.numDisplay);
                                        dic[@"numDisplay"] = @(cmodel.numDisplay);
                                        dic[@"n_price"] = @(cmodel.price);
                                        dic[@"price"] = @(cmodel.price);
                                        dic[@"pro_code"] = cmodel.pro_code;
                                        dic[@"diffid"] = [NSString stringWithFormat:@"%ld",cmodel.ID];
                                        cmodel.diffid= [NSString stringWithFormat:@"%ld",cmodel.ID];
                                        dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                        dic[@"type"] = @"项目服务";
                                        [_rec_proArr addObject:dic];
                                    }
                                    CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        };
                    }
                    return cell;
                }
                    break;
                case Goods:
                {
                    NSMutableArray *arr;
                    if (_isGoodsSearch) {
                        arr = _GoodSearchArr;
                    } else {
                        arr = [_SLGoodsModelmodel.list mutableCopy];
                    }
                    if (indexPath.row < arr.count) {
                        SLGood *SLGoodmodel = arr[indexPath.row];
                        [cell freshSerViceRightCellSLGood:SLGoodmodel];
                        cell.btnSerViceRightCellSLGoodBlock = ^(SLGood *cmodel, NSInteger indexAdd) {
                            switch (indexAdd) {
                                case 1:
                                {
                                    if (cmodel.numDisplay > 0) {
                                        cmodel.numDisplay --;
                                        for (NSMutableDictionary *tempDic in _rec_goodsArr) {
                                            if ([tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                                if (cmodel.numDisplay == 0) {
                                                    [_rec_goodsArr removeObject:tempDic];
                                                }else{
                                                    tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                                    tempDic[@"num"] = @(cmodel.numDisplay);
                                                }
                                                break;
                                            }
                                        }
                                        [self reduceChangeNumMethod];
                                    }else{
                                        return ;
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    if (cmodel.numDisplay >= cmodel.s_num) {
                                        [MzzHud toastWithTitle:@"温馨提示" message:@"本项目次数不足"];
                                        return;
                                    }
                                    cmodel.numDisplay++;
                                    BOOL isFind = NO;
                                    for (NSMutableDictionary *tempDic in _rec_goodsArr) {
                                        if ([tempDic[@"goods_code"] isEqualToString:cmodel.goods_code]) {
                                            tempDic[@"numDisplay"] = @(cmodel.numDisplay);
                                            tempDic[@"num"] = @(cmodel.numDisplay);
                                            isFind = YES;
                                            break;
                                        }
                                    }
                                    if (!isFind) {
                                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                        dic[@"name"] = cmodel.name;
                                        dic[@"id"] = @(cmodel.ID);
                                        dic[@"numDisplay"] = @(cmodel.numDisplay);
                                        dic[@"numMax"] = @(cmodel.s_num);
                                        dic[@"num"] = @(cmodel.numDisplay);
                                        dic[@"n_price"] = @(cmodel.price);
                                        dic[@"price"] = @(cmodel.price);
                                        dic[@"goods_code"] = cmodel.goods_code;
                                        dic[@"shichang"] = [NSString stringWithFormat:@"%ld",cmodel.shichang];
                                        dic[@"type"] = @"产品服务";
                                        [_rec_goodsArr addObject:dic];
                                    }
                                    CGRect fromeRect = [tempCell convertRect:tempCell.lb6.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        };
                        
                    }
                    return cell;
                }
                    break;
#pragma mark --------------服务单--销售服务单右侧tableview显示---------------
                case sell_Pro:
                {
                    BillTiYanFuwuRightCell *cell;
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"BillTiYanFuwuRightCell" owner:nil options:nil] firstObject];
                    }else{
                        cell  = [tableView dequeueReusableCellWithIdentifier:BillTiYanFuwuRightCellindentifier];
                    }
                    __block BillTiYanFuwuRightCell *tempCell = cell;
                    NSMutableArray *arr;
                    if (_issell_ProSearch) {
                        arr = _sell_ProSearchArr;
                    } else {
                        arr = [_SLS_ProModelmodel.list mutableCopy];
                    }
                    if (indexPath.row < arr.count) {
                        SLS_Pro *SLS_Promodel = arr[indexPath.row];
                        [cell freshBillTiYanFuwuRightCell1:SLS_Promodel];
                        
                        cell.btnQuanGDKDBlock = ^{
                            _vouchModel = SLS_Promodel;
                            _ChangeindexPath = indexPath;
                            [self requestDiYongQuan:[NSString stringWithFormat:@"%@",SLS_Promodel.ID] type:_typeStrRight code:SLS_Promodel.pro_code];
                        };
                        cell.btnShopGDKDBlock = ^(SLS_Pro *model) {
                            if (!model.num) {
                                [MzzHud toastWithTitle:@"" message:@"请先选择数量"];
                                return ;
                            }
                            BOOL isFind = NO;
                            for (NSMutableDictionary *tempDic in _proArr) {
                                if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                                    tempDic[@"num"] = @(model.num);
                                    tempDic[@"price"] = model.inputPrice;
                                    if (model.sellProModel) {
                                        tempDic[@"ticket_coupon_id"] = [NSString stringWithFormat:@"%ld",_vouchModel.sellProModel.uid];
                                    }
                                    isFind = YES;
                                    break;
                                }
                            }
                            if (!isFind) {
                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                NSMutableDictionary *ticket = [NSMutableDictionary dictionary];
                
                                dic[@"name"] = model.name;
                                dic[@"num"] = @(model.num);
                                dic[@"price"] = model.inputPrice;
                                dic[@"pro_code"] = model.pro_code;
                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                                dic[@"type"] = @"项目服务";
                                dic[@"n_price"]=model.n_price;
                                dic[@"price"]=model.n_price;
                                if (model.sellProModel) {
                                    dic[@"ticket_coupon_id"] = [NSString stringWithFormat:@"%ld",_vouchModel.sellProModel.uid];
                                    [ticket setValue:model.sellProModel.code forKey:@"code"];
                                    [ticket setValue:model.sellProModel.name forKey:@"name"];
                                    [dic setValue:ticket forKey:@"ticketArray"];
                                }
                                [_proArr addObject:dic];
                            }
                            CGRect fromeRect = [tempCell convertRect:tempCell.btnShopAdd.frame toView:self.view];
                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                            [self.view addSubview:self.redView];
                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                            
                        };
                        cell.btnBillTiYanFuwuRightCellSLS_ProBlock = ^(SLS_Pro *model, NSInteger indexAdd) {
                            switch (indexAdd) {
                                case 1:
                                {
                                    if (model.num == 0) {
                                        for (SLS_Pro *delmodel in _proArr) {
                                            if ([delmodel.pro_code isEqualToString:model.pro_code]) {
                                                [_proArr removeObject:delmodel];
                                                [self reduceChangeNumMethod];
                                                break;
                                            }
                                        }
                                    }
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        };
                    }
                    return cell;
                }
                    break;
                case sell_Goods:
                {
                    BillTiYanFuwuRightCell *cell;
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"BillTiYanFuwuRightCell" owner:nil options:nil] firstObject];
                    }else{
                        cell  = [tableView dequeueReusableCellWithIdentifier:BillTiYanFuwuRightCellindentifier];
                    }
                    __block BillTiYanFuwuRightCell *tempCell = cell;
                    NSMutableArray *arr;
                    if (_issell_GoodsSearch) {
                        arr = _sell_GoodsSearchArr;
                    } else {
                        arr = [_SLGoodListModelmodel.list mutableCopy];
                    }
                    if (indexPath.row < arr.count) {
                        SLGoodModel *SLGoodModelmodel = arr[indexPath.row];
                        [cell freshBillTiYanFuwuRightCell2:SLGoodModelmodel];
                        cell.btnBillTiYanFuwuRightCellSLGoodModelBlock = ^(SLGoodModel *model, NSInteger indexAdd) {
                            switch (indexAdd) {
                                case 1:
                                {
                                    if (model.num > 0) {
                                        model.num --;
                                        for (NSMutableDictionary *tempDic in _goodsArr) {
                                            if ([tempDic[@"goods_code"] isEqualToString:model.goods_code]) {
                                                if (model.num == 0) {
                                                    [_goodsArr removeObject:tempDic];
                                                }else{
                                                    tempDic[@"num"] = @(model.num);
                                                }
                                                break;
                                            }
                                        }
                                        [self reduceChangeNumMethod];
                                    }else{
                                        return ;
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    if (!cell.tf1.text ||[cell.tf1.text isEqualToString:@""]) {
                                        [MzzHud toastWithTitle:@"" message:@"请填写价格"];
                                        return;
                                    }
                                    model.num++;
                                    BOOL isFind = NO;
                                    for (NSMutableDictionary *tempDic in _goodsArr) {
                                        if ([tempDic[@"goods_code"] isEqualToString:model.goods_code]) {
                                            tempDic[@"num"] = @(model.num);
                                            isFind = YES;
                                            break;
                                        }
                                    }
                                    if (!isFind) {
                                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                        dic[@"name"] = model.name;
                                        //                                        dic[@"id"] = @(model.ID);
                                        dic[@"num"] = @(model.num);
                                        dic[@"price"] = model.inputPrice;
                                        dic[@"goods_code"] = model.goods_code;
                                        dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                                        dic[@"type"] = @"产品服务";
                                        [_goodsArr addObject:dic];
                                    }
                                    CGRect fromeRect = [tempCell convertRect:tempCell.lb7.frame toView:self.view];
                                    CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                    [self.view addSubview:self.redView];
                                    [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                }
                                    break;
                                default:
                                    break;
                            }
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        };
                    }
                    return cell;
                }
                    break;
                case sell_TiYan:
                {
                    SLCourseExperList *model;
                    if (indexPath.row < _SLSCourseExpermodel.list.count) {
                        model = _SLSCourseExpermodel.list[_blockindex];
                    }
                    BillTiYanFuwuRightCell *cell;
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"BillTiYanFuwuRightCell" owner:nil options:nil] firstObject];
                    }else{
                        cell  = [tableView dequeueReusableCellWithIdentifier:BillTiYanFuwuRightCellindentifier];
                    }
                    __block BillTiYanFuwuRightCell *tempCell = cell;
                    switch (_blockwhice) {
                        case 1:
                        {
                            NSMutableArray *arr;
                            if (_issell_TiYanProSearch) {
                                arr = _sell_TiYanProSearchArr;
                            } else {
                                arr = [model.pro_list mutableCopy];
                            }
                            if (indexPath.row < arr.count) {
                                SLPro_ListM *SLPro_ListMmodel = arr[indexPath.row];
                                [cell freshBillTiYanFuwuRightCell3:SLPro_ListMmodel];
//                                //体验服务项目体验服务
//                                cell.btnQuanGDKDBlock = ^{
//                                    _tiYanProVouchModel = SLPro_ListMmodel;
//                                    _ChangeindexPath = indexPath;
////                                    [self requestDiYongQuan:[NSString stringWithFormat:@"%ld",_tiyanId] type:_typeStrRight];
//                                };
                                cell.btnBillTiYanFuwuRightCellSLPro_ListMBlock = ^(SLPro_ListM *model, NSInteger indexAdd) {
                                    switch (indexAdd) {
                                        case 1:
                                        {
                                            if (model.numDisplay > 0) {
                                                model.numDisplay --;
                                                for (NSMutableDictionary *tempDic in _course_experArr) {
                                                    if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                                                        if (model.numDisplay == 0) {
                                                            [_course_experArr removeObject:tempDic];
                                                        }else{
                                                            tempDic[@"num"] = @(model.numDisplay);
                                                        }
                                                        break;
                                                    }
                                                }
                                                [self reduceChangeNumMethod];
                                            }else{
                                                return ;
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            if (model.numDisplay >= model.num) {
                                                [MzzHud toastWithTitle:@"温馨提示" message:@"本项目次数不足"];
                                                return;
                                            }
                                            if (!cell.tf1.text ||[cell.tf1.text isEqualToString:@""]) {
                                                [MzzHud toastWithTitle:@"" message:@"请填写价格"];
                                                return;
                                            }
                                            model.numDisplay++;
                                            BOOL isFind = NO;
                                            for (NSMutableDictionary *tempDic in _course_experArr) {
                                                if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                                                    tempDic[@"num"] = @(model.numDisplay);
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                            if (!isFind) {
                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                dic[@"name"] = model.name;
                                                dic[@"num"] = @(model.numDisplay);
                                                dic[@"numMax"] = @(model.num);
                                                dic[@"price"] = model.inputPrice;
                                                dic[@"pro_code"] = model.pro_code;
                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                                                dic[@"type"] = @"体验项目";
                                                [_course_experArr addObject:dic];
                                            }
                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb7.frame toView:self.view];
                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                            [self.view addSubview:self.redView];
                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                };
                            }
                            return cell;
                        }
                            break;
                        case 2:
                        {
                            NSMutableArray *arr;
                            if (_issell_TiYanGoodsSearch) {
                                arr = _sell_TiYanGoodsSearchArr;
                            } else {
                                arr = [model.goods_list mutableCopy];
                            }
                            if (indexPath.row < arr.count) {
                                SLGoods_ListM *SLGoods_ListMmodel = arr[indexPath.row];
                                [cell freshBillTiYanFuwuRightCell4:SLGoods_ListMmodel];
                                //体验服务产品体验服务
                                cell.btnQuanGDKDBlock = ^{
                                    _tiYanGoodsVouchMmodel = SLGoods_ListMmodel;
                                    _ChangeindexPath = indexPath;
//                                    [self requestDiYongQuan:[NSString stringWithFormat:@"%ld",_tiyanId] type:_typeStrRight];
                                };
                                cell.btnBillTiYanFuwuRightCellSLGoods_ListMBlock = ^(SLGoods_ListM *model, NSInteger indexAdd) {
                                    switch (indexAdd) {
                                        case 1:
                                        {
                                            if (model.numDisplay > 0) {
                                                model.numDisplay --;
                                                if (model.numDisplay == 0) {
                                                    for (NSMutableDictionary *tempDic in _course_experArr) {
                                                        if ([tempDic[@"goods_code"] isEqualToString:model.goods_code]) {
                                                            [_course_experArr removeObject:tempDic];
                                                            break;
                                                        }
                                                    }
                                                }
                                                [self reduceChangeNumMethod];
                                            }else{
                                                return ;
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            if (model.numDisplay >= model.num) {
                                                [MzzHud toastWithTitle:@"温馨提示" message:@"本产品次数不足"];
                                                return;
                                            }
                                            if (!cell.tf1.text ||[cell.tf1.text isEqualToString:@""]) {
                                                [MzzHud toastWithTitle:@"" message:@"请填写价格"];
                                                return;
                                            }
                                            model.numDisplay++;
                                            BOOL isFind = NO;
                                            for (NSMutableDictionary *tempDic in _course_experArr) {
                                                if ([tempDic[@"goods_code"] isEqualToString:model.goods_code]) {
                                                    tempDic[@"num"] = @(model.numDisplay);
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                            if (!isFind) {
                                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                                dic[@"name"] = model.name;
                                                dic[@"num"] = @(model.numDisplay);
                                                dic[@"numMax"] = @(model.num);
                                                dic[@"price"] = model.inputPrice;
                                                dic[@"goods_code"] = model.goods_code;
                                                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                                                dic[@"type"] = @"体验产品";
                                                [_course_experArr addObject:dic];
                                            }
                                            CGRect fromeRect = [tempCell convertRect:tempCell.lb7.frame toView:self.view];
                                            CGRect toRect = [_downView convertRect:_btnGouWu.frame toView:self.view];
                                            [self.view addSubview:self.redView];
                                            [[ThrowLineTool sharedTool] throwObject:self.redView from:fromeRect.origin to:toRect.origin];
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                };
                            }
                            return cell;
                        }
                            break;
                        default:
                            break;
                    }
                }
                    break;
                default:
                    return nil;
                    break;
            }
            return cell;
        }
    }else{
#pragma mark ----------购物车cell ---------
        static  NSString *SaleGouWuCheCellIndeifer = @"SaleGouWuCheCellIndeifer";
        SaleGouWuCheCell *cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleGouWuCheCell" owner:nil options:nil] firstObject];
        }else{
            cell  = [tableView dequeueReusableCellWithIdentifier:SaleGouWuCheCellIndeifer];
        }
        switch (skxkTbChoiseTag) {
            case 0:
            {
                if (_isSale) {
                    switch (_billType) {
                        case 3:
                        {
                            SaleModel *model;
                            if ((0 <= indexPath.row) && (indexPath.row < _GDKDProSelfTempArr.count)) {
                                model = _GDKDProSelfTempArr[indexPath.row];
                            }else if ((_GDKDProSelfTempArr.count <= indexPath.row ) && (indexPath.row < (_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count))){
                                model = _GDKDGoodsSelfTempArr[indexPath.row-_GDKDProSelfTempArr.count];
                            }
                            else if (((_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count) <= indexPath.row)  && (indexPath.row < (_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count))){
                                model = _GDKDTeHuiSelfTempArr[indexPath.row-(_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count)];
                            }else if (((_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count))){
                                model = _GDKDRenXuanSelfTempArr[indexPath.row-(_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count)];
                            }else if (((_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count ))){
                                model = _GDKDChuZhiSelfTempArr[indexPath.row-(_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count)];
                            }else if (((_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count ) <= indexPath.row) && (indexPath.row  < (_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count + _GDKDTimeSelfTempArr.count))){
                                model = _GDKDTimeSelfTempArr[indexPath.row-(_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count )];
                            }else if (((_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count + _GDKDTimeSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count + _GDKDTimeSelfTempArr.count + _GDKDTicketSelfTempArr.count))){
                                model = _GDKDTicketSelfTempArr[indexPath.row-(_GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count + _GDKDTimeSelfTempArr.count)];
                            }
                            [cell freshSaleGouWuCheCell:model];
                            cell.btnSaleGouWuCheCellAddBlock = ^(SaleModel *BlockModel, NSInteger addflag) {
                                switch (addflag) {
                                    case 1:
                                    {
                                        if (BlockModel.addnum > 0) {
                                            BlockModel.addnum --;
                                        }
                                        if (BlockModel.addnum == 0) {
                                            BOOL isFind = NO;
                                            if (!isFind) {
                                                for (SaleModel *tempModel in _GDKDProSelfTempArr) {
                                                    if ([BlockModel.code isEqualToString:tempModel.code]) {
                                                        [_GDKDProSelfTempArr removeObject:tempModel];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempModel in _GDKDGoodsSelfTempArr) {
                                                    if ([BlockModel.code isEqualToString:tempModel.code]) {
                                                        [_GDKDGoodsSelfTempArr removeObject:tempModel];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempModel in _GDKDTeHuiSelfTempArr) {
                                                    if ([BlockModel.code isEqualToString:tempModel.code]) {
                                                        [_GDKDTeHuiSelfTempArr removeObject:tempModel];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempModel in _GDKDRenXuanSelfTempArr) {
                                                    if ([BlockModel.code isEqualToString:tempModel.code]) {
                                                        [_GDKDRenXuanSelfTempArr removeObject:tempModel];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempModel in _GDKDChuZhiSelfTempArr) {
                                                    if ([BlockModel.code isEqualToString:tempModel.code]) {
                                                        [_GDKDChuZhiSelfTempArr removeObject:tempModel];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempModel in _GDKDTimeSelfTempArr) {
                                                    if ([BlockModel.code isEqualToString:tempModel.code]) {
                                                        [_GDKDTimeSelfTempArr removeObject:tempModel];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempModel in _GDKDTicketSelfTempArr) {
                                                    if ([BlockModel.code isEqualToString:tempModel.code]) {
                                                        [_GDKDTicketSelfTempArr removeObject:tempModel];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                        break;
                                    case 2:
                                    {
                                        BlockModel.addnum ++;
                                    }
                                        break;
                                    default:
                                        break;
                                }
                                NSArray *arr = _dicRight[BlockModel.code];
                                for (SaleModel *ttmodel in arr) {
                                    ttmodel.addnum = BlockModel.addnum;
                                }
                                [self reduceChangeNumMethod];
                                [_tbViewRight reloadData];
                            };
                        }
                            break;
                        case 4:
                        {
                            if ((0 <= indexPath.row) && (indexPath.row < _YGZHProSelfTempArr.count)){
                                SAZhiHuanPorModel *model = _YGZHProSelfTempArr[indexPath.row];
                                [cell freshYiGouZhiHuanProSaleGouWuCheCell:model];
                                cell.btnSaleYiGouZhiHuanProGouWuCheCellAddBlock = ^(SAZhiHuanPorModel *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.numDisPlay > 0) {
                                                BlockModel.numDisPlay --;
                                            }
                                            if (BlockModel.numDisPlay == 0) {
                                                for (SAZhiHuanPorModel *tempmodel in _YGZHProSelfTempArr) {
                                                    if (tempmodel.uid == BlockModel.uid) {
                                                        [_YGZHProSelfTempArr removeObject:tempmodel];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            if (BlockModel.nums > BlockModel.numDisPlay) {
                                                BlockModel.numDisPlay ++;
                                            }else{
                                                [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                                            }
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                            }else if ((_YGZHProSelfTempArr.count <= indexPath.row ) && (indexPath.row < (_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count))){
                                SAZhiHuanPorModel *model = _YGZHGoodsSelfTempArr[indexPath.row-_YGZHProSelfTempArr.count];
                                [cell freshYiGouZhiHuanProSaleGouWuCheCell:model];
                                cell.btnSaleYiGouZhiHuanProGouWuCheCellAddBlock = ^(SAZhiHuanPorModel *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.numDisPlay > 0) {
                                                BlockModel.numDisPlay --;
                                            }
                                            if (BlockModel.numDisPlay == 0) {
                                                for (SAZhiHuanPorModel *tempmodel in _YGZHGoodsSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_YGZHGoodsSelfTempArr removeObject:tempmodel];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            if (BlockModel.nums > BlockModel.numDisPlay) {
                                                BlockModel.numDisPlay ++;
                                            }else{
                                                [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                                            }
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                            }else if ((_YGZHProSelfTempArr.count+_YGZHGoodsSelfTempArr.count <= indexPath.row ) && (indexPath.row < (_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHChuZhiSelfTempArr.count))){
                                SAZhiHuanPorModel *model = _YGZHChuZhiSelfTempArr[indexPath.row-_YGZHProSelfTempArr.count -_YGZHGoodsSelfTempArr.count];
                                [cell freshYiGouZhiHuanProSaleGouWuCheCell:model];
                                cell.btnSaleYiGouZhiHuanProGouWuCheCellAddBlock = ^(SAZhiHuanPorModel *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.numDisPlay > 0) {
                                                BlockModel.numDisPlay --;
                                            }
                                            if (BlockModel.numDisPlay == 0) {
                                                for (SAZhiHuanPorModel *tempmodel in _YGZHChuZhiSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_YGZHChuZhiSelfTempArr removeObject:tempmodel];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            if (BlockModel.nums > BlockModel.numDisPlay) {
                                                BlockModel.numDisPlay ++;
                                            }else{
                                                [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                                            }
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                            }else if (((_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHChuZhiSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count + _YGZHChuZhiSelfTempArr.count))){
                                SAZhiHuanPorModel *model = _YGZHRenXuanSelfTempArr[indexPath.row-(_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHChuZhiSelfTempArr.count)];
                                [cell freshYiGouZhiHuanProSaleGouWuCheCell:model];
                                cell.btnSaleYiGouZhiHuanProGouWuCheCellAddBlock = ^(SAZhiHuanPorModel *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.numDisPlay > 0) {
                                                BlockModel.numDisPlay --;
                                            }
                                            if (BlockModel.numDisPlay == 0) {
                                                for (SAZhiHuanPorModel *tempmodel in _YGZHRenXuanSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_YGZHChuZhiSelfTempArr removeObject:tempmodel];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            if (BlockModel.num > BlockModel.numDisPlay) {
                                                BlockModel.numDisPlay ++;
                                            }else{
                                                [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                                            }
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                            }else if (((_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count+_YGZHChuZhiSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count + _YGZHTimeSelfTempArr.count+_YGZHChuZhiSelfTempArr.count))){
                                SAZhiHuanPorModel *model = _YGZHTimeSelfTempArr[indexPath.row-(_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count+_YGZHChuZhiSelfTempArr.count)];
                                [cell freshYiGouZhiHuanProSaleGouWuCheCell:model];
                                cell.btnSaleYiGouZhiHuanDingJinGouWuCheCellAddBlock = ^(SADepositListModelSales *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.numDisPlay > 0) {
                                                BlockModel.numDisPlay --;
                                            }
                                            if (BlockModel.numDisPlay == 0) {
                                                for (SAZhiHuanPorModel *tempmodel in _YGZHTimeSelfTempArr) {
                                                   if ([tempmodel.code isEqualToString:tempmodel.code]) {
                                                        [_YGZHTimeSelfTempArr removeObject:tempmodel];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            BlockModel.numDisPlay ++;
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                            }else if (((_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count+_YGZHTimeSelfTempArr.count+_YGZHChuZhiSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count + _YGZHTimeSelfTempArr.count+_YGZHChuZhiSelfTempArr.count+_YGZHTicketSelfTempArr.count))){
                                SAZhiHuanPorModel *model = _YGZHTicketSelfTempArr[indexPath.row-(_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count+_YGZHTimeSelfTempArr.count+_YGZHChuZhiSelfTempArr.count)];
                                [cell freshYiGouZhiHuanProSaleGouWuCheCell:model];
                                cell.btnSaleYiGouZhiHuanProGouWuCheCellAddBlock = ^(SAZhiHuanPorModel *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.numDisPlay > 0) {
                                                BlockModel.numDisPlay --;
                                            }
                                            if (BlockModel.numDisPlay == 0) {
                                                for (SAZhiHuanPorModel *tempmodel in _YGZHTicketSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_YGZHTicketSelfTempArr removeObject:tempmodel];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            if (BlockModel.nums > BlockModel.numDisPlay) {
                                                BlockModel.numDisPlay ++;
                                            }else{
                                                [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                                            }
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                            }else if (((_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count+_YGZHTimeSelfTempArr.count+_YGZHChuZhiSelfTempArr.count+_YGZHTicketSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count + _YGZHTimeSelfTempArr.count+_YGZHChuZhiSelfTempArr.count+_YGZHTicketSelfTempArr.count+_YGZHDingjinSelfTempArr.count))){
                                SADepositListModelSales *model = _YGZHDingjinSelfTempArr[indexPath.row-(_YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count+_YGZHTimeSelfTempArr.count+_YGZHChuZhiSelfTempArr.count+_YGZHTicketSelfTempArr.count)];
                                [cell freshYiGouZhiHuanDingjinSaleGouWuCheCell:model];
                                cell.btnSaleYiGouZhiHuanDingJinGouWuCheCellAddBlock = ^(SADepositListModelSales *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.numDisPlay > 0) {
                                                BlockModel.numDisPlay --;
                                            }
                                            if (BlockModel.numDisPlay == 0) {
                                                for (SADepositListModelSales *tempmodel in _YGZHDingjinSelfTempArr) {
                                                    if ([tempmodel.ordernum isEqualToString:BlockModel.ordernum]) {
                                                        [_YGZHDingjinSelfTempArr removeObject:tempmodel];
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                            break;
                                        case 2:
                                        {
                                            BlockModel.numDisPlay ++;
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                            }
                        }
                            break;
                        case 5:
                        {
                            SaleModel *model;
                            if ((0 <= indexPath.row) && (indexPath.row < _GXZDProSelfTempArr.count)) {
                                model = _GXZDProSelfTempArr[indexPath.row];
                            }else if ((_GXZDProSelfTempArr.count <= indexPath.row ) && (indexPath.row < (_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count))){
                                model = _GXZDGoodsSelfTempArr[indexPath.row-_GXZDProSelfTempArr.count];
                            }else if (((_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count) <= indexPath.row)  && (indexPath.row < (_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count))){
                                model = _GXZDTeHuiSelfTempArr[indexPath.row-(_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count)];
                            }else if (((_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count))){
                                model = _GXZDRenXuanSelfTempArr[indexPath.row-(_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count)];
                            }else if (((_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count ))){
                                model = _GXZDTimeSelfTempArr[indexPath.row-(_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count)];
                            }else if (((_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count ) <= indexPath.row) && (indexPath.row  < (_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count + _GXZDTicketSelfTempArr.count))){
                                model = _GXZDTicketSelfTempArr[indexPath.row-(_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count)];
                            }
                            [cell freshSaleGouWuCheCell:model];
                            cell.btnSaleGouWuCheCellAddBlock = ^(SaleModel *BlockModel, NSInteger addflag) {
                                switch (addflag) {
                                    case 1:
                                    {
                                        if (BlockModel.addnum > 0) {
                                            BlockModel.addnum --;
                                        }
                                        if (BlockModel.addnum == 0) {
                                            BOOL isFind = NO;
                                            if (!isFind) {
                                                for (SaleModel *tempmodel in _GXZDProSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_GXZDProSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempmodel in _GXZDGoodsSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_GXZDGoodsSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempmodel in _GXZDTeHuiSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_GXZDTeHuiSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempmodel in _GXZDRenXuanSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_GXZDRenXuanSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempmodel in _GXZDTimeSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_GXZDTimeSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SaleModel *tempmodel in _GXZDTicketSelfTempArr) {
                                                    if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                        [_GXZDTicketSelfTempArr removeObject:tempmodel];
                                                        [self reduceChangeNumMethod];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                        break;
                                    case 2:
                                    {
                                        BlockModel.addnum ++;
                                    }
                                        break;
                                    default:
                                        break;
                                }
                                NSArray *arr = _dicRight[BlockModel.code];
                                for (SaleModel *ttmodel in arr) {
                                    ttmodel.addnum = BlockModel.addnum;
                                }
                                [self reduceChangeNumMethod];
                                [_tbViewRight reloadData];
                            };
                        }
                            break;
                        case 6:
                        {
                            if (indexPath.row <_cartSubProArr.count) {
                                NSMutableDictionary *dic = _cartSubProArr[indexPath.row];
                                [cell freshSKXKGouWuCheCell:dic];
                            }else if ((_cartSubProArr.count <=indexPath.row) &&(indexPath.row <_cartSubProArr.count+ _cartSubCardNumArr.count)){
                                NSMutableDictionary *dic = _cartSubCardNumArr[indexPath.row -_cartSubProArr.count];
                                [cell freshSKXKGouWuCheCell:dic];
                            }else if ((_cartSubProArr.count+ _cartSubCardNumArr.count <=indexPath.row) &&(indexPath.row <_cartSubProArr.count+ _cartSubCardNumArr.count +_cartSubStoreCardArr.count)){
                                NSMutableDictionary *dic = _cartSubStoreCardArr[indexPath.row -_cartSubProArr.count-_cartSubCardNumArr.count];
                                [cell freshSKXKGouWuCheCell:dic];
                            }else if ((_cartSubProArr.count+ _cartSubCardNumArr.count +_cartSubStoreCardArr.count<=indexPath.row) &&(indexPath.row <_cartSubProArr.count+ _cartSubCardNumArr.count +_cartSubStoreCardArr.count + _cartSubTimeArr.count)){
                                NSMutableDictionary *dic = _cartSubTimeArr[indexPath.row -_cartSubProArr.count-_cartSubCardNumArr.count-_cartSubStoreCardArr.count];
                                [cell freshSKXKGouWuCheCell:dic];
                            }
                            cell.btnSKXKGouWuCheCellAddBlock = ^(NSMutableDictionary *BlockDic, NSInteger addflag) {
                                switch (addflag) {
                                    case 1:
                                    {
                                        if ([BlockDic[@"to_liexing"] isEqualToString:@"pro"]) {
                                            [_cartSubProArr removeAllObjects];
                                        }else if([BlockDic[@"to_liexing"] isEqualToString:@"card_num"]){
                                            for (NSMutableDictionary *dic in _cartSubCardNumArr) {
                                                if ([dic[@"ids"] isEqualToString:BlockDic[@"ids"]]) {
                                                    dic[@"numDisplay"] =[NSString stringWithFormat:@"%ld",[dic[@"numDisplay"] integerValue] -1];
                                                    if ([dic[@"numDisplay"] integerValue] == 0) {
                                                        [_cartSubCardNumArr removeObject:dic];
                                                    }
                                                    break;
                                                }
                                            }
                                        }else if([BlockDic[@"to_liexing"] isEqualToString:@"stored_card"]){
                                            for (NSMutableDictionary *dic in _cartSubStoreCardArr) {
                                                if ([dic[@"ids"] isEqualToString:BlockDic[@"ids"]]) {
                                                    dic[@"numDisplay"] =[NSString stringWithFormat:@"%ld",[dic[@"numDisplay"] integerValue] -1];
                                                    if ([dic[@"numDisplay"] integerValue] == 0) {
                                                        [_cartSubStoreCardArr removeObject:dic];
                                                    }
                                                    break;
                                                }
                                            }
                                        }else if([BlockDic[@"to_liexing"] isEqualToString:@"card_time"]){
                                            for (NSMutableDictionary *dic in _cartSubTimeArr) {
                                                if ([dic[@"ids"] isEqualToString:BlockDic[@"ids"]]) {
                                                    dic[@"numDisplay"] =[NSString stringWithFormat:@"%ld",[dic[@"numDisplay"] integerValue] -1];
                                                    if ([dic[@"numDisplay"] integerValue] == 0) {
                                                        [_cartSubTimeArr removeObject:dic];
                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                        [self reduceChangeNumMethod];
                                    }
                                        break;
                                    case 2:
                                    {
                                        if ([BlockDic[@"to_liexing"] isEqualToString:@"pro"]) {
                                            return ;
                                        }else if([BlockDic[@"to_liexing"] isEqualToString:@"card_num"]){
                                            for (NSMutableDictionary *dic in _cartSubCardNumArr) {
                                                if ([dic[@"ids"] isEqualToString:BlockDic[@"ids"]]) {
                                                    if (([dic[@"numMax"] integerValue]) >([dic[@"numDisplay"] integerValue]) ) {
                                                        dic[@"numDisplay"] =[NSString stringWithFormat:@"%ld",[dic[@"numDisplay"] integerValue] +1];
                                                    } else {
                                                        [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                                                    }
                                                    break;
                                                }
                                            }
                                        }else if([BlockDic[@"to_liexing"] isEqualToString:@"stored_card"]){
                                            for (NSMutableDictionary *dic in _cartSubStoreCardArr) {
                                                if ([dic[@"ids"] isEqualToString:BlockDic[@"ids"]]) {
                                                    dic[@"numDisplay"] =[NSString stringWithFormat:@"%ld",[dic[@"numDisplay"] integerValue] +1];
                                                    break;
                                                }
                                            }
                                        }else if([BlockDic[@"to_liexing"] isEqualToString:@"card_time"]){
                                            for (NSMutableDictionary *dic in _cartSubTimeArr) {
                                                if ([dic[@"ids"] isEqualToString:BlockDic[@"ids"]]) {
                                                    dic[@"numDisplay"] =[NSString stringWithFormat:@"%ld",[dic[@"numDisplay"] integerValue] +1];
                                                    break;
                                                }
                                            }
                                        }
                                        [self reduceChangeNumMethod];
                                        [_tbViewRight reloadData];
                                    }
                                        break;
                                    default:
                                        break;
                                }
                            };
                        }
                            break;
                        case 7:{
                            SaleModel *model;
                            if (indexPath.row <_CustomerTempArr.count) {
                                SAAccountModel *customerModel = _CustomerTempArr[indexPath.row];
                                [cell freshUserGouWuCheCell:customerModel];
                                cell.btnCustomerUserGouWuCheCellAddBlock = ^(SAAccountModel *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            [_CustomerTempArr removeAllObjects];
                                            [_tbViewRight reloadData];
                                            [self reduceChangeNumMethod];
                                        }
                                            break;
                                        case 2:
                                        {
                                            [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                };
                            }else{
                                if ((_CustomerTempArr.count <= indexPath.row) && (indexPath.row <_CustomerTempArr.count+ _GXZDProSelfTempArr.count)) {
                                    model = _GXZDProSelfTempArr[indexPath.row - _CustomerTempArr.count];
                                }else if ((_CustomerTempArr.count+_GXZDProSelfTempArr.count <= indexPath.row ) && (indexPath.row < (_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count))){
                                    model = _GXZDGoodsSelfTempArr[indexPath.row-_CustomerTempArr.count -_GXZDProSelfTempArr.count];
                                }else if (((_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count) <= indexPath.row)  && (indexPath.row < (_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count))){
                                    model = _GXZDTeHuiSelfTempArr[indexPath.row-(_CustomerTempArr.count +_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count)];
                                }else if (((_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count))){
                                    model = _GXZDRenXuanSelfTempArr[indexPath.row-(_CustomerTempArr.count +_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count)];
                                }else if (((_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count ))){
                                    model = _GDKDChuZhiSelfTempArr[indexPath.row-(_CustomerTempArr.count +_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count)];
                                }else if (((_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count +_GDKDChuZhiSelfTempArr.count) <= indexPath.row) && (indexPath.row  < (_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count +_GDKDChuZhiSelfTempArr.count+ _GXZDTimeSelfTempArr.count ))){
                                    model = _GXZDTimeSelfTempArr[indexPath.row-(_CustomerTempArr.count +_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count+_GDKDChuZhiSelfTempArr.count)];
                                }else if (((_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count ) <= indexPath.row) && (indexPath.row  < (_CustomerTempArr.count+_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count + _GXZDTicketSelfTempArr.count))){
                                    model = _GXZDTicketSelfTempArr[indexPath.row-(_CustomerTempArr.count +_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count)];
                                }
                                [cell freshSaleGouWuCheCell:model];
                                cell.btnSaleGouWuCheCellAddBlock = ^(SaleModel *BlockModel, NSInteger addflag) {
                                    switch (addflag) {
                                        case 1:
                                        {
                                            if (BlockModel.addnum > 0) {
                                                BlockModel.addnum --;
                                            }
                                            if (BlockModel.addnum == 0) {
                                                BOOL isFind = NO;
                                                if (!isFind) {
                                                    for (SaleModel *tempmodel in _GXZDProSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                            [_GXZDProSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SaleModel *tempmodel in _GXZDGoodsSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                            [_GXZDGoodsSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SaleModel *tempmodel in _GXZDTeHuiSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                            [_GXZDTeHuiSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SaleModel *tempmodel in _GXZDRenXuanSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                            [_GXZDRenXuanSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SaleModel *tempmodel in _GDKDChuZhiSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                            [_GDKDChuZhiSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SaleModel *tempmodel in _GXZDTimeSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                            [_GXZDTimeSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SaleModel *tempmodel in _GXZDTicketSelfTempArr) {
                                                        if ([tempmodel.code isEqualToString:BlockModel.code]) {
                                                            [_GXZDTicketSelfTempArr removeObject:tempmodel];
                                                            [self reduceChangeNumMethod];
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                            break;
                                        case 2:
                                        {
                                            BlockModel.addnum ++;
                                        }
                                            break;
                                        default:
                                            break;
                                    }
                                    NSArray *arr = _dicRight[BlockModel.code];
                                    for (SaleModel *ttmodel in arr) {
                                        ttmodel.addnum = BlockModel.addnum;
                                    }
                                    [self reduceChangeNumMethod];
                                    [_tbViewRight reloadData];
                                };
                                
                            }
                        }
                            break;
                        default:
                            break;
                    }
                    
                }else{
                    switch (_billType) {
                        case 1:
                        {
                            NSMutableDictionary *dic;
                            if ((0 <= indexPath.row)&&(indexPath.row <_presArr.count)) {
                                dic = _presArr[indexPath.row];
                            }else if ((_presArr.count <= indexPath.row)&&(indexPath.row < (_presArr.count+_stored_cardArr.count))){
                                dic = _stored_cardArr[indexPath.row-_presArr.count];
                            }else if (((_presArr.count+_stored_cardArr.count) <= indexPath.row)&&(indexPath.row < (_presArr.count+_stored_cardArr.count+_card_numArr.count))){
                                dic = _card_numArr[indexPath.row-_presArr.count-_stored_cardArr.count];
                            }else if (((_presArr.count+_stored_cardArr.count+_card_numArr.count) <= indexPath.row)&&(indexPath.row < (_presArr.count+_stored_cardArr.count+_card_numArr.count+_card_timeArr.count))){
                                dic = _card_timeArr[indexPath.row-_presArr.count-_stored_cardArr.count-_card_numArr.count];
                            }else if (((_presArr.count+_stored_cardArr.count+_card_numArr.count+_card_timeArr.count) <= indexPath.row)&&(indexPath.row < (_presArr.count+_stored_cardArr.count+_card_numArr.count+_card_timeArr.count+_rec_proArr.count))){
                                dic = _rec_proArr[indexPath.row-_presArr.count-_stored_cardArr.count-_card_numArr.count-_card_timeArr.count];
                            }else if (((_presArr.count+_stored_cardArr.count+_card_numArr.count+_card_timeArr.count+_rec_proArr.count) <= indexPath.row)&&(indexPath.row < (_presArr.count+_stored_cardArr.count+_card_numArr.count+_card_timeArr.count+_rec_proArr.count+_rec_goodsArr.count))){
                                dic = _rec_goodsArr[indexPath.row-_presArr.count-_stored_cardArr.count-_card_numArr.count-_card_timeArr.count-_rec_proArr.count];
                            }
                            [cell freshFuWuDanGouWuCheCell:dic];
                            cell.btnSaleGouWuCheCellXiaoShouFuWuDanAddBlock = ^(NSMutableDictionary *blockdic, NSInteger addflag) {
                                switch (addflag) {
                                    case 1:
                                    {
                                        if ([blockdic[@"numDisplay"] integerValue]>0) {
                                            NSInteger tempnum = [blockdic[@"numDisplay"] integerValue];
                                            tempnum --;
                                            blockdic[@"numDisplay"] = @(tempnum);
                                            BOOL isFind = NO;
                                            for (SLPresListModel *tempSLPresListModel in _SLPresModelmodel.list) {
                                                for (Pro_List *tempPro_List in tempSLPresListModel.pro_list) {
                                                    if (tempPro_List.ID==[blockdic[@"id"] integerValue]) {
                                                        tempPro_List.numDisplay --;
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            isFind = NO;
                                            if(!isFind){
                                                for (SLStored_Card *tempSLStored_Card in _SLTi_CardModelmodel.stored_card) {
                                                    if (!isFind) {
                                                        for (SLPro_List *tempSLPro_List in tempSLStored_Card.pro_list) {
                                                            if ([tempSLPro_List.diffid isEqualToString:blockdic[@"diffid"]]) {
                                                                tempSLPro_List.numDisplay --;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (!isFind) {
                                                        for (SLGoods_List *tempSLGoods_List in tempSLStored_Card.goods_list) {
                                                            if ([tempSLGoods_List.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                                tempSLGoods_List.numDisplay --;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (isFind) {
                                                        break;
                                                    }
                                                }
                                            }
                                            if(!isFind){
                                                for (SLCard_Num *tempSLCard_Num in _SLTi_CardModelmodel.card_num) {
                                                    if (!isFind) {
                                                        for (SLPro_List *tempSLPro_List in tempSLCard_Num.pro_list) {
                                                            if ([tempSLPro_List.diffid isEqualToString:blockdic[@"diffid"]]) {
                                                                tempSLPro_List.numDisplay --;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (!isFind) {
                                                        for (SLGoods_List *tempSLGoods_List in tempSLCard_Num.goods_list) {
                                                            if ([tempSLGoods_List.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                                tempSLGoods_List.numDisplay --;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (isFind) {
                                                        break;
                                                    }
                                                }
                                            }
                                            if(!isFind){
                                                for (SLCard_Time *tempSLCard_Time in _SLTi_CardModelmodel.card_time) {
                                                    if (!isFind) {
                                                        for (SLPro_List *tempSLPro_List in tempSLCard_Time.pro_list) {
                                                            if ([tempSLPro_List.diffid isEqualToString:blockdic[@"diffid"]]) {
                                                                tempSLPro_List.numDisplay --;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (!isFind) {
                                                        for (SLGoods_List *tempSLGoods_List in tempSLCard_Time.goods_list) {
                                                            if ([tempSLGoods_List.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                                tempSLGoods_List.numDisplay --;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (isFind) {
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SLProModel *tempSLProModel in _SLServPromodel.list) {
                                                    if (tempSLProModel.ID ==[blockdic[@"id"] integerValue]) {
                                                        tempSLProModel.numDisplay --;
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SLGood *tempSLGood in _SLGoodsModelmodel.list) {
                                                    if (tempSLGood.ID ==[blockdic[@"id"] integerValue]) {
                                                        tempSLGood.numDisplay --;
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                        
                                        if ([blockdic[@"numDisplay"] integerValue] == 0) {
                                            BOOL isFind = NO;
                                            for (NSMutableDictionary *tempdic in _presArr) {
                                                if (tempdic[@"id"] ==blockdic[@"id"]) {
                                                    [_presArr removeObject:blockdic];
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                            isFind = NO;
                                            if (!isFind) {
                                                for (NSMutableDictionary *tempdic in _stored_cardArr) {
                                                    
                                                    if ([tempdic[@"diffid"] isEqualToString:blockdic[@"diffid"]]||[tempdic[@"goods_code"] isEqualToString:blockdic[@"goods_code"]]) {
                                                        [_stored_cardArr removeObject:blockdic];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (NSMutableDictionary *tempdic in _card_numArr) {
                                                    
                                                    if ([tempdic[@"diffid"] isEqualToString:blockdic[@"diffid"]]||[tempdic[@"goods_code"] isEqualToString:blockdic[@"goods_code"]]) {
                                                        [_card_numArr removeObject:blockdic];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (NSMutableDictionary *tempdic in _card_timeArr) {
                                                    
                                                    if ([tempdic[@"diffid"] isEqualToString:blockdic[@"diffid"]]||[tempdic[@"goods_code"] isEqualToString:blockdic[@"goods_code"]]) {
                                                        [_card_timeArr removeObject:blockdic];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (NSMutableDictionary *tempdic in _rec_proArr) {
                                                    
                                                    if (tempdic[@"id"]==blockdic[@"id"]) {
                                                        [_rec_proArr removeObject:blockdic];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (NSMutableDictionary *tempdic in _rec_goodsArr) {
                                                    
                                                    if ([tempdic[@"goods_code"] isEqualToString:blockdic[@"goods_code"]]) {
                                                        [_rec_goodsArr removeObject:blockdic];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                        break;
                                    case 2:
                                    {
                                        if (blockdic[@"numMax"]) {
                                            if ([blockdic[@"numMax"] integerValue] > [blockdic[@"numDisplay"] integerValue]) {
                                                NSInteger tempnum = [blockdic[@"numDisplay"] integerValue];
                                                tempnum ++;
                                                blockdic[@"numDisplay"] = @(tempnum);
                                            }else{
                                                [MzzHud toastWithTitle:@"温馨提示" message:@"次数不足"];
                                                return;
                                            }
                                        }else{
                                            NSInteger tempnum = [blockdic[@"numDisplay"] integerValue];
                                            tempnum ++;
                                            blockdic[@"numDisplay"] = @(tempnum);
                                        }
                                        BOOL isFind = NO;
                                        for (SLPresListModel *tempSLPresListModel in _SLPresModelmodel.list) {
                                            for (Pro_List *tempPro_List in tempSLPresListModel.pro_list) {
                                                if (tempPro_List.ID ==[blockdic[@"id"] integerValue]) {
                                                    tempPro_List.numDisplay ++;
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                        }
                                        isFind = NO;
                                        if(!isFind){
                                            for (SLStored_Card *tempSLStored_Card in _SLTi_CardModelmodel.stored_card) {
                                                if (!isFind) {
                                                    for (SLPro_List *tempSLPro_List in tempSLStored_Card.pro_list) {
                                                        if ([tempSLPro_List.diffid isEqualToString:blockdic[@"diffid"]]) {
                                                            tempSLPro_List.numDisplay ++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SLGoods_List *tempSLGoods_List in tempSLStored_Card.goods_list) {
                                                        if ([tempSLGoods_List.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                            tempSLGoods_List.numDisplay ++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (isFind) {
                                                    break;
                                                }
                                            }
                                        }
                                        if(!isFind){
                                            for (SLCard_Num *tempSLCard_Num in _SLTi_CardModelmodel.card_num) {
                                                if (!isFind) {
                                                    for (SLPro_List *tempSLPro_List in tempSLCard_Num.pro_list) {
                                                        if ([tempSLPro_List.diffid isEqualToString:blockdic[@"diffid"]]) {
                                                            tempSLPro_List.numDisplay ++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SLGoods_List *tempSLGoods_List in tempSLCard_Num.goods_list) {
                                                        if ([tempSLGoods_List.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                            tempSLGoods_List.numDisplay ++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (isFind) {
                                                    break;
                                                }
                                            }
                                        }
                                        if(!isFind){
                                            for (SLCard_Time *tempSLCard_Time in _SLTi_CardModelmodel.card_time) {
                                                if (!isFind) {
                                                    for (SLPro_List *tempSLPro_List in tempSLCard_Time.pro_list) {
                                                        if ([tempSLPro_List.diffid isEqualToString:blockdic[@"diffid"]]) {
                                                            tempSLPro_List.numDisplay ++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SLGoods_List *tempSLGoods_List in tempSLCard_Time.goods_list) {
                                                        if ([tempSLGoods_List.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                            tempSLGoods_List.numDisplay ++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (isFind) {
                                                    break;
                                                }
                                            }
                                        }
                                        if (!isFind) {
                                            for (SLProModel *tempSLProModel in _SLServPromodel.list) {
                                                if (tempSLProModel.ID ==[blockdic[@"id"] integerValue]) {
                                                    tempSLProModel.numDisplay ++;
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                        }
                                        if (!isFind) {
                                            for (SLGood *tempSLGood in _SLGoodsModelmodel.list) {
                                                if ([tempSLGood.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                    tempSLGood.numDisplay ++;
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                        break;
                                    default:
                                        break;
                                }
                                [self reduceChangeNumMethod];
                                [_tbViewRight reloadData];
                            };

                        }
                            break;
                        case 2:
                        {
                            NSMutableDictionary *dic;
                            if ((0 <= indexPath.row) && (indexPath.row < _proArr.count)) {
                                dic = _proArr[indexPath.row];
                            }else if ((_proArr.count <= indexPath.row ) && (indexPath.row < (_proArr.count + _goodsArr.count))){
                                dic = _goodsArr[indexPath.row-_proArr.count];
                            }
                            else if (((_proArr.count + _goodsArr.count) <= indexPath.row)  && (indexPath.row < (_proArr.count + _goodsArr.count + _course_experArr.count))){
                                dic = _course_experArr[indexPath.row-(_proArr.count + _goodsArr.count)];
                            }
                            [cell freshSaleServerGouWuCheCell:dic];
                            cell.btnSaleGouWuCheCellXiaoShouFuWuDanAddBlock = ^(NSMutableDictionary *blockdic, NSInteger addflag) {
                                switch (addflag) {
                                    case 1:
                                    {
                                        if ([blockdic[@"num"] integerValue]>0) {
                                            NSInteger tempnum = [blockdic[@"num"] integerValue];
                                            tempnum --;
                                            blockdic[@"num"] = @(tempnum);
                                            BOOL isFind = NO;
                                            for (SLS_Pro *tempSLS_Promodel in _SLS_ProModelmodel.list) {
                                                if ([tempSLS_Promodel.pro_code isEqualToString:blockdic[@"pro_code"]]) {
                                                    tempSLS_Promodel.num --;
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                            isFind = NO;
                                            if (!isFind) {
                                                for (SLGoodModel *tempSLGoodModelmodel in _SLGoodListModelmodel.list) {
                                                    if ([tempSLGoodModelmodel.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                        tempSLGoodModelmodel.num --;
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (SLCourseExperList *tempTiYanmodel in _SLSCourseExpermodel.list) {
                                                    if (!isFind) {
                                                        for (SLPro_ListM *tempSLPro_ListMmodel in tempTiYanmodel.pro_list) {
                                                            if ([tempSLPro_ListMmodel.pro_code isEqualToString:blockdic[@"pro_code"]]) {
                                                                tempSLPro_ListMmodel.numDisplay--;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (!isFind) {
                                                        for (SLGoods_ListM *tempSLGoods_ListMmodel in tempTiYanmodel.goods_list) {
                                                            if ([tempSLGoods_ListMmodel.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                                tempSLGoods_ListMmodel.numDisplay--;
                                                                isFind = YES;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (isFind) {
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                        if ([blockdic[@"num"] integerValue] == 0) {
                                            BOOL isFind = NO;
                                            for (NSMutableDictionary *tempdic in _proArr) {
                                                if ([tempdic[@"pro_code"] isEqualToString:blockdic[@"pro_code"]]) {
                                                    [_proArr removeObject:blockdic];
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                            if (!isFind) {
                                                for (NSMutableDictionary *tempdic in _goodsArr) {
                                                    if ([tempdic[@"goods_code"] isEqualToString:blockdic[@"goods_code"]]) {
                                                        [_goodsArr removeObject:blockdic];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (!isFind) {
                                                for (NSMutableDictionary *tempdic in _course_experArr) {
                                                    if ([tempdic[@"pro_code"] isEqualToString:blockdic[@"pro_code"]] || [tempdic[@"goods_code"] isEqualToString:blockdic[@"goods_code"]]) {
                                                        [_course_experArr removeObject:blockdic];
                                                        isFind = YES;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                        break;
                                    case 2:
                                    {
                                        if (blockdic[@"numMax"]) {
                                            if ([blockdic[@"numMax"] integerValue] > [blockdic[@"num"] integerValue]) {
                                                NSInteger tempnum = [blockdic[@"num"] integerValue];
                                                tempnum ++;
                                                blockdic[@"num"] = @(tempnum);
                                            }else{
                                                [MzzHud toastWithTitle:@"温馨提示" message:@"次数不足"];
                                                return;
                                            }
                                        }else{
                                            NSInteger tempnum = [blockdic[@"num"] integerValue];
                                            tempnum ++;
                                            blockdic[@"num"] = @(tempnum);
                                        }
                                        BOOL isFind = NO;
                                        for (SLS_Pro *tempSLS_Promodel in _SLS_ProModelmodel.list) {
                                            if ([tempSLS_Promodel.pro_code isEqualToString:blockdic[@"pro_code"]]) {
                                                tempSLS_Promodel.num ++;
                                                isFind = YES;
                                                break;
                                            }
                                        }
                                        if (!isFind) {
                                            for (SLGoodModel *tempSLGoodModelmodel in _SLGoodListModelmodel.list) {
                                                if ([tempSLGoodModelmodel.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                    tempSLGoodModelmodel.num ++;
                                                    isFind = YES;
                                                    break;
                                                }
                                            }
                                        }
                                        if (!isFind) {
                                            for (SLCourseExperList *tempTiYanmodel in _SLSCourseExpermodel.list) {
                                                if (!isFind) {
                                                    for (SLPro_ListM *tempSLPro_ListMmodel in tempTiYanmodel.pro_list) {
                                                        if ([tempSLPro_ListMmodel.pro_code isEqualToString:blockdic[@"pro_code"]]) {
                                                            tempSLPro_ListMmodel.numDisplay++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (!isFind) {
                                                    for (SLGoods_ListM *tempSLGoods_ListMmodel in tempTiYanmodel.goods_list) {
                                                        if ([tempSLGoods_ListMmodel.goods_code isEqualToString:blockdic[@"goods_code"]]) {
                                                            tempSLGoods_ListMmodel.numDisplay++;
                                                            isFind = YES;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (isFind) {
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                        break;
                                    default:
                                        break;
                                }
                                [self reduceChangeNumMethod];
                                [_tbViewRight reloadData];
                            };
                        }
                            break;
                        default:{
                            return 0;
                        }
                            break;
                    }
                }
                return cell;
            }
                break;
            case 1:
            {
                static  NSString *SKXKProCellIndeifer = @"SKXKProCellIndeifer";
                SKXKProCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"SKXKProCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:SKXKProCellIndeifer];
                }
                ShengKaXuKaProDataList *model = _ShengKaXuKaProList[indexPath.row];
                [cell freshSKXKProCell:model];
                cell.btnSKXKProCellBlock = ^(ShengKaXuKaProDataList *model) {
                    [_tbGouWuChe reloadData];
                    NSMutableArray *proSelectArr = [[NSMutableArray alloc]init];
                    for (ShengKaXuKaProDataList *tempmodel in _ShengKaXuKaProList) {
                        if (tempmodel.selected) {
                            ShengKaXuKaProDataList *newModel = [[ShengKaXuKaProDataList alloc]init];
                            newModel.ID = tempmodel.ID;
                            newModel.code = tempmodel.code;
                            newModel.price = tempmodel.price;
                            newModel.nums = tempmodel.nums;
                            newModel.is_have = tempmodel.is_have;
                            newModel.money = tempmodel.money;
                            newModel.name = tempmodel.name;
                            newModel.selected = tempmodel.selected;
                            [proSelectArr addObject:newModel];
                        }
                    }
                    _sKXKProOneceModel.ShengKaXuKaProList = proSelectArr;
                    [_tbViewRight reloadData];
                };
                return cell;
            }
                break;
            case 2:
            {
                static  NSString *SKXKProCellIndeifer = @"SKXKProCellIndeifer";
                SKXKProCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"SKXKProCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:SKXKProCellIndeifer];
                }
                ShengKaXuKaKeShengHuiYuanKaList *model = _ShengKaXuKaShengKaMuBiaoList[indexPath.row];
                [cell freshSKXKMuBiaoCell:model];
                cell.btnSKXKMuBiaoCellBlock = ^(ShengKaXuKaKeShengHuiYuanKaList *model) {
                    ShengKaXuKaKeShengHuiYuanKaList *toPassModel = [[ShengKaXuKaKeShengHuiYuanKaList alloc]init];
                    toPassModel.denomination = model.denomination;
                    toPassModel.code = model.code;
                    toPassModel.name = model.name;
                    toPassModel.card_id = model.card_id;
                    toPassModel.price = model.price;
                    toPassModel.selected = model.selected;
                    
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        if (model.selected) {
                            _sKXKProOneceModel.ShengKaXuKaShengKaMuBiaoListModel = toPassModel;
                            
                            [_tbViewRight reloadData];
                        }
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        if (model.selected) {
                            _ShengKaXuKaRenXuanDataModel.ShengKaXuKaShengKaMuBiaoListModel = toPassModel;
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        }
                    }else if ([_typeStrRight isEqualToString:@"stored_card"])
                    {
                        if (model.selected) {
                            _ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel = toPassModel;
                            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        }
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        _ShengKaXuKaShiJianListModel.ShengKaXuKaShengKaMuBiaoListModel = toPassModel;
                        [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                    for (ShengKaXuKaKeShengHuiYuanKaList *tempmodel in _ShengKaXuKaShengKaMuBiaoList) {
                        if ([tempmodel.code isEqualToString:model.code]) {
                            continue;
                        }else{
                            tempmodel.selected = NO;
                        }
                    }
                    [_tbGouWuChe reloadData];
                    
                };
                
                return cell;
            }
                break;
            case 3:
            {
                static  NSString *SKXKProCellIndeifer = @"SKXKProCellIndeifer";
                SKXKProCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"SKXKProCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:SKXKProCellIndeifer];
                }
                ZheKouStored_Card *model = _ZheKouList[indexPath.row];
                [cell freshSKXKZheKouCell:model];
                cell.btnSKXKZheKouCellBlock = ^(ZheKouStored_Card *model) {
                    _ChangeSaleModelmodel.sastoreCardModel = model;
                    [_tbGouWuChe reloadData];
                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                };
                
                return cell;
            }
                break;
                
            case 4:
            {
                static  NSString *SKXKProCellIndeifer = @"SKXKProCellIndeifer";
                SKXKProCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"SKXKProCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:SKXKProCellIndeifer];
                }
                CiShuModel *cishumodel = _LiaoChengCiShuList[indexPath.row];
                [cell freshSKXKCiShuCell:cishumodel];
                cell.btnSKXKCiShuCellBlock = ^(CiShuModel *model) {
                    for (CiShuModel *tempmodel in _LiaoChengCiShuList) {
                        if ([tempmodel.cishu isEqualToString:model.cishu]) {
                            continue;
                        }else{
                            tempmodel.selected = NO;
                        }
                    }
                    _ChangeSaleModelmodel.ciShu = model.cishu;
                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                };
                
                return cell;
            }
                break;
#pragma mark --------根据skxkTbChoiseTag = 5 购物车tableviewcell显示抵用券-------------
            case 5:
            {
                static  NSString *OrderVouchersCellIdentF = @"OrderVouchersCell";
                OrderVouchersCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderVouchersCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:OrderVouchersCellIdentF];
                }
                NSString *type;
                if (_type == sell_Pro) {
                    type = @"礼品";
                    SellProTicketModel *diyongquanmodel = _sellProTicketList[indexPath.row];
                    [cell freshSellProDiYongQuanCell:diyongquanmodel];
                    
                }else{
                    type = @"非礼品";
                    SATicketModel *diyongquanmodel = _SATicketList[indexPath.row];
                    [cell freshSKXKDiYongQuanCell:diyongquanmodel];
                }
                //点击选择的抵用券、现金券或者折扣券
                cell.btnSKXKDiYongQuanCellBlock = ^(SATicketModel *model) {
                    if (model.mark != _selectTicketModel.mark) {
                        _selectTicketModel.selected = NO;
                        model.selected = YES;
                        _selectTicketModel = model;
                    }else{
                        [_SATicketList replaceObjectAtIndex:[_SATicketList indexOfObject:model]  withObject:model];
                    }
                    
//                    [_SATicketList replaceObjectAtIndex:[_SATicketList indexOfObject:model]  withObject:model];
//                    if (model.selected) {
//                        _selectTicketModel = model;
//                    }else{
//                        _selectTicketModel = nil;
//                    }
//                    for (SATicketModel *tempmodel in _SATicketList) {
//                        if (tempmodel.mark == model.mark) {
//                            tempmodel.selected = YES;;
//                        }else{
//                            tempmodel.selected = NO;
//                        }
//
//                    }
                    [_tbGouWuChe reloadData];
                    _ChangeSaleModelmodel.staicketModel = model;
                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

                };
                //点击选择的礼品券
                cell.btnSellProDiYongQuanCellBlock = ^(SellProTicketModel *model) {
                    for (SellProTicketModel *tempmodel in _SATicketList) {
                        if ([tempmodel.code isEqualToString:model.code]) {
                            tempmodel.selected = YES;;
                        }else{
                            tempmodel.selected = NO;
                        }
                    }
                    [_tbGouWuChe reloadData];
                    if (_type == sell_Pro) {
                        _vouchModel.sellProModel = model;
                    }
                    [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    
                };
                return cell;
            }
                break;
            default:
                break;
        }
    }
    return nil;
}
- (void)cellBtnEvent:(UIButton *)sender{
    if (_SLTi_CardModelmodel.isShow) {
        return;
    }
    _SLTi_CardModelmodel.isShow = !_SLTi_CardModelmodel.isShow;
    _type = tiCard;
    [_tbViewLeft reloadData];
    [_tbViewRight reloadData];
}
- (void)BillTiYanFuwuCellBtnEvent:(UIButton *)sender{
    _SLSCourseExpermodel.isShow = !_SLSCourseExpermodel.isShow;
    _type = sell_TiYan;
    [_tbViewLeft reloadData];
    [_tbViewRight reloadData];
}
- (void)btnMoreProEvent{
    skxkTbChoiseTag = 1;
    [self hiddenSomeview];
}
- (void)btnmubiaoEvent{
    skxkTbChoiseTag = 2;
    [self hiddenSomeview];
}
- (void)btnZheKouEvent{
    skxkTbChoiseTag = 3;
    [self hiddenSomeview];
}
- (void)btnCiShuMethod{
    skxkTbChoiseTag = 4;
    [self hiddenSomeview];
}
#pragma mark --------------抵用券--------
- (void)DiYongQuanMethod{
    skxkTbChoiseTag = 5;
    [self hiddenSomeviewDy];
}
- (void)hiddenSomeviewDy{
    _tbGouWuChe.hidden = NO;
    _btnTopDark.hidden = NO;
    
    _downView.hidden = YES;
    [_tbGouWuChe reloadData];
}
- (void)hiddenSomeview{
    _tbGouWuChe.hidden = NO;
    _btnTopDark.hidden = NO;
    
    _btnCancle.hidden = NO;
    _lbMiddle.hidden = NO;
    _btnSure.hidden = NO;
    _btnGouWu.hidden = YES;
    _lbGouWuNum.hidden = YES;
    _btnNext.hidden = YES;
    [_tbGouWuChe reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tbViewLeft) {
        return 0;
    } else if(tableView == _tbViewRight){
        if (_isSale) {
            return 0;
        } else {
            switch (_type) {
                case Pres:
                    return 60;
                    break;
                case tiCard:
                    return 80;
                    break;
                default:
                    return 0;
                    break;
            }
        }
    }else{
        return 40;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tbViewLeft) {
        return nil;
    } else if(tableView == _tbViewRight){
        if (_isSale) {
            return nil;
        } else {
            switch (_type) {
#pragma mark ---------处方服务sectionHeard----------
                case Pres:
                {
                    if (section < _SLPresModelmodel.list.count) {
                        SLPresListModel *SLPresListModelmodel = _SLPresModelmodel.list[section];
                        OrderRightSectionHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"OrderRightSectionHeader" owner:nil options:nil] firstObject];
                        header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
                        header.selectMore = SLPresListModelmodel.isSelect;
                        [header freshOrderRightSectionHeard:SLPresListModelmodel];
                       __block BOOL isFind = NO;
                        //选中处方标题
                        header.clickXuan = ^(BOOL select) {
                            NSLog(@"----%ld",(long)section);
                            SLPresListModel *SLPresListModelmodel = _SLPresModelmodel.list[section];
                            NSMutableArray *arr = [SLPresListModelmodel.pro_list mutableCopy];
                            
                            SLPresListModelmodel.isSelect = select;
                            for (Pro_List *model in arr) {
                                model.numDisplay=1;
                                for (NSMutableDictionary *tempDic in _presArr) {
                                    if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                                        tempDic[@"numDisplay"] = @(model.numDisplay);
                                        tempDic[@"num"] = @(model.numDisplay);
                                        isFind = YES;
                                        break;
                                    }
                                }
                                if (!isFind) {
                                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                    dic[@"name"] = model.pro_name;
                                    dic[@"id"] = @(model.ID);
                                    dic[@"numMax"] = @(model.num);
                                    dic[@"num"] = @(model.numDisplay);
                                    dic[@"numDisplay"] = @(model.numDisplay);
                                    dic[@"price"] = model.price;
                                    dic[@"pro_code"] = model.pro_code;
                                    dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                                    dic[@"type"] = @"处方服务";
                                    [_presArr addObject:dic];
                                }
                            }
                            [self reduceChangeNumMethod];
                            [_tbViewRight reloadData];
                        };
                        //取消选中标题
                        header.clickWeiXuan = ^(BOOL select) {
                            SLPresListModel *SLPresListModelmodel = _SLPresModelmodel.list[section];
                            NSMutableArray *arr = [SLPresListModelmodel.pro_list mutableCopy];
                            
                            SLPresListModelmodel.isSelect = select;
                            for (Pro_List *model in arr) {
                                model.numDisplay=0;
                                for (NSMutableDictionary *tempDic in _presArr) {
                                    if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                                        if (model.numDisplay == 0) {
                                            [_presArr removeObject:tempDic];
                                            isFind = YES;
                                        }
                                        break;
                                    }
                                }
                                if (!isFind) {
                                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                    dic[@"name"] = model.pro_name;
                                    dic[@"id"] = @(model.ID);
                                    dic[@"numMax"] = @(model.num);
                                    dic[@"num"] = @(model.numDisplay);
                                    dic[@"numDisplay"] = @(model.numDisplay);
                                    dic[@"price"] = model.price;
                                    dic[@"pro_code"] = model.pro_code;
                                    dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                                    dic[@"type"] = @"处方服务";
                                    [_presArr addObject:dic];
                                }
                            }
                            [self reduceChangeNumMethod];
                            [_tbViewRight reloadData];

                        };
                        return header;
                    }
                    return nil;
                }
                    break;
                case tiCard:
                {
                    NSArray *arrstored_card = _SLTi_CardModelmodel.stored_card;
                    NSArray *arrcard_num = _SLTi_CardModelmodel.card_num;
                    NSArray *arrcard_time = _SLTi_CardModelmodel.card_time;
                    
                    if (!_rightHeader) {
                        _rightHeader = [[[NSBundle mainBundle] loadNibNamed:@"BeautyDesignRightSectionHeader" owner:nil options:nil] lastObject];
                        _rightHeader.frame = CGRectMake(0, 0, 218*WIDTH_SALE_BASE, 80);
                    }
                    switch (_blocktype) {
                        case stored_cardType:
                        {
                            if (!arrstored_card.count) {
                                return nil;
                            }
                            SLStored_Card *model = arrstored_card[_blockindex];
                            [_rightHeader freshBeautyDesignRightSectionHeader:model.name withstr2:[NSString stringWithFormat:@"余额：%@",model.money]];
                        }
                            break;
                        case card_numType:
                        {
                            if (!arrcard_num.count) {
                                return nil;
                            }
                            SLCard_Num *model;
                            if (_blockindex<arrcard_num.count) {
                                if (_blockindex!=0) {
                                    model = arrcard_num[_blockindex];
                                }else{
                                    model = arrcard_num[_blockindex];
                                }
                            }else{
                                model = arrcard_num[_blockindex-arrstored_card.count];
                            }
                            [_rightHeader freshBeautyDesignRightSectionHeader:model.name withstr2:[NSString stringWithFormat:@"剩余次数：%ld",model.num]];
                        }
                            break;
                        case card_timeType:
                        {
                            if (!arrcard_time.count) {
                                return nil;
                            }
                            SLCard_Time *model;
                            if (_blockindex<arrcard_time.count) {
                                if (_blockindex!=0) {
                                    model = arrcard_time[_blockindex-1];
                                }else{
                                    model = arrcard_time[_blockindex];
                                }
                            }else{
                                model = arrcard_time[_blockindex-arrcard_num.count-arrstored_card.count];
                            }
                            [_rightHeader freshBeautyDesignRightSectionHeader:model.name withstr2:[NSString stringWithFormat:@"截止日期：%@",model.end_time]];
                        }
                            break;
                        default:
                            break;
                    }
                    return _rightHeader;
                }
                    break;
                default:
                    return nil;
                    break;
            }
        }
    }else{
        UIView *header;
        if (header) {
            [header removeFromSuperview];
        }
        switch (skxkTbChoiseTag) {
            case 0:
            {
                header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
                lb.font = [UIFont systemFontOfSize:13];
                lb.text = @"已选商品";
                lb.textColor = kLabelText_Commen_Color_6;
                [header addSubview:lb];
                
                UILabel *lb2 = [[UILabel alloc]init];;
                lb2.textColor = kLabelText_Commen_Color_9;
                lb2.font = FONT_SIZE(13);
                lb2.text = @"清空";
                [lb2 sizeToFit];
                lb2.frame =CGRectMake(SCREEN_WIDTH-15-lb2.width, 10, lb2.width, 20);
                [header addSubview:lb2];
                
                UIImage * image4 = [UIImage imageNamed:@"beautyshanchu"];
                UIImageView *im4 = [[UIImageView alloc]init];;
                im4.image = image4;
                im4.frame =CGRectMake(lb2.left -6-image4.size.width, 0, image4.size.width, image4.size.height);
                im4.userInteractionEnabled = YES;
                im4.center = CGPointMake(im4.center.x, lb2.center.y);
                [header addSubview:im4];
                
                UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.frame = CGRectMake(im4.left, 0, lb2.right - im4.left, 40);
                [btn1 addTarget:self action:@selector(delEvent) forControlEvents:UIControlEventTouchUpInside];
                [header addSubview:btn1];
                
            }
                break;
            case 1:
            {
                header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 30)];
                lb.font = [UIFont systemFontOfSize:15];
                lb.text = @"请选择升卡项目";
                lb.textColor = kLabelText_Commen_Color_6;
                lb.textAlignment = NSTextAlignmentCenter;
                [header addSubview:lb];
            }
                break;
            case 2:
            {
                header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 30)];
                lb.font = [UIFont systemFontOfSize:15];
                lb.text = @"请选择升卡类型";
                lb.textColor = kLabelText_Commen_Color_6;
                lb.textAlignment = NSTextAlignmentCenter;
                [header addSubview:lb];
            }
                break;
            case 3:
            {
                header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 30)];
                lb.font = [UIFont systemFontOfSize:15];
                lb.text = @"请选择会员优惠";
                lb.textColor = kLabelText_Commen_Color_6;
                lb.textAlignment = NSTextAlignmentCenter;
                [header addSubview:lb];
            }
                break;
            case 4:
            {
                header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 30)];
                lb.font = [UIFont systemFontOfSize:15];
                lb.text = @"请选择疗程次数";
                lb.textColor = kLabelText_Commen_Color_6;
                lb.textAlignment = NSTextAlignmentCenter;
                [header addSubview:lb];
            }
                break;
            case 5:
            {
                header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
                lb.font = [UIFont systemFontOfSize:15];
                lb.text = @"请选择抵用券";
                lb.textColor = kLabelText_Commen_Color_6;
                lb.textAlignment = NSTextAlignmentCenter;
                [header addSubview:lb];
                
                UIButton *trueButton = [UIButton buttonWithType:UIButtonTypeSystem];
                trueButton.frame = CGRectMake(SCREEN_WIDTH-15-40, 10, 40, 20);
                [trueButton setTitle:@"确认" forState:UIControlStateNormal];
                [trueButton setTitleColor:kLabelText_Commen_Color_ea007e forState:UIControlStateNormal];
                [trueButton addTarget:self action:@selector(trueButtonAction) forControlEvents:UIControlEventTouchUpInside];
                [header addSubview:trueButton];
                
                UIButton *clooseButton = [UIButton buttonWithType:UIButtonTypeSystem];
                clooseButton.frame = CGRectMake(SCREEN_WIDTH-15-80-31, 10, 40, 20);
                [clooseButton setTitle:@"取消" forState:UIControlStateNormal];
                [clooseButton setTitleColor:kLabelText_Commen_Color_ea007e forState:UIControlStateNormal];
                [clooseButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
                [header addSubview:clooseButton];
                
            }
                break;
            default:
                break;
        }
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
        line.backgroundColor = kBackgroundColor;
        [header addSubview:line];
        return header;
    }
}
#pragma mark -------抵用券确定按钮点击事件
-(void)trueButtonAction
{
    [self TopDarkEvent:nil];
}
-(void)closeButtonAction
{
    if ([_typeStrRight isEqualToString:@"sell_Pro"]) {
        SLS_Pro  *selectModel = [_SLS_ProModelmodel.list mutableCopy][_ChangeindexPath.row];//这个对象选择了抵用券
        selectModel.staicketModel.selected = NO;
    }else{
        SaleModel *selectModel = _dicRight[_typeStrRight][_ChangeindexPath.row];//这个对象选择了抵用券
        selectModel.staicketModel.selected = NO;
    }

    [_tbViewRight reloadData];
    [self TopDarkEvent:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tbViewLeft) {
        return 1;
    } else if(tableView == _tbViewRight){
        if (_isSale) {
            return 1;
        } else {
            switch (_type) {
                case Pres:
                    if (_isPresSearch) {
                        return 1;
                    } else {
                        return _SLPresModelmodel.list.count;
                    }
                    break;
                default:
                    return 1;
                    break;
            }
        }
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _searchSection = section;
    
    if (tableView == _tbViewLeft) {
        switch (_billType) {
            case 1:
            {
                return _arrLeft.count;
            }
                break;
            case 2:
            {
                return _arrLeft.count;
            }
                break;
            case 3:
            {
                return _Gudingmodel.list.count;
            }
                break;
            case 4:
            {
                return _Yigoumodel.list.count;
            }
                break;
            case 5:
            {
                return _Gexingmodel.list.count;
            }
                break;
            case 6:
            {
                return _Shengkamodel.list.count;
            }
                break;
            case 7:
            {
                return _KaiShiZhiHuanmodel.list.count;
            }
                break;
            default:
                return 0;
                break;
        }
    } else if(tableView == _tbViewRight){
        if (_isSale) {
            switch (_billType) {
                case 3:
                {
                    NSArray *arr;
                    if (_isGuDingSearch) {
                        arr = _GuDingSearchArr;
                    } else {
                        arr = _dicRight[_typeStrRight];
                    }
                    if (arr &&(arr.count > 0)) {
                        return arr.count;
                    }else{
                        return 0;
                    }
                }
                    break;
                case 4:
                {
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        if (_isYiGouZhiHuanProSearch) {
                            return _YiGouZhiHuanProSearchArr.count;
                        } else {
                            return _YiGouZhiHuanProList.count;
                        }
                    }else if ([_typeStrRight isEqualToString:@"goods"])
                    {
                        if (_isYiGouZhiHuanGoodsSearch) {
                            return _YiGouZhiHuanGoodsSearchArr.count;
                        } else {
                            return _YiGouZhiHuanGoodsList.count;
                        }
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        if (_isYiGouZhiHuanRenXuanSearch) {
                            return _YiGouZhiHuanRenXuanSearchArr.count;
                        } else {
                            return _YiGouZhiHuanRenXuanList.count;
                        }
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        if (_isYiGouZhiHuanTimeSearch) {
                            return _YiGouZhiHuanTimeSearchArr.count;
                        } else {
                            return _YiGouZhiHuanTimeList.count;
                        }
                    }else if ([_typeStrRight isEqualToString:@"sales"])
                    {
                        if (_isYiGouZhiHuanDingJinDingDanSearch) {
                            return _YiGouZhiHuanDingJinDingDanSearchArr.count;
                        } else {
                            return _YiGouZhiHuanDingJinDingDanList.count;
                        }
                    }else if ([_typeStrRight isEqualToString:@"ticket"])
                    {
                        if (_isYiGouZhiHuanPiaoQuanSearch) {
                            return _YiGouZhiHuanPiaoQuanSearchArr.count;
                        } else {
                            return _YiGouZhiHuanPiaoQuanList.count;
                        }
                    }else if ([_typeStrRight isEqualToString:@"stored_card"]){
                        if (_isYiGouZhiHuanChuZhiSearch) {
                            return _YiGouZhiHuanChuZhiSearchArr.count;
                        } else {
                            return _YiGouZhiHuanChuZhiList.count;
                        }
                    }
                    else{
                        return 0;
                    }
                }
                    break;
                case 5:
                {
                    NSArray *arr;
                    if (_isGeXingSearch) {
                        arr = _GeXingSearchArr;
                    } else {
                        arr = _dicRight[_typeStrRight];
                    }
                    if (arr &&(arr.count > 0)) {
                        return arr.count;
                    }else{
                        return 0;
                    }
                }
                    break;
                case 6:
                {
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        return 1;
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        return _ShengKaXuKaRenXuanKaList.count;
                    }else if ([_typeStrRight isEqualToString:@"stored_card"])
                    {
                        return _ShengKaXuKaChuZhiModelList.count;
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        return _ShengKaXuKaShiJianModelList.count;
                    }else{
                        return 0;
                    }
                }
                    break;
                case 7:
                {
                    if ([_typeStrRight isEqualToString:@"bank"]) {
                        if (_SAAccountModelmodel) {
                            return 1;
                        } else {
                            return 0;
                        }
                    } else {
                        if (_isYiGouZhiHuanSearch) {
                            return _YiGouZhiHuanSearchArr.count;
                        } else {
                            NSArray *arr = _dicRight[_typeStrRight];
                            if (_billType==7) {
                                if([_typeStrRight isEqualToString:@"stored_card"]){
                                    if (_zhiHuanChuZhiUserArr.count) {
                                        return _zhiHuanChuZhiUserArr.count;
                                    }
                                }
                            }
                            if (arr &&(arr.count > 0)) {
                                return arr.count;
                            }else{
                                return 0;
                            }
                        }
                    }
                }
                    break;
                default:
                    return 0;
                    break;
            }
        } else {
            switch (_type) {
                case Pres:
                {
                    if (_isPresSearch) {
                        return _PresSearchArr.count;
                    } else {
                        if (section < _SLPresModelmodel.list.count) {
                            SLPresListModel *SLPresListModelmodel = _SLPresModelmodel.list[section];
                            return SLPresListModelmodel.pro_list.count;
                        }
                    }
                    return 0;
                }
                    break;
                case tiCard:
                {
                    NSArray *arrstored_card = _SLTi_CardModelmodel.stored_card;
                    NSArray *arrcard_num = _SLTi_CardModelmodel.card_num;
                    NSArray *arrcard_time = _SLTi_CardModelmodel.card_time;
                    switch (_blocktype) {
                        case stored_cardType:
                        {
                            if (arrstored_card.count) {
                                SLStored_Card *model = arrstored_card[_blockindex];
                                switch (_blockwhice) {
                                    case 1:
                                    {
                                        if (_isstored_cardTypeProSearch) {
                                            return _stored_cardTypeProSearchArr.count;
                                        } else {
                                            return model.pro_list.count;
                                        }
                                    }
                                        break;
                                    case 2:
                                    {
                                        if (_isstored_cardTypeGoodsSearch) {
                                            return _stored_cardTypeGoodsSearchArr.count;
                                        } else {
                                            return model.goods_list.count;
                                        }
                                    }
                                        break;
                                    default:
                                        return 0;
                                        break;
                                }
                            }else{
                                return 0;
                            }
                        }
                            break;
                        case card_numType:
                        {
                            if (arrcard_num.count) {
                                SLCard_Num *model;
                                if (_blockindex < arrcard_num.count) {
                                    if (_blockindex!=0) {
                                        model = arrcard_num[_blockindex];
                                    }else{
                                        model = arrcard_num[_blockindex];
                                    }
                                }else{
                                    model = arrcard_num[_blockindex-arrstored_card.count];
                                }
                                switch (_blockwhice) {
                                    case 1:
                                    {
                                        if (_iscard_numTypeProSearch) {
                                            return _card_numTypeProSearchArr.count;
                                        } else {
                                            return model.pro_list.count+model.goods_list.count;
                                        }
                                    }
                                        break;
                                    
                                    default:
                                        return 0;
                                        break;
                                }
                            } else {
                                return 0;
                            }
                        }
                            break;
                        case card_timeType:
                        {
                            if (arrcard_time.count) {
                                SLCard_Time *model;
                                if (_blockindex < arrcard_time.count) {
                                    if (_blockindex!=0) {
                                        model = arrcard_time[_blockindex-1];
                                    }else{
                                        model = arrcard_time[_blockindex];
                                    }
                                }else{
                                     model = arrcard_time[_blockindex-arrcard_num.count-arrstored_card.count];
                                }
                                switch (_blockwhice) {
                                    case 1:
                                    {
                                        if (_iscard_timeTypeProSearch) {
                                            return _card_timeTypeProSearchArr.count;
                                        } else {
                                            return model.pro_list.count+model.goods_list.count;
                                        }
                                    }
                                        break;
                                    
                                    default:
                                        return 0;
                                        break;
                                }
                            } else {
                                return 0;
                            }
                        }
                            break;
                        default:
                            return 0;
                            break;
                    }
                }
                    break;
                case Pro:
                {
                    if (_isProSearch) {
                        return _ProSearchArr.count;
                    } else {
                        return _SLServPromodel.list.count;
                    }
                }
                    break;
                case Goods:
                {
                    if (_isGoodsSearch) {
                        return _GoodSearchArr.count;
                    } else {
                        return _SLGoodsModelmodel.list.count;
                    }
                }
                    break;
                case sell_Pro:
                {
                    if (_issell_ProSearch) {
                        return _sell_ProSearchArr.count;
                    } else {
                        return _SLS_ProModelmodel.list.count;
                    }
                }
                    break;
                case sell_Goods:
                {
                    if (_issell_GoodsSearch) {
                        return _sell_GoodsSearchArr.count;
                    } else {
                        return _SLGoodListModelmodel.list.count;
                    }
                }
                    break;
                case sell_TiYan:
                {
                    SLCourseExperList *model;
                    if (_blockindex < _SLSCourseExpermodel.list.count) {
                        model = _SLSCourseExpermodel.list[_blockindex];
                    }
                    switch (_blockwhice) {
                        case 1:
                        {
                            if (_issell_TiYanProSearch) {
                                return _sell_TiYanProSearchArr.count;
                            } else {
                                return model.pro_list.count;
                            }
                        }
                            break;
                        case 2:
                        {
                            if (_issell_TiYanGoodsSearch) {
                                return _sell_TiYanGoodsSearchArr.count;
                            } else {
                                return model.goods_list.count;
                            }
                        }
                            break;
                        default:
                            return 0;
                            break;
                    }
                }
                    break;
                default:
                    return 0;
                    break;
            }
        }
    }else{
        switch (skxkTbChoiseTag) {
            case 0:
            {
                
                if (_isSale) {
                    switch (_billType) {
                        case 3:
                        {
                            NSInteger num = _GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count + _GDKDTimeSelfTempArr.count + _GDKDTicketSelfTempArr.count;
                            return num;
                        }
                            break;
                        case 4:
                        {
                            NSInteger num = _YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count + _YGZHTimeSelfTempArr.count + _YGZHDingjinSelfTempArr.count + _YGZHTicketSelfTempArr.count+_YGZHChuZhiSelfTempArr.count;
                            return num;
                        }
                            break;
                        case 5:
                        {
                            NSInteger num = _GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count + _GXZDTicketSelfTempArr.count;
                            return num;
                        }
                            break;
                        case 6:
                        {
                            NSInteger num = _cartSubProArr.count + _cartSubCardNumArr.count + _cartSubStoreCardArr.count + _cartSubTimeArr.count;
                            return num;
                        }
                            break;
                        case 7:
                        {
                            NSInteger num = (_CustomerTempArr.count +_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count +_GDKDChuZhiSelfTempArr.count+ _GXZDTicketSelfTempArr.count);
                            return num;
                        }
                            break;
                        default:{
                            return 0;
                        }
                            break;
                    }
                }else{
                    switch (_billType) {
                        case 1:
                        {
                            NSInteger num = _presArr.count +_stored_cardArr.count+_card_numArr.count+_card_timeArr.count+_rec_proArr.count+_rec_goodsArr.count;
                            return num;
                        }
                            break;
                        case 2:
                        {
                            NSInteger num = _proArr.count + _goodsArr.count + _course_experArr.count;
                            return num;
                        }
                            break;
                        default:{
                            return 0;
                        }
                            break;
                    }
                }
            }
                break;
            case 1:
            {
                return _ShengKaXuKaProList.count;
            }
                break;
            case 2:
            {
                return _ShengKaXuKaShengKaMuBiaoList.count;
            }
                break;
            case 3:
            {
                return _ZheKouList.count;
            }
                break;
            case 4:
            {
                return _LiaoChengCiShuList.count;
            }
                break;
            case 5:
            {
                if (_type == sell_Pro) {
                    return _sellProTicketList.count;
                }else{
                    return _SATicketList.count;
                }
            }
                break;
            default:
            {
                return 0;
            }
                break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbViewLeft) {
        switch (_billType) {
            case 1:
            {
                switch (indexPath.row) {
                    case 1:
                    {
                        if (_SLTi_CardModelmodel.isShow) {
                            NSArray *arrstored_card;
                            NSArray *arrcard_num;
                            NSArray *arrcard_time;
                            arrstored_card = _SLTi_CardModelmodel.stored_card;
                            arrcard_num = _SLTi_CardModelmodel.card_num;
                            arrcard_time = _SLTi_CardModelmodel.card_time;
                            if(_isShowArray.count){
                                NSMutableArray *indexArray = [NSMutableArray array];
                                for (NSString *index in _isShowArray) {
                                    if ([index isEqualToString:@"yes"]) {
                                        [indexArray addObject:index];
                                    }
                                }
                                return (arrstored_card.count + arrcard_num.count + arrcard_time.count)*40.0+40+indexArray.count*80;
                            }
                            return (arrstored_card.count + arrcard_num.count + arrcard_time.count)*40.0+40;
                            
                        } else {
                            return 40;
                        }
                    }
                        break;
                    default:{
                        return 40;
                    }
                        break;
                }
            }
                break;
            case 2:
            {
                switch (indexPath.row) {
                    case 2:
                    {
                        if (_SLSCourseExpermodel.isShow) {
                            NSArray *list;
                            list = _SLSCourseExpermodel.list;
                            return (list.count)*120+40;
                        } else {
                            return 40;
                        }
                    }
                        break;
                        
                    default:{
                        return 40;
                    }
                        break;
                }
            }
                break;
            default:
                return 40;
                break;
        }
    } else if(tableView == _tbViewRight){
        if (_isSale) {
            switch (_billType) {
                case 3:
                {
                    NSArray *arr;
                    if (_isGuDingSearch) {
                        arr = _GuDingSearchArr;
                    } else {
                        arr = _dicRight[_typeStrRight];
                    }
                    if (arr &&(arr.count > 0)) {
                        if (indexPath.row<arr.count) {
                            SaleModel *model = arr[indexPath.row];
                            if ([_typeStrRight isEqualToString:@"pro"]) {
                                if (model.isShow) {
                                    return 270;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"goods"])
                            {
                                if (model.isShow) {
                                    return 230;
                                } else {
                                    return 90;
                                }
                            }else if ([_typeStrRight isEqualToString:@"card_course"])
                            {
                                if (model.isShow) {
                                    return 180;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"card_num"])
                            {
                                if (model.isShow) {
                                    return 150;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"stored_card"])
                            {
                                if (model.isShow) {
                                    return 130;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"card_time"])
                            {
                                if (model.isShow) {
                                    return 180;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"ticket"])
                            {
                                if (model.isShow) {
                                    return 160;
                                } else {
                                    return 60;
                                }
                            }else{
                                return 0;
                            }
                        }else{
                            return 0;
                        }
                    }else{
                        return 0;
                    }
                }
                    break;
                case 4:
                {
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanProSearch) {
                            arr = _YiGouZhiHuanProSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanProList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        if (model.isShow) {
                            return 190;
                        }else{
                            return 60;
                        }
                    }else if ([_typeStrRight isEqualToString:@"goods"])
                    {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanGoodsSearch) {
                            arr = _YiGouZhiHuanGoodsSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanGoodsList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        if (model.isShow) {
                            return 180;
                        }else{
                            return 60;
                        }
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanRenXuanSearch) {
                            arr = _YiGouZhiHuanRenXuanSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanRenXuanList mutableCopy];
                        }
                        SAZhiHuanPorModel *model =arr[indexPath.row];
                        if (model.isShow) {
                            return 200;
                        }else{
                            return 60;
                        }
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanTimeSearch) {
                            arr = _YiGouZhiHuanTimeSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanTimeList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        if (model.isShow) {
                            return 210;
                        } else {
                            return 60;
                        }
                        
                    }else if ([_typeStrRight isEqualToString:@"sales"])
                    {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanDingJinDingDanSearch) {
                            arr = _YiGouZhiHuanDingJinDingDanSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanDingJinDingDanList mutableCopy];
                        }
                        SADepositListModelSales *model = arr[indexPath.row];
                        if (model.isShow) {
                            return 260;
                        }else{
                            return 60;
                        }
                    }else if ([_typeStrRight isEqualToString:@"ticket"])
                    {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanPiaoQuanSearch) {
                            arr = _YiGouZhiHuanPiaoQuanSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanPiaoQuanList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        if (model.isShow) {
                            return 160;
                        }else{
                            return 60;
                        }
                    }else if ([_typeStrRight isEqualToString:@"stored_card"])
                    {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanChuZhiSearch) {
                            arr = _YiGouZhiHuanChuZhiSearchArr;
                        } else {
                            arr = [_YiGouZhiHuanChuZhiList mutableCopy];
                        }
                        SAZhiHuanPorModel *model = arr[indexPath.row];
                        if (model.isShow) {
                            return 160;
                        }else{
                            return 60;
                        }
                    }
                    else{
                        return 0;
                    }
                }
                    break;
                case 5:
                {
                    NSArray *arr;
                    if (_isGeXingSearch) {
                        arr = _GeXingSearchArr;
                    } else {
                        arr = _dicRight[_typeStrRight];
                    }
                    if (arr &&(arr.count > 0)) {
                        if (indexPath.row<arr.count) {
                            SaleModel *model = arr[indexPath.row];
                            if ([_typeStrRight isEqualToString:@"pro"]) {
                                if (model.isShow) {
                                    return 210;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"goods"])
                            {
                                if (model.isShow) {
                                    return 210;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"card_course"])
                            {
                                if (model.isShow) {
                                    return 200;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"card_num"])
                            {
                                if (model.isShow) {
                                    return 190;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"card_time"])
                            {
                                if (model.isShow) {
                                    return 190;
                                } else {
                                    return 60;
                                }
                            }else if ([_typeStrRight isEqualToString:@"ticket"])
                            {
                                if (model.isShow) {
                                    return 190;
                                } else {
                                    return 60;
                                }
                            }else{
                                return 0;
                            }
                        }else{
                            return 0;
                        }
                    }else{
                        return 0;
                    }
                }
                    break;
                case 6:
                {
                    if ([_typeStrRight isEqualToString:@"pro"]) {
                        return 200;
                    }else if ([_typeStrRight isEqualToString:@"card_num"])
                    {
                        ShengKaXuKaRenXuanData *model = _ShengKaXuKaRenXuanKaList[indexPath.row];
                        if (model.isShow) {
                            return 280;
                        } else {
                            return 60;
                        }
                    }else if ([_typeStrRight isEqualToString:@"stored_card"])
                    {
                        ShengKaChuZhiList *model = _ShengKaXuKaChuZhiModelList[indexPath.row];
                        if (model.isShow) {
                            if ([model.to_type isEqualToString:@"1"]) {
                                return 260;
                            } else{
                                return 190;
                            }
                        } else {
                            return 60;
                        }
                    }else if ([_typeStrRight isEqualToString:@"card_time"])
                    {
                        ShengKaXuKaShiJianList *model = _ShengKaXuKaShiJianModelList[indexPath.row];
                        if (model.isShow) {
                            return 260;
                        } else {
                            return 60;
                        }
                    }else{
                        return 0;
                    }
                }
                    break;
                case 7:
                {
                    if ([_typeStrRight isEqualToString:@"bank"]) {
                        return 160;
                    } else {
                        NSMutableArray *arr;
                        if (_isYiGouZhiHuanSearch) {
                            arr = _YiGouZhiHuanSearchArr;
                        } else {
                            arr = _dicRight[_typeStrRight];
                        }
                        if (arr &&(arr.count > 0)) {
                            if (indexPath.row<arr.count) {
                                SaleModel *model = arr[indexPath.row];
                                if ([_typeStrRight isEqualToString:@"pro"]) {
                                    if (model.isShow) {
                                        return 210;
                                    } else {
                                        return 60;
                                    }
                                }else if ([_typeStrRight isEqualToString:@"goods"])
                                {
                                    if (model.isShow) {
                                        return 210;
                                    } else {
                                        return 60;
                                    }
                                }else if ([_typeStrRight isEqualToString:@"card_course"])
                                {
                                    if (model.isShow) {
                                        return 200;
                                    } else {
                                        return 60;
                                    }
                                }else if ([_typeStrRight isEqualToString:@"card_num"])
                                {
                                    if (model.isShow) {
                                        return 190;
                                    } else {
                                        return 60;
                                    }
                                }else if ([_typeStrRight isEqualToString:@"stored_card"])
                                {
                                    if (_zhiHuanChuZhiUserArr.count) {
                                        SaleModel *storedmodel = _zhiHuanChuZhiUserArr[indexPath.row];
                                        if (storedmodel.isShow) {
                                            return 160;
                                        } else {
                                            return 60;
                                        }
                                    } else {
                                        if (model.isShow) {
                                            return 130;
                                        } else {
                                            return 60;
                                        }
                                    }
                                }else if ([_typeStrRight isEqualToString:@"card_time"])
                                {
                                    if (model.isShow) {
                                        return 190;
                                    } else {
                                        return 60;
                                    }
                                }else if ([_typeStrRight isEqualToString:@"ticket"])
                                {
                                    if (model.isShow) {
                                        return 190;
                                    } else {
                                        return 60;
                                    }
                                }else{
                                    return 0;
                                }
                            }else{
                                return 0;
                            }
                        }else{
                            return 0;
                        }
                    }
                }
                    break;
                default:
                    return 40;
                    break;
            }
        } else {
            switch (_type) {
                case Pres:
                    return 100;
                    break;
                case tiCard:
                    return 100;
                    break;
                case Pro:
                    return 100;
                    break;
                case Goods:
                    return 100;
                    break;
                case sell_Pro:
                    return 200;
                    break;
                case sell_Goods:
                    return 150;
                    break;
                case sell_TiYan:
                    return 110;
                    break;
                default:
                    return 0;
                    break;
            }
        }
    }else{
        switch (skxkTbChoiseTag) {
            case 0:
            {
                return 40;
            }
                break;
            case 1:
            {
                return 80;
            }
                break;
            case 2:
            {
                return 80;
            }
                break;
            case 3:
            {
                return 80;
            }
                break;
            case 4:
            {
                return 80;
            }
                break;
            case 5:
            {
                return 120;
            }
                break;
            default:
            {
                return 40;
            }
                break;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbViewLeft) {
        switch (_billType) {
            case 1:
            {
                switch (indexPath.row) {
                    case 1:
                    {
                    }
                        break;
                    default:{
                        _SLTi_CardModelmodel.isShow = NO;
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                        [_tbViewLeft reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                        break;
                }
            }
                break;
            case 2:
            {
                switch (indexPath.row) {
                    case 2:
                    {
                    }
                        break;
                        
                    default:{
                        _SLSCourseExpermodel.isShow = NO;
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                        [_tbViewLeft reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                        break;
                }
            }
                break;
            default:
                break;
        }
        if (_lastindexPath) {
            ServiceLeftCell *cell = [_tbViewLeft cellForRowAtIndexPath:_lastindexPath];
            cell.lbTitle.textColor = kLabelText_Commen_Color_3;
            cell.contentView.backgroundColor = kBackgroundColor;
        }
        ServiceLeftCell *cell = [_tbViewLeft cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = kBtn_Commen_Color;
        cell.lbTitle.textColor = [UIColor whiteColor];
        _lastindexPath = indexPath;
        [self reloadData:indexPath.row];
    }
}
#pragma mark ---------点击左侧tableviewcell获取对应的右侧tableview数据------------------
- (void)reloadData:(NSInteger)row{
    switch (_billType) {
        case 1:
        {
            switch (row) {
                case 0:
                    _type = Pres;
                    break;
                case 1:
                    _type = tiCard;
                    break;
                case 2:
                    _type = Pro;
                    break;
                case 3:
                    _type = Goods;
                    break;
                default:
                    break;
            }
            [_tbViewRight reloadData];
        }
            break;
        case 2:
        {
            switch (row) {
                    //销售服务的——typeStrRight类型根据后台需要进行设置
                case 0:
                    _type = sell_Pro;
                    _typeStrRight = @"sell_Pro";
                    break;
                case 1:
                    _type = sell_Goods;
                    _typeStrRight = @"sell_Goods";
                    break;
                case 2:
                    _type = sell_TiYan;
                    _typeStrRight = @"sell_TiYan";
                    break;
                default:
                    break;
            }
            [_tbViewRight reloadData];
        }
            break;
        case 3:
        {
            SALeftModel *model = _Gudingmodel.list[row];
            _typeStrRight = model.type;
            _isGuDingSearch = NO;
            [self requestRightData:_typeStrRight];
        }
            break;
        case 4:
        {
            SALeftModel *model = _Yigoumodel.list[row];
            _typeStrRight = model.type;
            [self requstYiGouZhiHuanRightData:_typeStrRight];
        }
            break;
        case 5:
        {
            SALeftModel *model = _Gexingmodel.list[row];
            _typeStrRight = model.type;
            _isGeXingSearch = NO;
            [self requestRightData:_typeStrRight];
        }
            break;
        case 6:
        {
            SALeftModel *model = _Shengkamodel.list[row];
            _typeStrRight = model.type;
            [self requestShengKaXuKaRightData:model.type];
        }
            break;
        case 7:
        {
            SALeftModel *model = _KaiShiZhiHuanmodel.list[row];
            _typeStrRight = model.type;
            [self requestKaiShiZhiHuanRightData:_typeStrRight];
        }
            break;
        default:
            break;
    }
}
#pragma mark ---------------点击下一步按钮--------------
- (IBAction)btnCommit:(UIButton *)sender {
    
    if (_gouwucheNum == 0) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先添加购物车再进行下一步"];
        return;
    }
    switch (_billType) {
        case 1:
        {
            [_commitDic setValue:_presArr forKey:@"pres"];
            
            [_commitDic setValue:_stored_cardArr forKey:@"stored_card"];
            [_commitDic setValue:_card_numArr forKey:@"card_num"];
            [_commitDic setValue:_card_timeArr forKey:@"card_time"];
            
            [_commitDic setValue:_rec_proArr forKey:@"rec_pro"];
            [_commitDic setValue:_rec_goodsArr forKey:@"rec_goods"];
            
            SaleServiceNextViewController *VC = [[SaleServiceNextViewController alloc]init];
            VC.billType = _billType;
            VC.user_id = _user_id;
            VC.name = _name;
            VC.mobile = _mobile;
            VC.commitDic = _commitDic;
            [self.navigationController pushViewController:VC animated:NO];
        }
            break;
        case 2:
        {
            [_commitDic setValue:_proArr forKey:@"pro"];
            [_commitDic setValue:_goodsArr forKey:@"goods"];
            [_commitDic setValue:_course_experArr forKey:@"course_exper"];
            
            SaleServiceNextViewController *VC = [[SaleServiceNextViewController alloc]init];
            VC.billType = _billType;
            VC.user_id = _user_id;
            VC.name = _name;
            VC.mobile = _mobile;
            VC.commitDic = _commitDic;
            [self.navigationController pushViewController:VC animated:NO];
        }
            break;
        case 3:
        {
            [self num3Action];
            
            MzzGuDingZhiDanController *VC = [[MzzGuDingZhiDanController alloc]init];
            VC.user_id = _user_id;
            VC.name = _name;
            VC.mobile = _mobile;
            VC.commitDic = _commitDic;
            VC.store_code = _store_code;
            VC.toPayMoney = self.toPayMoney;
            VC.ordernum = self.ordernum;
            [self.navigationController pushViewController:VC animated:NO];
        }
            break;
        case 4:
        {
            NSMutableDictionary *dic = [self num4Action];
            SaleServiceViewController *VC = [[SaleServiceViewController alloc]init];
            VC.user_id = _user_id;
            VC.name = _name;
            VC.mobile = _mobile;
            VC.store_code = _store_code;
            VC.billType = 7;
            VC.isSale = YES;
            VC.ziHuanDic = dic;
            VC.yigouNumStr = _yigouNumStr;
            [self.navigationController pushViewController:VC animated:NO];
        }
            break;
        case 5:
        {
            [self num5Action];
            
            MzzGeXingZhiDanController *VC = [[MzzGeXingZhiDanController alloc]init];
            VC.user_id = _user_id;
            VC.name = _name;
            VC.mobile = _mobile;
            VC.commitDic = _commitDic;
            VC.store_code = _store_code;
            VC.toPayMoney = self.toPayMoney;
            VC.ordernum = self.ordernum;
            [self.navigationController pushViewController:VC animated:NO];
        }
            break;
        case 6:
        {
            [self num6Action];
            
            MzzShengkaXukaController *VC = [[MzzShengkaXukaController alloc]init];
            VC.user_id = _user_id;
            VC.name = _name;
            VC.mobile = _mobile;
            VC.commitDic = _commitDic;
            VC.store_code = _store_code;

            [self.navigationController pushViewController:VC animated:NO];
        }
            break;
        case 7:{
            [self num7Action];
            if (_isMustbeStop) {
                return;
            }
            MzzYiGouZhiHuanController *VC = [[MzzYiGouZhiHuanController alloc]init];
            VC.user_id = _user_id;
            VC.name = _name;
            VC.mobile = _mobile;
            VC.commitDic = _ziHuanDic;
            VC.store_code = _store_code;
            [self.navigationController pushViewController:VC animated:NO];
        }
            break;
        default:
            break;
    }
}
- (void)num3Action{
    if (_cartArr.count > 0) {
        [_cartArr removeAllObjects];
    }
    for (SaleModel *model in _GDKDProSelfTempArr) {
        NSMutableDictionary *ticket = [NSMutableDictionary dictionary];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:model.ciShu?model.ciShu:@"" forKey:@"pro_num"];
        [dic setValue:@"pro" forKey:@"type"];
        [dic setValue:@"项目" forKey:@"typeName"];
        [dic setValue:model.lingshouMoney forKey:@"q_money"];
        
        [dic setValue:model.sastoreCardModel.code?model.sastoreCardModel.code:@"" forKey:@"store_card"];
        if (model.staicketModel.type == 1) {
            [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",model.staicketModel.uid]:@"" forKey:@"ticket"];
        }else{
            [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",model.staicketModel.uid]:@"" forKey:@"ticket_coupon_id"];
        }
        [ticket setValue:model.staicketModel.code forKey:@"code"];
        [ticket setValue:model.staicketModel.price forKey:@"money"];
        [ticket setValue:model.staicketModel.name forKey:@"name"];
        [dic setValue:ticket forKey:@"ticketArray"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GDKDGoodsSelfTempArr) {
        NSMutableDictionary *ticket = [NSMutableDictionary dictionary];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.ciShu?model.ciShu:@"" forKey:@"pro_num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"goods" forKey:@"type"];
        [dic setValue:@"产品" forKey:@"typeName"];
        [dic setValue:model.lingshouMoney forKey:@"q_money"];
        [dic setValue:model.sastoreCardModel.code?model.sastoreCardModel.code:@"" forKey:@"store_card"];
        if (model.staicketModel.type == 1) {
            [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",model.staicketModel.uid]:@"" forKey:@"ticket"];
        }else{
            [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",model.staicketModel.uid]:@"" forKey:@"ticket_coupon_id"];
        }
        [ticket setValue:model.staicketModel.code forKey:@"code"];
        [ticket setValue:model.staicketModel.price forKey:@"money"];
        [ticket setValue:model.staicketModel.name forKey:@"name"];
        [dic setValue:ticket forKey:@"ticketArray"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GDKDTeHuiSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"0" forKey:@"award_xf"];
        [dic setValue:@"card_course" forKey:@"type"];
        [dic setValue:model.lingshouMoney forKey:@"q_money"];

        NSMutableArray *rangArr = [[NSMutableArray alloc]init];
        NSDictionary *rootDic = [model.baohanJsonStr dictionaryWithJsonString:model.baohanJsonStr];
        NSArray *arr1 = rootDic[@"guding"];
        NSArray *arr2 = rootDic[@"daixuan"];
        if (arr1.count) {
            for (NSMutableDictionary *dic in arr1) {
                [dic removeObjectForKey:@"rights"];
                dic[@"group_id"] = dic[@"group"];
                dic[@"group_map"] = @"";
                [rangArr addObject:dic];
            }
        }
        if (arr2.count) {
            for (NSMutableDictionary *dic in arr2) {
                [dic removeObjectForKey:@"rights"];
                dic[@"group_id"] = dic[@"group"];
                dic[@"group_map"] = @"";
                [rangArr addObject:dic];
            }
        }
        [dic setValue:rangArr forKey:@"range"];
        [dic setValue:@"特惠卡" forKey:@"typeName"];
        [_cartArr addObject:dic];
    }
    
    for (SaleModel *model in _GDKDRenXuanSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"card_num" forKey:@"type"];
        [dic setValue:@"任选卡" forKey:@"typeName"];
        [dic setValue:model.lingshouMoney forKey:@"q_money"];

        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GDKDChuZhiSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"stored_card" forKey:@"type"];
        [dic setValue:@"储值卡" forKey:@"typeName"];
        [dic setValue:model.lingshouMoney forKey:@"q_money"];

        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GDKDTimeSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"card_time" forKey:@"type"];
        [dic setValue:@"时间卡" forKey:@"typeName"];
        [dic setValue:model.lingshouMoney forKey:@"q_money"];

        [dic setValue:model.sastoreCardModel.code?model.sastoreCardModel.code:@"" forKey:@"store_card"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GDKDTicketSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"ticket" forKey:@"type"];
        [dic setValue:@"票券" forKey:@"typeName"];
        [dic setValue:model.lingshouMoney forKey:@"q_money"];

        [_cartArr addObject:dic];
    }
    
    [_commitDic setValue:_cartArr forKey:@"cart"];
}
- (NSMutableDictionary *)num4Action{
    
    NSMutableDictionary *cartDic = [[NSMutableDictionary alloc]init];
    NSMutableArray *y_awardArr = [[NSMutableArray alloc]init];
    
    NSInteger huishouTotalPrice = 0;
    
    for (SAZhiHuanPorModel *model in _YGZHProSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.uid)] forKey:@"did"];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        huishouTotalPrice += [model.totalPrice integerValue];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"pro" forKey:@"type"];
        [dic setValue:@"项目" forKey:@"typeName"];
        [y_awardArr addObject:dic];
    }
    for (SAZhiHuanPorModel *model in _YGZHGoodsSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.uid)] forKey:@"did"];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        huishouTotalPrice += [model.totalPrice integerValue];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"goods" forKey:@"type"];
        [dic setValue:@"产品" forKey:@"typeName"];
        [y_awardArr addObject:dic];
    }
    for (SAZhiHuanPorModel *model in _YGZHChuZhiSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.user_card_id)] forKey:@"did"];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        huishouTotalPrice += [model.totalPrice integerValue];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"stored_card" forKey:@"type"];
        [dic setValue:@"储值卡" forKey:@"typeName"];
        if (model.isHuiShou) {
            [dic setValue:@(1) forKey:@"award_del"];
        }else{
            [dic setValue:@(2) forKey:@"award_del"];
        }
        [y_awardArr addObject:dic];
    }
    for (SAZhiHuanPorModel *model in _YGZHRenXuanSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.uid)] forKey:@"did"];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        huishouTotalPrice += [model.totalPrice integerValue];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"card_num" forKey:@"type"];
        [dic setValue:@"任选卡" forKey:@"typeName"];
        if (model.isHuiShou) {
            [dic setValue:@(1) forKey:@"award_del"];
        }else{
            [dic setValue:@(2) forKey:@"award_del"];
        }
        [y_awardArr addObject:dic];
    }
    for (SAZhiHuanPorModel *model in _YGZHTimeSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.uid)] forKey:@"did"];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        huishouTotalPrice += [model.totalPrice integerValue];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"card_time" forKey:@"type"];
        [dic setValue:@"时间卡" forKey:@"typeName"];
        if (model.isHuiShou) {
            [dic setValue:@(1) forKey:@"award_del"];
        }else{
            [dic setValue:@(2) forKey:@"award_del"];
        }
        [y_awardArr addObject:dic];
    }
    for (SADepositListModelSales *model in _YGZHDingjinSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.ID)] forKey:@"sales_id"];
        [dic setValue:@"定金订单" forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        huishouTotalPrice += [model.totalPrice integerValue];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"num"];
        [dic setValue:@"" forKey:@"code"];
        [dic setValue:@"sales" forKey:@"type"];
        [dic setValue:@"定金订单" forKey:@"typeName"];
        [y_awardArr addObject:dic];
    }
    
    for (SAZhiHuanPorModel *model in _YGZHTicketSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.uid)] forKey:@"did"];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:model.totalPrice forKey:@"price"];
        huishouTotalPrice += [model.totalPrice integerValue];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.numDisPlay)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:@"ticket" forKey:@"type"];
        [dic setValue:@"票券" forKey:@"typeName"];
        [y_awardArr addObject:dic];
    }
    [cartDic setValue:y_awardArr forKey:@"y_award"];
    [_commitDic setValue:cartDic forKey:@"cart"];
    [_commitDic setValue:[NSString stringWithFormat:@"%@",@(huishouTotalPrice)] forKey:@"huishouTotalPrice"];
    return _commitDic;
}

- (void)num5Action{
    if (_cartArr.count > 0) {
        [_cartArr removeAllObjects];
    }
    for (SaleModel *model in _GXZDProSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            [dic setValue:model.inputPrice forKey:@"heji"];
            [dic setValue:model.inputPrice forKey:@"price"];
        }else{
            [dic setValue:model.totalPrice forKey:@"heji"];
            [dic setValue:model.totalPrice forKey:@"price"];
            
        }
        [dic setValue:model.totalShangpinYuanJiaPrice?model.totalShangpinYuanJiaPrice:@"" forKey:@"amount_t"];
        [dic setValue:@"pro" forKey:@"type"];
        [dic setValue:@"项目" forKey:@"typeName"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GXZDGoodsSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            [dic setValue:model.inputPrice forKey:@"heji"];
            [dic setValue:model.inputPrice forKey:@"price"];
            
        }else{
            [dic setValue:model.totalPrice forKey:@"heji"];
            [dic setValue:model.totalPrice forKey:@"price"];
        }
        [dic setValue:model.totalShangpinYuanJiaPrice?model.totalShangpinYuanJiaPrice:@"" forKey:@"amount_t"];
        [dic setValue:@"goods" forKey:@"type"];
        [dic setValue:@"产品" forKey:@"typeName"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GXZDTeHuiSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            [dic setValue:model.inputPrice forKey:@"heji"];
            [dic setValue:model.inputPrice forKey:@"price"];
            
        }else{
            [dic setValue:model.totalPrice forKey:@"heji"];
            [dic setValue:model.totalPrice forKey:@"price"];
            
        }
        [dic setValue:model.totalShangpinYuanJiaPrice?model.totalShangpinYuanJiaPrice:@"" forKey:@"amount_t"];
        
        NSMutableArray *rangArr = [[NSMutableArray alloc]init];
        NSDictionary *rootDic = [model.baohanJsonStr dictionaryWithJsonString:model.baohanJsonStr];
        NSArray *arr1 = rootDic[@"guding"];
        NSArray *arr2 = rootDic[@"daixuan"];
        if (arr1.count) {
            for (NSMutableDictionary *dic in arr1) {
                [dic removeObjectForKey:@"rights"];
                dic[@"group_id"] = dic[@"group"];
                dic[@"group_map"] = @"";
                [rangArr addObject:dic];
            }
        }
        if (arr2.count) {
            for (NSMutableDictionary *dic in arr2) {
                [dic removeObjectForKey:@"rights"];
                dic[@"group_id"] = dic[@"group"];
                dic[@"group_map"] = @"";
                [rangArr addObject:dic];
            }
        }
        [dic setValue:rangArr forKey:@"range"];
        
        [dic setValue:@"card_course" forKey:@"type"];
        [dic setValue:@"特惠卡" forKey:@"typeName"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GXZDRenXuanSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            [dic setValue:model.inputPrice forKey:@"heji"];
            [dic setValue:model.inputPrice forKey:@"price"];
            
        }else{
            [dic setValue:model.totalPrice forKey:@"heji"];
            [dic setValue:model.totalPrice forKey:@"price"];
            
        }
        [dic setValue:model.totalShangpinYuanJiaPrice?model.totalShangpinYuanJiaPrice:@"" forKey:@"amount_t"];
        [dic setValue:@"card_num" forKey:@"type"];
        [dic setValue:@"任选卡" forKey:@"typeName"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GXZDTimeSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            [dic setValue:model.inputPrice forKey:@"heji"];
            [dic setValue:model.inputPrice forKey:@"price"];
            
        }else{
            [dic setValue:model.totalPrice forKey:@"heji"];
            [dic setValue:model.totalPrice forKey:@"price"];
            
        }
        [dic setValue:model.totalShangpinYuanJiaPrice?model.totalShangpinYuanJiaPrice:@"" forKey:@"amount_t"];
        [dic setValue:@"card_time" forKey:@"type"];
        [dic setValue:@"时间卡" forKey:@"typeName"];
        [_cartArr addObject:dic];
    }
    for (SaleModel *model in _GXZDTicketSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            [dic setValue:model.inputPrice forKey:@"heji"];
            [dic setValue:model.inputPrice forKey:@"price"];
            
        }else{
            [dic setValue:model.totalPrice forKey:@"heji"];
            [dic setValue:model.totalPrice forKey:@"price"];
            
        }
        [dic setValue:model.totalShangpinYuanJiaPrice?model.totalShangpinYuanJiaPrice:@"" forKey:@"amount_t"];
        [dic setValue:@"ticket" forKey:@"type"];
        [dic setValue:@"票券" forKey:@"typeName"];
        [_cartArr addObject:dic];
    }
    [_commitDic setValue:_cartArr forKey:@"cart"];
}
- (void)num6Action{
    if (_cartArr.count > 0) {
        [_cartArr removeAllObjects];
    }
    if (_SKXKproDic.allKeys.count > 0) {
        [_cartArr addObject:_SKXKproDic];
    }
    for (NSMutableDictionary *tempDic in _cartSubCardNumArr) {
        [_cartArr addObject:tempDic];
    }
    for (NSMutableDictionary *tempDic in _cartSubStoreCardArr) {
        [_cartArr addObject:tempDic];
    }
    for (NSMutableDictionary *tempDic in _cartSubTimeArr) {
        [_cartArr addObject:tempDic];
    }
    [_commitDic setValue:_cartArr forKey:@"cart"];
}
- (void)num7Action{
    NSMutableDictionary * tmpcartDic =_ziHuanDic[@"cart"];
    NSMutableArray *awardArr = [[NSMutableArray alloc]init];
    [tmpcartDic setValue:awardArr forKey:@"award"];
    if (awardArr.count > 0) {
        [awardArr removeAllObjects];
    }
    float zhiHuanTotalPrice = 0.0;
    if (_CustomerTempArr.count > 0) {
        SAAccountModel *model = _CustomerTempArr[0];
        if (!model.inputPrice || [model.inputPrice isEqualToString:@""]) {
            [MzzHud toastWithTitle:@"温馨提示" message:@"请填写充值金额"];
            _isMustbeStop = YES;
            return;
        }else{
            _isMustbeStop = NO;
        }
        NSMutableDictionary *dicbank = [[NSMutableDictionary alloc]init];
        [dicbank setValue:[NSString stringWithFormat:@"%ld",_user_id] forKey:@"user_id"];
        [dicbank setValue:[NSString stringWithFormat:@"%@",@(1)] forKey:@"num"];
        [dicbank setValue:[NSString stringWithFormat:@"%.2f",[model.inputPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.inputPrice floatValue];
        [dicbank setValue:[NSString stringWithFormat:@"账户充值：%@元",[NSString stringWithFormat:@"%.2f",[model.inputPrice floatValue]]] forKey:@"name"];
        [dicbank setValue:@"bank" forKey:@"type"];
        [dicbank setValue:@"账户" forKey:@"typeName"];
        [awardArr addObject:dicbank];
    }
    for (SaleModel *model in _GXZDProSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.totalPrice floatValue];
        [dic setValue:@"pro" forKey:@"type"];
        [dic setValue:@"项目" forKey:@"typeName"];
        [awardArr addObject:dic];
    }
    for (SaleModel *model in _GXZDGoodsSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.totalPrice floatValue];
        [dic setValue:@"goods" forKey:@"type"];
        [dic setValue:@"产品" forKey:@"typeName"];
        [awardArr addObject:dic];
    }
    for (SaleModel *model in _GXZDTeHuiSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.totalPrice floatValue];
        [dic setValue:@"card_course" forKey:@"type"];
        NSMutableArray *rangArr = [[NSMutableArray alloc]init];
        NSDictionary *rootDic = [model.baohanJsonStr dictionaryWithJsonString:model.baohanJsonStr];
        NSArray *arr1 = rootDic[@"guding"];
        NSArray *arr2 = rootDic[@"daixuan"];
        if (arr1.count) {
            for (NSMutableDictionary *dic in arr1) {
                [dic removeObjectForKey:@"rights"];
                dic[@"group_id"] = dic[@"group"];
                dic[@"group_map"] = @"";
                [rangArr addObject:dic];
            }
        }
        if (arr2.count) {
            for (NSMutableDictionary *dic in arr2) {
                [dic removeObjectForKey:@"rights"];
                dic[@"group_id"] = dic[@"group"];
                dic[@"group_map"] = @"";
                [rangArr addObject:dic];
            }
        }
        [dic setValue:rangArr forKey:@"range"];
        [dic setValue:@"特惠卡" forKey:@"typeName"];
        [awardArr addObject:dic];
    }
    for (SaleModel *model in _GXZDRenXuanSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.totalPrice floatValue];
        [dic setValue:@"card_num" forKey:@"type"];
        [dic setValue:@"任选卡" forKey:@"typeName"];
        [awardArr addObject:dic];
    }
    for (SaleModel *model in _GDKDChuZhiSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.totalPrice floatValue];
        [dic setValue:@"stored_card" forKey:@"type"];
        [dic setValue:@"储值卡" forKey:@"typeName"];
        [awardArr addObject:dic];
    }
    for (SaleModel *model in _GXZDTimeSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.totalPrice floatValue];
        [dic setValue:@"card_time" forKey:@"type"];
        [dic setValue:@"时间卡" forKey:@"typeName"];
        [awardArr addObject:dic];
    }
    for (SaleModel *model in _GXZDTicketSelfTempArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.addnum)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]] forKey:@"price"];
        zhiHuanTotalPrice += [model.totalPrice floatValue];
        [dic setValue:@"ticket" forKey:@"type"];
        [dic setValue:@"票券" forKey:@"typeName"];
        [awardArr addObject:dic];
    }
    [_ziHuanDic setValue:[NSString stringWithFormat:@"%.2f",zhiHuanTotalPrice] forKey:@"zhiHuanTotalPrice"];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)GouWuCheEvent:(UIButton *)sender {
    _tbGouWuChe.hidden = !_tbGouWuChe.hidden;
    _btnTopDark.hidden = !_btnTopDark.hidden;
    
    _btnCancle.hidden = YES;
    _lbMiddle.hidden = YES;
    _btnSure.hidden = YES;
    _btnGouWu.hidden = NO;
    _lbGouWuNum.hidden = NO;
    _btnNext.hidden = NO;
    if (!_tbGouWuChe.hidden) {
        skxkTbChoiseTag = 0;
        [_tbGouWuChe reloadData];
    }
}
- (IBAction)TopDarkEvent:(UIButton *)sender {
    _tbGouWuChe.hidden = YES;
    _btnTopDark.hidden = YES;
    
    _btnCancle.hidden = YES;
    _lbMiddle.hidden = YES;
    _btnSure.hidden = YES;
    _btnGouWu.hidden = NO;
    _lbGouWuNum.hidden = NO;
    _btnNext.hidden = NO;
    _downView.hidden = NO;
}
- (IBAction)btnCancleEvent:(UIButton *)sender {
    [self TopDarkEvent:nil];
    
}
- (IBAction)btnSureEvent:(UIButton *)sender {
    [self TopDarkEvent:nil];
    switch (skxkTbChoiseTag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        default:
            break;
    }
}
#pragma mark 优惠券
- (void)requestZheKouYouHuiSearchId:(NSString *)searchId
                             proNum:(NSString *)proNum
                               type:(NSString *)type{
    
    [SaleListRequest requestgetBasicStoredSearchId:searchId userId:[NSString stringWithFormat:@"%ld",_user_id] proNum:proNum type:type joinCode:join_code storedCode:_store_code resultBlock:^(ZheKouModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _ZheKouList = [NSMutableArray array];
            [_ZheKouList removeAllObjects];
            [_ZheKouList addObjectsFromArray: model.data.stored_card];
            SaleModel *selectModel = _dicRight[_typeStrRight][_ChangeindexPath.row];//这个对象选择了优惠卡
            [_selectHuiyuanArray addObject:selectModel];
            if (selectModel.huiyuanName.length!=0) {
                for(int i = 0 ; i<_ZheKouList.count ; i++){
                    ZheKouStored_Card * Card =_ZheKouList[i];
                    if ([selectModel.huiyuanName isEqualToString:Card.name]){
                        Card.selected = YES;
                        break;
                    }
                }
            }
            if (_ZheKouList.count>0) {
                [self btnzhekouChoiceEvent];
            } else {
                [MzzHud toastWithTitle:@"温馨提示" message:@"暂无会员优惠"];
            }
            //            [_tbViewRight reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_ChangeindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}
- (void)reduceChangeNumMethod{
    if (_isSale) {
        switch (_billType) {
            case 3:
            {
                NSInteger num = _GDKDProSelfTempArr.count + _GDKDGoodsSelfTempArr.count + _GDKDTeHuiSelfTempArr.count + _GDKDRenXuanSelfTempArr.count + _GDKDChuZhiSelfTempArr.count + _GDKDTimeSelfTempArr.count + _GDKDTicketSelfTempArr.count;
                _lbGouWuNum.text = [NSString stringWithFormat:@"%@",@(num)];
                _gouwucheNum = num;
                _lbHuiShouTop.constant = 35;
                _lbHuiShou.text = [NSString stringWithFormat:@"规划总项目数：%ld",num];
            }
                break;
            case 4:
            {
                NSInteger num = _YGZHProSelfTempArr.count + _YGZHGoodsSelfTempArr.count + _YGZHRenXuanSelfTempArr.count + _YGZHTimeSelfTempArr.count + _YGZHDingjinSelfTempArr.count + _YGZHTicketSelfTempArr.count+_YGZHChuZhiSelfTempArr.count;
                _lbGouWuNum.text = [NSString stringWithFormat:@"%@",@(num)];
                _yigouNumStr = _lbGouWuNum.text;
                _gouwucheNum = num;
                _lbHuiShouTop.constant = 35;
                _lbHuiShou.text = [NSString stringWithFormat:@"规划总项目数：%ld",num];
            }
                break;
            case 5:
            {
                NSInteger num = _GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count + _GXZDTimeSelfTempArr.count + _GXZDTicketSelfTempArr.count;
                _lbGouWuNum.text = [NSString stringWithFormat:@"%@",@(num)];
                _gouwucheNum = num;
                _lbHuiShouTop.constant = 35;
                _lbHuiShou.text = [NSString stringWithFormat:@"规划总项目数：%ld",num];
            }
                break;
            case 6:
            {
                NSInteger num = _cartSubProArr.count + _cartSubCardNumArr.count + _cartSubStoreCardArr.count + _cartSubTimeArr.count;
                _lbGouWuNum.text = [NSString stringWithFormat:@"%@",@(num)];
                _gouwucheNum = num;
                _lbHuiShouTop.constant = 35;
                _lbHuiShou.text = [NSString stringWithFormat:@"规划总项目数：%ld",num];
            }
                break;
            case 7:
            {
                NSInteger num = (_CustomerTempArr.count +_GXZDProSelfTempArr.count + _GXZDGoodsSelfTempArr.count + _GXZDTeHuiSelfTempArr.count + _GXZDRenXuanSelfTempArr.count +_GDKDChuZhiSelfTempArr.count+ _GXZDTimeSelfTempArr.count + _GXZDTicketSelfTempArr.count);
                _lbGouWuNum.text = [NSString stringWithFormat:@"%@",@(num)];
                _lbZhiHuan.hidden = NO;
                _lbZhiHuan.text = [NSString stringWithFormat:@"置换数量：%@个",@(num)];
                _gouwucheNum = num;
            }
                break;
            default:
                break;
        }
        
    }else{
        switch (_billType) {
            case 1:
            {
                NSInteger num = _presArr.count +_stored_cardArr.count+_card_numArr.count+_card_timeArr.count+_rec_proArr.count+_rec_goodsArr.count;
                _lbGouWuNum.text = [NSString stringWithFormat:@"%ld",num];
                _gouwucheNum = num;
                _lbHuiShouTop.constant = 35;
                _lbHuiShou.text = [NSString stringWithFormat:@"规划总项目数：%ld",num];
            }
                break;
            case 2:
            {
                NSInteger num = _proArr.count + _goodsArr.count + _course_experArr.count;
                _lbGouWuNum.text = [NSString stringWithFormat:@"%ld",num];
                _gouwucheNum = num;
                _lbHuiShouTop.constant = 35;
                _lbHuiShou.text = [NSString stringWithFormat:@"规划总项目数：%ld",num];
            }
                break;
            default:
                break;
        }
    }
    [_tbGouWuChe reloadData];
}
#pragma mark --------清空购物车----------
- (void)delEvent{
    _tbGouWuChe.hidden = YES;
    _btnTopDark.hidden = YES;
    _lbGouWuNum.text = @"0";
    _lbHuiShou.text = [NSString stringWithFormat:@"规划总项目数：0"];
    if (_isSale) {
        switch (_billType) {
            case 3:
            {
                [_GDKDProSelfTempArr removeAllObjects];
                [_GDKDGoodsSelfTempArr removeAllObjects];
                [_GDKDTeHuiSelfTempArr removeAllObjects];
                [_GDKDRenXuanSelfTempArr removeAllObjects];
                [_GDKDChuZhiSelfTempArr removeAllObjects];
                [_GDKDTimeSelfTempArr removeAllObjects];
                [_GDKDTicketSelfTempArr removeAllObjects];
            }
                break;
            case 4:
            {
                for (SAZhiHuanPorModel *delmodel in _YGZHProSelfTempArr) {
                    delmodel.numDisPlay = 0;
                }
                [_YGZHProSelfTempArr removeAllObjects];
                [_YGZHGoodsSelfTempArr removeAllObjects];
                [_YGZHRenXuanSelfTempArr removeAllObjects];
                [_YGZHTimeSelfTempArr removeAllObjects];
                [_YGZHDingjinSelfTempArr removeAllObjects];
                [_YGZHTicketSelfTempArr removeAllObjects];
                [_YGZHChuZhiSelfTempArr removeAllObjects];

            }
                break;
            case 5:
            {
                [_GXZDProSelfTempArr removeAllObjects];
                [_GXZDGoodsSelfTempArr removeAllObjects];
                [_GXZDTeHuiSelfTempArr removeAllObjects];
                [_GXZDRenXuanSelfTempArr removeAllObjects];
                [_GXZDTimeSelfTempArr removeAllObjects];
                [_GXZDTicketSelfTempArr removeAllObjects];
            }
                break;
            case 6:
            {
                [_cartSubProArr removeAllObjects];
                [_cartSubCardNumArr removeAllObjects];
                [_cartSubStoreCardArr removeAllObjects];
                [_cartSubTimeArr removeAllObjects];
            }
                break;
            case 7:
            {
                [_CustomerTempArr removeAllObjects];
                [_GXZDProSelfTempArr removeAllObjects];
                [_GXZDGoodsSelfTempArr removeAllObjects];
                [_GXZDTeHuiSelfTempArr removeAllObjects];
                [_GXZDRenXuanSelfTempArr removeAllObjects];
                [_GXZDTimeSelfTempArr removeAllObjects];
                [_GXZDTicketSelfTempArr removeAllObjects];
            }
                break;
            default:
                break;
        }
    }else{
        switch (_billType) {
            case 1:
            {
                 switch (_type) {
                         case Pres:
                     {
                         //刷新服务单处方服务右侧tableview数据显示
                         [self refreshFuWu];
                     }
                         break;
                     default:
                         break;
                 }
                [_presArr removeAllObjects];
                [_stored_cardArr removeAllObjects];
                [_card_numArr removeAllObjects];
                [_card_timeArr removeAllObjects];
                [_rec_proArr removeAllObjects];
                [_rec_goodsArr removeAllObjects];
                
                break;
            }
            case 2:
            {
                [_proArr removeAllObjects];
                [_goodsArr removeAllObjects];
                [_course_experArr removeAllObjects];
            }
                break;
            default:
                break;
        }
    }
    [_tbViewRight reloadData];
}
#pragma mark -----------点击清空购物车按钮刷新服务单处方服务右侧tableview数据显示------------
-(void)refreshFuWu
{
    BOOL isFind = NO;
    for (SLPresListModel *SLPresListModelmodel in _SLPresModelmodel.list) {
        NSMutableArray *arr = [SLPresListModelmodel.pro_list mutableCopy];
        SLPresListModelmodel.isSelect = NO;
        for (Pro_List *model in arr) {
            model.numDisplay=0;
            for (NSMutableDictionary *tempDic in _presArr) {
                if ([tempDic[@"pro_code"] isEqualToString:model.pro_code]) {
                    if (model.numDisplay == 0) {
                        [_presArr removeObject:tempDic];
                        isFind = YES;
                    }
                    break;
                }
            }
            if (!isFind) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                dic[@"name"] = model.pro_name;
                dic[@"id"] = @(model.ID);
                dic[@"numMax"] = @(model.num);
                dic[@"num"] = @(model.numDisplay);
                dic[@"numDisplay"] = @(model.numDisplay);
                dic[@"price"] = model.price;
                dic[@"pro_code"] = model.pro_code;
                dic[@"shichang"] = [NSString stringWithFormat:@"%ld",model.shichang];
                dic[@"type"] = @"处方服务";
                [_presArr addObject:dic];
            }
            
        }
    }
}

- (void)animationDidFinish{
    [self.redView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        _btnGouWu.transform = CGAffineTransformMakeScale(0.8, 0.8);
        _lbGouWuNum.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _btnGouWu.transform = CGAffineTransformMakeScale(1, 1);
            _lbGouWuNum.transform = CGAffineTransformMakeScale(1, 1);
            [self reduceChangeNumMethod];
        } completion:^(BOOL finished) {
            
        }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
