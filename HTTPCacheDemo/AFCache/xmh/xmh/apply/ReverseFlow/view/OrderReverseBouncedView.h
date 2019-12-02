//
//  OrderReverseBouncedView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/13.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReverseBouncedView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (void)refreashViewTitle:(NSString *)title left:(NSString *)left right:(NSString *)right;

@end
