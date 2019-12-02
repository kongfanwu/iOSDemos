//
//  CustomerGradeCell.h
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerGradeModel;
@interface CustomerGradeCell : UITableViewCell
@property (nonatomic, strong)UICollectionView *gradeConllectionView;
- (void)updateCustomerGradeCellModel:(CustomerGradeModel *)model;
@end
