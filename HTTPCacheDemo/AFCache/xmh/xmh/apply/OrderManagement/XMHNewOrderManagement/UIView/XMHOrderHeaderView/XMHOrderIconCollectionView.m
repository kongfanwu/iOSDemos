//
//  XMHOrderIconCollectionView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderIconCollectionView.h"
#import "XMHOrderIconCell.h"
#import "NSArray+Safe.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kLineBgH  3
#define kLineBgW  33
#define kIndicatorViewW  22
#define kScaleW                  (SCREEN_WIDTH/375.0)
@interface XMHOrderIconCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_titles;
    NSArray *_images;
    UIView *_indicatorView;
}
@end

@implementation XMHOrderIconCollectionView

- (id)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        _images = images;
        [self loadCollectionView];
    }
    return  self;
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (iPhone5) {
        layout.itemSize = CGSizeMake(47, 75);
        layout.minimumLineSpacing = 45;
    }else{
         layout.itemSize = CGSizeMake(47 * kScaleW, 75);
         layout.minimumLineSpacing = (64 * kScaleW);
    }

    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);//设置cell的左右缩进
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height - 5) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    //注册
    [_collectionView registerNib:[UINib nibWithNibName:@"XMHOrderIconCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"XMHOrderIconCell"];
   
    
    UIView *lineBgView = [[UIView alloc]initWithFrame:CGRectMake((self.width - kLineBgW) * 0.5 , _collectionView.bottom, kLineBgW, kLineBgH)];
    lineBgView.layer.cornerRadius = kLineBgH * 0.5;
    lineBgView.layer.masksToBounds = YES;
    lineBgView.backgroundColor = [ColorTools colorWithHexString:@"#D8D8D8"];
    [self addSubview:lineBgView];
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kIndicatorViewW, kLineBgH)];
    _indicatorView.backgroundColor = kColorTheme;
    _indicatorView.layer.cornerRadius = kLineBgH * 0.5;
    _indicatorView.layer.masksToBounds = YES;
    [lineBgView addSubview:_indicatorView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMHOrderIconCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMHOrderIconCell" forIndexPath:indexPath];
    cell.textLab.text = [_titles safeObjectAtIndex:indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[_images safeObjectAtIndex:indexPath.row]];
    cell.iconImageView.mj_size = CGSizeMake(47*kScaleW, 47*kScaleW);
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *title =  [_titles safeObjectAtIndex:indexPath.row];
    if (self.menViewClickTitle) {
        self.menViewClickTitle(title);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   __block CGFloat indicatorViewX = 0;
    CGPoint point =  scrollView.contentOffset;
    [UIView animateWithDuration:0.05 animations:^{
        CGFloat x = 0;
        if (point.x > 0) {
            x = (point.x * (kLineBgW))/SCREEN_WIDTH;
             _indicatorView.frame = CGRectMake(x - indicatorViewX , 0, kIndicatorViewW , kLineBgH);
            indicatorViewX = _indicatorView.mj_x;
        }else{
            _indicatorView.frame = CGRectMake(x, 0, kIndicatorViewW , kLineBgH);
        }
//    _indicatorView.frame = CGRectMake(x, 0, kIndicatorViewW , kLineBgH);

    }];
}
@end
