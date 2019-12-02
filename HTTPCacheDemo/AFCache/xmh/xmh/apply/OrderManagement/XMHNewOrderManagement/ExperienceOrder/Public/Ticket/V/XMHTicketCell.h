//
//  XMHTicketCell.h
//  xmh
//
//  Created by KFW on 2019/3/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHTicketModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHTicketCell : UITableViewCell

- (void)configModel:(XMHTicketModel *)model;

@end

NS_ASSUME_NONNULL_END
