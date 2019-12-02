//
//  BookCollectionViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *img;
@property (strong, nonatomic) UILabel *lb;
- (void)updateBookCollectionViewCell;
@end
