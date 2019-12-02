//
//  XMHAwardItem.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHAwardItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imageSelet;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, copy)void(^selectedAwardItem)(SaleModel *model);
- (void)refreshCellModel:(SaleModel *)model;
- (void)resetCell;
@end

NS_ASSUME_NONNULL_END
