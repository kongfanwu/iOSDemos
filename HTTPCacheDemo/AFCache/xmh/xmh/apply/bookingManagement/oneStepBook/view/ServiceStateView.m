//
//  ServiceStateView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ServiceStateView.h"

@implementation ServiceStateView{
    
    NSArray * _colors;
    NSArray * _titles;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _colors = @[[ColorTools colorWithHexString:@"#cccccc"],[ColorTools colorWithHexString:@"#333333"],[ColorTools colorWithHexString:@"#ffc555"],[ColorTools colorWithHexString:@"#48c2af"]];
        _titles = @[@"休息",@"可预约",@"服务中",@"已预约"];
        
        [self initSubViews];
        
    }
    return self;
}
- (void)initSubViews{
    
    NSInteger count = 4;
    
    for (int i = 0; i< count; i ++) {
        
        UILabel * lb1 = [[UILabel alloc] init];
        lb1.frame = CGRectMake(15 + (72 + 13) *i , (self.height - 13)/2 , 13, 13);
        lb1.layer.cornerRadius = 6.5;
        lb1.layer.masksToBounds = YES;
        if (i!=1) {
          lb1.backgroundColor = _colors[i];
        }else{
            lb1.layer.borderColor =((UIColor* )_colors[i]).CGColor;
            lb1.layer.borderWidth = 1;
        }
        
        [self addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc] init];
        lb2.text = _titles[i];
        lb2.font = FONT_SIZE(14);
        lb2.textColor = kLabelText_Commen_Color_3;
        [lb2 sizeToFit];
        lb2.frame = CGRectMake(lb1.right + 7, (self.height - lb2.height)/2, lb2.width, lb2.height);
        [self addSubview:lb2];
    }
}
@end
