//
//  BookCustomerTableViewCell.m
//  xmh
//
//  Created by 李晓明 on 2017/11/23.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookCustomerTableViewCell.h"
#import "BookCustomerCollectionViewCell.h"
#import "LolHomeGuKeModel.h"
#import "BookReachStandardView.h"
@interface BookCustomerTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation BookCustomerTableViewCell{
    
    UICollectionViewFlowLayout * _layout;
    UICollectionView * _cv;
    NSMutableArray * _dataArr;
    UILabel * _lb;
    BookReachStandardView * _reach;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _dataArr = [[NSMutableArray alloc] init];
        [self initSubViews];
    }
    return self;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _lb.frame =  CGRectMake(0, 0, SCREEN_WIDTH, 10);
    CGFloat  height = 0;
    if (dataArr.count > 0) {
        if (dataArr.count%4 == 0) {
            height = dataArr.count/4 * 50;
        }else{
            height = (dataArr.count/4 + 1)* 50;
        }
    }
    _cv.frame = CGRectMake(0,10 + 44, SCREEN_WIDTH , height + 10 + 55 + 44);
    MzzLog(@"self.....%f",height + 10 + 55)
    [_reach updateBookReachStandardView];
    _dataArr = dataArr;
    [_cv reloadData];
}

- (void)initSubViews{
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = kBackgroundColor;
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    _lb = label;
    [self addSubview:label];
    
    _reach = [[BookReachStandardView alloc] init];
    _reach.frame = CGRectMake(0, _lb.bottom, SCREEN_WIDTH, 44);
    [self addSubview:_reach];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake((SCREEN_WIDTH - 15 *2 - 9 * 4)/5, 50);
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10  + 44, SCREEN_WIDTH , self.height) collectionViewLayout:_layout];
    _cv.delegate = self;
    _cv.dataSource = self;
    _cv.showsHorizontalScrollIndicator = NO;
    [_cv registerClass:[BookCustomerCollectionViewCell class] forCellWithReuseIdentifier:@"CustomerCollectionViewCell"];
    _cv.backgroundColor = [UIColor whiteColor];
    _cv.pagingEnabled = NO;
    [self addSubview:_cv];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCustomerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomerCollectionViewCell" forIndexPath:indexPath];
    
    if ((indexPath.row)%2==0) {
        cell.backgroundColor = [ColorTools colorWithHexString:@"f5f5f5"];
    }else{
         cell.backgroundColor = [UIColor whiteColor];
    }
    if (_dataArr.count!= 0) {
        if(indexPath.row < _dataArr.count){
            cell.model = _dataArr[indexPath.row];
        }else{
            cell.model = nil;
        }
    }
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count + 4 - _dataArr.count % 4;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MzzLog(@"indexRow...........%ld",indexPath.row  - _dataArr.count);
    if (indexPath.row < _dataArr.count) {
        if (_BookCustomerTableViewCellBlock) {
            _BookCustomerTableViewCellBlock(_dataArr[indexPath.row]);
        }
    }
}
@end
