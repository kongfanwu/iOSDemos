//
//  WorkChoiceCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkChoiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
- (void)refreshWorkChoiceCell:(NSString *)str;
@end
