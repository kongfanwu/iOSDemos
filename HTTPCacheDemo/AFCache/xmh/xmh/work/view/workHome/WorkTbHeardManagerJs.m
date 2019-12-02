//
//  WorkTbHeardManagerJs.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTbHeardManagerJs.h"
#import "WorkModel.h"
@interface WorkTbHeardManagerJs()
@property (weak, nonatomic) IBOutlet UILabel *oneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;

@property (weak, nonatomic) IBOutlet UILabel *twoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;

@property (weak, nonatomic) IBOutlet UILabel *threeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;

@property (weak, nonatomic) IBOutlet UILabel *foureTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *foureLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneBiao;
@property (weak, nonatomic) IBOutlet UILabel *twoBiao;
@property (weak, nonatomic) IBOutlet UILabel *threeBiao;
@property (weak, nonatomic) IBOutlet UILabel *foureBiao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraint;



@end
@implementation WorkTbHeardManagerJs

+ (instancetype)loadWorkTbHeaderManagerJs{
    return loadNibName(@"WorkTbHeardManagerJs");

}
-(void)updateWorkTbHeaderModel:(WorkHeardManagerModel *)model withRole:(NSInteger)role{
    
    if (role == 4) {
        self.oneTitleLabel.text = @"人均接待";
        self.oneLabel.text = [NSString stringWithFormat:@"%@",model.admit];
        
        self.twoTitleLabel.text = @"人均操作";
        self.twoLabel.text = [NSString stringWithFormat:@"%@",model.handl];
        
        self.threeTitleLabel.text =@"客均项目";
        self.threeLabel.text = [NSString stringWithFormat:@"%@",model.equal];
        
        self.foureTitleLabel.text =@"客均耗卡单价";
        self.foureLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
        self.oneBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.admit_bz,@"人"];
        self.twoBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.handl_bz,@"人"];
        self.threeBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.equal_bz,@"人"];
        self.foureBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.price_bz,@"人"];

        
    }else if(role == 6){
        self.oneTitleLabel.text = @"今日预约人数";
        self.oneLabel.text = [NSString stringWithFormat:@"%@",model.appo];
        
        self.twoTitleLabel.text = @"今日引流人数";
        self.twoLabel.text = [NSString stringWithFormat:@"%@",model.drain];
        
        self.threeTitleLabel.text =@"客均项目数";
        self.threeLabel.text = [NSString stringWithFormat:@"%@",model.equal];
        
        self.foureTitleLabel.text =@"客均单价";
        self.foureLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
        self.oneBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.appo_bz,@"人"];
        self.twoBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.drain_bz,@"人"];
        self.threeBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.equal_bz,@"人"];
        self.foureBiao.text = [NSString stringWithFormat:@"%@%@%@",@"标准：",model.price_bz,@"人"];

        
    }else{
        self.oneTitleLabel.text = @"转化人数";
        self.oneLabel.text = [NSString stringWithFormat:@"%@",model.count];
        
        self.twoTitleLabel.text = @"转化率";
        self.twoLabel.text = [NSString stringWithFormat:@"%.2f",[model.rate floatValue]];
        
        self.threeTitleLabel.text =@"转化单价";
        self.threeLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
        
        self.foureTitleLabel.text =@"承接人数";
        self.foureLabel.text = [NSString stringWithFormat:@"%@",model.carry];
        self.heightContraint.constant = 65;
        self.oneBiao.text = @"";
        self.twoBiao.text = @"";
        self.threeBiao.text = @"";
        self.foureBiao.text = @"";
    }
}


@end
