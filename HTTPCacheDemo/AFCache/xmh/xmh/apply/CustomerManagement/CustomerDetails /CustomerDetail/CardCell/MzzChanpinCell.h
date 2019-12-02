//
//  MzzChanpinCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzUser_salesModel.h"
@interface MzzChanpinCell : UITableViewCell
@property (nonatomic ,strong)MzzGoodsModel *model;
@property (nonatomic ,assign)NSString * user_id;
@property (nonatomic ,copy)void(^reFresh)(void);
@end
