//
//  ChuFangWaitForBookTableViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaiYuYueModel;
@interface ChuFangWaitForBookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (nonatomic, copy)void(^chuFangWaitForBookTableViewCellBlock)(UIButton *btn);
- (void)updateChuFangWaitForBookTableViewCell:(DaiYuYueModel *)model;
@end
