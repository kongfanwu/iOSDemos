//
//  OneDateView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OneDateView.h"
#import "OneDateCollectionViewCell.h"
static NSString * cellName = @"OneDateViewCell";
@interface OneDateView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation OneDateView{
    NSMutableArray * _dataArr;
    UICollectionView * _cv;
    OneDateCollectionViewCell * _selectCell;
 
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr = [[NSMutableArray alloc] init];
        [self getCurrentWeeks];
        [self initSubViews];

    }
    return self;
}
- (void)initSubViews{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/4, self.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,self.height) collectionViewLayout:layout];
    cv.delegate = self;
    cv.dataSource = self;
    cv.showsHorizontalScrollIndicator = NO;
    [cv registerClass:[OneDateCollectionViewCell class] forCellWithReuseIdentifier:cellName];
    cv.backgroundColor = [UIColor whiteColor];
    cv.pagingEnabled = NO;
    cv.bounces = YES;
    cv.scrollsToTop = NO;
    _cv = cv;
    cv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [self addSubview:cv];
    
    [_cv performBatchUpdates:^{
        
        
        
    } completion:^(BOOL finished) {
        
        NSArray * cells = [_cv visibleCells];
        
        if (cells.count > 0) {
            
            OneDateCollectionViewCell * cell = cells[0];
            cell.lb.textColor = kBtn_Commen_Color;
            
        }
        
    }];
    
}
#pragma mark --- CollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OneDateCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
   
    [cell updateOneDateCollectionViewCell:_dataArr[indexPath.row]];
    
       return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 7;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OneDateCollectionViewCell * cell = (OneDateCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.lb.textColor = kBtn_Commen_Color;
    NSArray * cells = [collectionView visibleCells];
    
    
    for (OneDateCollectionViewCell * selectCell in cells) {
        
        if (![selectCell isEqual:cell]) {
            
            selectCell.lb.textColor = kLabelText_Commen_Color_6;
        }
        
        
    }

    if (_OneDateViewBlock) {
        _OneDateViewBlock(cell.lb.text,indexPath);
    }
}

- (void)getCurrentWeeks{
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 7; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        //        NSString *dateStr = @"5月31日";
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        //组合时间
        if (i==0) {
            weekStr = @"今天";
        }
        NSString *strTime = [NSString stringWithFormat:@"%@%@",weekStr,dateStr];
        [eightArr addObject:strTime];
    }
    _dataArr = eightArr;
    [_cv reloadData];
    
    
}

@end
