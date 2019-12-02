//
//  UITextView+XMHPlaceholder.h
//  test
//
//  Created by KFW on 2019/3/29.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (XMHPlaceholder)

/** <##> */
@property (nonatomic, strong) UILabel *xmhPlaceholder;
/** <##> */
@property (nonatomic, strong) UIColor *xmhPlaceholderColor;

- (void)xmhAddPlaceholder:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
