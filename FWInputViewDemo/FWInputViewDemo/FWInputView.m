//
//  FWInputView.m
//  FWInputViewDemo
//
//  Created by KFW on 2019/1/28.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FWInputView.h"
#import "UIViewAdditions.h"
#import "UITextView+PlaceHolder.h"

CGFloat const inputRight = 100; // 右按钮间距
CGFloat const textViewContentGap = 10; // 输入框与文字上下总间距

CGFloat const inputTopBottonGap = 10; // 输入框与self上下间距
CGFloat const kTextViewHeight = 20.3 + 10;
CGFloat const kFWInputViewHeight = kTextViewHeight + inputTopBottonGap * 2;

@interface FWInputView() <UITextViewDelegate>
/** <##> */
@property (nonatomic, strong) UITextView *textView;
/** <##> */
@property (nonatomic) CGRect kbRect;
/** <##> */
@property (nonatomic) BOOL showEmoj;
@end

@implementation FWInputView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, inputTopBottonGap, self.width - inputRight, kTextViewHeight)];
        [self addSubview:_textView];
        _textView.delegate = self;
        
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.textContainerInset = UIEdgeInsetsMake(textViewContentGap / 2.f, 0, textViewContentGap / 2.f, 0); // 去除内容间距 - 计算高度
        [_textView becomeFirstResponder];
        
        UIButton *emojBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:emojBtn];
        emojBtn.frame = CGRectMake(_textView.right + 5, (kTextViewHeight - 30) / 2.f, 30, 30);
        [emojBtn addTarget:self action:@selector(emojClick) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(scrollViewWillBeginDragging:)
//                                                     name:kScrollViewWillBeginDragging object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:_textView];
        
    }
    return self;
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.kbRect = kbRect;
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    NSValue *animationCurveValue = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSTimeInterval animationCurve;
    [animationCurveValue getValue:&animationCurve];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    self.bottom = kbRect.origin.y;
    [UIView commitAnimations];
    [_textView scrollRangeToVisible:NSMakeRange(1, 1)];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.kbRect = kbRect;
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    NSValue *animationCurveValue = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSTimeInterval animationCurve;
    [animationCurveValue getValue:&animationCurve];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (!self.showEmoj) {
        self.top = kbRect.origin.y;
    } else {
        
    }
    
    [UIView commitAnimations];
}

//- (void)scrollViewWillBeginDragging:(NSNotification *)not
//{
//    [self remove];
//}

- (void)textViewTextDidChangeNotification:(NSNotification *)not
{
    UITextView *textView = not.object;
    CGSize constraintSize;
    constraintSize.width = self.width - 10 - inputRight + textView.textContainer.lineFragmentPadding * 2;
    constraintSize.height = MAXFLOAT;
    CGSize sizeFrame2 = [textView sizeThatFits:constraintSize];
    // 最高显示3行内容
    if (sizeFrame2.height > kTextViewHeight * 3) {
        return;
    }
    
    self.height = sizeFrame2.height + inputTopBottonGap * 2;
    self.bottom = self.kbRect.origin.y;
    _textView.height = sizeFrame2.height;
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [_textView addPlaceHolder:_placeholder];
}

- (void)emojClick {
    self.showEmoj = YES;
    [_textView resignFirstResponder];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //判断输入的字是否是回车，即按下return
    if ([text isEqualToString:@"\n"]) {
        
//        if (_sendBlock) {
//            _sendBlock(self);
//        }
        [self remove];
        return NO;
    }
    return YES;
}

#pragma mark - public method

- (void)remove
{
    [self resignFirstResponder];
    [self removeFromSuperview];
}

@end
