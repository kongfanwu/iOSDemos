//
//  ViewController.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "ViewController.h"
#import "XMHConvenientUIKit.h"
#import "Masonry.h"

@interface ViewController () <UITextFieldDelegate>
/** <##> */
@property (nonatomic, strong) UILabel *la;
/** <##> */
@property (nonatomic, strong) UIButton *button;
/** UIImageView */
@property (nonatomic, strong) UIImageView *imageView;
/** <##> */
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.la = UILabel
    .xmhNewAndSuperView(self.view)
    .xmhText(@"234567")
    .xmhFont([UIFont systemFontOfSize:14])
    .xmhTextColor(UIColor.redColor)
    .xmhTextAlignment(NSTextAlignmentCenter)
    .xmhBackgroundColor(UIColor.blueColor)
    .xmhCornerRadius(10)
    .xmhBorderWidth(2)
    .xmhBorderColor(UIColor.cyanColor)
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(200, 44));
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(100);
    });

    self.button = UIButton
    .xmhNewAndSuperView(self.view)
    .xmhSetTitleAndState(@"title", UIControlStateNormal)
    .xmhSetTitlColorAndState(UIColor.redColor, UIControlStateNormal)
    .xmhSetBackgroundImageAndState([UIImage imageNamed:@"1"], UIControlStateNormal)
    .xmhTitleLabel(^(UILabel *titleLabel){
        titleLabel.xmhFont([UIFont systemFontOfSize:30]);
    })
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(200, 80));
        make.top.equalTo(self.la.mas_bottom);
        make.centerX.equalTo(self.view);
    })
    .xmhAddEvent(UIControlEventTouchUpInside, ^(UIButton *sender){
        NSLog(@"UIControlEventTouchUpInside");
    });
    
    self.imageView = UIImageView
    .xmhNewAndSuperView(self.view)
    .xmhImage([UIImage imageNamed:@"1"])
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.equalTo(self.button.mas_bottom);
        make.centerX.equalTo(self.view);
    });
    
    self.textField = UITextField
    .xmhNewAndSuperView(self.view)
    .xmhText(@"text")
    .xmhPlaceholder(@"place")
    .xmhDelegate(self)
    .xmhBackgroundColor(UIColor.orangeColor)
    
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.top.equalTo(self.imageView.mas_bottom);
        make.centerX.equalTo(self.view);
    });
    
    
    
}



@end
