//
//  BeeTagView.h
//  xmh
//
//  Created by Ss H on 2018/11/17.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CollectionViewDidSelectBlock)(NSMutableArray *selectArray);

@interface BeeTagView : UIView

@property (nonatomic,assign) UIEdgeInsets edgeInset; // collectionView 的内边距
@property (nonatomic,assign) float minitemSpace; // 列间距
@property (nonatomic,assign) float minlineSpace; // 行间距
@property (nonatomic,assign) float textInterval; // 文字左右距离
@property (nonatomic,assign) float cellHeight; // cell的高度
@property (nonatomic,assign) float cellCornerRadius; // 边框弧度
@property (nonatomic,assign) float textFont; // 文字大小
@property (nonatomic,assign) float collectionViewMaxHeight; // 最高高度
@property (nonatomic,assign) float cellBorderWidth; // 边框大小
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;
@property (weak, nonatomic) IBOutlet UIButton *classificationButton;
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic,strong)NSMutableArray *tagArr;

@property (nonatomic,copy) CollectionViewDidSelectBlock didselectBlock; // 点击cell
@property (copy, nonatomic) void (^popToRoot)();

/**
 * textArr: 文字数组
 * textColor: 文字颜色
 * cellBackColor: item背景颜色
 * borderColor: item边框颜色
 */
- (id)initWithTextArr:(NSMutableArray *)textArr TextColor:(UIColor *)textColor CellBackColor:(UIColor *)cellBackColor CellBorderColor:(UIColor *)borderColor;

@end
