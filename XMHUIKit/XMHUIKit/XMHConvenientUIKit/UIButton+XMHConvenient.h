//
//  UIButton+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

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

@end

NS_ASSUME_NONNULL_END
