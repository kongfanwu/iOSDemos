//
//  XMHFormTaskDetailVC.m
//  xmh
//
//  Created by kfw on 2019/6/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskDetailVC.h"
#import "LNavView.h"
#import "XLFormAction+XMHXLFormAction.h"
#import "XMHTaskModel.h"
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
#import "XMHTraceCustomerVC.h"
#import "XMHTraceDiscountCouponVC.h"

@interface XMHFormTaskDetailVC ()
//@property (nonatomic, strong) LNavView * navView;
/** <##> */
@property (nonatomic, strong) XMHTaskModel *taskModel;
@end

@implementation XMHFormTaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    [self.bottomView removeFromSuperview];
    self.bottomView = nil;
    
    self.tableView.frame = CGRectMake(10, self.navView.bottom, self.view.width - 20, self.view.height - self.navView.bottom - kSafeAreaBottom);
    self.tableView.tableFooterView = UIView.new;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.separatorColor = kSeparatorColor;
    
//    [self initializeFormTaskMdoel:nil];
    [self getData];
}

- (void)getData {
    if (IsEmpty(_taskId)) return;
    
    [XMHProgressHUD showGifImage];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_CUTE_HAND_INFO_URL] refreshRequest:YES cache:NO params:@{@"id" : _taskId} progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        self.taskModel = [XMHTaskModel yy_modelWithJSON:obj.data];
        [self initializeFormTaskMdoel:self.taskModel];
    }];
}

- (void)initializeFormTaskMdoel:(XMHTaskModel *)taskModel {
    XMHXLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row, *rulesDateRow;
    XLFormOptionsObject *formOptionsObject;
    
    form = [XMHXLFormDescriptor formDescriptorWithTitle:@"Basic Predicates"];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [form addFormSection:section];
    
    // 任务名
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_name rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"任务名称："];
    row.value = taskModel.name;
    [section addFormRow:row];

    // 追踪顾客
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_track_user_ids rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"追踪顾客："];
    [row.cellConfigAtConfigure setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    row.value = taskModel.track_user;
    row.action.viewControllerClass = [XMHTraceCustomerVC class];
    if (taskModel.track_user) row.action.nextParams = @{@"userIDs" : taskModel.track_user, @"remain_user_ids" : taskModel.remain_user_ids, @"track_user_num" : taskModel.track_user_num}; // viewControllerClass 实例需要传的参
    row.valueTransformerInstance = [XMHFormValueTransformer formValueTransformertRransformedValueBlock:^id _Nonnull(id  _Nonnull value) {
        if (![value isKindOfClass:[NSArray class]] || IsEmpty(value) || ![value respondsToSelector:@selector(count)]) return @"";
        return [NSString stringWithFormat:@"%ld人", ((NSArray *)value).count];
    }];
    [section addFormRow:row];
    
    // 追踪时间
    rulesDateRow = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_time_type rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"追踪时间："];
    rulesDateRow.selectorOptions = [XMHFormTaskDataCreateManager createTrackDateList];
    if (taskModel.time_type) {
        rulesDateRow.value = [XMHFormTaskDataCreateManager selectModelIdStr:taskModel.time_type list:rulesDateRow.selectorOptions];
    } else {
        rulesDateRow.value = rulesDateRow.selectorOptions.firstObject;
    }
    [section addFormRow:rulesDateRow];
    
    // 追踪规则设置 每次相同 每次不同
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_rules_type rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"追踪规则设置："];
    row.selectorOptions = [XMHFormTaskDataCreateManager createRulesTypeList];
    formOptionsObject = [XMHFormTaskDataCreateManager selectModelIdStr:taskModel.rules_type list:row.selectorOptions];
    row.value = formOptionsObject.displayText;
    [section addFormRow:row];

    // 日历
    XLFormOptionsObject *tulesDateItemModel = rulesDateRow.value;
    XLFormSectionDescriptor *calendarSection = [self addCalendarRowFormTrackDateId:tulesDateItemModel.formValue obj:taskModel block:nil];
    [form addFormSection:calendarSection];

    XMHFormRowDescriptor *calendarRow = (XMHFormRowDescriptor *)calendarSection.formRows.firstObject;
    XMHTrackDayMonthModel *calendarTrackDayMonthModel = (XMHTrackDayMonthModel *)calendarRow.value;

    // 根据追踪方式不同，显示不同cell样式
    [self rowModelFromTrackMethodId:calendarTrackDayMonthModel.track_method obj:calendarTrackDayMonthModel form:form];
    
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
        ((XMHFormRowDescriptor *)row).url = @"task/taskDayDetail.html";
        ((XMHFormRowDescriptor *)row).calendarType = XMHFormCellCalendarTypeDay;
        ((XMHFormRowDescriptor *)row).list = taskModel.list;
        row.value = [taskModel minDayModel];//((XMHFormRowDescriptor *)row).list.firstObject;
    }
    // 月
    else if ([trackDateId isEqualToString:@"2"]) {
        row = [XMHFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_calendar rowType:XLFormRowDescriptorTypeXMHFormTaskCalendarMonthCell title:nil];
        [newSection addFormRow:row]; 
        ((XMHFormRowDescriptor *)row).url = @"task/taskMonthDetail.html";
        ((XMHFormRowDescriptor *)row).calendarType = XMHFormCellCalendarTypeDay;
        ((XMHFormRowDescriptor *)row).list = taskModel.list;
        row.value = [taskModel minDayModel];
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
    
    XLFormRowDescriptor *row;
    
    // 追踪方式
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_track_method rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"追踪方式："];
    row.selectorOptions = [XMHFormTaskDataCreateManager createTrackMethodList];
    XLFormOptionsObject *formOptionsObject = [XMHFormTaskDataCreateManager selectModelIdStr:trackMethodId list:row.selectorOptions];
    row.value = formOptionsObject.displayText;
    [newSection addFormRow:row];
    
    if ([trackMethodId isEqualToString:@"1"]) {
        // 追踪话术
        row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_track_msg rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"追踪话术："];
        row.value = obj.track_msg;
        [newSection addFormRow:row];
        
        // 具体发送时间
        [newSection addFormRow:[self createSendDateRowObj:obj]];
    }
    else if ([trackMethodId isEqualToString:@"2"]) {
        // 选择优惠券
        row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_coupon_list rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"已选择优惠券："];
        [row.cellConfigAtConfigure setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
        row.action.viewControllerClass = [XMHTraceDiscountCouponVC class];
        row.action.nextParams = @{@"couponList" : obj.coupon_list ? obj.coupon_list : @[]}; // viewControllerClass 实例需要传的参
        row.valueTransformerInstance = [XMHFormValueTransformer formValueTransformertRransformedValueBlock:^id _Nonnull(id  _Nonnull value) {
            if (![value isKindOfClass:[NSArray class]] || IsEmpty(value) || ![value respondsToSelector:@selector(count)]) return @"";
            return [NSString stringWithFormat:@"%ld张", ((NSArray *)value).count];
        }];
        // 空数组，提示默认语句，非空提示已选择几人
        row.value = obj ? obj.coupon_list : @[];
        [newSection addFormRow:row];
        
        // 每人发送几张优惠券
        row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_person_send rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"每人发送："];
        row.value = obj.person_send;
        row.valueTransformerInstance = [XMHFormValueTransformer formValueTransformertRransformedValueBlock:^id _Nonnull(id  _Nonnull value) {
            if (IsEmpty(value)) return @"";
            return [NSString stringWithFormat:@"%@张", value];
        }];
        [newSection addFormRow:row];
        
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
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:XMHTaskModel_send_date rowType:XLFormRowDescriptorTypeXMHFormTaskTextCell title:@"具体发送时间："];
    row.value = obj.send_date;
    return row;
}

- (void)initNavViews
{
    [self.view addSubview:self.navView];
    [self.navView setNavViewTitle:@"自定义追踪" backBtnShow:YES];
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
//    XLFormRowDescriptor *currentRow = [self.form formRowWithTag:tag];
    // ----------------- 追踪时间 -----------------
    if ([tag isEqualToString:XMHTaskModel_time_type]) {
       
    }
    
    // ----------------- 选择优惠券 -----------------
    else if ([tag isEqualToString:XMHTaskModel_coupon_list]) {
        
    }
    // ----------------- 日期 -----------------
    else if ([tag isEqualToString:XMHTaskModel_calendar]) {
        
        if ([newValue isKindOfClass:[NSDate class]]) {
            NSString *key = @(((NSDate *)newValue).timeIntervalSince1970).stringValue;
            [((XMHFormRowDescriptor *)rowDescriptor).list enumerateObjectsUsingBlock:^(XMHTrackDayMonthModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.date isEqualToString:key]) {
                    // 根据追踪方式不同，显示不同cell样式
                    [self rowModelFromTrackMethodId:obj.track_method obj:obj form:nil];
                    *stop = YES;
                }
            }];
        }
    }
}

#pragma mark -  重写

// 设置 row.selectorOptions 点击默认会跳转到 XLFormOptionsViewController 重写此方法，不要调用 Super 这个方法，以达到不跳转目的
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
