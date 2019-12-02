//
//  MessageNextCell.h
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMsgModel;
@interface MessageNextCell : UITableViewCell
- (void)updateMessageNextCellModel:(LMsgModel *)model;
@end
