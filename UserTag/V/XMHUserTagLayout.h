//
//  XMHUserTagLayout.h
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHUserTagLayout : UICollectionViewLayout
@property (assign, nonatomic) CGFloat itemHeight;
@property (assign, nonatomic) CGFloat itemSpace;
@property (assign, nonatomic) CGFloat lineSpace;
@property (assign, nonatomic) UIEdgeInsets sectionInsets;
@property (assign, nonatomic) CGFloat headerViewHeight;//头视图的高度
@property (assign, nonatomic) CGFloat footViewHeight;//尾视图的高度

@property (nonatomic, copy) CGFloat (^widthComputeBlock)(NSIndexPath *indexPath, CGFloat height); //获取cell宽度Block

@end

NS_ASSUME_NONNULL_END
