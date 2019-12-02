//
//  LNoticeView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNoticeView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnGuanBi;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSubTitle;
@property (weak, nonatomic) IBOutlet UITextField *tf;
- (void)refreashViewTitle:(NSString *)title content:(NSString *)content left:(NSString *)left right:(NSString *)right input:(NSString *)input;
@end
