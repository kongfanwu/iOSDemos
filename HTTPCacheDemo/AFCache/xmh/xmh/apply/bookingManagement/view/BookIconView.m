//
//  BookIconView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookIconView.h"
#import "BookCollectionViewCell.h"
@interface BookIconView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation BookIconView{
    
     UILabel * _lbPointer;                   //指示器
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initSubViews];
}
- (void)initSubViews{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(55, 75);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 75) collectionViewLayout:layout];
    cv.delegate = self;
    cv.dataSource = self;
    cv.showsHorizontalScrollIndicator = NO;
    [cv registerClass:[BookCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    cv.backgroundColor = [UIColor whiteColor];
    cv.pagingEnabled = NO;
    cv.bounces = YES;
    cv.scrollsToTop = NO;
    cv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [self addSubview:cv];
    
    _lbPointer = [[UILabel alloc] initWithFrame:CGRectMake( 7.5, cv.height - 2, 40, 2)];
    _lbPointer.backgroundColor =  [ColorTools colorWithHexString:@"#f10180"];
    [cv addSubview:_lbPointer];
       
    
    
}
- (void)updateBookIconView{
    
    
}

#pragma mark --- CollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 15;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _lbPointer.frame = CGRectMake(indexPath.row *(15 + 40) + 7.5, _lbPointer.top, 40, 2);
    
    if ([_delegate respondsToSelector:@selector(bookIconViewSelectIndexPath:)]) {
        
        [_delegate performSelector:@selector(bookIconViewSelectIndexPath:) withObject:indexPath];
    }
}
- (void)setSelectIndex:(NSInteger)selectIndex{
    
    _lbPointer.frame = CGRectMake(selectIndex *(15 + 40) + 7.5, _lbPointer.top, 40, 2);
}
@end
