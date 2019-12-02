//
//  MzzPortraitView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/11/16.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzPortraitView : UIView
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic,strong)UIView *botomView;//底部标题View
@property (nonatomic ,strong)UIButton *moreButton;
@property (nonatomic,assign) UIEdgeInsets edgeInset; // collectionView 的内边距
@property (nonatomic,assign) float minitemSpace; // 列间距
@property (nonatomic,assign) float minlineSpace; // 行间距
@property (nonatomic,assign) float textInterval; // 文字左右距离
@property (nonatomic,assign) float cellHeight; // cell的高度
@property (nonatomic,assign) float cellCornerRadius; // 边框弧度
@property (nonatomic,assign) float textFont; // 文字大小
@property (nonatomic,assign) float collectionViewMaxHeight; // 最高高度
@property (nonatomic,assign) float cellBorderWidth; // 边框大小

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)dataArray andWithSelect:(BOOL)select;
@property (copy, nonatomic) void (^changeHeight)(int height,BOOL iselect);
@property (copy, nonatomic) void (^toPushAddPortrait)();
@property (copy, nonatomic) void (^heightBlock)(int height);

@end
