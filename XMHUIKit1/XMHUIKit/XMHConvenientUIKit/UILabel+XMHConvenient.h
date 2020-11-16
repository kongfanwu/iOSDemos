//
//  UILabel+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

/*
 self.la = UILabel
 .xmhNewAndSuperView(self.view)
 .xmhTextAndTextColorAndFont(@"234567", UIColor.redColor, [UIFont systemFontOfSize:14])
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
 */

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XMHConvenient)

- (UILabel *(^)(NSString *))xmhText;
- (UILabel *(^)(UIColor *))xmhTextColor;
- (UILabel *(^)(UIFont *))xmhFont;
- (UILabel *(^)(NSTextAlignment))xmhTextAlignment;
- (UILabel *(^)(NSString *, UIColor *, UIFont *))xmhTextAndTextColorAndFont;

@end

NS_ASSUME_NONNULL_END
