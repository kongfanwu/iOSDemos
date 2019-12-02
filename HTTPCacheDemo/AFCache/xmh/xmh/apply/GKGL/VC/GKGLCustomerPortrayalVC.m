//
//  GKGLCustomerPortrayalVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerPortrayalVC.h"
#import "GKGLCustomerPortrayalTopView.h"
#import "GKGLHealthInquiryVC.h"
#import "GKGLHealthInquiryDetailCollectionCell.h"
#import "MzzCustomerRequest.h"
#import "GKGLHealthInquiryLayout.h"
@interface GKGLCustomerPortrayalVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)GKGLCustomerPortrayalTopView *portrayalTopView;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UILabel *lbTitle;
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@end

@implementation GKGLCustomerPortrayalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"顾客画像" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    self.logoView.backgroundColor = kColorTheme;
    self.logoView.image = nil;
    [self.view addSubview:self.portrayalTopView];
    [self.view addSubview:self.line];
    [self.view addSubview:self.lbTitle];
    [self.view addSubview:self.myCollectionView];
}
- (GKGLCustomerPortrayalTopView *)portrayalTopView
{
    WeakSelf
    if (!_portrayalTopView) {
        _portrayalTopView = loadNibName(@"GKGLCustomerPortrayalTopView");
        _portrayalTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 105);
        _portrayalTopView.GKGLCustomerPortrayalTopViewBlock = ^{
            GKGLHealthInquiryVC * healthInquiryVC = [[GKGLHealthInquiryVC alloc] init];
            healthInquiryVC.isFromGKGL = YES;
            healthInquiryVC.userid = weakSelf.userid;
            [weakSelf.navigationController pushViewController:healthInquiryVC animated:NO];
        };
    }
    return _portrayalTopView;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, _portrayalTopView.bottom + 15, SCREEN_WIDTH, 10)];
        _line.backgroundColor = kColorE;
    }
    return _line;
}
- (UILabel *)lbTitle
{
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"顾客标签";
        _lbTitle.font = FONT_NUM_SIZE(15);
        [_lbTitle sizeToFit];
        _lbTitle.frame = CGRectMake((SCREEN_WIDTH - _lbTitle.width)/2, _line.bottom + 15, _lbTitle.width, _lbTitle.height);
    }
    return _lbTitle;
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
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _lbTitle.bottom + 15, SCREEN_WIDTH, SCREEN_HEIGHT - _lbTitle.bottom - 15) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerNib:[UINib nibWithNibName:@"GKGLHealthInquiryDetailCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GKGLHealthInquiryDetailCollectionCell"];
        _myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestHealthInquiryMarkData];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GKGLHealthInquiryDetailCollectionCell * healthInquiryDetailCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GKGLHealthInquiryDetailCollectionCell" forIndexPath:indexPath];
    [healthInquiryDetailCollectionCell updateCellPortrayalParam:_dataSource[indexPath.row]];
    return healthInquiryDetailCollectionCell;
}
#pragma mark ------网络请求------
- (void)requestHealthInquiryMarkData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_HEADLTHINQUIRY_MARK_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            [_myCollectionView reloadData];
        }else{}
    }];
}
@end
