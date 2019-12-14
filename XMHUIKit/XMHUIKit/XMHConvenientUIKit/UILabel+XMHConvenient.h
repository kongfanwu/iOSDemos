//
//  UILabel+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XMHConvenient)

- (UILabel *(^)(NSString *))xmhText;
- (UILabel *(^)(UIColor *))xmhTextColor;
- (UILabel *(^)(UIFont *))xmhFont;
- (UILabel *(^)(NSTextAlignment))xmhTextAlignment;

@end

NS_ASSUME_NONNULL_END
