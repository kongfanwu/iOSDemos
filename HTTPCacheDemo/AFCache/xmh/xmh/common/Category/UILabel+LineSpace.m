//
//  UILabel+LineSpace.m
//  xmh
//
//  Created by ald_ios on 2018/9/3.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "UILabel+LineSpace.h"
static char *lineSpaceKey;
@implementation UILabel (LineSpace)
+ (void)load {
    //交换设置文本的方法实现。
    Method oldMethod = class_getInstanceMethod([self class], @selector(setText:));
    Method newMethod = class_getInstanceMethod([self class], @selector(setHasLineSpaceText:));
    method_exchangeImplementations(oldMethod, newMethod);
}
//设置带有行间距的文本。
- (void)setHasLineSpaceText:(NSString *)text {
    if (![text isKindOfClass:[NSString class]]) {
        text = [NSString stringWithFormat:@"%@",text];
    }
    if (!text.length || self.lineSpace==0) {
        [self setHasLineSpaceText:text];
        return;
    }
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = self.lineSpace;
    style.lineBreakMode = self.lineBreakMode;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    self.attributedText = attrString;
}
- (void)setLineSpace:(CGFloat)lineSpace {
    objc_setAssociatedObject(self, &lineSpaceKey, @(lineSpace), OBJC_ASSOCIATION_ASSIGN);
    self.text = self.text;
}
- (CGFloat)lineSpace {
    return [objc_getAssociatedObject(self, &lineSpaceKey) floatValue];
}
@end
