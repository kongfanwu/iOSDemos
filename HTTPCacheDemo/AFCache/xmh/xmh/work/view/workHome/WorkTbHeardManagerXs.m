//
//  WorkTbHeardManagerXs.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTbHeardManagerXs.h"
#import "WorkModel.h"

@interface WorkTbHeardManagerXs()
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *foureLabel;
@property (weak, nonatomic) IBOutlet UILabel *fiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *sixLabel;
@property (weak, nonatomic) IBOutlet UILabel *saveLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneBiao;
@property (weak, nonatomic) IBOutlet UILabel *threeBiao;
@property (weak, nonatomic) IBOutlet UILabel *fourBiao;


@end
@implementation WorkTbHeardManagerXs

+ (instancetype)loadWorkTbHeaderManagerXs{
    return loadNibName(@"WorkTbHeardManagerXs");

}
-(void)updateWorkTbHeaderModel:(WorkHeardManagerModel *)model withRole:(NSInteger)role{

    self.oneLabel.text = [NSString stringWithFormat:@"%@",model.valid];
    self.twoLabel.text = [NSString stringWithFormat:@"%@",model.target];
    self.threeLabel.text = [NSString stringWithFormat:@"%@",model.deal];
    self.foureLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
    self.fiveLabel.text = [NSString stringWithFormat:@"%@%@%@",model.consume,@"/",model.total];
    self.sixLabel.text = [NSString stringWithFormat:@"%@%@%@",model.aim_n,@"/",model.aim_a];
    self.saveLabel.text = [NSString stringWithFormat:@"%@%@%@",model.pop_n,@"/",model.pop_a];
    self.lastLabel.text = [NSString stringWithFormat:@"%@%@%@",model.grant_n,@"/",model.grant_a];
    self.oneBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.valid_bz,@"人"];
    self.threeBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.deal_bz,@"人"];
    self.fourBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.price_bz,@"元"];

}

@end
