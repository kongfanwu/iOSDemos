//
//  BeautyJianGeWeakCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/21.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyJianGeWeakCell.h"

@implementation BeautyJianGeWeakCell{
    UIImage *_image1;
    UIImage *_image2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    _image1 = [UIImage imageNamed:@"beautyweixuanzhong"];
    _image2 = [UIImage imageNamed:@"beautyxuanzhong"];
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(15);
}
- (void)refreshBeautyJianGeWeakCell:(NSString *)str;{
    _im1.image = _image1;
    _im1.frame = CGRectMake(15, (44-15)/2.0, 15, 15);
    _lb1.text = str;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_im1.right+15, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    _lb2.hidden = YES;
}
- (void)reFreshBeautyChoicejishiCell:(BeautyChoiseJishiList *)model{
    _im1.image = _image1;
    _im1.frame = CGRectMake(15, (44-15)/2.0, 15, 15);
    _lb1.text = model.name;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_im1.right+15, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    _lb2.hidden = NO;
    
    _lb2.text = model.phone;
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(SCREEN_WIDTH-124-_lb2.width, (44-_lb2.height)/2.0, _lb2.width, _lb2.height);
}
- (void)refreshWorkChoiceCell:(NSString *)str{
    _im1.hidden = YES;
    _lb1.hidden = NO;
    _lb1.text = str;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake((SCREEN_WIDTH-_lb1.width)/2.0, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    _lb2.hidden = YES;
}
- (void)refreshBeautyJianGeWeakCellWithSelect:(BOOL)isSelect{
    if (isSelect) {
        _im1.image = _image2;
    }else{
        _im1.image = _image1;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
