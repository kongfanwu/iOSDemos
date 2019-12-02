//
//  WorkTbHeardManager.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTbHeardManager.h"
#import "WorkModel.h"
@interface WorkTbHeardManager()
@property (weak, nonatomic) IBOutlet UILabel *yuyueLabel;
@property (weak, nonatomic) IBOutlet UILabel *youxiaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *yinliuLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiedaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *caozuoLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuyueBiao;
@property (weak, nonatomic) IBOutlet UILabel *youxiaoBiao;
@property (weak, nonatomic) IBOutlet UILabel *yinliuBiao;
@property (weak, nonatomic) IBOutlet UILabel *jiedaiBiao;
@property (weak, nonatomic) IBOutlet UILabel *caozuoBiao;
@property (weak, nonatomic) IBOutlet UILabel *projectBiao;
@property (weak, nonatomic) IBOutlet UILabel *priceBiao;


@end

@implementation WorkTbHeardManager

+ (instancetype)loadWorkTbHeaderManager
{
    return loadNibName(@"WorkTbHeardManager");
}
-(void)updateWorkTbHeaderModel:(WorkHeardManagerModel *)model withRole:(NSInteger)role{
    
    self.yuyueLabel.text = [NSString stringWithFormat:@"%@",model.appo];
    self.youxiaoLabel.text = [NSString stringWithFormat:@"%@",model.valid];
    self.yinliuLabel.text = [NSString stringWithFormat:@"%@",model.drain];
    self.jiedaiLabel.text = [NSString stringWithFormat:@"%@",model.admit];
    self.caozuoLabel.text = [NSString stringWithFormat:@"%@",model.handl];
    self.projectLabel.text = [NSString stringWithFormat:@"%@",model.equal];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
    self.yuyueBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.appo_bz,@"人"];
    self.youxiaoBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.valid_bz,@"人"];
    self.yinliuBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.drain_bz,@"人"];
    self.jiedaiBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.admit_bz,@"人"];
    self.jiedaiBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.handl_bz,@"人"];
    self.projectBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.equal_bz,@"人"];
    self.priceBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.price_bz,@"元"];

    if (role == 1) {
        self.priceTitleLabel.text = @"客均单价";
    }else{
        self.priceTitleLabel.text = @"客均耗卡单价";
    }
}

@end
