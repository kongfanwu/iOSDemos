//
//  XMHXLFormDescriptor.m
//  xmh
//
//  Created by kfw on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHXLFormDescriptor.h"

@implementation XMHXLFormDescriptor

-(NSDictionary *)httpParameters:(XLFormViewController *)formViewController
{
    NSMutableDictionary * result = [NSMutableDictionary dictionary];
    for (XLFormSectionDescriptor * section in self.formSections) {
        if (section.multivaluedTag.length > 0) {
            NSMutableDictionary *multiValuedValuesDic = NSMutableDictionary.new;
            [result setObject:multiValuedValuesDic forKey:section.multivaluedTag];
            
            for (XLFormRowDescriptor * row in section.formRows) {
                NSString *httpParameterKey = nil;
                if ((httpParameterKey = [self httpParameterKeyForRow:row cell:[row cellForFormController:formViewController]])) {
                    id parameterValue = [row.value valueData] ?: [NSNull null];
                    [multiValuedValuesDic setObject:parameterValue forKey:httpParameterKey];
                }
            }
        }
        else {
            for (XLFormRowDescriptor * row in section.formRows) {
                NSString *httpParameterKey = nil;
                if ((httpParameterKey = [self httpParameterKeyForRow:row cell:[row cellForFormController:formViewController]])) {
                    id parameterValue = [row.value valueData] ?: [NSNull null];
                    [result setObject:parameterValue forKey:httpParameterKey];
                }
            }
        }
    }
    
    return result;
}

-(NSString *)httpParameterKeyForRow:(XLFormRowDescriptor *)row cell:(UITableViewCell<XLFormDescriptorCell> *)descriptorCell
{
    NSString *result = nil;
    
    if ([descriptorCell respondsToSelector:@selector(formDescriptorHttpParameterName)]) {
        result = [descriptorCell formDescriptorHttpParameterName];
    }
    else if (row.tag.length > 0) {
        result = row.tag;
    }
    
    return result;
}

@end
