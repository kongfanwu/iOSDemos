//
//  XMHAlertContentBottomView.m
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/25.
//

#import "XMHAlertContentBottomView.h"
#import "XMHAlertTool.h"
#import "UIView+Exting.h"
#import "XMHAlertAction.h"

@interface XMHAlertContentBottomView()
///
@property (nonatomic, strong) CALayer *topLayer;
@end

@implementation XMHAlertContentBottomView

- (CALayer *)createLayer {
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = kLineColor.CGColor;
    return layer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.topLayer = [self createLayer];
    [self.layer addSublayer:_topLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _topLayer.frame = CGRectMake(0, 0, self.width, kLineHeight);
    if (_actions.count > 0) {
        [self removeAllSubViews];
        if (_actions.count == 1) {
            UIButton *button = [XMHAlertAction buttonFromAction:_actions.firstObject];
            button.frame = CGRectMake(0, kLineHeight, self.width, self.height - kLineHeight);
            [self addSubview:button];
        }
        else if (_actions.count == 2) {
            for (CALayer *layer in self.layer.sublayers) {
                if (layer != _topLayer) [layer removeFromSuperlayer];
            }
            
            CGFloat buttonWidth = (self.width - kLineHeight) / 2.f;
            
            UIButton *firstButton = [XMHAlertAction buttonFromAction:_actions.firstObject];
            firstButton.frame = CGRectMake(0, kLineHeight, buttonWidth, self.height - kLineHeight);
            [self addSubview:firstButton];
            
            CALayer *layer = [self createLayer];
            layer.frame = CGRectMake(firstButton.right, kLineHeight, kLineHeight, self.height - kLineHeight);
            [self.layer addSublayer:layer];
            
            UIButton *lastButton = [XMHAlertAction buttonFromAction:_actions.lastObject];
            lastButton.frame = CGRectMake(buttonWidth + kLineHeight, kLineHeight, buttonWidth, firstButton.height);
            [self addSubview:lastButton];
        }
    }
}



@end
