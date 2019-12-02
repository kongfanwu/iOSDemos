//
//  MzzPortraitCollectionViewCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzPortraitCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIButton *content;
@property (copy, nonatomic) void (^addButtonBlock)();

- (void)setTheLabeValueWithFont:(CGFloat)font borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius andContent:(NSString *)string;

@end
