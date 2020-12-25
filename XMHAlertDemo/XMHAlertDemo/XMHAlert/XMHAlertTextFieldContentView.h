//
//  XMHAlertTextFieldContentView.h
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/24.
//

#import <UIKit/UIKit.h>
#import "XMHAlertContentViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHAlertTextFieldContentView : UIView <XMHAlertContentViewProtocol>
@property (nonatomic, strong, readonly) UITextField *textField;
@end

NS_ASSUME_NONNULL_END
