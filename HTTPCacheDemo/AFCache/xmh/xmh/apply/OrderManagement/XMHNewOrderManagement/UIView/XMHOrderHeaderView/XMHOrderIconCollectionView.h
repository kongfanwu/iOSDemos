//
//  XMHOrderIconCollectionView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHOrderIconCollectionView : UIView

/**
 选中title
 */
@property (nonatomic,copy) void(^menViewClickTitle)(NSString *title);

/**
 初始化

 @param frame frame
 @param images 图标数组
 @param titles 标题数组
 @return  XMHOrderIconCollectionView
 */
- (id)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles;
@end

NS_ASSUME_NONNULL_END
