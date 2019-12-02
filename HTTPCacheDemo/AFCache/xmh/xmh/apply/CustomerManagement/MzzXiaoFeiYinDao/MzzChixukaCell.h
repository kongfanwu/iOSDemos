//
//  MzzChixukaCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzGuideModel.h"
@interface MzzChixukaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
- (void)updateCellModel:(MzzStored_card *)model;
@end
