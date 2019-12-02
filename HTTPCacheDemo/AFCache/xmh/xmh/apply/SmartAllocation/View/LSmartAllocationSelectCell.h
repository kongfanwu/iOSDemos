//
//  LSmartAllocationSelectCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSADaiFenPeiModel.h"
@interface LSmartAllocationSelectCell : UITableViewCell
@property (nonatomic, strong)LSAUserModel * model;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UILabel *lbName1;
@property (weak, nonatomic) IBOutlet UILabel *lbStore;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UILabel *lbName2;
@property (weak, nonatomic) IBOutlet UILabel *lbManageNum;
@end
