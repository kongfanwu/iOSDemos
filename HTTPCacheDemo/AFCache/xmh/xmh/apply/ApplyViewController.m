//
//  ApplyViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ApplyViewController.h"
#import "ApplySectionHeader.h"
#import "StatisticsAndApplyCell.h"
#import "MzzHud.h"
#import "RolesTools.h"
#import "ULBCollectionViewFlowLayout.h"
#import "ApplySectionFooter.h"
#import "MineCellModel.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
//end
#import "ShareWorkInstance.h"
#import "XMHActionCenterRequest.h"
#import "XMHCredentiaManageBossVC.h"
#import "XMHNormalOrderManagementVC.h"
#import "XMHAchievementReportVC.h"
#import "XMHConsumeReportVC.h"
static NSString * const reuseIdentifier = @"ApplyCell";
static NSString * const kHeaderView = @"kHeaderView";
static NSString * const kFooterView = @"kFooterView";
@interface ApplyViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
ULBCollectionViewDelegateFlowLayout
>
@property (nonatomic,strong)UICollectionView * collectionView;
@end
@implementation ApplyViewController
{
    NSArray * _dataSource;
    NSArray * _sectionTitleArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseData];
    [self initSubViews];
}
- (void)initBaseData
{
    

    if ([RolesTools getUserMainRole] == 1 ||[RolesTools getUserMainRole] == 2) {
         _dataSource = @[@[
//                             [MineCellModel createModelWithTitle:@"智能分配" icon:@"yingyong_zhinengfenpei" className:@"LolSmartAllocationController"],
                           [MineCellModel createModelWithTitle:@"美丽定制" icon:@"yingyong_meilidingzhi" className:@"BeautyManagerHomeVC"],
                           [MineCellModel createModelWithTitle:@"预约管理" icon:@"yingyong_yuyueguanli" className:@"BookManagerHomeVC"],
                           [MineCellModel createModelWithTitle:@"订单管理" icon:@"yingyong_dingdanguanli"],
                           [MineCellModel createModelWithTitle:@"审批应用" icon:@"yingyong_shenpiyingyong" className:@"ApproveController"],
                           [MineCellModel createModelWithTitle:@"顾客管理" icon:@"yingyong_gukeguanli" className:@"GKGLMainVC"],
                           [MineCellModel createModelWithTitle:@"线上交易" icon:@"yingyong_xianshangjiaoyi" className:@"DealOnlineController"],
                           [MineCellModel createModelWithTitle:@"优惠券" icon:@"yingyong_youhuiquan" className:@"XMHActionCenterVC"]
//                           #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"业绩报表" icon:@"yingyong_youhuiquan" className:@"XMHAchievementReportVC"],
//                           #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"消耗报表" icon:@"yingyong_youhuiquan" className:@"XMHConsumeReportVC"],
//                           #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"员工报表" icon:@"yingyong_youhuiquan" className:@"XMHEmployReportVC"],
//                           #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"顾客保有报表" icon:@"yingyong_youhuiquan" className:@"XMHCustomerRetainReportVC"]
                           ],
                         @[
                             #warning iOS_test_entrance
                            [MineCellModel createModelWithTitle:@"业绩报表" icon:@"baobiao-yejibaobiao" className:@"XMHAchievementReportVC"], //PerformanceReportVC
                            #warning iOS_test_entrance
                           [MineCellModel createModelWithTitle:@"员工报表" icon:@"baobiao-yuangongbaobiao" className:@"XMHEmployReportVC"],//CustomerReportVC
                           [MineCellModel createModelWithTitle:@"收银报表" icon:@"baobiao-shouyingbaobiao" className:@"CashReportVC"],
                           [MineCellModel createModelWithTitle:@"顾客活跃报表" icon:@"baobiao-gukehuoyuebaobiao" className:@"CustomerActiveReportVC"],
                           [MineCellModel createModelWithTitle:@"顾客等级报表" icon:@"baobiao-gukedengjibaobiao" className:@"CustomerGradeReportVC"],
                            #warning iOS_test_entrance
                           [MineCellModel createModelWithTitle:@"顾客保有报表" icon:@"baobiao-gukebaoyoubaobiao" className:@"XMHCustomerRetainReportVC"],//CustomerRetainVC
                            #warning iOS_test_entrance
                           [MineCellModel createModelWithTitle:@"消耗报表" icon:@"baobiao-xiaohaobaobiao" className:@"XMHConsumeReportVC"]//ExpendReportVC
                           
                           ]
                         ];
    }else{
         _dataSource = @[@[
//                             [MineCellModel createModelWithTitle:@"智能分配" icon:@"yingyong_zhinengfenpei" className:@"LolSmartAllocationController"],
                           [MineCellModel createModelWithTitle:@"美丽定制" icon:@"yingyong_meilidingzhi" className:@"BeautyManagerHomeVC"],
                           [MineCellModel createModelWithTitle:@"预约管理" icon:@"yingyong_yuyueguanli" className:@"BookManagerHomeVC"],
                           [MineCellModel createModelWithTitle:@"订单管理" icon:@"yingyong_dingdanguanli"],
                           [MineCellModel createModelWithTitle:@"审批应用" icon:@"yingyong_shenpiyingyong" className:@"ApproveController"],
                           [MineCellModel createModelWithTitle:@"顾客管理" icon:@"yingyong_gukeguanli" className:@"GKGLMainVC"],
                           [MineCellModel createModelWithTitle:@"线上交易" icon:@"yingyong_xianshangjiaoyi" className:@"DealOnlineController"],
                           [MineCellModel createModelWithTitle:@"健康问诊" icon:@"gkgl_gkhxjiankwenzhen" className:@"GKGLHealthInquiryVC"],
                           [MineCellModel createModelWithTitle:@"优惠券" icon:@"yingyong_youhuiquan" className:@"XMHActionCenterVC"]
//                            #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"业绩报表" icon:@"yingyong_youhuiquan" className:@"XMHAchievementReportVC"],
//                            #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"消耗报表" icon:@"yingyong_youhuiquan" className:@"XMHConsumeReportVC"],
//                            #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"员工报表" icon:@"yingyong_youhuiquan" className:@"XMHEmployReportVC"],
//                            #warning iOS_test_entrance
//                           [MineCellModel createModelWithTitle:@"顾客保有报表" icon:@"yingyong_youhuiquan" className:@"XMHCustomerRetainReportVC"]
                           
                           ],
                         //
                         
                           #warning iOS_test_entrance
                         @[[MineCellModel createModelWithTitle:@"业绩报表" icon:@"baobiao-yejibaobiao" className:@"XMHAchievementReportVC"],//PerformanceReportVC
                            #warning iOS_test_entrance
                           [MineCellModel createModelWithTitle:@"员工报表" icon:@"baobiao-yuangongbaobiao" className:@"XMHEmployReportVC"],//CustomerReportVC
                           [MineCellModel createModelWithTitle:@"收银报表" icon:@"baobiao-shouyingbaobiao" className:@"CashReportVC"],
                           [MineCellModel createModelWithTitle:@"顾客活跃报表" icon:@"baobiao-gukehuoyuebaobiao" className:@"CustomerActiveReportVC"],
                           [MineCellModel createModelWithTitle:@"顾客等级报表" icon:@"baobiao-gukedengjibaobiao" className:@"CustomerGradeReportVC"],
                           #warning iOS_test_entrance
                           [MineCellModel createModelWithTitle:@"顾客保有报表" icon:@"baobiao-gukebaoyoubaobiao" className:@"XMHCustomerRetainReportVC"],//CustomerRetainVC
                           #warning iOS_test_entrance
                           [MineCellModel createModelWithTitle:@"消耗报表" icon:@"baobiao-xiaohaobaobiao" className:@"XMHConsumeReportVC"]//ExpendReportVC
                           ]
                         ];
    }
    
    _sectionTitleArr = @[@"管理应用",@"报表"];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"应用"];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = kColorF5F5F5;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *layout = [[ULBCollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGSize size = [UIScreen mainScreen].bounds.size;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3);
//        layout.minimumInteritemSpacing = 10;
//        layout.minimumLineSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        layout.headerReferenceSize = CGSizeMake(size.width, 56);
        layout.footerReferenceSize = CGSizeMake(size.width, 20);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, Heigh_Nav,SCREEN_WIDTH - 20,Heigh_View) collectionViewLayout:layout];
        [_collectionView registerClass:[StatisticsAndApplyCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[ApplySectionHeader class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView];
        [_collectionView registerClass:[ApplySectionFooter class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section
{
    return [UIColor whiteColor];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ApplySectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView forIndexPath:indexPath];
        [header updateApplySectionHeaderTitle:_sectionTitleArr[indexPath.section]];
        reusableView = header;
    }else if (kind == UICollectionElementKindSectionFooter){
        ApplySectionFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterView forIndexPath:indexPath];
        reusableView = footer;
    }
    return reusableView;
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([RolesTools getUserMainRole] == 4 ||[RolesTools getUserMainRole] == 5 ||[RolesTools getUserMainRole] == 6 ||[RolesTools getUserMainRole] == 8 ||[RolesTools getUserMainRole] == 9||[RolesTools getUserMainRole] == 10||[RolesTools getUserMainRole] == 11) {
        return 1;
    }
    return _dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StatisticsAndApplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateStatisticsAndApplyCellModel:_dataSource[indexPath.section][indexPath.row]withCount:nil];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MineCellModel * model = _dataSource[indexPath.section][indexPath.row];
    /** 需要请求接口的 单独处理
     
        优惠券的 权限需要网络请求
     */
    if ([model.title isEqualToString:@"优惠券"]){
        
        LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString * accountID = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
        NSMutableDictionary * param = NSMutableDictionary.new;
        [param setValue:accountID forKey:@"account_id"];
        [XMHActionCenterRequest requestCommonUrl:kCOUPON_LIMIT_URL Param:param resultBlock:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
            if (isSuccess) {
                if (!IsEmpty(resultDic[@"is_active_role"])){
                    NSInteger  is_active_role = [resultDic[@"is_active_role"] integerValue];
                    if (is_active_role == 0) {
                        [XMHProgressHUD showOnlyText:@"您没有查看此功能权限"];
                    }else{
                        Class vcClass = NSClassFromString(model.className);
                        UIViewController * next =  [[vcClass alloc]init];
                        [self.navigationController pushViewController:next animated:NO];
                    }
                }
            }
        }];
        
    }
    else{
        
        if ([model.title isEqualToString:@"智能分配"]) {
            [XMHProgressHUD showOnlyText:@"您没有查看此功能权限"];
            if (![RolesTools applyPushToApproveVC]) return;
        }
        else if ([model.title isEqualToString:@"预约管理"]){
            if ([RolesTools getUserMainRole] == 11) {
                [XMHProgressHUD showOnlyText:@"您没有查看此功能权限"];
                return;
            }
        }
        else if ([model.title isEqualToString:@"线上交易"]){
            [XMHProgressHUD showOnlyText:@"您没有查看此功能权限"];
            if (![RolesTools applyPushToDealOnlineVC]) return;
        }
        else if ([model.title isEqualToString:@"美丽定制"]){
            if ([RolesTools getUserMainRole] == 11||[RolesTools getUserMainRole] == 2) {
                [XMHProgressHUD showOnlyText:@"您没有查看此功能权限"];
                return;
            }
        }
        else if ([model.title isEqualToString:@"订单管理"]){
            //  主角色 - 1管理层，2财务人员，3店经理，4技术店长，5销售店长，6售前店长，7前台，8售后美容师，9售前美容师，10售中美容师，11导购
            NSInteger role = [ShareWorkInstance shareInstance].share_join_code.framework_function_main_role;
            if (role == 1 ||
                role == 2 ||
                role == 3) {
                XMHCredentiaManageBossVC *vc = XMHCredentiaManageBossVC.new;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                XMHNormalOrderManagementVC *nextVC = [[XMHNormalOrderManagementVC alloc]init];
                [self.navigationController pushViewController:nextVC animated:NO];
            }
            return;
        }

        Class vcClass = NSClassFromString(model.className);
        UIViewController * next =  [[vcClass alloc]init];
        [self.navigationController pushViewController:next animated:NO];
    }
    
}
@end
