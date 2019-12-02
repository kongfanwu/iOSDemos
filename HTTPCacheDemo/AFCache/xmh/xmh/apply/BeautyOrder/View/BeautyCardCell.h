//
//  BeautyCardCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UIImageView *im1;
/**
 *刷新BeautyCardCell
 */
- (void)reFreshBeautyCardCell:(NSString *)strCard;
- (void)resetimagebgWidth:(CGFloat)width;
@end
