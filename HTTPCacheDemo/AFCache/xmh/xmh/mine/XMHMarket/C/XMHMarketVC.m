//
//  XMHMarketVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHMarketVC.h"
#import "XMHMarketSelectView.h"
#import "XMHMarketInfoView.h"
#import "XMHPickerView.h"
#import "XMHMarketShareView.h"
#import "MarketRequest.h"
#import "MStoreListModel.h"
#import "MWareListModel.h"
#import "XMHMarketModel.h"
#import "UIView+FWScreenshot.h"
#import <UMShare/UMShare.h>
@interface XMHMarketVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray * storeDataSource;
@property (nonatomic, strong)NSMutableArray * goodsDataSource;
@property (nonatomic, strong)NSString * selectStoreCode;
@property (nonatomic, strong)NSString * selectGoodsCode;
@property (nonatomic, strong)XMHMarketInfoView * marketInfoView;
@property (nonatomic, strong)XMHMarketModel *market;
@property (nonatomic, strong)UIButton * shareBtn;
@property (nonatomic, strong)XMHMarketSelectView * storeSelectView;
@property (nonatomic, strong)XMHMarketSelectView * goodsSelectView;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation XMHMarketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    [self.navView setNavViewTitle:_navtitle backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
//    [self initSubViews];
    [self requestStoreData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KTabbarHeight);
    }];
}
- (void)initSubViews
{
    UILabel * lb1 = [[UILabel alloc] init];
    lb1.text = @"第一步：请选择要推广的门店";
    lb1.font = FONT_SIZE(11);
    lb1.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    [lb1 sizeToFit];
    lb1.frame = CGRectMake(15, Heigh_Nav + 15, lb1.width, lb1.height);
    [self.view addSubview:lb1];
    XMHMarketSelectView * selectView1 = loadNibName(@"XMHMarketSelectView");
    
    __weak typeof(self) _self = self;
    [selectView1 bk_whenTapped:^{
        __strong typeof(_self) self = _self;
        [self selectStore];
    }];
    _storeSelectView = selectView1;
    [selectView1 updateViewTitle:@"请选择要推广的门店"];
    selectView1.frame = CGRectMake(15, lb1.bottom + 5, SCREEN_WIDTH - 30, 44);
    [self.view addSubview:selectView1];
    
    UILabel * lb2 = [[UILabel alloc] init];
    lb2.text = @"第二步：选择商品即可生成二维码";
    lb2.font = FONT_SIZE(11);
    lb2.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    [lb2 sizeToFit];
    lb2.frame = CGRectMake(15, selectView1.bottom + 15, lb2.width, lb2.height);
    [self.view addSubview:lb2];
    NSString * title= @"";
    if (_marketVCType == XMHMarketVCTypeSMLL) {
        title = @"请选择要生成的领礼商品";
    }else if (_marketVCType == XMHMarketVCTypeXMYL){
        title = @"请选择要生成的特惠项目";
    }else if (_marketVCType == XMHMarketVCTypeLKLB){
        title = @"请选择要生成的众筹项目";
    }else if (_marketVCType == XMHMarketVCTypeQYB){
        title = @"请选择要生成的权益包";
    }else if (_marketVCType == XMHMarketVCTypeVIP){
        title = @"请选择要生成的VIP活动";
    }else{}
    XMHMarketSelectView * selectView2 = loadNibName(@"XMHMarketSelectView");
    [selectView2 bk_whenTapped:^{
        __strong typeof(_self) self = _self;
        [self selectGoods];
    }];
    _goodsSelectView = selectView2;
    [selectView2 updateViewTitle:title];
    selectView2.frame = CGRectMake(15, lb2.bottom + 5, SCREEN_WIDTH - 30, 44);
    [self.view addSubview:selectView2];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"  分享或收藏 " forState:UIControlStateNormal];
    [shareBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [shareBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self showShareView];
    } forControlEvents:UIControlEventTouchUpInside];
    shareBtn.backgroundColor = [UIColor whiteColor];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareBtn setImage:[UIImage imageNamed:@"yxewm_fenxiang"] forState:UIControlStateNormal];
    [shareBtn setTitleColor:kColor3 forState:UIControlStateNormal];
    shareBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    shareBtn.frame = CGRectMake(0, SCREEN_HEIGHT - KTabbarHeight, SCREEN_WIDTH, KTabbarHeight);
    _shareBtn = shareBtn;
    [self.view addSubview:shareBtn];
    
    XMHMarketInfoView * info = loadNibName(@"XMHMarketInfoView");
    info.hidden = shareBtn.hidden = YES;
    _marketInfoView = info;
    CGFloat w = SCREEN_WIDTH - 38 * 2;
    CGFloat h = 362 * w /300;
    info.frame = CGRectMake(38, selectView2.bottom + 15, w,h);
    info.layer.cornerRadius = 10;
    info.layer.masksToBounds = YES;
    [self.view addSubview:info];
}
- (void)selectStore
{
    NSMutableArray *dataArray = NSMutableArray.new;
    for (int i = 0; i < _storeDataSource.count; i++) {
        XMHItemModel *model = [[XMHItemModel alloc] init];
        MStoreModel * storeModel = _storeDataSource[i];
        model.title = storeModel.name;
        model.idStr = storeModel.store_code;
        [dataArray addObject:model];
    }
    
    XMHPickerView *pickerView = [[XMHPickerView alloc] init];
    pickerView.dataArray = (NSMutableArray *)@[dataArray];
    pickerView.type = PickerViewTypeCustom;
    pickerView.selectComponent = 0;
    [self.view addSubview:pickerView];

    __weak typeof(self) _self = self;
    [pickerView setSureBlock:^(XMHItemModel *  _Nonnull model) {
        __strong typeof(_self) self = _self;
        self.selectStoreCode = model.idStr;
        [self.storeSelectView updateViewTitle:model.title];
        [self requestGoodsData];
    }];
    
}
- (void)selectGoods
{
    NSMutableArray *dataArray = NSMutableArray.new;
    for (int i = 0; i < _goodsDataSource.count; i++) {
        XMHItemModel *model = [[XMHItemModel alloc] init];
        MWareModel * goodModel = _goodsDataSource[i];
        model.title = goodModel.name;
        model.idStr = goodModel.code;
        [dataArray addObject:model];
    }
    
    XMHPickerView *pickerView = [[XMHPickerView alloc] init];
    pickerView.dataArray = (NSMutableArray *)@[dataArray];
    pickerView.type = PickerViewTypeCustom;
    pickerView.selectComponent = 0;
    [self.view addSubview:pickerView];
    
    __weak typeof(self) _self = self;
    [pickerView setSureBlock:^(XMHItemModel *  _Nonnull model) {
        __strong typeof(_self) self = _self;
        self.selectGoodsCode = model.idStr;
        [self.goodsSelectView updateViewTitle:model.title];
        [self requestQCode];
    }];
}
- (void)showShareView
{
    XMHMarketShareView * shareView = loadNibName(@"XMHMarketShareView");
    __weak typeof(self) _self = self;
    shareView.XMHMarketShareViewBlock = ^(NSInteger index) {
        __strong typeof(_self) self = _self;
       UIImage * shotImg =  [self.marketInfoView screenshot];
        if (index == 1) {/** 微信 */
            [self shareImageToPlatformType:UMSocialPlatformType_WechatSession img:shotImg];
        }else if (index == 2){/** 朋友圈 */
            [self shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine img:shotImg];
        }else if (index == 3){/** 本地 */
            [self loadImageFinished:shotImg];
        }else{}
    };
    [shareView updateViewModel:_market type:_marketVCType];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    shareView.frame = window.bounds;
    [window addSubview:shareView];
}
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (image) {
        [XMHProgressHUD showOnlyText:@"图片保存成功"];
    }
}
/** 分享 */
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType img:(UIImage *)img
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    [shareObject setShareImage:img];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [XMHProgressHUD showOnlyText:error.localizedDescription];
        }else{
            [XMHProgressHUD showOnlyText:kNOTICE_UM_SHARE_SUCCESS_MSG];
        }
    }];
}

#pragma mark -----网络请求-----
/** 门店数据 */
- (void)requestStoreData
{
    NSString * framID = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    [MarketRequest requestStoreFramId:framID resultBlock:^(MStoreListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _storeDataSource = [[NSMutableArray alloc] initWithArray:model.list];
            if (_storeDataSource.count == 1) {
                MStoreModel * storeModel = _storeDataSource[0];
                _selectStoreCode = storeModel.store_code;
                [_storeSelectView updateViewTitle:storeModel.name];
                [self requestGoodsData];
            }
        }
    }];
}
/** 商品数据 */
- (void)requestGoodsData
{
    NSString * type = [NSString stringWithFormat:@"%ld",_marketVCType];
    [MarketRequest requestWareType:type storeCode:_selectStoreCode resultBlock:^(MWareListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _goodsDataSource = [[NSMutableArray alloc] initWithArray:model.list];
        }
    }];
}
/** 商品数据 */
- (void)requestQCode
{
    NSString * type = [NSString stringWithFormat:@"%ld",_marketVCType];
    [MarketRequest requestQRcodeType:type storeCode:_selectStoreCode code:_selectGoodsCode resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            XMHMarketModel *market = [XMHMarketModel yy_modelWithDictionary:model.data];
            _market = market;
            _marketInfoView.hidden = _shareBtn.hidden = NO;
            _tableView.scrollEnabled = YES;
            self.view.backgroundColor = UIColor.whiteColor;
            [_marketInfoView updateViewModel:market type:_marketVCType];
        }
    }];
}

#pragma mark -- lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - KNaviBarHeight - KTabbarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.tableHeaderView = [self tableViewHeaderView];
        _tableView.tableFooterView = [self tableViewFooterView];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return 0;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{return UITableViewCell.new;}

- (UIView *)tableViewHeaderView{
    UIView *headerView = UIView.new;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 156);
    headerView.backgroundColor = kBackgroundColor;
    
    UILabel * lb1 = [[UILabel alloc] init];
    lb1.text = @"第一步：请选择要推广的门店";
    lb1.font = FONT_SIZE(11);
    lb1.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    [lb1 sizeToFit];
    lb1.frame = CGRectMake(15,  15, lb1.width, 14);
    [headerView addSubview:lb1];
    XMHMarketSelectView * selectView1 = loadNibName(@"XMHMarketSelectView");
    
    __weak typeof(self) _self = self;
    [selectView1 bk_whenTapped:^{
        __strong typeof(_self) self = _self;
        [self selectStore];
    }];
    _storeSelectView = selectView1;
    [selectView1 updateViewTitle:@"请选择要推广的门店"];
    selectView1.frame = CGRectMake(15, lb1.bottom + 5, SCREEN_WIDTH - 30, 44);
    [headerView addSubview:selectView1];
    
    UILabel * lb2 = [[UILabel alloc] init];
    lb2.text = @"第二步：选择商品即可生成二维码";
    lb2.font = FONT_SIZE(11);
    lb2.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    [lb2 sizeToFit];
    lb2.frame = CGRectMake(15, selectView1.bottom + 15, lb2.width, 14);
    [headerView addSubview:lb2];
    NSString * title= @"";
    if (_marketVCType == XMHMarketVCTypeSMLL) {
        title = @"请选择要生成的领礼商品";
    }else if (_marketVCType == XMHMarketVCTypeXMYL){
        title = @"请选择要生成的特惠项目";
    }else if (_marketVCType == XMHMarketVCTypeLKLB){
        title = @"请选择要生成的众筹项目";
    }else if (_marketVCType == XMHMarketVCTypeQYB){
        title = @"请选择要生成的权益包";
    }else if (_marketVCType == XMHMarketVCTypeVIP){
        title = @"请选择要生成的VIP活动";
    }else{}
    XMHMarketSelectView * selectView2 = loadNibName(@"XMHMarketSelectView");
    [selectView2 bk_whenTapped:^{
        __strong typeof(_self) self = _self;
        [self selectGoods];
    }];
    _goodsSelectView = selectView2;
    [selectView2 updateViewTitle:title];
    selectView2.frame = CGRectMake(15, lb2.bottom + 5, SCREEN_WIDTH - 30, 44);
    [headerView addSubview:selectView2];
    
    return headerView;
}
- (UIView *)tableViewFooterView{
    CGFloat w = SCREEN_WIDTH - 38 * 2;
    CGFloat h = 362 * w /300;
    CGFloat y = 15;
    if (_marketVCType == XMHMarketVCTypeVIP) {
        h = 489 * w /300;
        y = 25;
    }
   
    UIView *footerView = UIView.new;
    footerView.backgroundColor = kBackgroundColor;
    footerView.frame  =CGRectMake(0, 0, SCREEN_WIDTH, h + y * 2);
    
    XMHMarketInfoView * info = loadNibName(@"XMHMarketInfoView");
    info.hidden = YES;
    _marketInfoView = info;
   
    info.frame = CGRectMake(38,  y, w,h);
    info.layer.cornerRadius = 10;
    info.layer.masksToBounds = YES;
    [footerView addSubview:info];
  
    return footerView;
}
- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        __weak typeof(self) _self = self;
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"  分享或收藏 " forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kColor6 forState:UIControlStateNormal];
        [_shareBtn bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            [self showShareView];
        } forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.backgroundColor = [UIColor whiteColor];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_shareBtn setImage:[UIImage imageNamed:@"yxewm_fenxiang"] forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kColor3 forState:UIControlStateNormal];
        _shareBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _shareBtn.hidden = YES;
    }
    return _shareBtn;
}
@end
