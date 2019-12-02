//
//  XMHFormTaskBaseCell.h
//  xmh
//
//  Created by kfw on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
/*
 注意： 自定义的子类命名方式需遵循以下规则 // XMHForm***
 
 -(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller 方法有特殊处理 
 */

#import <XLForm/XLForm.h>
#import "XMHFormTaskNextVCProtocol.h"
#import "XLFormAction+XMHXLFormAction.h"
#import "XMHTaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormTaskBaseCell : XLFormBaseCell <UIPopoverPresentationControllerDelegate>
/* 最大输入字符限制，默认NSIntegerMax。 使用 XMHFormTaskInputCellTextFieldMaxNumberOfCharacters KVO */
@property (nonatomic, copy) NSNumber *textFieldMaxNumberOfCharacters;

@end

NS_ASSUME_NONNULL_END
