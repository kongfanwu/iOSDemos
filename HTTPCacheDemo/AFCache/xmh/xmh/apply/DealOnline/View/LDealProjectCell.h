//
//  LDealProjectCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 150

#import <UIKit/UIKit.h>
#import "OHomeListModel.h"
@interface LDealProjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (strong, nonatomic)NSObject * obj;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb22;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb33;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb44;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb55;
- (void)updateLDealProjectCellWithModel:(OHomeModel *)homeModel type:(NSInteger)type;
@end
