//
//  XMHFormTaskCalendarMonthCell.m
//  xmh
//
//  Created by kfw on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskCalendarMonthCell.h"
#import "NSDate-Helper.h"
#import "XMHFormRowDescriptor.h"

@implementation XMHFormTaskCalendarMonthCell

// 在主表单中注册对应的cell以及对应的ID
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[XMHFormTaskCalendarMonthCell class] forKey:XLFormRowDescriptorTypeXMHFormTaskCalendarMonthCell];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 返回行高，autolayout 布局一般用不到此方法
 */
+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 166;
}

// 这个方法是用来设置属性的 必须重写  类似于初始化的属性不变的属性进行预先配置
- (void)configure
{
    [super configure];
    
}

// 这个方法是用来进行更新的，外面给唯一的字段Value设定值就好了 通过self.rowDescriptor.value的值变化来进行更新
- (void)update
{
    [super update];
    [self requestUrl:[NSString stringWithFormat:@"%@%@", SERVER_H5, ((XMHFormRowDescriptor *)self.rowDescriptor).url]];
}

#pragma mark - WKScriptMessageHandler

/**
 js调用OC代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [super userContentController:userContentController didReceiveScriptMessage:message];
    if ([message.name isEqualToString:@"clickDate"]) {
        NSDate *date = [NSDate dateFromString:message.body withFormat:@"yyyy-MM-dd"];
        if (date) {
            self.rowDescriptor.value = date;
        } else {
            MzzLog(@"月日历时间格式不对");
        }
    }
}


@end
