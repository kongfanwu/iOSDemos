//
//  BeautyFourDownView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyFourDownView.h"

@implementation BeautyFourDownView{
    UIImage *_image1;
    UIImage *_image2;
    UIImage *_image3;
    NSString *_jiangeStr;
    NSString *_weekStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    _image1 = [UIImage imageNamed:@"beautyweixuanzhong"];
    _image2 = [UIImage imageNamed:@"beautyxuanzhong"];
    
    _image3 = [UIImage imageNamed:@"gengduo"];
    
    _line1.backgroundColor = kBackgroundColor;
    _line2.backgroundColor = kBackgroundColor;
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(15);
    
    _lb3.textColor = kLabelText_Commen_Color_9;
    _lb3.font = FONT_SIZE(15);
    _lb3.textAlignment = NSTextAlignmentRight;
    _lb4.textColor = kLabelText_Commen_Color_9;
    _lb4.font = FONT_SIZE(15);
    _lb4.textAlignment = NSTextAlignmentRight;
    
    _im1.image = _image1;
    _im2.image = _image1;
    _im3.image = _image3;
    _im4.image = _image3;
    
    _im5.backgroundColor = kBackgroundColor;

    _lb5.textColor = kLabelText_Commen_Color_3;
    _lb5.font = FONT_BOLD_SIZE(14);
    _lb6.textColor = kLabelText_Commen_Color_3;
    _lb6.font = FONT_BOLD_SIZE(14);
    _lb7.textColor = kLabelText_Commen_Color_3;
    _lb7.font = FONT_BOLD_SIZE(14);
    _lb8.textColor = kLabelText_Commen_Color_3;
    _lb8.font = FONT_BOLD_SIZE(14);
    _lb9.textColor = kLabelText_Commen_Color_3;
    _lb9.font = FONT_BOLD_SIZE(14);
    _lb10.textColor = kLabelText_Commen_Color_3;
    _lb10.font = FONT_BOLD_SIZE(14);
    _lb11.textColor = kLabelText_Commen_Color_3;
    _lb11.font = FONT_BOLD_SIZE(14);
    _lb12.textColor = kLabelText_Commen_Color_3;
    _lb12.font = FONT_BOLD_SIZE(14);

    _line3.backgroundColor = kBackgroundColor;
    _line4.backgroundColor = kBackgroundColor;

    _lb13.textColor = kLabelText_Commen_Color_3;
    _lb13.font = FONT_SIZE(15);
    _lb14.textColor = kLabelText_Commen_Color_3;
    _lb14.font = FONT_SIZE(15);
    
    _lb15.textColor = kLabelText_Commen_Color_9;
    _lb15.font = FONT_SIZE(15);
    _lb15.textAlignment = NSTextAlignmentRight;
    _text1.font = FONT_SIZE(15);
    _im6.image = _image3;
    
    _jiangeStr = nil;
    _weekStr = nil;
}
- (void)reFreshBeautyFourDownViewXiangmu:(NSInteger)xiangmuNum daodianNum:(NSInteger)daodianNum zhouqi:(NSInteger)zhouqi jinge:(CGFloat)jine{
    _line1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
    _im1.frame = CGRectMake(15, (44-15)/2.0, 15, 15);
    _lb1.text = @"按间隔";
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_im1.right+10, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    
    _btn1.frame = CGRectMake(0, _line1.bottom, SCREEN_WIDTH, 43);
    
    _line2.frame = CGRectMake(0, 44, SCREEN_WIDTH, 1);
    _im2.frame = CGRectMake(15,_line2.bottom + (44-15)/2.0, 15, 15);
    _lb2.text = @"按星期";
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_im2.right+10,_line2.bottom + (44-_lb2.height)/2.0, _lb2.width, _lb2.height);
    
    _btn2.frame = CGRectMake(0, _line2.bottom, SCREEN_WIDTH, 43);
    
    _im3.frame = CGRectMake(SCREEN_WIDTH - 15 - _image3.size.width, (44-_image3.size.height)/2.0, _image3.size.width, _image3.size.height);
    
    _lb3.text = _jiangeStr?_jiangeStr:@"请选择";
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_im3.left - 10 -150, (44-_lb3.height)/2.0, 150, _lb3.height);
    
    _im4.frame = CGRectMake(SCREEN_WIDTH - 15 - _image3.size.width,_line2.bottom + (44-_image3.size.height)/2.0, _image3.size.width, _image3.size.height);
    _lb4.text = _weekStr?_weekStr:@"请选择";
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_im4.left - 10 -150,_line2.bottom + (44-_lb4.height)/2.0, 150, _lb4.height);
    
    _im5.frame = CGRectMake(0, 89, SCREEN_WIDTH, 10);
    _lb5.text = @"规划总项目数:";
    [_lb5 sizeToFit];
    _lb5.frame =CGRectMake(15,_im5.bottom + (44-_lb5.height)/2.0, _lb5.width, _lb5.height);
    
    _lb6.text = @"规划处方周期:";
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(15,_lb5.bottom + (44-_lb6.height)/2.0, _lb6.width, _lb6.height);
    
    _lb7.text = [NSString stringWithFormat:@"%@个",@(xiangmuNum)];
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb5.right + 5,_im5.bottom + (44-_lb7.height)/2.0, _lb7.width, _lb7.height);
    if (daodianNum == 1) {
        _lb8.text = [NSString stringWithFormat:@"%@天",@(1)];
    } else {
        _lb8.text = [NSString stringWithFormat:@"%@天",@(zhouqi)];
    }
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb6.right + 5,_lb7.bottom + (44-_lb8.height)/2.0, _lb8.width, _lb8.height);
    
    _lb9.text = @"规划到店数:";
    [_lb9 sizeToFit];
    _lb9.frame =CGRectMake(SCREEN_WIDTH/2.0+15,_im5.bottom + (44-_lb9.height)/2.0, _lb9.width, _lb9.height);
    
    _lb10.text = @"规划总金额:";
    [_lb10 sizeToFit];
    _lb10.frame =CGRectMake(_lb9.left,_lb9.bottom + (44-_lb10.height)/2.0, _lb10.width, _lb10.height);
    
    _lb11.text = [NSString stringWithFormat:@"%@次",@(daodianNum)];
    [_lb11 sizeToFit];
    _lb11.frame =CGRectMake(_lb9.right + 5,_im5.bottom + (44-_lb11.height)/2.0, _lb11.width, _lb11.height);
    
    _lb12.text = [NSString stringWithFormat:@"%.2f元",jine];
    [_lb12 sizeToFit];
    _lb12.frame =CGRectMake(_lb10.right + 5,_lb11.bottom + (44-_lb12.height)/2.0, _lb12.width, _lb12.height);
    
    _line3.frame = CGRectMake(0, _lb6.bottom+15, SCREEN_WIDTH, 1);
    
    _lb13.text = @"服务管家";
    [_lb13 sizeToFit];
    _lb13.frame =CGRectMake(15,_line3.bottom + (44-_lb13.height)/2.0, _lb13.width, _lb13.height);
    
    _btn3.frame = CGRectMake(0, _line3.bottom, SCREEN_WIDTH, 43);
    
    _line4.frame = CGRectMake(0, _line3.bottom+44, SCREEN_WIDTH, 1);

    _lb14.text = @"设置处方名称";
    [_lb14 sizeToFit];
    _lb14.frame =CGRectMake(15,_line4.bottom + (44-_lb14.height)/2.0, _lb14.width, _lb14.height);
    
    _im6.frame = CGRectMake(SCREEN_WIDTH - 15 - _image3.size.width,_line3.bottom + (44-_image3.size.height)/2.0, _image3.size.width, _image3.size.height);
    
    _lb15.text = @"选择美容师";
    [_lb15 sizeToFit];
    _lb15.frame =CGRectMake(_im6.left - 10 -150,_line3.bottom + (44-_lb15.height)/2.0, 150, _lb15.height);
    
    _text1.placeholder = @"请输入处方名称";
    _text1.frame =CGRectMake(_im6.left - 10 -150,_line4.bottom + (44-35)/2.0, 150, 35);
    
    
    if ([_lb4.text isEqualToString:@"请选择"]) {
        _lb4.textColor = kColorC;
    }else{
        _lb4.textColor = kColor3;
    }
    if ([_lb3.text isEqualToString:@"请选择"]) {
        _lb3.textColor = kColorC;
    }else{
        _lb3.textColor = kColor3;
    }
}
- (void)reFreshBeautyFourDownViewJianGe:(NSString *)str{
    
    _lb3.text = str;
    _lb3.textColor = kLabelText_Commen_Color_3;
    _jiangeStr = str;
    _weekStr = nil;
    if (!str) {
        _lb3.text = @"请选择";
    }
    if ([_lb3.text isEqualToString:@"请选择"]) {
        _lb3.textColor = kColorC;
    }else{
        _lb3.textColor = kColor3;
    }
}
- (void)reFreshBeautyFourDownViewWeek:(NSString *)str{
    _lb4.text = str;
    _lb4.textColor = kLabelText_Commen_Color_3;
    _weekStr = str;
    _jiangeStr = nil;
    if (!str) {
        _lb4.text = @"请选择";
    }
    if ([_lb4.text isEqualToString:@"请选择"]) {
        _lb4.textColor = kColorC;
    }else{
        _lb4.textColor = kColor3;
    }
}
- (void)reFreshBeautyFourDownViewJishi:(NSString *)str{
    _lb15.text = str;
    _lb15.textColor = kLabelText_Commen_Color_3;
}
- (void)reFreshCricle:(UIButton *)sender{
   
    switch (sender.tag) {
        case 1000:
            {
                _im1.image = _image2;
                _im2.image = _image1;
            }
            break;
        case 1001:
        {
            _im1.image = _image1;
            _im2.image = _image2;
        }
            break;
        default:
            break;
    }
    if (!sender) {
        _im1.image = _image1;
        _im2.image = _image1;
    }
}
@end
