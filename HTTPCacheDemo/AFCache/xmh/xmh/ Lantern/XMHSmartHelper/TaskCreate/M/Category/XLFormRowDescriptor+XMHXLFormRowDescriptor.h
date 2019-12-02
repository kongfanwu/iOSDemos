//
//  XLFormRowDescriptor+XMHXLFormRowDescriptor.h
//  xmh
//
//  Created by kfw on 2019/6/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <XLForm/XLForm.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLFormRowDescriptor (XMHXLFormRowDescriptor)

/** 转换实例 */
@property (nonatomic, strong) NSValueTransformer *valueTransformerInstance;

/**
 返回转换后的text
 
 @return text
 */
- (NSString *)valueTransformerDisplayText;

@end

NS_ASSUME_NONNULL_END
