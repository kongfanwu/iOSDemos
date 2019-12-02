//
//  MineInfoTextCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineInfoTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfContent;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (copy, nonatomic) void (^MineInfoTextCellBlockBlock)(NSString *str);
@end
