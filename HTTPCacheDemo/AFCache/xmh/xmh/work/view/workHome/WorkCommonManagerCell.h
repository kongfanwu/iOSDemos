//
//  WorkCommonManagerCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MzzManageModel;
@interface WorkCommonManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *yejiTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yejiLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiaohaoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiaohaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuyueTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuyueLabel;
@property (weak, nonatomic) IBOutlet UILabel *yinliuTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yinliuLabel;
@property (weak, nonatomic) IBOutlet UILabel *kjProjectTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *kjProjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *kjPriceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *kjPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *kcTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *kcLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *effectiveTitleLabel;//有效客数
@property (weak, nonatomic) IBOutlet UILabel *effectiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *receptionTitleLabel;//人均接待
@property (weak, nonatomic) IBOutlet UILabel *receptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *operationTitleLabel;//人均操作
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;

-(void)updateWorkCommonCellDataModel:(MzzManageModel*)model andChooseStr:(NSString *)chooseStr;


@end
