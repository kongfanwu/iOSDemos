//
//  FTFormRow.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FTFormSection, FTFormAction, FTFormBaseCell, FTFormUniversalConversion, FTFormParamVerify;


NS_ASSUME_NONNULL_BEGIN

@interface FTFormRow : NSObject

/** <##> */
@property (nonatomic, weak) FTFormSection *formSection;
/** 是否必填 默认 NO 如果为YES 必须实现 verify 属性 verifyBlock*/
@property (nonatomic) BOOL requeit;
/** 是否可编辑 默认 YES 可编辑 */
@property (nonatomic, strong) id enable;
/** 获取是否可编辑状态 */
@property (nonatomic, readonly) BOOL isEnable;
/** 是否隐藏 */
@property (nonatomic, strong) id hidden;
/** 获取是否隐藏状态 */
@property (nonatomic, readonly) BOOL isHiden;
/** <##> */
@property (nonatomic, strong) NSString *tag;
/** <##> */
@property (nonatomic, strong) NSString *title;
/** <##> */
@property (nonatomic, strong) id value;
/** 检查按钮的个数 */
@property (nonatomic, strong) id buttonCheck;
/** <##> */
@property (nonatomic, strong) NSArray *dataArray;
/** cell 类名 */
@property (nonatomic, copy) NSString *cellClass;
///** cell 样式 默认 UITableViewCellStyleDefault */
//@property (nonatomic, assign) UITableViewCellStyle cellStyle;
/** 是否显示分割线 默认 NO */
@property (nonatomic) BOOL separatorHidden;
/** cell */
@property (nonatomic, weak) FTFormBaseCell *cell;
/** 事件处理类 */
@property (nonatomic, strong) FTFormAction *action;
/** 通用转换器 */
@property (nonatomic, strong) FTFormUniversalConversion *universalConversion;
/** 表单校验 */
@property (nonatomic, strong) FTFormParamVerify *paramVerify;
@end

NS_ASSUME_NONNULL_END
