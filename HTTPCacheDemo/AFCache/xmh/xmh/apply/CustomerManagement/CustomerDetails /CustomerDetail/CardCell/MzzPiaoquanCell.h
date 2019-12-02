//
//  MzzPiaoquanCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzUser_salesModel.h"
@interface MzzPiaoquanCell : UITableViewCell
@property (nonatomic ,strong)MzzTicketModel *model;
@property (nonatomic ,assign)NSString * user_id;
@property (nonatomic ,copy)void(^reFresh)(void);
- (void)updateCellModel:(MzzTicketCouponModel *)model;
@end
