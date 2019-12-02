//
//  FWDYeJiSubCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWDYeJiSubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgVConstrant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgConstrantHight;

@end
