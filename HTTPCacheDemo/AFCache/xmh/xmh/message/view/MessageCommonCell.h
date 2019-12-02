//
//  MessageCommonCell.h
//  xmh
//
//  Created by ald_ios on 2018/12/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MsgHomeModel;
@interface MessageCommonCell : UITableViewCell
- (void)updateMessageCommonCellModel:(MsgHomeModel *)model;
@end
