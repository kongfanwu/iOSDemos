//
//  XMHFormTaskCreateBaseVC.h
//  xmh
//
//  Created by kfw on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <XLForm/XLForm.h>
#import "LNavView.h"
#import "XLFormAction+XMHXLFormAction.h"

// 创建
typedef NS_ENUM(NSInteger, XMHFormTaskBottomViewState) {
    XMHFormTaskBottomViewStateSave, // 保存
    XMHFormTaskBottomViewStateDelete, // 删除
};

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormTaskCreateBaseVC : XLFormViewController
/** default XMHFormTaskCreateVCTypeCreate */
@property (nonatomic) XMHFormTaskCreateVCType type;

/** <##> */
@property (nonatomic, strong, nullable) UIView *bottomView;
/** <##> */
@property (nonatomic, strong) UIButton *saveButton, *deleteButton;
/** default XMHFormTaskBottomViewStateSave */
@property (nonatomic) XMHFormTaskBottomViewState bottomViewState;
@property (nonatomic, strong) LNavView * navView;
/** <##> */
@property (nonatomic) CGPoint contentOffset;
/**
 根据tag搜索表单section
 
 @param tag section tag
 @param block secton：XLFormSectionDescriptor index:索引
 @return XLFormSectionDescriptor
 */
- (XLFormSectionDescriptor *)searchSectionTag:(NSString *)tag block:(nullable void(^)(XLFormSectionDescriptor *section, NSUInteger index))block;

/**
 表单校验
 
 @return YES：通过 NO：未通过
 */
- (BOOL)formValidation;
@end

NS_ASSUME_NONNULL_END
