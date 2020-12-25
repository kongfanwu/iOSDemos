//
//  XMHAlertDefaultContentView.m
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//

#import "XMHAlertDefaultContentView.h"
#import "XMHAlertTool.h"
#import "UIView+Exting.h"
#import "XMHAlertAction.h"
#import "XMHAlertContentBottomView.h"

@interface XMHAlertDefaultContentView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) XMHAlertContentBottomView *bottomView;
@end

@implementation XMHAlertDefaultContentView

@synthesize titleText = _titleText;
@synthesize messageText = _messageText;
@synthesize actions = _actions;

- (NSMutableArray *)actions {
    if (_actions) return _actions;
    _actions = NSMutableArray.new;
    return _actions;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 280, 0);
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel = UILabel.new;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = kTitleColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel) return _contentLabel;
    _contentLabel = UILabel.new;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = kMessageColor;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    return _contentLabel;
}

- (XMHAlertContentBottomView *)bottomView {
    if (_bottomView) return _bottomView;
    _bottomView = XMHAlertContentBottomView.new;
    [self addSubview:_bottomView];
    return _bottomView;
}

- (CALayer *)createLayer {
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = kLineColor.CGColor;
    return layer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *lastView;
    CGFloat gap = 34;
    CGFloat topGap = 0;
    if (_titleText.length && _messageText.length) {
        self.titleLabel.text = _titleText;
        [_titleLabel sizeToFit];
        self.contentLabel.text = _messageText;
        [_contentLabel sizeToFit];
        
        topGap = 20;
        _titleLabel.frame = CGRectMake(gap, topGap, self.width - gap * 2, _titleLabel.size.height);
        _contentLabel.frame = CGRectMake(gap, _titleLabel.bottom + topGap, self.width - gap * 2, _contentLabel.size.height);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        lastView = _contentLabel;
    }
    else if (_titleText.length) {
        self.titleLabel.text = _titleText;
        [_titleLabel sizeToFit];
        
        topGap = 31;
        _titleLabel.frame = CGRectMake(gap, topGap, self.width - gap * 2, _titleLabel.size.height);
        lastView = _titleLabel;
    }
    else if (_messageText.length) {
        self.contentLabel.text = _messageText;
        [_contentLabel sizeToFit];
        
        topGap = 31;
        _contentLabel.frame = CGRectMake(gap, topGap, self.width - gap * 2, _contentLabel.size.height);
        lastView = _contentLabel;
    }
    
    if (_actions.count > 0) {
        self.bottomView.actions = _actions;
        self.bottomView.frame = CGRectMake(0, lastView.bottom + 20, self.width, 49);
        lastView = self.bottomView;
    }
    
    CGFloat height = _actions.count > 0 ? lastView.bottom : lastView.bottom + topGap;
    if (height > self.superview.height - 88) {
        height = self.superview.height - 88;
    }
    self.height = height;
    self.center = CGPointMake(self.superview.width / 2.f, self.superview.height / 2.f);
    
    [self addCornerRadiu:10.f];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
