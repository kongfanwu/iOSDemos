//
//  BookTimeCollectionCell.h
//  xmh
//
//  Created by ald_ios on 2018/10/26.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookJisTime;
@interface BookTimeCollectionCell : UICollectionViewCell
- (void)updateBookTimeCollectionCellModel:(BookJisTime *)model;
@end
