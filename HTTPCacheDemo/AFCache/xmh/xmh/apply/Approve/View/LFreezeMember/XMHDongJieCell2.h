//
//  XMHDongJieCell2.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSponsorApproceModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHDongJieCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *awardLab;
@property (weak, nonatomic) IBOutlet UILabel *noticeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceTLab;
@property (weak, nonatomic) IBOutlet UILabel *counttLab;
@property (weak, nonatomic) IBOutlet UILabel *awardTLab;
@property (weak, nonatomic) IBOutlet UIView *bgVIew;
@property (strong, nonatomic)LSponsorApproceModel * model;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end

NS_ASSUME_NONNULL_END
