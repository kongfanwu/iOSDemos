//
//  XMHFormEndTypeAlertVC.m
//  xmh
//
//  Created by kfw on 2019/6/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormEndTypeAlertVC.h"

@interface XMHFormEndTypeAlertVC ()
@property (weak, nonatomic) IBOutlet UIButton *trackButton;
@property (weak, nonatomic) IBOutlet UIButton *xiaoFeiButton;
@property (weak, nonatomic) IBOutlet UIButton *xiaoHaoButton;
/** <##> */
@property (nonatomic, strong) UIButton *selectButton;
/** <##> */
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation XMHFormEndTypeAlertVC
- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.buttons = NSMutableArray.new;
    [self.buttons addObject:_trackButton];
    [self.buttons addObject:_xiaoFeiButton];
    [self.buttons addObject:_xiaoHaoButton];
    
    [_buttons enumerateObjectsUsingBlock:^(UIButton *  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.tag = idx + 1;
        [btn setBackgroundImage:[UIImage imageWithColor:kColorFFF3F0 size:CGSizeMake(5, 5)] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:kColorF5F5F5 size:CGSizeMake(5, 5)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kColorF5F5F5 size:CGSizeMake(5, 5)] forState:UIControlStateHighlighted];
    }];
    
    [self btnClick:_buttons.firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (IBAction)btnClick:(UIButton *)sender {
    
    [_buttons enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.borderWidth = 0;
        obj.selected = NO;
    }];
    
    sender.layer.borderWidth = kBorderWidth;
    sender.layer.borderColor = kColorFF9072.CGColor;
    sender.selected = YES;
    
    self.selectButton = sender;
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)submitClick:(UIButton *)sender {
    if (self.didFinishBlock) self.didFinishBlock(@(self.selectButton.tag).stringValue);
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
