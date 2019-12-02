//
//  MzzBillCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzBillInfoListModel.h"
@interface MzzBillCell : UITableViewCell
@property (nonatomic ,strong)MzzBillInfoModel *model;

- (void)setupModel:(MzzBillInfoModel *)model andType:(NSString *)type andCardName:(NSString *)cardName;
@end
