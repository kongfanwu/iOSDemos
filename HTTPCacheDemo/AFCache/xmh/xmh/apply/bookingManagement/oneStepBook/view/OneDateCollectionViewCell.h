//
//  OneDateCollectionViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneDateCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *lb;
- (void)updateOneDateCollectionViewCell:(NSString *)title;

@end
