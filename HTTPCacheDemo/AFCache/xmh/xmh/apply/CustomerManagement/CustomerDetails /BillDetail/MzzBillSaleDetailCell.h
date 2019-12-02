//
//  MzzBillSaleDetailCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/16.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
@class MzzBillInfoModel;
@interface MzzBillSaleDetailCell : UITableViewCell
- (void)setupModel:(MzzBillInfoModel *)model andType:(NSString *)type andCardName:(NSString *)cardName;
@end
