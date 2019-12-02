//
//  RestrictionInput.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/11/23.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestrictionInput : NSObject
+ (void)restrictionInputTextField:(UITextField *)inputClass maxNumber:(NSInteger)maxNumber showView:(UIView *)showView showErrorMessage:(NSString *)errorMessage;
+ (void)restrictionInputTextView:(UITextView *)inputClass maxNumber:(NSInteger)maxNumber showView:(UIView *)showView showErrorMessage:(NSString *)errorMessage;
+ (BOOL)isInputRuleNotBlank:(NSString *)str;
+ (BOOL)isInputRuleAndBlank:(NSString *)str;

@end
