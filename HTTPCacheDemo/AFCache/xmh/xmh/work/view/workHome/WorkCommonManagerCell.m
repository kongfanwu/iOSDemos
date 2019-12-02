//
//  WorkCommonManagerCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkCommonManagerCell.h"
#import "MzzWordManagerModel.h"

@implementation WorkCommonManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateWorkCommonCellDataModel:(MzzManageModel *)model andChooseStr:(NSString *)chooseStr
{
    if ([chooseStr containsString:@"业绩"]) {
        self.yejiTitleLabel.textColor = kBtn_Commen_Color;
        self.yejiLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"消耗"]){
        self.xiaohaoTitleLabel.textColor = kBtn_Commen_Color;
        self.xiaohaoLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"客次"]){
        self.kcTitleLabel.textColor = kBtn_Commen_Color;
        self.kcLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"项目"]){
        self.projectTitleLabel.textColor = kBtn_Commen_Color;
        self.projectLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"引流"]){
        self.yinliuTitleLabel.textColor = kBtn_Commen_Color;
        self.yinliuLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"预约"]){
        self.yuyueTitleLabel.textColor = kBtn_Commen_Color;
        self.yuyueLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"有效客"]){
        self.effectiveTitleLabel.textColor = kBtn_Commen_Color;
        self.effectiveLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"人均接待"]){
        self.receptionTitleLabel.textColor = kBtn_Commen_Color;
        self.receptionLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"人均操作"]){
        self.operationTitleLabel.textColor = kBtn_Commen_Color;
        self.operationLabel.textColor = kBtn_Commen_Color;
    }else if ([chooseStr containsString:@"客均项目"]){
        self.kjProjectTitleLabel.textColor = kBtn_Commen_Color;
        self.kjProjectLabel.textColor = kBtn_Commen_Color;
    }else
    {
        self.kjPriceTitleLabel.textColor = kBtn_Commen_Color;
        self.kjPriceLabel.textColor = kBtn_Commen_Color;
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    self.yejiLabel.text = [NSString stringWithFormat:@"%@%@",model.ach,@"元"];
    self.xiaohaoLabel.text = [NSString stringWithFormat:@"%ld%@",(long)model.exp,@"元"];
    self.yuyueLabel.text =[NSString stringWithFormat:@"%@%@",model.appo,@"次"];
    self.yinliuLabel.text = [NSString stringWithFormat:@"%@%@",model.drai,@"人"];
    self.kcLabel.text = [NSString stringWithFormat:@"%ld%@",(long)model.num,@"人"];
    self.projectLabel.text = [NSString stringWithFormat:@"%@%@",model.pro,@"个"];
    self.effectiveLabel.text = [NSString stringWithFormat:@"%@%@",model.vali,@"人"];
    self.kjProjectLabel.text = [NSString stringWithFormat:@"%@%@",model.pro_p,@"个"];
    self.self.kjPriceLabel.text = [NSString stringWithFormat:@"%@%@",model.exp_p,@"元"];
    self.receptionLabel.text = [NSString stringWithFormat:@"%@%@",model.admit,@"人"];
    self.operationLabel.text = [NSString stringWithFormat:@"%@%@",model.handl,@"次"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
