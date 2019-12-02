//
//  MineInfoSexCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzPickerTextField.h"
@interface MineInfoSexCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet MzzPickerTextField *tfContent;
@property (weak, nonatomic) IBOutlet UIView *btnMore;

@end
