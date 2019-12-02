//
//  SmarketViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/30.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SmarketViewController.h"
#import "SmarketListView.h"
#import "SmartketSelectView.h"
#import "MarketRequest.h"
#import "MStoreListModel.h"
#import "MWareListModel.h"
#import "ShareWorkInstance.h"
#import "BaseModel.h"
#import <YYWebImage/YYWebImage.h>
@interface SmarketViewController ()

@end

@implementation SmarketViewController
{
    MStoreListModel * _storeListModel;
    MWareListModel * _wareListModel;
    SmarketListView * _storeView;
    SmarketListView * _wareView;
    SmartketSelectView * _selectView;
    NSString * _framId;
    NSString * _storeName;
    NSString * _type;
    NSString * _storeCode;
    NSString * _wareName;
    NSString * _wareCode;
    BaseModel * _baseModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:self.title backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self initParams];
    [self requestStoreData];
    [self initSubViews];
}
- (void)initParams
{
    _framId = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * type = @"";
    if ([self.title isEqualToString:@"扫码领礼"]) {
        type = @"1";
    }else if ([self.title isEqualToString:@"项目引流"]){
        type = @"2";
    }else if ([self.title isEqualToString:@"老客裂变"]){
        type = @"3";
    }else{
        type = @"4";
    }
    _type = type;
}
- (void)initSubViews
{
//    [self creatNav];
    [self createListView];
    [self requestStoreData];
}
- (void)requestStoreData
{
    WeakSelf
    [MarketRequest requestStoreFramId:_framId resultBlock:^(MStoreListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _storeListModel = model;
            [weakSelf refreshStoreView];
        }
    }];
}
- (void)refreshStoreView
{
    WeakSelf
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (MStoreModel * model in _storeListModel.list) {
        [arr addObject:model.name];
    }
    NSArray * nameArr = [[NSArray alloc] initWithArray:arr];
    [_storeView.tf setupData:nameArr];
    _storeView.tf.doneclick = ^(UITextField *textField) {
        _storeName = textField.text;
        [weakSelf requesWareData];
    };
}
- (void)requesWareData
{
    WeakSelf
    NSString * storeCode = @"";
    for (MStoreModel * model in _storeListModel.list) {
        if ([model.name isEqualToString:_storeName]) {
            storeCode = model.store_code;
            _storeCode = storeCode;
        }
    }
    [MarketRequest requestWareType:_type storeCode:storeCode resultBlock:^(MWareListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _wareListModel = model;
            [weakSelf refreshWareView];
        }
    }];
}
- (void)requestQCode
{
    WeakSelf
    [MarketRequest requestQRcodeType:_type storeCode:_storeCode code:_wareCode resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _baseModel = model;
            [weakSelf refreshNoticeView];
        }
    }];
}
- (void)refreshNoticeView
{
    _selectView.viewNotice.hidden = YES;
    _selectView.viewQCode.hidden = NO;
    [_selectView.imgV yy_setImageWithURL:[NSURL URLWithString:_baseModel.data[@"img"]] placeholder:kDefaultImage];
    
}
-(void)longPressView:(UILongPressGestureRecognizer *)longPressGest{
    
//    NSLog(@"%ld",longPressGest.state);
    if (longPressGest.state==UIGestureRecognizerStateBegan) {
        [self loadImageFinished:_selectView.imgV.image];
        MzzLog(@"长按手势开启");
    } else {
        MzzLog(@"长按手势结束");
    }
    
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
- (void)refreshWareView
{
    WeakSelf
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (MWareModel * model in _wareListModel.list) {
        [arr addObject:model.name];
    }
    NSArray * nameArr = [[NSArray alloc] initWithArray:arr];
    [_wareView.tf setupData:nameArr];
    _wareView.tf.doneclick = ^(UITextField *textField) {
        _wareName = textField.text;
        for (MWareModel * model in _wareListModel.list) {
            if ([model.name isEqualToString:_wareName]) {
                _wareCode = model.code;
                [weakSelf requestQCode];
                return ;
            }
        }
    };
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:self.title withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)createListView
{
    SmarketListView * list1 = [[[NSBundle mainBundle]loadNibNamed:@"SmarketListView" owner:nil options:nil]lastObject];
    list1.tf.text = @"请选择要推广的门店";
    list1.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44);
    _storeView = list1;
    [self.view addSubview:list1];
    
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, list1.bottom, SCREEN_WIDTH, 10);
    [self.view addSubview:line];
    
    SmarketListView * list2 = [[[NSBundle mainBundle]loadNibNamed:@"SmarketListView" owner:nil options:nil]lastObject];
    list2.frame = CGRectMake(0, line.bottom, SCREEN_WIDTH, 44);
    _wareView = list2;
    NSString * str = @"";
    if ([self.title isEqualToString:@"扫码领礼"]) {
        str = @"请选择要生成的领礼商品";
    }else if ([self.title isEqualToString:@"项目引流"]){
        str = @"请选择要生成的特惠项目";
    }else if ([self.title isEqualToString:@"老客裂变"]){
         str = @"请选择要生成的众筹项目";
    }else{
        str = @"请选择要生成的权益包";
    }
    list2.tf.text = str;
    [self.view addSubview:list2];
    
    SmartketSelectView * selectView = [[[NSBundle mainBundle]loadNibNamed:@"SmartketSelectView" owner:nil options:nil]lastObject];
    selectView.frame = CGRectMake(0, list2.bottom, SCREEN_WIDTH, 400);
    _selectView = selectView;
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
    [_selectView addGestureRecognizer:longPressGest];
    [self.view addSubview:selectView];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
