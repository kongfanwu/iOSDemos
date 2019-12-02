//
//  MinePWCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinePWCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UITextField *lbContent;
@property (copy, nonatomic) void (^MinePWCellBlock)(NSString * text);
@end
