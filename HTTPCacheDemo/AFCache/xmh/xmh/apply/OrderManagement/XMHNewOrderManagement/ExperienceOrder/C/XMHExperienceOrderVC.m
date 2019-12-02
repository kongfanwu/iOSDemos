//
//  XMHExperienceOrderVC.m
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHExperienceOrderVC.h"
#import "XMHCustomerInfoView.h"
#import "XMHShoppingCartView.h"
#import "XMHSegmentVCManager.h"
#import "XMHSegmentVCModel.h"
#import "XMHExperienceOrderContentVC.h"
#import "XMHExperienceOrderRequest.h"
#import "XMHExperienceOrderContentVC.h"
#import "XMHOrderSearchCustomerVC.h"
#import "CustomerListModel.h"
#import "SLSCourseExper.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "XMHShoppingCartManager.h"
#import "XMHServiceOrderListVC.h"
#import "XMHExperienceOrderRecordVC.h"


@interface XMHExperienceOrderVC ()
/** <##> */
@property (nonatomic, strong) XMHCustomerInfoView *customerInfoView;
/** <##> */
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) XMHShoppingCartView *shoppingCart;
/** <##> */
@property (nonatomic, strong) XMHSegmentVCManager *segmentVCManager;
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** 搜索数据源 */
@property (nonatomic, strong) NSMutableArray *searchDataArray;
@end

@implementation XMHExperienceOrderVC

- (void)dealloc
{
    [XMHShoppingCartManager.sharedInstance clear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;

    [self.navView setNavViewTitle:@"体验制单" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    self.customerInfoView = [[XMHCustomerInfoView alloc] init];
    [self.view addSubview:_customerInfoView];
    [_customerInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    
    WeakSelf
    [_customerInfoView setSearchBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        // 搜索顾客
        XMHOrderSearchCustomerVC *orderSearchCustomerVC = XMHOrderSearchCustomerVC.new;
        [weakSelf presentViewController:orderSearchCustomerVC animated:YES completion:nil];
        [orderSearchCustomerVC setSelectedCustomer:^(CustomerModel * _Nonnull model) {
            weakSelf.selectUserModel = model;
            [customerInfoView configUserName:[NSString stringWithFormat:@"%@ (%@)", model.uname, [model safeMobile]]];
            [weakSelf loadData];
        }];
    }];
    
    [_customerInfoView setDeleteUserBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        weakSelf.selectUserModel = nil;
        [weakSelf configDataProjectModel:nil goodModel:nil experienceModel:nil];
        [XMHShoppingCartManager.sharedInstance clear];
    }];
    
    // 购物车
    self.shoppingCart = [[XMHShoppingCartView alloc] init];
    [self.view addSubview:_shoppingCart];
    [_shoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(49);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    // 支付
    [_shoppingCart setShoppingCart:^(NSMutableArray * _Nonnull modelArr) {
        // 服务制单
        XMHServiceOrderListVC *vc = XMHServiceOrderListVC.new;
        vc.selectUserModel = weakSelf.selectUserModel;
        // 取与购物相同指针对象的集合
        vc.modelArray = XMHShoppingCartManager.sharedInstance.dataArray;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    // 服务内容
    self.contentView = [[UIView alloc] init];
    _contentView.backgroundColor = UIColor.whiteColor;
    [self.view insertSubview:_contentView belowSubview:_shoppingCart];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customerInfoView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_shoppingCart.mas_top);
    }];
    
    self.segmentVCManager = XMHSegmentVCManager.new;
    [self addChildViewController:_segmentVCManager];
    _segmentVCManager.view.frame = _contentView.bounds;
    [_contentView addSubview:_segmentVCManager.view];
    
    [self configDataProjectModel:nil goodModel:nil experienceModel:nil];
}

- (void)loadData {
    [XMHExperienceOrderRequest requestProjectGoodsCourseUserId:@(_selectUserModel.uid).stringValue resultBlock:^(BOOL isSuccess, SLS_ProModel * _Nonnull projectModel, SLGoodListModel * _Nonnull goodModel, SLSCourseExper * _Nonnull experienceModel) {
        [self configDataProjectModel:projectModel goodModel:goodModel experienceModel:experienceModel];
    }];
}

- (void)configDataProjectModel:(SLS_ProModel *)projectModel goodModel:(SLGoodListModel *)goodModel experienceModel:(SLSCourseExper *)experienceModel {
    NSMutableArray *dataArray = NSMutableArray.new;
    XMHSegmentVCModel *model;
    XMHExperienceOrderContentVC *vc;
    
    // 特惠卡里的项目、产品 绑定特惠卡kcode
    if (experienceModel) {
        [experienceModel.list enumerateObjectsUsingBlock:^(SLCourseExperList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.pro_list enumerateObjectsUsingBlock:^(SLPro_ListM * _Nonnull proObj, NSUInteger idx, BOOL * _Nonnull stop) {
                proObj.course_code = obj.course_code;
            }];
            [obj.goods_list enumerateObjectsUsingBlock:^(SLGoods_ListM * _Nonnull goodsObj, NSUInteger idx, BOOL * _Nonnull stop) {
                goodsObj.course_code = obj.course_code;
            }];
        }];
    }
    
    // 选择用户后可编辑
    BOOL edit = NO;
    if (projectModel && goodModel && experienceModel) {
        edit = YES;
        
        // 收集搜索数据源
        self.searchDataArray = NSMutableArray.new;
        // 项目服务
        [_searchDataArray addObjectsFromArray:projectModel.list];
        // 产品服务
        [_searchDataArray addObjectsFromArray:goodModel.list];
        // 循环体验卡
        for (SLCourseExperList *courseExperList in experienceModel.list) {
            // 体验项目
            [_searchDataArray addObjectsFromArray:courseExperList.pro_list];
            // 体验产品
            [_searchDataArray addObjectsFromArray:courseExperList.goods_list];
        }
    }
    
    // 购物车是否可编辑
    _shoppingCart.isEdit = edit;
    
    model = XMHSegmentVCModel.new;
    model.text = @"项目服务";
    model.select = YES;
    model.edit = edit;
//    model.badge = projectModel.list.count;
    
    vc = XMHExperienceOrderContentVC.new;
    vc.selectUserModel = self.selectUserModel;
    vc.type = XMHExperienceOrderTypeProject;
    vc.projectModel = projectModel;
    vc.edit = edit;
    vc.searchDataArray = self.searchDataArray;
    model.contentVC = vc;
    
    [dataArray addObject:model];
    
    model = XMHSegmentVCModel.new;
    model.text = @"产品服务";
    model.edit = edit;
//    model.badge = goodModel.list.count;
    
    vc = XMHExperienceOrderContentVC.new;
    vc.selectUserModel = self.selectUserModel;
    vc.type = XMHExperienceOrderTypeGoods;
    vc.goodModel = goodModel;
    vc.edit = edit;
    vc.searchDataArray = self.searchDataArray;
    model.contentVC = vc;
    
    [dataArray addObject:model];
    
    model = XMHSegmentVCModel.new;
    model.text = @"体验服务";
    model.edit = edit;
    model.contentVC = XMHSegmentVCManagerEmptyDataVC.new;
    model.childList = [self childListcourseModel:experienceModel block:^(NSInteger allBadge) {
//        model.badge = allBadge;
    }];
    [dataArray addObject:model];
    
    _segmentVCManager.dataArray = dataArray;
}

/**
 配置体验服务子集数据
 */
- (NSArray *)childListcourseModel:(SLSCourseExper *)experienceModel block:(void(^)(NSInteger allBadge))block {
    NSMutableArray *dataArray = NSMutableArray.new;
    XMHSegmentVCModel *model;
    XMHExperienceOrderContentVC *vc;
    
    NSInteger allBadge = 0;
    
    for (int i = 0; i < experienceModel.list.count; i++) {
        SLCourseExperList *courseExperList = experienceModel.list[i];
        model = XMHSegmentVCModel.new;
        model.text = courseExperList.name;
        model.badge = courseExperList.pro_list.count + courseExperList.goods_list.count;
        if (i == 0) {
            model.select = YES;
        }
        
        vc = XMHExperienceOrderContentVC.new;
        vc.selectUserModel = self.selectUserModel;
        vc.type = XMHExperienceOrderTypeExperience;
        vc.courseExperList = courseExperList;
        vc.searchDataArray = self.searchDataArray;
        model.contentVC = vc;
        
        [dataArray addObject:model];
        
        allBadge += model.badge;
    }
    if (block) block(allBadge);
    return dataArray;
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
