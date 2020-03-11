//
//  FTFormVC.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FTForm;

NS_ASSUME_NONNULL_BEGIN

@interface FTFormVC : UITableViewController <FTFormVCProtocol>
@property (nonatomic, strong) FTForm *form;

/**
 获取表单数据
 
 @return 字典
 */
- (NSDictionary *)getFormParam;

/**
 校验表单
 
 @return 校验失败集合
 */
- (NSArray <FTFormParamVerifyResult *> *)paramVerify;

#pragma mark - FTFormVCProtocol

- (void)rowValueDidChangeRow:(FTFormRow *)row newValue:(id)newValue oldValue:(id)oldValue;
@end

NS_ASSUME_NONNULL_END
