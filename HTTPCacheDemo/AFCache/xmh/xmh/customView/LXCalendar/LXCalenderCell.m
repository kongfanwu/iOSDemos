//
//  LXCalenderCell.m
//  LXCalendar
//
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXCalenderCell.h"
#import "LolDayModel.h"
@interface LXCalenderCell()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *num;


@end
@implementation LXCalenderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label.layer.cornerRadius = 5;
    self.label.layer.masksToBounds = YES;
    
}
-(void)setModel:(LXCalendarDayModel *)model{
    _model = model;
    
    self.label.text = @"";
    _num.text = [NSString stringWithFormat:@"%ld",model.day];
//    [self.label setFTCornerdious:0.0];
    self.label.backgroundColor = [UIColor whiteColor];
    
    if (model.isNextMonth || model.isLastMonth) {
        self.userInteractionEnabled = NO;
       
        if (model.isShowLastAndNextDate) {
            
            self.label.hidden = NO;
            
            if (model.isNextMonth) {
                self.label.textColor = model.nextMonthTitleColor? model.nextMonthTitleColor:[UIColor colorWithWhite:0.85 alpha:1.0];
            }
            
            if (model.isLastMonth) {
                self.label.textColor = model.lastMonthTitleColor? model.lastMonthTitleColor:[UIColor colorWithWhite:0.85 alpha:1.0];
            }
         
        }else{
            
            self.label.hidden = YES;
            self.icon.hidden = YES;
            self.lb2.hidden = YES;
           
        }//        self.label.hidden = YES;
       
        
    }else{
        
        self.label.hidden = NO;
        self.userInteractionEnabled = YES;
        self.icon.hidden = NO;
        self.lb2.hidden = NO;
        
        if (model.isSelected) {
//            [self.label setFTCornerdious:5];
            self.label.backgroundColor = model.selectBackColor?model.selectBackColor:[UIColor greenColor];
            
            if (model.isHaveAnimation) {
                 [self addAnimaiton];
            }
           
        }
        switch (model.dayModel.state) {
            case 1:{//休息
//                self.lb1.backgroundColor = kLabelText_Commen_Color_9;
//                self.lb2.textColor = kLabelText_Commen_Color_9;
                self.lb2.text = @"休息";
                self.icon.image = UIImageName(@"styygl_xiuxi");
                break;
            }
            case 2:{//达标
//                self.lb1.backgroundColor = [ColorTools colorWithHexString:@"#48c2af"];
//                self.lb2.textColor = [ColorTools colorWithHexString:@"#48c2af"];
                self.icon.image = UIImageName(@"styygl_dabiao");
                break;
            }
            case 3:{//不达标
//                self.lb1.backgroundColor = [ColorTools colorWithHexString:@"f86f5c"];
//                self.lb2.textColor = [ColorTools colorWithHexString:@"f86f5c"];
                self.icon.image = UIImageName(@"styygl_budabiao");
                break;
            }
            default:
                break;
        }
        
//        self.lb2.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.dayModel.pro_num,(long)model.dayModel.num];
         self.lb2.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.dayModel.num,(long)model.dayModel.pro_num];
        
        self.label.textColor = model.currentMonthTitleColor?model.currentMonthTitleColor:[UIColor blueColor];
        if (model.isToday) {
//            self.label.layer.borderWidth = 1;
//            self.label.layer.cornerRadius = 6;
//            self.label.layer.borderColor = kLabelText_Commen_Color_9.CGColor;
            self.label.backgroundColor = [ColorTools colorWithHexString:@"#FFF0F8"];
        }else{
            self.label.layer.borderWidth = 0;
            self.label.layer.cornerRadius = 0;
            self.label.layer.borderColor = [UIColor whiteColor].CGColor;
        }
    }
    /** 新版隐藏 */
    _lb2.hidden = YES;
}

-(void)addAnimaiton{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    
    anim.values = @[@0.6,@1.2,@1.0];
//    anim.fromValue = @0.6;
    anim.keyPath = @"transform.scale";  // transform.scale 表示长和宽都缩放
    anim.calculationMode = kCAAnimationPaced;
    anim.duration = 0.25;                // 设置动画执行时间
//    anim.repeatCount = MAXFLOAT;        // MAXFLOAT 表示动画执行次数为无限次
    
//    anim.autoreverses = YES;            // 控制动画反转 默认情况下动画从尺寸1到0的过程中是有动画的，但是从0到1的过程中是没有动画的，设置autoreverses属性可以让尺寸0到1也是有过程的
    
    [self.label.layer addAnimation:anim forKey:nil];
}
@end
