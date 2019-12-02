//
//  GKGLCustomerBillCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillCell.h"
#import "GKGLCustomerBillCollectionCell.h"
#import "GKGLBillListModel.h"
#import <YYWebImage/YYWebImage.h>
@interface GKGLCustomerBillCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@end
@implementation GKGLCustomerBillCell
{
    GKGLBillModel * _billModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _dataSource = [[NSMutableArray alloc] init];
    [self.contentView addSubview:self.myCollectionView];
    [self.contentView bringSubviewToFront:_icon];
    [self.contentView bringSubviewToFront:_lbName];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lbName.textColor = [UIColor whiteColor];
//    [self.contentView sendSubviewToBack:self.myCollectionView];
//    [UIView animateWithDuration:10 animations:^{
//        [_myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//    }];
//    [self.myCollectionView setContentOffset:CGPointMake(self.myCollectionView.contentSize.width, 0)];
}

- (UICollectionView *)myCollectionView {
    if (_myCollectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        CGFloat itemW = (SCREEN_WIDTH - 40) / 2;
//        CGFloat itemH = 30;
        layout.itemSize = CGSizeMake(90, 70);
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_icon.right - 20 , (self.height - 70)/2, SCREEN_WIDTH - _icon.right- 15 + 20 , 70) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor clearColor];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 0);
        [_myCollectionView registerNib:[UINib nibWithNibName:@"GKGLCustomerBillCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GKGLCustomerBillCollectionCell"];
//        [_myCollectionView setContentOffset:CGPointMake(0, _myCollectionView.contentSize.width - _myCollectionView.frame.size.width) animated:YES];
//        [_myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:9 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.pagingEnabled = NO;

    }
    return _myCollectionView;
}
#pragma mark ------UICollectionViewDelegate------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
   
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
    return 10;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GKGLCustomerBillCollectionCell * billCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GKGLCustomerBillCollectionCell" forIndexPath:indexPath];
    [billCollectionCell updateGKGLCustomerBillCollectionCellParamDic:_dataSource[indexPath.row] type:_billModel.type];
    return billCollectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_GKGLCustomerBillCellTapBlock) {
        _GKGLCustomerBillCellTapBlock(_dataSource[indexPath.row],_billModel.type);
    }
}
- (void)updateGKGLCustomerBillCellModel:(GKGLBillModel *)model
{
    _billModel = model;
    [_dataSource removeAllObjects];
    _lbName.text = [NSString stringWithFormat:@"%@%@",model.name,model.num];
    if ([model.type isEqualToString:@"bank"]) {/** 账户 */
        _icon.image = UIImageName(@"gkgl_gkzdzhanghua");
    }
    if ([model.type isEqualToString:@"ticket"]) {/** 票券 */
        _icon.image = UIImageName(@"gkgl_gkzdpiaoquan");
    }
    if ([model.type isEqualToString:@"pro"]) {/** 项目 */
        _icon.image = UIImageName(@"gkgl_gkzdxiangmu");
    }
    if ([model.type isEqualToString:@"goods"]) {/** 产品 */
        _icon.image = UIImageName(@"gkgl_gkzdchanpin");
    }
    if ([model.type isEqualToString:@"card_time"]) {/** 时间卡 */
        _icon.image = UIImageName(@"gkgl_gkzdshijianka");
    }
    if ([model.type isEqualToString:@"card_num"]) {/** 任选卡 */
        _icon.image = UIImageName(@"gkgl_gkzdrenxuanka");
    }
    if ([model.type isEqualToString:@"ticket_coupon"]) {/** 优惠券 */
        _icon.image = UIImageName(@"gkgl_gkzdyouhuiquan");
    }
    if ([model.type isEqualToString:@"stored_card"]) {/** 储值卡 */
        _icon.image = UIImageName(@"gkgl_gkzdchuzhika");
    }
    if ([model.type isEqualToString:@"equity"]) {
        _icon.image = UIImageName(@"gkgl_gkzdquanyibao");
    }
    [_dataSource addObjectsFromArray:model.list];
    [_myCollectionView reloadData];
    
}
@end
