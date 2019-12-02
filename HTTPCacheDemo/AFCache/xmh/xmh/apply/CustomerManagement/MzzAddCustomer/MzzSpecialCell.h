//
//  MzzSpecialCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzChangeInfoModel.h"
#import "SPShowChangeInfo.h"
@interface MzzSpecialCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIView *tips;
@property (weak, nonatomic) IBOutlet UILabel *frame_name;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UIImageView *selImg;

- (void)setupData:(MzzApprovalpersonNew *)model;
- (void)setupShowData:(SPShowPersonModel *)model;
- (void)setIsSelected:(BOOL)isSelected;

@end
