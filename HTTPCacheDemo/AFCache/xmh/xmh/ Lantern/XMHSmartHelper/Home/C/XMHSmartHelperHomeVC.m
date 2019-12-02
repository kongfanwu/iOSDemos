//
//  XMHSmartHelperHomeVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartHelperHomeVC.h"
#import "MineCellModel.h"
#import "ULBCollectionViewFlowLayout.h"
#import "XMHSmartHelperHomeCell.h"
#import "XMHSmartGuanJiaVC.h"
#import "ApplySectionHeader.h"
#import "ApplySectionFooter.h"
#import "XMHSHHomeModel.h"
#import "XMHFormTaskCreateVC.h"

static NSString * const reuseIdentifier = @"ApplyCell";
static NSString * const kHeaderView = @"kHeaderView";
static NSString * const kFooterView = @"kFooterView";
@interface XMHSmartHelperHomeVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
ULBCollectionViewDelegateFlowLayout
>
@property (nonatomic, strong)NSArray * dataSource;
@property (nonatomic, strong)UICollectionView * collectionView;
@end

@implementation XMHSmartHelperHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView setNavViewTitle:@"智能助手" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    self.view.backgroundColor = kBackgroundColor;
    
    [self initBaseData];
    [self initSubViews];
}
- (void)initBaseData
{

    _dataSource = @[[MineCellModel createModelWithTitle:@"日常任务管理" icon:@"znzzst_guanli" className:@"XMHTaskMangerHomeVC"],
                    [MineCellModel createModelWithTitle:@"创建日常任务" icon:@"znzzst_chuangjian" className:@"XMHFormTaskCreateVC"],
                    [MineCellModel createModelWithTitle:@"数据报告" icon:@"znzzst_shujubaogao" className:@"XMHDataReportVC"],
                    [MineCellModel createModelWithTitle:@"智能管家设置" icon:@"znzzst_guanjiashezhi" className:@"XMHSmartGuanJiaVC"],
                   ];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestReadNum];
}
- (void)initSubViews
{
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = kColorF5F5F5;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *layout = [[ULBCollectionViewFlowLayout alloc] init];
        CGSize size = [UIScreen mainScreen].bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        layout.headerReferenceSize = CGSizeMake(size.width, 10);
        layout.footerReferenceSize = CGSizeMake(size.width, 20);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, Heigh_Nav + 10,SCREEN_WIDTH - 20,Heigh_View) collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"XMHSmartHelperHomeCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
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
        [header updateApplySectionHeaderTitle:@""];
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
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMHSmartHelperHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateCellModel:_dataSource[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MineCellModel * model = _dataSource[indexPath.row];
    Class vcClass = NSClassFromString(model.className);
    UIViewController * next;
    if ([model.className isEqualToString:NSStringFromClass([XMHFormTaskCreateVC class])]) {
        next = [[XMHFormTaskCreateVC alloc] initWithForm:nil style:UITableViewStylePlain];
    } else {
        next =  [[vcClass alloc]init];
    }
    [self.navigationController pushViewController:next animated:NO];
}
- (void)requestReadNum
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_READNUM_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            XMHSHHomeModel *model = [XMHSHHomeModel yy_modelWithDictionary:obj.data];
            MineCellModel * cellModel1 = [_dataSource safeObjectAtIndex:0];
            MineCellModel * cellModel2 = [_dataSource safeObjectAtIndex:2];
            cellModel1.num = model.task_count;
            cellModel2.num = model.result_count;
            [_collectionView reloadData];
        }else{
            
        }
    }];
}
@end
