//
//  LanternPlanVC.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/25.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternPlanVC.h"
#import "LanternPlanCollectionViewCell.h"
#import "LanternPlanSetionHeardView.h"
#import "LanternRequest.h"
#import "MzzTags.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "LanternPlanToAddTheGoodsVC.h"
#import "CommonSubmitView.h"
#import "LanternAddGoodsVC.h"
#import "LanternRequest.h"
#import "LanternPlanInfoListModel.h"
#import "LanternPlanCollectionCell.h"
#import "LanternXSPlanVC.h"
#import "LanternXHPlanVC.h"
#import "LNavigationController.h"
@interface LanternPlanVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *myCollectionView;

@property (nonatomic,strong)CommonSubmitView *commonSubmitView;
@property (nonatomic,strong)NSMutableArray *dataSource;//数据源

@end

@implementation LanternPlanVC
{
    LanternPlanInfoListModel *_lanternPlanInfoListModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WeakSelf
    self.view.backgroundColor = kColorE;
    _dataSource = [[NSMutableArray alloc] init];
    
    NSString * navTitle = @"";
    NSString * showDate = [_date componentsSeparatedByString:@"-"][1];
    if (_type.intValue == 1) {
        navTitle = [NSString stringWithFormat:@"%@月销售计划",showDate];
    }
    if (_type.intValue == 2) {
        navTitle = [NSString stringWithFormat:@"%@月消耗计划",showDate];
    }
    [self.navView setNavViewTitle:navTitle backBtnShow:YES rightBtnTitle:@""];
    self.navView.backgroundColor = kBtn_Commen_Color;
    self.navView.NavViewBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    [self.view addSubview:self.myCollectionView];
    [self.view addSubview:self.commonSubmitView];
    [self requestPlanData];
}
- (UICollectionView *)myCollectionView {
    if (_myCollectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (SCREEN_WIDTH - 40) / 2;
        CGFloat itemH = 30;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 5, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav- 70) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerNib:[UINib nibWithNibName:@"LanternPlanCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LanternPlanCollectionCell"];
        [_myCollectionView registerNib:[UINib nibWithNibName:@"LanternPlanSetionHeardView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    }
    return _myCollectionView;
}

- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        _commonSubmitView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
        [_commonSubmitView updateCommonSubmitViewTitle:@"生成"];
        _commonSubmitView.CommonSubmitViewBlock = ^{
            [weakSelf requestCommitPlanData];
        };
    }
    return _commonSubmitView;
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    WeakSelf
    if (kind == UICollectionElementKindSectionHeader) {
        LanternPlanSetionHeardView *headerView = (LanternPlanSetionHeardView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView updateLanternPlanSetionHeardViewModel:_dataSource[indexPath.section]];
        __weak typeof(self) _self = self;
        headerView.LanternPlanSetionHeardViewSelectBlock = ^(LanternPlanInfoModel *model) {
            __strong typeof(_self) self = _self;
            [self.dataSource replaceObjectAtIndex:[self.dataSource indexOfObject:model] withObject:model];
            [self.myCollectionView reloadData];
        };
        headerView.LanternPlanSetionHeardViewAddBlock = ^(LanternPlanInfoModel *model) {
            __strong typeof(_self) self = _self;
            LanternAddGoodsVC * lanternAddGoodsVC = [[LanternAddGoodsVC alloc] init];
            lanternAddGoodsVC.LanternAddGoodsVCBlock = ^(NSMutableArray *selectArr) {
                [model.pro addObjectsFromArray:selectArr];
                [self.dataSource replaceObjectAtIndex:[self.dataSource indexOfObject:model] withObject:model];
                [weakSelf.myCollectionView reloadData];
            };
            lanternAddGoodsVC.lanternPlanInfoModel = model;
            lanternAddGoodsVC.type = self.type.integerValue;
            lanternAddGoodsVC.isEdit = self.isSave;
            [weakSelf.navigationController pushViewController:lanternAddGoodsVC animated:NO];
        };
        reusableView = headerView;
    }
    return reusableView;
}
// 设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(SCREEN_WIDTH - 30, 50);
    return size;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataSource.count;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    LanternPlanInfoModel * lanternPlanInfoModel = _dataSource[section];
    return lanternPlanInfoModel.pro.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LanternPlanCollectionCell * lanternPlanCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanternPlanCollectionCell" forIndexPath:indexPath];
    LanternPlanInfoModel * infoModel = _dataSource[indexPath.section];
    LanternPlanProModel * proModel = infoModel.pro[indexPath.row];
    if (_isSave) {
        proModel.isEdit = YES;
    }
    [lanternPlanCollectionCell updateLanternPlanCollectionCellModel:proModel];
    return lanternPlanCollectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LanternPlanInfoModel * infoModel = _dataSource[indexPath.section];
    LanternPlanProModel * proModel = infoModel.pro[indexPath.row];
    proModel.selected = ! proModel.selected;
    [_myCollectionView reloadData];
}
#pragma mark ------网络请求------
/** 获取计划数据 */
- (void)requestPlanData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:self.type forKey:@"type"];
    [param setValue:self.date forKey:@"date"];
   
    __weak typeof(self) _self = self;
    [LanternRequest requestPlanInfoData:param resultBlock:^(LanternPlanInfoListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        __strong typeof(_self) self = _self;
        if (isSuccess) {
            for (int i = 0; i< model.list.count; i++) {
                LanternPlanInfoModel * lanternPlanInfoModel = model.list[i];
                if (!([lanternPlanInfoModel.rate isEqualToString:@"不建议销售"] || [lanternPlanInfoModel.rate isEqualToString:@"不建议消耗"])) {
                    lanternPlanInfoModel.selected = YES;
                }
                for (int j = 0; j < lanternPlanInfoModel.pro.count; j++) {
                    LanternPlanProModel * proModel = lanternPlanInfoModel.pro[j];
                    proModel.selected = YES;
                }
            }
            [self.dataSource addObjectsFromArray:model.list];
            [self.myCollectionView reloadData];
        }else{}
    }];
}
/** 提交选择计划数据 */
- (void)requestCommitPlanData
{
    /** 组织参数 */
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * planJson = @"";
    NSString * saleContentJson = @"";
//    NSMutableArray *planArr = [[NSMutableArray alloc] init];
    NSMutableArray *saleContentArr = [[NSMutableArray alloc] init];
    
    /** 销售内容参数 */
//    if (_type.integerValue == 1) {
    for (int i = 0; i < _dataSource.count; i++) {
        LanternPlanInfoModel * lanternPlanInfoModel = _dataSource[i];
        if (lanternPlanInfoModel.selected) {
            NSMutableDictionary * tempDic = [[NSMutableDictionary alloc] init];
            NSMutableArray * proArr = [[NSMutableArray alloc] init];
            for (int j = 0; j < lanternPlanInfoModel.pro.count; j++) {
                LanternPlanProModel * proModel = lanternPlanInfoModel.pro[j];
                if (proModel.selected) {
                    NSMutableDictionary * proDic = [[NSMutableDictionary alloc] init];
                    [proDic setValue:proModel.code forKey:@"code"];
                    [proDic setValue:proModel.price forKey:@"price"];
                    [proDic setValue:proModel.type forKey:@"type"];
                    [proDic setValue:proModel.num forKey:@"num"];
                    if (_type.integerValue == 2) {
                        [proDic setValue:proModel.name forKey:@"name"];
                    }
                    [proArr addObject:proDic];
                }
            }
            [tempDic setValue:proArr forKey:@"pro"];
            [tempDic setValue:lanternPlanInfoModel.user_id forKey:@"user_id"];
            [saleContentArr addObject:tempDic];
        }
    }
    if (_type.integerValue == 1) {
        saleContentJson = saleContentArr.jsonData;
    }
    if (_type.integerValue == 2) {
        planJson = saleContentArr.jsonData;
    }
//    }
    /** 消耗内容参数 */
    /** 组织提交参数 */
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:_type?_type:@"" forKey:@"type"];
    [param setValue:_date?_date:@"" forKey:@"date"];
    [param setValue:saleContentJson?saleContentJson:@"" forKey:@"sale_content"];
    [param setValue:planJson?planJson:@"" forKey:@"plan"];
    [param setValue:_isSave?_isSave:@"" forKey:@"isSave"];
    [param setValue:_editID?_editID:@"" forKey:@"id"];
    WeakSelf
    [LanternRequest requestAddmakePlanData:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if (_comeFrom == ComeFromeDetail) {
                [self.navigationController popViewControllerAnimated:NO];
            }else if(_comeFrom == ComeFromeHome){
                if (_type.integerValue == 1) {
                    LanternXSPlanVC * lanternXSPlanVC = [[LanternXSPlanVC alloc] init];
                    lanternXSPlanVC.LanternXSPlanVCBlock = ^(NSString *editID, NSString *isSave) {
                        weakSelf.editID = editID;
                        weakSelf.isSave = isSave;
                    };
                    lanternXSPlanVC.date = _date;
                    lanternXSPlanVC.comeFrom = DetailComeFromeMakePlan;
                    [self.navigationController pushViewController:lanternXSPlanVC animated:NO];
                }
                if (_type.integerValue == 2) {
                    LanternXHPlanVC * lanternXHPlanVC = [[LanternXHPlanVC alloc] init];
                    lanternXHPlanVC.LanternXHPlanVCBlock = ^(NSString *editID, NSString *isSave) {
                        weakSelf.editID = editID;
                        weakSelf.isSave = isSave;
                    };
                    lanternXHPlanVC.date = _date;
                    lanternXHPlanVC.comeFrom = DetailComeFromeMakePlan;
                    [self.navigationController pushViewController:lanternXHPlanVC animated:NO];
                    
                }
            }
            
        }else{}
    }];
}
@end
