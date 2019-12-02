//
//  WorkTbHeardMagnagerSq.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTbHeardMagnagerSq.h"
#import "WorkModel.h"

@interface WorkTbHeardMagnagerSq ()
@property (weak, nonatomic) IBOutlet UILabel *txtOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtOneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtTwoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtThreeTitleLaebl;
@property (weak, nonatomic) IBOutlet UILabel *txtFoureLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtFoureTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtOneBiao;
@property (weak, nonatomic) IBOutlet UILabel *txtTwoBiao;
@property (weak, nonatomic) IBOutlet UILabel *txtThreeBiao;
@property (weak, nonatomic) IBOutlet UILabel *txtFourBiao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foureConstraint;

@end

@implementation WorkTbHeardMagnagerSq

+ (instancetype)loadWorkTbHeaderManagerSq{
    return loadNibName(@"WorkTbHeardMagnagerSq");
    
}

-(void)updateWorkTbHeaderModel:(WorkHeardManagerModel *)model withRole:(NSInteger)role{
    
    if (role == 9) {//售前美容师
        _txtOneLabel.text = [NSString stringWithFormat:@"%.2f",[model.rate floatValue]];
        _txtOneTitleLabel.text = @"成交率";
        _txtTwoLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
        _txtTwoTitleLabel.text = @"成交单价";
        
        _txtThreeTitleLaebl.text = @"今日试做/月累计人数";
        _txtThreeLabel.text = [NSString stringWithFormat:@"%@%@%@",model.try_d,@"/",model.try_m];
        
        _txtFoureLabel.text = [NSString stringWithFormat:@"%@%@%@",model.dea_d,@"/",model.dea_m];
        _txtFoureTitleLabel.text = @"今日成交/月累计人数";
        
        _txtOneBiao.text = @"";
        _txtTwoBiao.text = @"";
        _txtThreeBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.try_bz,@"人"];
        _txtFourBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.dea_bz,@"人"];
        _oneConstraint.constant = 10;
        _twoConstraint.constant = 10;
        
    }else{
        _txtOneLabel.text = [NSString stringWithFormat:@"%@",model.toker];
        _txtOneTitleLabel.text = @"今日拓客";
        _txtTwoLabel.text = [NSString stringWithFormat:@"%@",model.try_];
        _txtTwoTitleLabel.text = @"今日试做";
        
        _txtThreeTitleLaebl.text = @"今日成交";
        _txtThreeLabel.text = [NSString stringWithFormat:@"%@",model.deal];
        
        _txtFoureLabel.text = [NSString stringWithFormat:@"%.2f",[model.achie floatValue]];
        _txtFoureTitleLabel.text = @"今日业绩";
        
        _txtOneBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.toker_bz,@"人"];
        _txtTwoBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.try_bz,@"人"];
        _txtThreeBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.deal_bz,@"人"];
        _txtFourBiao.text = @"";
        _foureConstraint.constant = 10;
    }
}

@end
