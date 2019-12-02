//
//  XMHFormValidator.h
//  AFNetworking
//
//  Created by KFW on 2019/5/30.
// 数据校验类

#import <UIKit/UIKit.h>
#import "XLFormValidatorProtocol.h"

NS_ASSUME_NONNULL_BEGIN
typedef XLFormValidationStatus * _Nullable (^ValidBlock)(XLFormRowDescriptor * _Nullable row);


@interface XMHFormValidator : NSObject <XLFormValidatorProtocol>

/** 数据校验block */
@property (nonatomic, copy) ValidBlock isValidBlock;

+ (instancetype)formValidatorValidBlock:(ValidBlock)isValidBlock;

@end

NS_ASSUME_NONNULL_END
