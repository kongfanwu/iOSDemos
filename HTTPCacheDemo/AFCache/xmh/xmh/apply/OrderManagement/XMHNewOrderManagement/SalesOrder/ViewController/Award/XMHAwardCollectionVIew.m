//
//  XMHAwardCollectionVIew.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHAwardCollectionVIew.h"
#import "XMHAwardItem.h"
#import "SASaleListModel.h"
//static const CGFloat countLabW = 55;
//static const CGFloat allMargin = countLabW + 5 *kMargin + 28;

@interface XMHAwardCollectionVIew()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@end

@implementation XMHAwardCollectionVIew
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self loadCollectionView];
    }
    return self;
}
- (void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
 
    CGFloat itemW = (SCREEN_WIDTH - 3 * kMargin)/2;
    CGFloat itemH = 20;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
//    layout.sectionInset = UIEdgeInsetsMake(0, kMargin, 0, 0);//设置cell的左右缩进
    NSInteger maxNum = 2;//一行显示2个item
    //    NSInteger row = self.dataArr.count % maxNum;
    NSInteger row = self.dataArr.count % maxNum + self.dataArr.count / maxNum;
    
    itemH = 20 * row + kMargin *(row - 1);
    _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 2 * kMargin, itemH);
    [_collectionView reloadData];
    
}
- (void)loadCollectionView
{

    CGFloat itemW = (SCREEN_WIDTH - 3 * kMargin)/2;
    CGFloat itemH = 20;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    //    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);//设置cell的左右缩进
    NSInteger maxNum = 2;//一行显示2个item
//    NSInteger row = self.dataArr.count % maxNum;
    NSInteger row = self.dataArr.count % maxNum + self.dataArr.count / maxNum;

     itemH = 20 * row + kMargin *(row - 1);

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , itemH) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];

    //注册
    [_collectionView registerNib:[UINib nibWithNibName:@"XMHAwardItem" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"XMHAwardItem"];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMHAwardItem * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMHAwardItem" forIndexPath:indexPath];
    [cell resetCell];
    SaleModel *model = [self.dataArr safeObjectAtIndex:indexPath.row];
    if (self.model.uid == model.uid) {
        model.isBaoHan = self.model.isBaoHan;
    }else{
        model.isBaoHan = NO;
    }
    WeakSelf
    cell.selectedAwardItem = ^(SaleModel * _Nonnull model) {
        weakSelf.model = model;
        [_collectionView reloadData];
        
        if (_selectAwardItemModel) {
            _selectAwardItemModel(weakSelf.model);
        }
    };
    [cell refreshCellModel:model];
    return cell;

}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/

@end
