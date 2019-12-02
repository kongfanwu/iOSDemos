//
//  LNMsgCell.h
//  xmh
//
//  Created by ald_ios on 2018/8/31.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMsgListModel.h"
@interface LNMsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;
@property (strong, nonatomic)LMsgModel * model;

@end
