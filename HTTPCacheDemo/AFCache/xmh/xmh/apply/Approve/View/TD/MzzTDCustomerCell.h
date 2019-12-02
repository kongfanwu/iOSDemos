//
//  MzzTDCustomerCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSearchStoreUserModel.h"
#import "SPSearchUserModel.h"
@interface MzzTDCustomerCell : UICollectionViewCell
- (void)setData:(SPStoreUserModel *)model;
-(void)setBillData:(SPUserModel *)model;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (copy, nonatomic) void (^MzzTDCustomerCellBlock)(UIImageView * imgV,SPUserModel *model);
@end
