//
//  UITextView+PlaceHolder.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
static const char *phTextView = "placeHolderTextView";
@implementation UITextView (PlaceHolder)

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, phTextView);
}

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, phTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addPlaceHolder:(NSString *)placeHolder {
    if (![self placeHolderTextView]) {
//        self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeHolderTextViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    }
}

- (void)placeHolderTextViewTextDidChangeNotification:(NSNotification *)not
{
    UITextView *textView = not.object;
    
    if (textView == self) {
//        if ([textView.text isIncludingEmoji]) {
//            textView.text = [textView.text removedEmojiString];
//        }
    }
    
    if (textView.text.length <= 0) {
        self.placeHolderTextView.hidden = NO;
    } else {
        self.placeHolderTextView.hidden = YES;
    }
}

@end
