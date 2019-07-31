//
//  FWInputView.h
//  FWInputViewDemo
//
//  Created by KFW on 2019/1/28.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kTextViewHeight;
UIKIT_EXTERN CGFloat const inputTopBottonGap;
UIKIT_EXTERN CGFloat const kFWInputViewHeight;

NS_ASSUME_NONNULL_BEGIN

@interface FWInputView : UIView
/** <##> */
@property (nonatomic, copy) NSString *placeholder;

- (void)remove;
@end

NS_ASSUME_NONNULL_END
