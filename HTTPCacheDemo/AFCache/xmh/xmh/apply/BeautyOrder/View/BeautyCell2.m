//
//  BeautyCell2.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCell2.h"
#import <YYWebImage/YYWebImage.h>
@interface BeautyCell2 ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UILabel *lb12;
@property (weak, nonatomic) IBOutlet UILabel *lb13;
@property (weak, nonatomic) IBOutlet UILabel *lb14;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *imageMore;
@end

@implementation BeautyCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _imageView1.frame = CGRectMake(15, 15, 57, 57);
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(15);
    _lb3.textColor = kLabelText_Commen_Color_9;
    _lb3.font = FONT_SIZE(11);
    _lb4.textColor = kLabelText_Commen_Color_9;
    _lb4.font = FONT_SIZE(11);
    _lb5.textColor = kLabelText_Commen_Color_9;
    _lb5.font = FONT_SIZE(11);
    
    _lb6.textColor = kLabelText_Commen_Color_3;
    _lb6.font = FONT_SIZE(15);
    _lb7.textColor = kLabelText_Commen_Color_9;
    _lb7.font = FONT_SIZE(11);
    _lb8.textColor = kLabelText_Commen_Color_9;
    _lb8.font = FONT_SIZE(11);
    _lb9.textColor = kLabelText_Commen_Color_9;
    _lb9.font = FONT_SIZE(11);
    
    _lb10.textColor = [ColorTools colorWithHexString:@"#f3b337"];
    _lb10.font = FONT_SIZE(12);
    _lb11.textColor = [ColorTools colorWithHexString:@"#f3b337"];
    _lb11.font = FONT_SIZE(20);
    _lb12.textColor = [ColorTools colorWithHexString:@"#f3b337"];
    _lb12.font = FONT_SIZE(9);
    
    _lb13.textColor = [ColorTools colorWithHexString:@"#f865fc"];
    _lb13.font = FONT_SIZE(11);
    _lb14.textColor = [ColorTools colorWithHexString:@"#f865fc"];
    _lb14.font = FONT_SIZE(11);
    
    _line1.backgroundColor = kBackgroundColor;
    _line2.backgroundColor = kBackgroundColor;
    
    UIImage *im = [UIImage imageNamed:@"gengduo"];
    _imageMore.image = im;
    _imageMore.frame = CGRectMake(SCREEN_WIDTH - 15*WIDTH_SALE_BASE - im.size.width, 50, im.size.width, im.size.height);
    
    UIImage *im2 = [UIImage imageNamed:@"beautytuoyuan"];
    _imageView2.image = im2;
    _imageView2.frame = CGRectMake(_imageMore.left - 25*WIDTH_SALE_BASE - im2.size.width, 35, im2.size.width, im2.size.height);
    _imageMore.center = CGPointMake(_imageMore.center.x, _imageView2.center.y);
}
- (void)reFreshBeautyCell2:(BeautyHomeUModel *)model{
    
    [_imageView1 yy_setImageWithURL:[NSURL URLWithString:model.pic] placeholder:nil];
    _lb1.text = model.name;
    _lb2.text = @"总负债:";
    _lb3.text = @"月均消耗项目数:";
    _lb4.text = @"月均耗卡单价:";
    _lb5.text = @"月到店次数:";
    
    _lb6.text = [NSString stringWithFormat:@"%.2f元",model.liabilitiesl];
    _lb7.text = [NSString stringWithFormat:@"%.0f个",model.column1];
    _lb8.text = [NSString stringWithFormat:@"%.2f元",model.column2];
    _lb9.text = [NSString stringWithFormat:@"%.1f次",model.column3];
    
    _lb10.text = @"预计消耗周期";
    _lb11.text = [NSString stringWithFormat:@"%ld",model.sum];
    _lb12.text = @"天";
    
    _lb13.text = @"未做处方数：";
    _lb14.text = [NSString stringWithFormat:@"%ld个",model.noNums];
    
    
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_imageView1.right+5, _imageView1.top, _lb2.width, _lb2.height);
    
    
    _lb1.frame =CGRectMake(5, _imageView1.bottom+10, _lb2.left - 5 , _lb2.height*2.5);
//    _lb1.numberOfLines = 2;
//    _lb1.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb2.left, _lb2.bottom+15, _lb3.width, _lb3.height);
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb2.left, _lb3.bottom+10, _lb4.width, _lb4.height);
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.left, _lb4.bottom+8, _lb5.width, _lb5.height);
    _line1.frame = CGRectMake(_lb2.left, _lb5.bottom+8, SCREEN_WIDTH-_lb2.left, 1);
    
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb6.width, _lb6.height);
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb7.width, _lb7.height);
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb8.width, _lb8.height);
    [_lb9 sizeToFit];
    _lb9.frame = CGRectMake(_lb5.right+5, _lb5.top, _lb9.width, _lb9.height);
    
    [_lb10 sizeToFit];
    _lb10.frame = CGRectMake(_lb6.right+5, 16, _lb10.width, _lb10.height);
    _lb10.center = CGPointMake(_imageView2.center.x, _lb10.center.y);
    
    [_lb11 sizeToFit];
    _lb11.frame = CGRectMake(0, 0, _lb11.width, _lb11.height);
    _lb11.center = CGPointMake(_imageView2.center.x -5, _imageView2.center.y);
    
    [_lb12 sizeToFit];
    _lb12.frame = CGRectMake(_lb11.right+3, _lb11.bottom - _lb12.height, _lb12.width, _lb12.height);
    
    _line2.frame = CGRectMake(0, _line1.bottom+40, SCREEN_WIDTH, 10);
    
    [_lb13 sizeToFit];
    _lb13.frame = CGRectMake(_lb2.left, _line1.bottom+10, _lb13.width, _lb13.height);
    [_lb14 sizeToFit];
    _lb14.frame = CGRectMake(_lb13.right+5, _lb13.top, _lb14.width, _lb14.height);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
