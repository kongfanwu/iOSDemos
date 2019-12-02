//
//  WorkTbHeardMagnagerSh.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTbHeardMagnagerSh.h"
#import "WorkModel.h"

@interface WorkTbHeardMagnagerSh()
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *foureLabel;
@property (weak, nonatomic) IBOutlet UILabel *fiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *sixLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneBiao;
@property (weak, nonatomic) IBOutlet UILabel *threeBiao;
@property (weak, nonatomic) IBOutlet UILabel *foureBiao;



@end

@implementation WorkTbHeardMagnagerSh

+ (instancetype)loadWorkTbHeaderManagerSh{
    return loadNibName(@"WorkTbHeardMagnagerSh");
    
}

-(void)updateWorkTbHeaderModel:(WorkHeardManagerModel *)model withRole:(NSInteger)role{
    
    self.oneLabel.text = [NSString stringWithFormat: @"%.2f",[model.appo floatValue]];
    self.twoLabel.text = [NSString stringWithFormat:@"%.2f",[model.serv floatValue]];
    self.threeLabel.text = [NSString stringWithFormat:@"%.2f",[model.pres floatValue]];
    self.foureLabel.text = [NSString stringWithFormat:@"%.2f",[model.valid floatValue]];
    self.fiveLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
    self.sixLabel.text = [NSString stringWithFormat:@"%.2f%@%.2f",[model.add floatValue],@"/",[model.count floatValue]];
    self.oneBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.appo_bz,@"人"];
    self.threeBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.pres_bz,@"人"];
    self.foureBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.valid_bz,@"人"];
    
}

@end
