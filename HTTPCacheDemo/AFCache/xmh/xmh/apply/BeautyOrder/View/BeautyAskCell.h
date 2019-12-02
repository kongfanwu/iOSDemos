//
//  BeautyAskCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyAskCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UITextView *text1;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIView *container;

/**
 *刷新BeautyAskCell
 */
- (void)reFreshBeautyAskCell:(NSString *)title withContext:(NSString *)context withPlaceText:(NSString *)placeText withhidden:(BOOL)isHidden;
@end
