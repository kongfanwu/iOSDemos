//
//  UIButton+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//
/*
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
 
 self.button = UIButton
 .xmhNewAndSuperView(self.view)
 .xmhSetTitleAndColorAndFontAndState(@"title", UIColor.redColor, [UIFont systemFontOfSize:30], UIControlStateNormal)
 .xmhSetBackgroundImageAndState([UIImage imageNamed:@"1"], UIControlStateNormal)
 .xmhMakeConstraints(^(MASConstraintMaker * make){
     make.size.mas_equalTo(CGSizeMake(200, 80));
     make.top.equalTo(self.la.mas_bottom);
     make.centerX.equalTo(self.view);
 })
 .xmhAddEvent(UIControlEventTouchUpInside, ^(UIButton *sender){
     NSLog(@"UIControlEventTouchUpInside");
 });
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XMHConvenient)

- (UIButton *(^)(NSString *, UIControlState))xmhSetTitleAndState;
- (UIButton *(^)(NSAttributedString *, UIControlState))xmhSetAttributedTitleAndState;
- (UIButton *(^)(UIColor *, UIControlState))xmhSetTitlColorAndState;
- (UIButton *(^)(UIImage *, UIControlState))xmhSetImageAndState;
- (UIButton *(^)(UIImage *, UIControlState))xmhSetBackgroundImageAndState;
- (UIButton *(^)(void(^)(UILabel *)))xmhTitleLabel;
- (UIButton *(^)(void(^)(UIImageView *)))xmhImageView;
- (UIButton *(^)(NSString *, UIColor *, UIFont *, UIControlState state))xmhSetTitleAndColorAndFontAndState;

@end

NS_ASSUME_NONNULL_END
