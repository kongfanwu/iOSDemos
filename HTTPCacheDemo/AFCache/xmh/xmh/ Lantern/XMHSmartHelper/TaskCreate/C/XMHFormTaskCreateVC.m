//
//  XMHFormTaskCreateVC.m
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//
/*
 情况：1 解决。 选完天，没选追踪方式、保存，又选其他天，移除选中天的数据（保存后 self.currentDateModel 为 nil）
 情况：2 解决。 都配置完，切换了追踪时间、规则。移除所有配置数据，UI默认， 日历cell根据【追踪时间】，【追踪方式】默认【消息】
 情况：3 解决。每次相同。天设置追踪完成后。其他的天，所有追踪数据都设置显示一样
 */

#import "XMHFormTaskCreateVC.h"
#import "XMHFormTaskDataCreateManager.h"
#import "XMHFormRowDescriptor.h"
#import "XMHXLFormDescriptor.h"
#import "UIImage+Reduce.h"
#import "XMHFormSelectTestVC.h"
#import "XMHFormTrackUserTransformer.h"
#import "XMHFormSelectAlertTestVC.h"
#import "XMHFormSendDateTransformer.h"
#import "XMHFormValidator.h"
#import "NSDate-Helper.h"
#import "XMHFormEndTypeAlertVC.h"
#import "XMHFormTaskCalendarBaseCell.h"
#import "XMHTraceSelectCustomerVC.h"
#import "XMHTraceSelectDiscountCouponVC.h"
#import "XMHTaskCreateDatePickVC.h"
#import "XMHFormTrackCouponTransformer.h"

@interface XMHFormTaskCreateVC ()
/** 选择的多天或多月集合 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, XMHTrackDayMonthModel *> *dateDic;
/** 当前创建日期model */
@property (nonatomic, strong) XMHTrackDayMonthModel *currentDateModel;
/** 上次保存日期model */
@property (nonatomic, strong) XMHTrackDayMonthModel *lastDateMdoel;
/** 日常任务mdoel */
@property (nonatomic, strong) XMHTaskModel *taskModel;

@end

@implementation XMHFormTaskCreateVC

- (NSMutableDictionary *)dateDic {
    if (_dateDic) return _dateDic;
    _dateDic = NSMutableDictionary.new;
    return _dateDic;
}

- (void)setCurrentDateModel:(XMHTrackDayMonthModel *)currentDateModel {
    _currentDateModel = currentDateModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == XMHFormTaskCreateVCTypeSystemEdit && !IsEmpty(_taskID)) {
        [self getData];
    } else {
        [self initializeFormTaskMdoel:nil];
    }
}

- (void)getData {
    if (IsEmpty(_taskID)) return;
    
    [XMHProgressHUD showGifImage];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_CUTE_HAND_INFO_URL] refreshRequest:YES cache:NO params:@{@"id" : _taskID} progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        self.taskModel = [XMHTaskModel yy_modelWithJSON:obj.data];
        [self configDateDicTaskModel:self.taskModel];
        [self initializeFormTaskMdoel:self.taskModel];
    }];
}

/**
 编辑状态，配置选中日历数据
 */
- (void)configDateDicTaskModel:(XMHTaskModel *)taskMdoel {
    [taskMdoel.list enumerateObjectsUsingBlock:^(XMHTrackDayMonthModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.dateDic[obj.date] = obj;
    }];
}

- (void)initializeFormTaskMdoel:(XMHTaskModel *)taskModel {
    XMHXLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row, *rulesDateRow;
    
    form = [XMHXLFormDescriptor formDescriptorWithTitle:@""];
    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [form addFormSection:section];
    
    // 任务名
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_name rowType:XLFormRowDescriptorTypeXMHFormTaskInputCell title:nil];
    [row.cellConfigAtConfigure setObject:@(10) forKey:XMHFormTaskInputCellTextFieldMaxNumberOfCharacters]; // 最大输入限制
    [row.cellConfigAtConfigure setObject:@"请输入任务名称" forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:kColor9 forKey:@"textField.placeholderLabel.textColor"];
    row.value = taskModel ? taskModel.name : @"";
    // 校验数据
    [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
        BOOL status = NO;
        if (!IsEmpty(row.value)) status = YES;
        return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
    }]];
    [section addFormRow:row];
    
    // 选择顾客 XLFormRowDescriptorTypeSelectorPush
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_track_user_ids rowType:XLFormRowDescriptorTypeXMHXLFormSelectorCell title:@"追踪顾客"];
    [row.cellConfig setObject:FONT_SIZE(16) forKey:@"textLabel.font"];
    [row.cellConfig setObject:kColor3 forKey:@"textLabel.textColor"];
    [row.cellConfig setObject:FONT_SIZE(16) forKey:@"detailTextLabel.font"];
    [row.cellConfig setObject:kColor6 forKey:@"detailTextLabel.textColor"];
    row.valueTransformer = [XMHFormTrackUserTransformer class];
    row.cellStyle = UITableViewCellStyleValue1;
    row.action.viewControllerClass = [XMHTraceSelectCustomerVC class];
    if (!IsEmpty(taskModel.track_user)) row.action.nextParams = @{@"userIDs" : taskModel.track_user}; // viewControllerClass 实例需要传的参 ///
    if (taskModel) {
        row.value = taskModel.track_user;//[XMHTaskModel formOptionsObjectArrayFromArray:taskModel.track_user];// row.value = NSArray <XLFormOptionsObject *> array 集合
    } else {
        row.value = @[];
    }
    // 空数组，提示默认语句，非空提示已选择几人
    [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
        BOOL status = NO;
        if ([row.value isKindOfClass:[NSArray class]] && ((NSArray *)row.value).count) status = YES;
        return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
    }]];
    [section addFormRow:row];
    
    // 追踪时间
    rulesDateRow = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_time_type rowType:XLFormRowDescriptorTypeXMHFormTaskButtonsCell title:@"追踪时间"];
    rulesDateRow.selectorOptions = [XMHFormTaskDataCreateManager createTrackDateList];
    // time_type
    if (taskModel.time_type) {
        rulesDateRow.value = [XMHFormTaskDataCreateManager selectModelIdStr:taskModel.time_type list:rulesDateRow.selectorOptions];
    } else {
        rulesDateRow.value = rulesDateRow.selectorOptions.firstObject;
    }
    [rulesDateRow addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
        BOOL status = NO;
        if (row.value) status = YES;
        return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
    }]];
    [section addFormRow:rulesDateRow];

    // 追踪规则设置 每次相同 每次不同
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_rules_type rowType:XLFormRowDescriptorTypeXMHFormTaskButtonsCell title:@"追踪规则设置"];
    row.selectorOptions = [XMHFormTaskDataCreateManager createRulesTypeList];
    if (taskModel.rules_type) {
        row.value = [XMHFormTaskDataCreateManager selectModelIdStr:taskModel.rules_type list:row.selectorOptions];
    } else {
        row.value = row.selectorOptions.firstObject;
    }
    [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
        BOOL status = NO;
        if (row.value) status = YES;
        return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
    }]];
    [section addFormRow:row];

    // 日历
    XLFormOptionsObject *tulesDateItemModel = rulesDateRow.value;
    [form addFormSection:[self addCalendarRowFormTrackDateId:tulesDateItemModel.formValue obj:taskModel block:nil]];

    // 默认选中mdoel
    XMHTrackDayMonthModel *defaultSelectDateMdoel;
    if (self.type == XMHFormTaskCreateVCTypeSystemEdit && self.lastDateMdoel) {
        defaultSelectDateMdoel = self.lastDateMdoel;
    }

    // 根据追踪方式不同，显示不同cell样式
    [self rowModelFromTrackMethodId:nil obj:defaultSelectDateMdoel form:form];
    
    self.form = form;
}

/**
 根据追踪类型 天、月加载日历row

 @param trackDateId 追踪类型id
 @param taskModel 预留
 */
- (XLFormSectionDescriptor *)addCalendarRowFormTrackDateId:(NSString *)trackDateId obj:(XMHTaskModel *)taskModel block:(void(^)(NSInteger index))block {
    XLFormRowDescriptor *row;
    // 移除上次追踪的 section
    __block NSInteger aindex = -1;
    __weak typeof(self) _self = self;
    [self searchSectionTag:XMHTaskModel_calendarSectionTag block:^(XLFormSectionDescriptor * _Nonnull section, NSUInteger index) {
        __strong typeof(_self) self = _self;
        aindex = index;
        [self.form removeFormSectionAtIndex:index];
    }];
    
    // 新建追送section
    XLFormSectionDescriptor *newSection = [XLFormSectionDescriptor formSection];
    newSection.multivaluedTag = XMHTaskModel_calendarSectionTag;
    // 天
    if ([trackDateId isEqualToString:@"1"]) {
        row = [XMHFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_calendar rowType:XLFormRowDescriptorTypeXMHFormTaskCalendarCell title:nil];
        [newSection addFormRow:row];
        ((XMHFormRowDescriptor *)row).url = [NSString stringWithFormat:@"task/taskDa.html?nocache=%d", arc4random_uniform(10000)];
        ((XMHFormRowDescriptor *)row).calendarType = XMHFormCellCalendarTypeDay;
        if (self.type == XMHFormTaskCreateVCTypeSystemEdit) ((XMHFormRowDescriptor *)row).taskType = XMHFormTaskCreateVCTypeSystemEdit;
        if (self.type == XMHFormTaskCreateVCTypeCreate) {
            // 当天 时分秒0
            NSDate *date = NSDate.new;
            row.value = [NSDate dateFromYear:(int)[date getYear] Month:(int)[date getMonth] Day:(int)[date getDay] hour:0 minute:0 second:0]; // 默认选中当前天。
        }
        [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
            BOOL status = NO;
            if (!IsEmpty(row.value)) status = YES;
            return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
        }]];
        ((XMHFormRowDescriptor *)row).list = taskModel.list;
        
        // 编辑状态，默认显示第一个日期
        if (self.type == XMHFormTaskCreateVCTypeSystemEdit) {
            self.lastDateMdoel = [taskModel minDayModel];
            self.bottomViewState = XMHFormTaskBottomViewStateDelete; // 编辑下，存在日期，删除状态
        } else if (self.type == XMHFormTaskCreateVCTypeCreate) {
            // 保留默认天数据 设置value 会自动创建相应model
            [self createDefaultDayModelRow:row];
        }
    }
    // 月
    else if ([trackDateId isEqualToString:@"2"]) {
        row = [XMHFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_calendar rowType:XLFormRowDescriptorTypeXMHFormTaskCalendarMonthCell title:nil];
        [newSection addFormRow:row];
        ((XMHFormRowDescriptor *)row).url = [NSString stringWithFormat:@"task/taskMonth.html?nocache=%d", arc4random_uniform(10000)];
        ((XMHFormRowDescriptor *)row).calendarType = XMHFormCellCalendarTypMonth;
        if (self.type == XMHFormTaskCreateVCTypeSystemEdit) ((XMHFormRowDescriptor *)row).taskType = XMHFormTaskCreateVCTypeSystemEdit;
        // 当月的话： 时间是当月天+ 1.其他月是每个月1号
//        NSDate *date = NSDate.new;
//        row.value = [NSDate dateFromYear:(int)[date getYear] Month:(int)[date getMonth] Day:(int)[date getDay] + 1 hour:0 minute:0 second:0]; // 默认选中当前天。
        [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
            BOOL status = NO;
            if (!IsEmpty(row.value)) status = YES;
            return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
        }]];
        ((XMHFormRowDescriptor *)row).list = taskModel.list;
        
        // 编辑状态，默认显示第一个日期
        if (self.type == XMHFormTaskCreateVCTypeSystemEdit) {
            self.lastDateMdoel = [taskModel minDayModel];
            self.bottomViewState = XMHFormTaskBottomViewStateDelete; // 编辑下，存在日期，删除状态
        }
        // 保留默认天数据
//        [self createDefaultDayModelRow:row];
    }
    if (block && aindex > -1) block(aindex);
    return newSection;
}

/**
 根据追踪方式创建相应的cell样式

 @param trackMethodId 追踪方式 1 消息 2 优惠券 3 预约
 @param obj 预留
 #param form 非空：添加 空：替换
 */
- (void)rowModelFromTrackMethodId:(NSString *)trackMethodId obj:(XMHTrackDayMonthModel *)obj form:(XMHXLFormDescriptor *)form {
    // 移除上次追踪的 section
    __block NSInteger aindex = -1;
    __weak typeof(self) _self = self;
    [self searchSectionTag:XMHTaskModel_trackMethodSectionTag block:^(XLFormSectionDescriptor * _Nonnull section, NSUInteger index) {
        __strong typeof(_self) self = _self;
        aindex = index;
        [self.form removeFormSectionAtIndex:index];
    }];
    
    // 新建追送section
    XLFormSectionDescriptor *newSection = [XLFormSectionDescriptor formSection];
    newSection.multivaluedTag = XMHTaskModel_trackMethodSectionTag;
    
    // 追踪方式
    XLFormRowDescriptor *trackMethodRow = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_track_method rowType:XLFormRowDescriptorTypeXMHFormTaskButtonsCell title:@"追踪方式"];
    trackMethodRow.selectorOptions = [XMHFormTaskDataCreateManager createTrackMethodList];
    [newSection addFormRow:trackMethodRow];
    if (!IsEmpty(trackMethodId)) {
        trackMethodRow.value = [XLFormOptionsObject formOptionsObjectWithValue:trackMethodId displayText:nil];
    }
    // 编辑状态 && 存在默认选中的天model
    else if (self.type == XMHFormTaskCreateVCTypeSystemEdit && self.lastDateMdoel) {
        trackMethodRow.value = [XMHFormTaskDataCreateManager selectModelIdStr:self.lastDateMdoel.track_method list:trackMethodRow.selectorOptions];
    }
    else {
        trackMethodRow.value = [XMHFormTaskDataCreateManager defaultTrackMethod];
    }
    [trackMethodRow addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
        BOOL status = NO;
        if (row.value) status = YES;
        return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
    }]];
    
    // 保存默认天下，追踪方式
    if (self.currentDateModel) {
        self.currentDateModel.track_method = ((XLFormOptionsObject *)trackMethodRow.value).formValue;
    }
    
    trackMethodId = ((XLFormOptionsObject *)trackMethodRow.value).formValue;
    
    XLFormRowDescriptor *row;
    if ([trackMethodId isEqualToString:@"1"]) {
        // 追踪话术
        row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_track_msg rowType:XLFormRowDescriptorTypeXMHFormTaskTrackMsgCell title:@"追踪话术"];
        [row.cellConfigAtConfigure setObject:@(70) forKey:XMHFormTaskInputCellTextFieldMaxNumberOfCharacters]; // 最大输入限制
        row.value = obj.track_msg;
        [newSection addFormRow:row];
        [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
            BOOL status = NO;
            if (!IsEmpty(row.value)) status = YES;
            return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
        }]];

        // 具体发送时间
        [newSection addFormRow:[self createSendDateRowObj:obj]];
    }
    else if ([trackMethodId isEqualToString:@"2"]) {
        
        // 选择优惠券
        row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_coupon_list rowType:XLFormRowDescriptorTypeXMHXLFormSelectorCell title:@"选择优惠券"];
        [row.cellConfig setObject:FONT_SIZE(16) forKey:@"textLabel.font"];
        [row.cellConfig setObject:kColor3 forKey:@"textLabel.textColor"];
        [row.cellConfig setObject:FONT_SIZE(16) forKey:@"detailTextLabel.font"];
        [row.cellConfig setObject:kColor6 forKey:@"detailTextLabel.textColor"];
        row.valueTransformer = [XMHFormTrackCouponTransformer class];
        row.cellStyle = UITableViewCellStyleValue1;
        // 空数组，提示默认语句，非空提示已选择几人
        if (!IsEmpty(obj.coupon_list)) {
            row.value = obj.coupon_list;
        } else {
            row.value = @[];
        }
        
        row.action.viewControllerClass = [XMHTraceSelectDiscountCouponVC class];
        if (!IsEmpty(row.value)) row.action.nextParams = @{@"couponList" : row.value}; // viewControllerClass 实例需要传的参 ///
        [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
            BOOL status = NO;
             if ([row.value isKindOfClass:[NSArray class]] && ((NSArray *)row.value).count) status = YES;
            return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
        }]];
        [newSection addFormRow:row];
        
        // 每人发送几张优惠券
        row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_person_send rowType:XLFormRowDescriptorTypeXMHFormTaskInputRightPointCell title:@"每人发送"];
        [row.cellConfig setObject:@"张" forKey:@"rightPointLabel.text"];
        [row.cellConfigAtConfigure setObject:@"请输入张数" forKey:@"textField.placeholder"];
        [row.cellConfigAtConfigure setObject:kColor9 forKey:@"textField.placeholderLabel.textColor"];
        [newSection addFormRow:row];
        [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
            BOOL status = NO;
            if (!IsEmpty(row.value)) status = YES;
            return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
        }]];
        if (obj) row.value = obj.person_send;
        
        // 具体发送时间
        [newSection addFormRow:[self createSendDateRowObj:obj]];
    }
    else if ([trackMethodId isEqualToString:@"3"]) {
        // 具体发送时间
        [newSection addFormRow:[self createSendDateRowObj:obj]];
    }
    
    if (form) {
        [form addFormSection:newSection];
    } else {
        [self.form addFormSection:newSection atIndex:aindex];
    }
}

// 具体发送时间
- (XLFormRowDescriptor *)createSendDateRowObj:(XMHTrackDayMonthModel *)obj {
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_send_date rowType:XLFormRowDescriptorTypeXMHXLFormButtonCell title:@"具体发送时间"];
    [row.cellConfig setObject:FONT_SIZE(16) forKey:@"textLabel.font"];
    [row.cellConfig setObject:kColor3 forKey:@"textLabel.textColor"];
    [row.cellConfig setObject:FONT_SIZE(16) forKey:@"detailTextLabel.font"];
    [row.cellConfig setObject:kColor6 forKey:@"detailTextLabel.textColor"];
    row.valueTransformer = [XMHFormSendDateTransformer class];
    row.action.viewControllerClass = [XMHTaskCreateDatePickVC class];
//    row.action.nextParams = @{@"date" : @"value"}; // viewControllerClass 实例需要传的参
    row.action.viewControllerPresentationMode = XLFormPresentationModePresent;
    row.cellStyle = UITableViewCellStyleValue1;
    if (obj) {
        row.value = obj.send_date;
    } else {
        // nil 提示默认语句，非空显示时间
        row.value = nil;
    }
    [row addValidator:[XMHFormValidator formValidatorValidBlock:^XLFormValidationStatus *(XLFormRowDescriptor * _Nullable row) {
        BOOL status = NO;
        if (!IsEmpty(row.value)) status = YES;
        return [XLFormValidationStatus formValidationStatusWithMsg:@"成功" status:status rowDescriptor:row];
    }]];
    return row;
}

/**
 更新row
 */
- (void)updateFormRowsRowTag:(NSString *)rowTag {
    // 日历
    __block NSInteger sectionIndex;
    XLFormOptionsObject *tulesDateItemModel = [self.form formRowWithTag:XMHTaskModel_time_type].value;
    XLFormSectionDescriptor *newSection = [self addCalendarRowFormTrackDateId:tulesDateItemModel.formValue obj:nil block:^(NSInteger index) {
        sectionIndex = index;
    }];
    [self.form addFormSection:newSection atIndex:sectionIndex];
    
    // 追踪方式
    XLFormRowDescriptor *trackMethodRow = [self.form formRowWithTag:XMHTaskModel_track_method];
    trackMethodRow.value = trackMethodRow.selectorOptions.firstObject;
    [self reloadFormRow:trackMethodRow];
    
    // 根据追踪方式不同，显示不同cell样式
    [self rowModelFromTrackMethodId:((XLFormOptionsObject *)trackMethodRow.value).formValue obj:nil form:nil];
}

/**
 创建默认天数据

 @param row <#row description#>
 */
- (void)createDefaultDayModelRow:(XLFormRowDescriptor *)row {
    // 保留默认天数据
    XMHTrackDayMonthModel *dateMdoel = XMHTrackDayMonthModel.new;
    self.currentDateModel = dateMdoel;
    dateMdoel.date = @(((NSDate *)row.value).timeIntervalSince1970).stringValue;
    self.dateDic[dateMdoel.date] = dateMdoel;
}

/**
 移除所有天数据
 当切换追踪时间、追踪规则设置 移除选中的 XMHTrackDayMonthModel
 */
- (void)removeAllDateModel {
    [self.dateDic removeAllObjects];
    self.currentDateModel = nil;
    
    self.bottomViewState = XMHFormTaskBottomViewStateSave;
}

/**
 移除选中天数据
 */
- (void)removeCurrentDateModel {
    if (self.currentDateModel) {
        self.dateDic[self.currentDateModel.date] = nil;
        self.currentDateModel = nil;
    }
}

/**
 根据表单样式、内容。设置保存按钮是否可点击
 */
- (void)changeSaveButtonState {
    // self.currentDateModel == nil 情况1： 保存后设置的
    if (self.currentDateModel == nil) {
        self.saveButton.enabled = NO;
        return;
    }
    
    NSArray *validationArray = [self formValidationErrors];
    self.saveButton.enabled = !validationArray.count;
}

/**
 处理追踪方式、以及以下的样式cell 是否可以编辑

 @param disabled YES: 不可编辑 NO: 可编辑
 */
- (void)changeFormDisabled:(BOOL)disabled {
    // 处理追踪方式、以及以下的样式cell 是否可以编辑
    XLFormRowDescriptor *trackMethodRow = [self.form formRowWithTag:XMHTaskModel_track_method];
    trackMethodRow.disabled = @(disabled);
    [self reloadFormRow:trackMethodRow];
    
    XLFormSectionDescriptor *trackMethodSection = [self searchSectionTag:XMHTaskModel_trackMethodSectionTag block:nil];
    [trackMethodSection.formRows enumerateObjectsUsingBlock:^(XLFormRowDescriptor *row, NSUInteger idx, BOOL * _Nonnull stop) {
        row.disabled = @(disabled);
        [self reloadFormRow:row];
    }];
}

/**
 H5保存、删除日期
 */
- (void)setH5Date {
    if (self.type == XMHFormTaskCreateVCTypeCreate) {
        XMHTrackDayMonthModel *currentMdoel = [self getShowModel];
        if (IsEmpty(currentMdoel)) {
            MzzLog(@"错误： self.currentDateModel = nil");
            return;
        }
        XMHFormTaskCalendarBaseCell *calendarCell = (XMHFormTaskCalendarBaseCell *)[[self.form formRowWithTag:XMHTaskModel_calendar] cellForFormController:self];
        NSDate *selectDate = [NSDate dateWithTimeIntervalSince1970:[currentMdoel.date doubleValue]];
        NSString *selectDateStr = [NSDate stringFromDate:selectDate withFormat:@"yyyy-MM-dd"];
        [calendarCell setH5Date:selectDateStr];
    } else {
        // self.lastDateMdoel 说明是保存过的。 self.currentDateModel 说明是编辑下新创建的
        NSDate *selectDate = [NSDate dateWithTimeIntervalSince1970:self.currentDateModel ? [self.currentDateModel.date doubleValue] : [self.lastDateMdoel.date doubleValue]];
        NSString *selectDateStr = [NSDate stringFromDate:selectDate withFormat:@"yyyy-MM-dd"];
        XMHFormTaskCalendarBaseCell *calendarCell = (XMHFormTaskCalendarBaseCell *)[[self.form formRowWithTag:XMHTaskModel_calendar] cellForFormController:self];
        [calendarCell setH5Date:selectDateStr];
    }
}

#pragma mark - Click
/**
 确认
 */
- (void)submitClick {
    if (![self formValidation]) {
        [XMHProgressHUD showOnlyText:@"信息不完整"];
        return;
    };
    
    NSDictionary *formParams = [self httpParameters];
    MzzLog(@"%@", formParams);
    NSMutableDictionary *newFormParams = [formParams mutableCopy];
    newFormParams[@"calendarSectionTag"] = nil;
    newFormParams[@"trackMethodSectionTag"] = nil;
    newFormParams[@"track_method"] = nil;
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSMutableDictionary *params = NSMutableDictionary.new;
    [params setDictionary:newFormParams];
    params[@"account"] = infomodel.data.account;
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"store_code"] = [ShareWorkInstance shareInstance].share_join_code.store_code;
    params[@"list"] = [self.dateDic.allValues yy_modelToJSONString]; // 发送时间数据
    params[@"track_user_ids"] = [((NSArray *)newFormParams[@"track_user_ids"]) componentsJoinedByString:@","];
    if (self.type == XMHFormTaskCreateVCTypeSystemEdit) {
        params[@"id"] = self.taskModel.ID;
    }
    MzzLog(@"%@", params);
    
    [XMHProgressHUD showGifImage];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_VERITY_MESS_AND_TICKET_URL] refreshRequest:YES cache:NO params:params progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        if (!isSuccess) return;
        if (isSuccess) [XMHProgressHUD dismiss];

        // 结束方式
        XMHFormEndTypeAlertVC *formEndTypeAlertVC = [[XMHFormEndTypeAlertVC alloc] initWithNibName:@"XMHFormEndTypeAlertVC" bundle:nil];
        [self presentViewController:formEndTypeAlertVC animated:NO completion:nil];
        __weak typeof(self) _self = self;
        [formEndTypeAlertVC setDidFinishBlock:^(NSString * _Nonnull ID) {
            __strong typeof(_self) self = _self;
            
            params[@"end_type"] = ID; // 结束方式
            MzzLog(@"%@", params);
            [XMHProgressHUD showGifImage];
            [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_CREATE_TASK_URL] refreshRequest:YES cache:NO params:params progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
                if (!isSuccess) return;
                if (isSuccess) [XMHProgressHUD dismiss];

                NSString *msg = self.type == XMHFormTaskCreateVCTypeCreate ? @"创建成功" : @"更新成功";
                [XMHProgressHUD showOnlyText:msg delay:3.f completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }];
        }];
    }];
}

/**
 保存
 */
- (void)saveClick:(UIButton *)sender {
    if (![self formValidation]) {
        [XMHProgressHUD showOnlyText:@"信息不完整"];
        return;
    };
    
    self.dateDic[self.currentDateModel.date] = self.currentDateModel;
    self.currentDateModel.isSaveState = YES;
    
    XLFormRowDescriptor *rulesTypeRow = [self.form formRowWithTag:XMHTaskModel_rules_type];
    NSString *tag = ((XLFormOptionsObject *)rulesTypeRow.value).formValue;
     // 1 每次相同
    if ([tag isEqualToString:@"1"]) {
        NSMutableDictionary *json = [[self.currentDateModel yy_modelToJSONObject] mutableCopy];
        json[@"date"] = nil;
        self.dateDic[self.currentDateModel.date] = self.currentDateModel;
        [self.dateDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, XMHTrackDayMonthModel * _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj != self.currentDateModel) {
                [obj yy_modelSetWithJSON:json];
            }
        }];
    }
    // 2 每次不同
//    else if ([tag isEqualToString:@"2"]) {}
    
    // H5保存、删除日期
    [self setH5Date];
    
    // 改变保存按钮状态
    [self changeSaveButtonState];
    // 保存后，按钮变成删除状态
    self.bottomViewState = XMHFormTaskBottomViewStateDelete;
    // 其他项目不可编辑
    [self changeFormDisabled:YES];
}

/**
 删除
 */
- (void)deleteClick:(UIButton *)sender {
    // H5保存、删除日期
    [self setH5Date];
    
    // 追踪规则
    NSInteger rulesId = [((XLFormOptionsObject *)[self.form formRowWithTag:XMHTaskModel_rules_type].value).formValue integerValue];
    XMHTrackDayMonthModel *currentMdoel = [self getShowModel];
    // 每次相同
    if (rulesId == 1) {
//        [self removeAllDateModel];
//
//        NSString *trackMethodId = ((XLFormOptionsObject *)[self.form formRowWithTag:XMHTaskModel_track_method].value).formValue;
//        [self rowModelFromTrackMethodId:trackMethodId obj:nil form:nil];
//
//        // 清除日历选中状态
//        XMHFormTaskCalendarBaseCell *calendarCell = (XMHFormTaskCalendarBaseCell *)[[self.form formRowWithTag:XMHTaskModel_calendar] cellForFormController:self];
//        [calendarCell setH5CleanAll];
        
        if (currentMdoel) {
            self.dateDic[currentMdoel.date] = nil;
            currentMdoel = nil;
        }
    }
    // 每次不同
    else {
        if (currentMdoel) {
            self.dateDic[currentMdoel.date] = nil;
            currentMdoel = nil;
            
//            NSString *trackMethodId = ((XLFormOptionsObject *)[self.form formRowWithTag:XMHTaskModel_track_method].value).formValue;
//            [self rowModelFromTrackMethodId:trackMethodId obj:nil form:nil];
        }
    }
    /* 删除后显示字典里第一个天数据（上次保存的数据）。如果字典无数据，显示当前天
     */
    XLFormRowDescriptor *calendarRow = [self.form formRowWithTag:XMHTaskModel_calendar];
    NSDate *showDate;
    if(self.dateDic.allValues.count) {
        XMHTrackDayMonthModel *showDataMdoel = self.dateDic.allValues[0];
        showDate = [NSDate dateWithTimeIntervalSince1970:[showDataMdoel.date doubleValue]];
    } else {
        NSDate *date = NSDate.new;
        showDate = [NSDate dateFromYear:(int)[date getYear] Month:(int)[date getMonth] Day:(int)[date getDay] hour:0 minute:0 second:0]; // 默认选中当前天。
    }
    calendarRow.value = showDate;
    self.bottomViewState = XMHFormTaskBottomViewStateSave;
}

- (XMHTrackDayMonthModel *)getShowModel {
    return self.lastDateMdoel ? self.lastDateMdoel : self.currentDateModel;
}

#pragma mark - XLFormDescriptorDelegate

/**
 当value被改变的时候回调
 */
-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
    NSString *tag = rowDescriptor.tag;
    MzzLog(@"%@", tag);
    // 获取 row mdoel
    XLFormRowDescriptor *currentRow = [self.form formRowWithTag:tag];
    
    // ----------------- 追踪顾客 -----------------
    if ([tag isEqualToString:XMHTaskModel_track_user_ids]) {
        [self reloadFormRow:currentRow];
    }
    // ----------------- 追踪时间 -----------------
    else if ([tag isEqualToString:XMHTaskModel_time_type]) {
        // 当切换追踪时间、追踪规则设置 移除选中的 XMHTrackDayMonthModel
        [self removeAllDateModel];
        [self updateFormRowsRowTag:XMHTaskModel_time_type];
    }
    // ----------------- 追踪规则设置 -----------------
    else if ([tag isEqualToString:XMHTaskModel_rules_type]) {
        // 当切换追踪时间、追踪规则设置 移除选中的 XMHTrackDayMonthModel
        [self removeAllDateModel];
        [self updateFormRowsRowTag:XMHTaskModel_rules_type];
    }
    // ----------------- 日历被选中 -----------------
    else if ([tag isEqualToString:XMHTaskModel_calendar]) {
        XLFormRowDescriptor *trackMethodRow = [self.form formRowWithTag:XMHTaskModel_track_method];
        // 根据追踪方式不同，显示不同cell样式 场景1：填写完某天规则，再次选择其他天。需要重新生成样式
        NSString *trackMethodId = ((XLFormOptionsObject *)trackMethodRow.value).formValue;
        // 追踪规则
        NSInteger rulesId = [((XLFormOptionsObject *)[self.form formRowWithTag:XMHTaskModel_rules_type].value).formValue integerValue];
        
        // 选完天，没选追踪方式、保存，又选其他天，移除选中天的数据（保存后 self.currentDateModel 为 nil）   && 追踪规则每次不同
        if (rulesId == 2 && self.currentDateModel.isSaveState == NO) {
            [self removeCurrentDateModel];
        }
        
        // 上次保存的天数据
        XMHTrackDayMonthModel *lastDateMdoel = self.dateDic[@(((NSDate *)currentRow.value).timeIntervalSince1970).stringValue];
        self.lastDateMdoel = lastDateMdoel;
        
        if (rulesId == 1) {
            
        } else if (rulesId == 2) {
            // 【追踪方式】存在保留天，与保留的一致。 不存在，设置成默认
            trackMethodId = lastDateMdoel ?lastDateMdoel.track_method : [XMHFormTaskDataCreateManager defaultTrackMethod].formValue; // 默认id
        }
        
        // 不存在保留天数据。创建天数据
        if (!lastDateMdoel) {
            // 2 追踪规则row
            self.currentDateModel = XMHTrackDayMonthModel.new;
            self.currentDateModel.date = @(((NSDate *)currentRow.value).timeIntervalSince1970).stringValue;
            // 刷新下【追踪方式】，目的：默认  self.currentDateModel.track_method = itemModel.formValue; 保留下
            self.currentDateModel.track_method = trackMethodId;
        } else {
            self.currentDateModel = nil;
        }
        
        //  处理追踪方式、以及以下的样式cell 是否可以编辑
        BOOL changeFormDisabledVar;
        
        // 每次相同
        if (rulesId == 1) {
            // 存在时间。代表这个时间已经设置了【追踪规则】
            if (lastDateMdoel) {
                // 已存在追踪规则，显示追踪规则。根据追踪方式不同，显示不同cell样式
                [self rowModelFromTrackMethodId:trackMethodId obj:lastDateMdoel form:nil];
                self.bottomViewState = XMHFormTaskBottomViewStateDelete;
                
                // 其他项目不可编辑
                changeFormDisabledVar = YES;
            }
            // 不存在时间
            else {
                // 如果以前保存过天数据，新添加的天，要设置成以前保存的数据
                XMHTrackDayMonthModel *saveDateMdoel = self.dateDic.allValues.firstObject;
                BOOL dataFull = [saveDateMdoel checkDataFull];
                if (dataFull) {
                    NSMutableDictionary *json = [[saveDateMdoel yy_modelToJSONObject] mutableCopy];
                    json[@"date"] = nil;
                    [self.currentDateModel yy_modelSetWithJSON:json];
                    
                    self.bottomViewState = XMHFormTaskBottomViewStateSave;
                    [self rowModelFromTrackMethodId:trackMethodId obj:self.currentDateModel form:nil];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    });
                    // 任务创建、编辑状态。其他项目不可编辑
                    changeFormDisabledVar = YES;
                } else {
                    self.bottomViewState = XMHFormTaskBottomViewStateSave;
                    [self rowModelFromTrackMethodId:trackMethodId obj:self.currentDateModel form:nil];
                    // 任务创建、编辑状态。其他项目可编辑。 注意其他项目编辑. 要在 rowModelFromTrackMethodId： 方法之后
                    changeFormDisabledVar = NO;
//                    self.dateDic[self.currentDateModel.date] = self.currentDateModel;
                }
            }
        }
        // 每次不同
        else {
            // 存在时间。代表这个时间已经设置了【追踪规则】
            if (lastDateMdoel) {
                // 已存在追踪规则，显示追踪规则。根据追踪方式不同，显示不同cell样式
                [self rowModelFromTrackMethodId:trackMethodId obj:lastDateMdoel form:nil];
                self.bottomViewState = XMHFormTaskBottomViewStateDelete;
                
                if (self.type == XMHFormTaskCreateVCTypeCreate) {
                    // 其他项目可编辑
                    changeFormDisabledVar = NO;
                } else if (self.type == XMHFormTaskCreateVCTypeSystemEdit){
                    // 任务编辑状态。点击已经保存过的天。都不可编辑追踪方式下的cell
                    // 其他项目不可编辑
                    [self changeFormDisabled:YES];
                    changeFormDisabledVar = YES;
                }
            }
            // 不存在时间
            else {
//                self.dateDic[self.currentDateModel.date] = self.currentDateModel;
                [self rowModelFromTrackMethodId:trackMethodId obj:nil form:nil];
                self.bottomViewState = XMHFormTaskBottomViewStateSave;
                
                // 任务编辑、创建状态。点击未保存的天。都可编辑追踪方式下的cell
                // 其他项目可编辑
                changeFormDisabledVar = NO;
            }
        }
        
        // 保留具体发送时间参数。具体发送时间选择框需要传当前选中日期参数。
        if (rowDescriptor.value) {
            XLFormRowDescriptor *sendDateRow = [self.form formRowWithTag:XMHTaskModel_send_date];
            sendDateRow.action.nextParams = @{@"date" : (NSDate *)rowDescriptor.value}; // viewControllerClass 实例需要传的参            
        }
        
        // 更新 【追踪方式】
        trackMethodRow.value = [XLFormOptionsObject formOptionsObjectWithValue:trackMethodId displayText:nil];
        [self reloadFormRow:trackMethodRow];
        
        // 其他项目不可编辑. 当前操作，在这之后不可有其他刷新，导致是否可编辑状态被抹去掉。
        [self changeFormDisabled:changeFormDisabledVar];
    }
    // ----------------- 追踪方式 -----------------
    else if ([tag isEqualToString:XMHTaskModel_track_method]) {
        // 根据追踪方式不同，显示不同cell样式
        NSString *trackMethodId = ((XLFormOptionsObject *)[self.form formRowWithTag:XMHTaskModel_track_method].value).formValue;
        self.currentDateModel.track_method = trackMethodId;
        if (self.type == XMHFormTaskCreateVCTypeSystemEdit) {
            [self rowModelFromTrackMethodId:trackMethodId obj:self.lastDateMdoel form:nil];
        } else {
            XMHTrackDayMonthModel *currentMdoel = [self getShowModel];
            [self rowModelFromTrackMethodId:trackMethodId obj:currentMdoel form:nil];
        }
    }
    // ----------------- 具体发送时间 -----------------
    else if ([tag isEqualToString:XMHTaskModel_send_date]) {
        self.currentDateModel.send_date = currentRow.value;
        [self reloadFormRow:currentRow];
    }
    // ----------------- 追踪话术 -----------------
    else if ([tag isEqualToString:XMHTaskModel_track_msg]) {
        self.currentDateModel.track_msg = currentRow.value;
    }
    // ----------------- 选择优惠券 -----------------
    else if ([tag isEqualToString:XMHTaskModel_coupon_list]) {
        self.currentDateModel.coupon_list = currentRow.value;
        [self reloadFormRow:currentRow];
    }
    // ----------------- 每人发送几张优惠券 -----------------
    else if ([tag isEqualToString:XMHTaskModel_person_send]) {
        self.currentDateModel.person_send = currentRow.value;
    }
    
    // 改变保存按钮状态
    [self changeSaveButtonState];
}




@end
