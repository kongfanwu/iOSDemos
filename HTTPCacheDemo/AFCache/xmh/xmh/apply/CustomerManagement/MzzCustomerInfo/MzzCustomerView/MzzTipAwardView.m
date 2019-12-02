//
//  MzzTipAwardView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTipAwardView.h"

@interface MzzTipAwardView ()


@end
@implementation MzzTipAwardView
- (IBAction)jian:(id)sender {
    NSInteger count =  _jiangzengshuliang.text.integerValue ;
    if (count == 0) {
        return;
    }
    count --;
     _jiangzengshuliang.text = [NSString stringWithFormat:@"%ld",count];
}
- (IBAction)jia:(id)sender {
   
    NSInteger count =  _jiangzengshuliang.text.integerValue ;
    count ++;
    _jiangzengshuliang.text = [NSString stringWithFormat:@"%ld",count];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    _quxiao.layer.borderColor = [UIColor blackColor].CGColor;
    _quxiao.layer.borderWidth = 1;
    _tianjia.layer.borderColor = [UIColor blackColor].CGColor;
     _tianjia.layer.borderWidth = 1;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
@end
