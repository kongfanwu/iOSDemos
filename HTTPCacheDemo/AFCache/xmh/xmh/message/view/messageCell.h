//
//  messageCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMsgListModel.h"
@class XMHBadgeLabel;
@interface messageCell : UITableViewCell

/*
 红点(imageview1)      年月日(3)  时分(4)
 标题(1)
 内容(2)
 */

@property (weak, nonatomic) IBOutlet UIImageView *imageview1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (strong, nonatomic)XMHBadgeLabel *badgeLabel;
@property (strong, nonatomic)LMsgModel * model;
@end
