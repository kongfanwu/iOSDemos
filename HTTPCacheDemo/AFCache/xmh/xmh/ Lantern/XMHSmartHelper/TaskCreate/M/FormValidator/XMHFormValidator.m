//
//  XMHFormValidator.m
//  AFNetworking
//
//  Created by KFW on 2019/5/30.
//

#import "XMHFormValidator.h"

@implementation XMHFormValidator

+ (instancetype)formValidatorValidBlock:(ValidBlock)isValidBlock {
    XMHFormValidator *formValidator = XMHFormValidator.new;
    formValidator.isValidBlock = isValidBlock;
    return formValidator;
}

#pragma mark - XLFormValidatorProtocol

-(XLFormValidationStatus *)isValid:(XLFormRowDescriptor *)row {
    if (!self.isValidBlock) return [XLFormValidationStatus formValidationStatusWithMsg:nil status:NO rowDescriptor:row];
    return self.isValidBlock(row);
}

@end
