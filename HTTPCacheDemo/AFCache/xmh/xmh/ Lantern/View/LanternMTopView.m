//
//  LanternMTopView.m
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMTopView.h"
@interface LanternMTopView ()
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@end
@implementation LanternMTopView
{
    NSArray * _lbs;
    NSArray * _imgs;
    NSInteger  _index;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    _lbs = @[_lb1,_lb2,_lb3,_lb4];
    _imgs = @[_img1,_img2,_img3,_img4];
    
    UITapGestureRecognizer * tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_view0 addGestureRecognizer:tap0];
    [_view1 addGestureRecognizer:tap1];
    [_view2 addGestureRecognizer:tap2];
    [_view3 addGestureRecognizer:tap3];
    
}
- (void)updateLanternMTopViewIndex:(NSInteger)index
{
    for (int i = 0; i < _lbs.count; i++) {
        UILabel *lb = _lbs[i];
        if (i == index) {
            lb.textColor = kColorTheme;
        }else{
            lb.textColor = kColor6;
        }
    }
    for (NSInteger i = 0; i < _imgs.count; i++) {
        UIImageView *imgv = _imgs[i];
        if (i == index) {
            NSString * str = [NSString stringWithFormat:@"zhinengjiansuo_%ldsel",index];
            imgv.image = UIImageName(str);
        }else{
            NSString * str = [NSString stringWithFormat:@"zhinengjiansuo_%ld",i];
            imgv.image = UIImageName(str);
        }
        
    }
    _index = index;
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    if (_LanternMTopViewBlock) {
        _LanternMTopViewBlock(tap.view.tag - 800);
    }
    [self updateLanternMTopViewIndex:tap.view.tag - 800];
}
@end
