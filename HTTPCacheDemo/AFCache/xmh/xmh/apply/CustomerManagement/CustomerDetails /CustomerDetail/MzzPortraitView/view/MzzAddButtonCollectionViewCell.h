//
//  MzzAddButtonCollectionViewCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzAddButtonCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *content;

- (void)setTheLabeValueWithFont:(CGFloat)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius andContent:(NSString *)string withBackGroundColor:(UIColor *)groundColor;
@end
