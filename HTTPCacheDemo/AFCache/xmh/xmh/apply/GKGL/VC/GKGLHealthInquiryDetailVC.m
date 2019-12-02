//
//  GKGLHealthInquiryDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHealthInquiryDetailVC.h"
#import "GKGLHealthInquiryDetailCollectionCell.h"
#import "GKGLCardPopularHeaderView.h"
#import "CommonSubmitView.h"
#import "MzzCustomerRequest.h"
#import "GKGLHealthInquiryLayout.h"
@interface GKGLHealthInquiryDetailVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)CommonSubmitView * submitView;
@property (nonatomic, assign)BOOL isEdit;
@property (nonatomic, strong)NSMutableDictionary * selectParam;
@property (nonatomic, assign)NSInteger selectIndex;
@end

@implementation GKGLHealthInquiryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] init];
    self.view.backgroundColor = kColorE;
    self.navView.backgroundColor = kColorTheme;
    [self.navView setNavViewTitle:_param[@"name"] backBtnShow:YES];
    [self.view addSubview:self.submitView];
    [self.view addSubview:self.myCollectionView];
}
- (CommonSubmitView *)submitView
{
    WeakSelf
    if (!_submitView) {
        _submitView = loadNibName(@"CommonSubmitView");
        _submitView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
        _submitView.CommonSubmitViewBlock = ^{
            if (!weakSelf.isEdit) {
                [[[MzzHud alloc] initWithTitle:@"" message:@"是否确认对此问卷进行确认保存" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf requestCommitData];
                    }
                }]show];
            }else{
                [[[MzzHud alloc] initWithTitle:@"" message:@"是否确认对此问卷进行编辑" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
                    if (index == 1) {
                        weakSelf.isEdit = NO;
                        [weakSelf.submitView updateCommonSubmitViewTitle:@"确认"];
                    }
                }]show];
            }
        };
    }
    return _submitView;
}
- (UICollectionView *)myCollectionView {
    if (_myCollectionView == nil) {
        GKGLHealthInquiryLayout *layout = [[GKGLHealthInquiryLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 5, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.estimatedItemSize = CGSizeMake(100, 40);
        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - _submitView.height) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerNib:[UINib nibWithNibName:@"GKGLHealthInquiryDetailCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GKGLHealthInquiryDetailCollectionCell"];
        [_myCollectionView registerNib:[UINib nibWithNibName:@"GKGLCardPopularHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        _myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestHealthInquiryDetailData];
        }];
        [_myCollectionView.mj_header beginRefreshing];
    }
    return _myCollectionView;
}
- (void)endRefreshing{
    [_myCollectionView.mj_header endRefreshing];
    [_myCollectionView.mj_footer endRefreshing];
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        GKGLCardPopularHeaderView *headerView = (GKGLCardPopularHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.GKGLCardPopularHeaderViewTapBlock = ^(NSInteger index){
           
        };
        [headerView updateGKGLCardPopularHeaderViewFromHealthInquiryTitle:_dataSource[indexPath.section]];
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
    if ([_dataSource[section][@"option_"] isKindOfClass:[NSArray class]]) {
       return  [_dataSource[section][@"option_"] count];
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GKGLHealthInquiryDetailCollectionCell * healthInquiryDetailCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GKGLHealthInquiryDetailCollectionCell" forIndexPath:indexPath];
    [healthInquiryDetailCollectionCell updateCellParam:_dataSource[indexPath.section][@"option_"][indexPath.row]];
    return healthInquiryDetailCollectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isEdit) {
        for (int i = 0; i < [_dataSource[indexPath.section][@"option_"] count]; i++) {
            NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"option_"][i];
            if ([currentDic[@"is"] integerValue] == 1) {
                _selectIndex = i;
            }
        }
        if (indexPath.row == _selectIndex) {
            NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"option_"][indexPath.row];
            if ([currentDic[@"is"] integerValue] == 1) {
                currentDic[@"is"] = @"0";
            }else{
                currentDic[@"is"] = @"1";
            }
        }else{
            NSMutableDictionary * lastDic = _dataSource[indexPath.section][@"option_"][_selectIndex];
            lastDic[@"is"] = @"0";

            NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"option_"][indexPath.row];
            currentDic[@"is"] = @"1";
            _selectIndex = indexPath.row;
        }
        [_myCollectionView reloadData];
    }
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark ------网络请求------
/** 获取问诊详情数据 */
- (void)requestHealthInquiryDetailData
{
    NSString * questionid  = _param[@"id"];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:questionid?questionid:@"" forKey:@"id"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_HEADLTHQUESTIONDETAIL_ITEM_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:resultDic[@"info"]];
//            for (int i = 0; i < _dataSource.count; i ++) {
//                NSMutableDictionary * bParam = _dataSource[i];
//                for (int j = 0; j < [bParam[@"option_"] count]; j++) {
//                    NSMutableDictionary * sParam = bParam[@"option_"][j];
//                    if ([sParam[@"is"] integerValue] == 1) {
//                        _selectParam = sParam;
//                    }
//                }
//            }
            [_myCollectionView reloadData];
            
            if ([resultDic[@"edit"] integerValue] == 1) {
                [_submitView updateCommonSubmitViewTitle:@"编辑"];
                _isEdit = YES;
            }else if ([resultDic[@"edit"] integerValue] == 0){
                _isEdit = NO;
                [_submitView updateCommonSubmitViewTitle:@"确认"];
            }else{}
        }else{}
    }];
}
/** 提交问诊数据 */
- (void)requestCommitData
{
    NSMutableArray * infoArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _dataSource.count; i++) {
        NSDictionary * dic = _dataSource[i];
        NSMutableDictionary * commitDic = [[NSMutableDictionary alloc] init];
        [commitDic setValue:dic[@"n_id"] forKey:@"n_id"];
        [commitDic setValue:dic[@"c_id"] forKey:@"c_id"];
        for (NSDictionary *subDic in dic[@"option_"]) {
            if ([subDic[@"is"] integerValue] == 1) {
                [commitDic setValue:subDic[@"option"] forKey:@"option"];
            }
            
        }
        [infoArr addObject:commitDic];
    }
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * questionid  = _param[@"id"];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:questionid?questionid:@"" forKey:@"q_id"];
    [param setValue:infoArr.jsonData?infoArr.jsonData:@"" forKey:@"info"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_HEADLTHINQUIRY_QUESTIONCOMMIT_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"提交成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:2];
        }else{}
    }];
}
@end
