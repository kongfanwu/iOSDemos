//
//  HomeCell.h
//  xmh
//
//  Created by ald_ios on 2018/9/10.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineCellModel;
@interface HomeCell : UITableViewCell
- (void)updateHomeCellModel:(MineCellModel *)model index:(NSInteger)index count:(NSInteger)count;
@end
