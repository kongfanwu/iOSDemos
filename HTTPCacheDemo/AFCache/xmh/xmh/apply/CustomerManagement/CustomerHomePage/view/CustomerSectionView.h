//
//  CustomerSectionView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomerSectionViewDelegate <NSObject>
@optional
//index:sc , indexpath:collectionview
- (void)choiceIndex:(NSInteger)index andCollectionIndexpath:(NSIndexPath *) indexpath;

@end

@interface CustomerSectionView : UIView

@property (nonatomic ,assign) id<CustomerSectionViewDelegate> delegate;

@end
