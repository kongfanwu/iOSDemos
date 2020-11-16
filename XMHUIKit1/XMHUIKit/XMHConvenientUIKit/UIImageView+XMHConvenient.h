//
//  UIImageView+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//
/*
 self.imageView = UIImageView
 .xmhNewAndSuperView(self.view)
 .xmhImage([UIImage imageNamed:@"1"])
 .xmhMakeConstraints(^(MASConstraintMaker * make){
     make.size.mas_equalTo(CGSizeMake(100, 100));
     make.top.equalTo(self.button.mas_bottom);
     make.centerX.equalTo(self.view);
 });
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (XMHConvenient)

- (UIImageView *(^)(UIImage *))xmhImage;
- (UIImageView *(^)(UIImage *))xmhHighlightedImage;
- (UIImageView *(^)(BOOL))xmhUserInteractionEnabled;
- (UIImageView *(^)(BOOL))xmhHighlighted;

@end

NS_ASSUME_NONNULL_END
