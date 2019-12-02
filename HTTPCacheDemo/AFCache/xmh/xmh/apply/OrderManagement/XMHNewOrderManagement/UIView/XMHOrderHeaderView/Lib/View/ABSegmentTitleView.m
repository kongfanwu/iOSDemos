//
//  ABSegmentTitleView.m
//  AddressBookListDemo
//
//  Created by ducaiyan on 22/5/18.
//  Copyright © 2018年 ducaiyan. All rights reserved.
//

#import "ABSegmentTitleView.h"

#define kBtnTag 10
#define kBageTag 20
@interface ABSegmentTitleView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *itemBtnArr;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray *numArr;

@end

@implementation ABSegmentTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArr delegate:(id<ABSegmentTitleViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithProperty];
        self.titlesArr = titlesArr;
        self.delegate = delegate;
    }
    return self;
}
//初始化默认属性值
- (void)initWithProperty
{
    self.itemMargin = 31;
    self.selectIndex = 0;
    self.titleNormalColor = [UIColor blackColor];
    self.titleSelectColor = [UIColor redColor];
    self.titleFont = [UIFont systemFontOfSize:14];
    self.indicatorColor = self.titleSelectColor;
   
}
//重新布局frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    if (self.itemBtnArr.count == 0) {
        return;
    }
    CGFloat totalBtnWidth = 0.0;
    UIFont *titleFont = _titleFont;
    
    for (NSString *title in self.titlesArr) {
        CGFloat itemBtnWidth = [ABSegmentTitleView getWidthWithString:title font:titleFont];
        totalBtnWidth += itemBtnWidth;
    }
    //左右间距给20;
    totalBtnWidth = totalBtnWidth + 40;
    if (totalBtnWidth <= CGRectGetWidth(self.bounds)) {//不能滑动
        CGFloat itemBtnHeight = CGRectGetHeight(self.bounds);
        //计算间距
      __block CGFloat tempItemMargin = ( CGRectGetWidth(self.bounds) - totalBtnWidth)/(self.titlesArr.count - 1);
       __block CGFloat x = 20;
        [self.itemBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            CGFloat itemBtnWidth =  [obj.currentTitle boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : titleFont} context:nil].size.width;
            obj.frame = CGRectMake(x , 0, itemBtnWidth, itemBtnHeight);
            x += itemBtnWidth + tempItemMargin;
            
            UILabel *lab = [obj viewWithTag:kBageTag + idx];
            lab.frame = CGRectMake(itemBtnWidth - 0.5 , 7, 20, 12);
            NSString *num = [NSString stringWithFormat:@"%@",[self.numArr safeObjectAtIndex:idx]];
            if (self.numArr.count > 0) {
                if ([num isEqualToString:@"0"]) {
                    lab.hidden = YES;
                }else{
                    lab.text = num;
                    lab.hidden = NO;
                }
            }
           
//            [lab sizeToFit];
        }];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.scrollView.bounds));
    }else{//超出屏幕 可以滑动
//        CGFloat currentX = 0;
//        for (int idx = 0; idx < self.titlesArr.count; idx++) {
//            UIButton *btn = [self.itemBtnArr safeObjectAtIndex:idx];
//            titleFont = _titleFont;
//            CGFloat itemBtnWidth = [ABSegmentTitleView getWidthWithString:[self.titlesArr safeObjectAtIndex:idx] font:titleFont] + self.itemMargin;
//            CGFloat itemBtnHeight = CGRectGetHeight(self.bounds);
//            btn.frame = CGRectMake(currentX, 0, itemBtnWidth, itemBtnHeight);
//            currentX += itemBtnWidth;
//        }
//        self.scrollView.contentSize = CGSizeMake(currentX, CGRectGetHeight(self.scrollView.bounds));
    }
    [self moveIndicatorView:YES];
}

- (void)moveIndicatorView:(BOOL)animated
{
    UIFont *titleFont = _titleFont;
    UIButton *selectBtn = [self.itemBtnArr safeObjectAtIndex:self.selectIndex]; 
    titleFont = titleFont;
   
    [UIView animateWithDuration:(0.05) animations:^{
        
        self.indicatorView.center = CGPointMake(selectBtn.center.x, CGRectGetHeight(self.scrollView.bounds) - 1);
        self.indicatorView.bounds = CGRectMake(0, 0, 25 , 3);//长度不需要和文字等长indicatorWidth
        
    } completion:^(BOOL finished) {
        [self scrollSelectBtnCenter:animated];
    }];
}

- (void)scrollSelectBtnCenter:(BOOL)animated
{
    UIButton *selectBtn = [self.itemBtnArr safeObjectAtIndex:self.selectIndex];
    CGRect centerRect = CGRectMake(selectBtn.center.x - CGRectGetWidth(self.scrollView.bounds)/2, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView scrollRectToVisible:centerRect animated:animated];
}

#pragma mark --LazyLoad

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray*)itemBtnArr
{
    if (!_itemBtnArr) {
        _itemBtnArr = [[NSMutableArray alloc]init];
    }
    return _itemBtnArr;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
        _indicatorView.layer.cornerRadius = 3 * 0.5;
        [self.scrollView addSubview:_indicatorView];
    }
    return _indicatorView;
}

#pragma mark --Setter

- (void)setTitlesArr:(NSArray *)titlesArr
{
    _titlesArr = titlesArr;
    [self.itemBtnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.itemBtnArr = nil;
    
    for (int i = 0; i < titlesArr.count; i ++) {
        NSString *title = [titlesArr safeObjectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + kBtnTag;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = _titleFont;
        [self.scrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemBtnArr addObject:btn];
        
        UILabel *bageLab = [[UILabel alloc]init];
        bageLab.backgroundColor = kLabelText_Commen_Color_ea007e;
        bageLab.layer.cornerRadius = 12 * 0.5;
        bageLab.layer.masksToBounds = YES;
        bageLab.tag = kBageTag + i;
        bageLab.text = @"0";
        bageLab.textAlignment = NSTextAlignmentCenter;
        bageLab.font = [UIFont systemFontOfSize:10];
        bageLab.textColor = UIColor.whiteColor;
        bageLab.hidden = YES;
        [btn addSubview:bageLab];
        
    }
    
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setItemMargin:(CGFloat)itemMargin
{
    _itemMargin = itemMargin;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
//    if (_selectIndex == selectIndex||_selectIndex < 0) {//||_selectIndex > self.itemBtnArr.count - 1
//        return;
//    }
//
    UIButton *lastBtn = [self.scrollView viewWithTag:_selectIndex + kBtnTag];
    lastBtn.selected = NO;
    
    lastBtn.titleLabel.font = _titleFont;
    _selectIndex = selectIndex;
    UIButton *currentBtn = [self.scrollView viewWithTag:_selectIndex + kBtnTag];
    currentBtn.selected = YES;
    currentBtn.titleLabel.font = _titleFont;

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (UIButton *btn in self.itemBtnArr) {
        btn.titleLabel.font = titleFont;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setBagesArr:(NSArray *)bagesArr
{
    _bagesArr = bagesArr;
    _numArr = [NSMutableArray array];
    for (int i = 0; i < _bagesArr.count; i++) {
        NSString *numStr = [_bagesArr safeObjectAtIndex:i];
        if ([numStr floatValue] >99) {
            numStr = @"99+";
        }
        [_numArr safeAddObject:numStr];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    for (UIButton *btn in self.itemBtnArr) {
        [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    for (UIButton *btn in self.itemBtnArr) {
        [btn setTitleColor:titleSelectColor forState:UIControlStateSelected];
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
}


#pragma mark --Btn

- (void)btnClick:(UIButton *)btn
{
    NSInteger index = btn.tag - kBtnTag;
    if (index == self.selectIndex) {
        return;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ABSegmentTitleView:startIndex:endIndex:)]) {
        [self.delegate ABSegmentTitleView:self startIndex:self.selectIndex endIndex:index];
    }
    self.selectIndex = index;
}

#pragma mark Private
/**
 计算字符串长度
 
 @param string string
 @param font font
 @return 字符串长度
 */
+ (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}


@end
