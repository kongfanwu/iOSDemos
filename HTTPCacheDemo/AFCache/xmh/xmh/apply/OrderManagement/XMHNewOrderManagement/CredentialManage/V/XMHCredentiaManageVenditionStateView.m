//
//  XMHCredentiaManageVenditionStateView.m
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaManageVenditionStateView.h"

@interface XMHCredentiaManageVenditionStateView()
/** <##> */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation XMHCredentiaManageVenditionStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setStateArrray:(NSArray<XMHCredentiaOrderStateItemModel *> *)stateArrray {
    _stateArrray = stateArrray;
    [self loadSubView];
}

- (void)loadSubView {
    if (_stateArrray.count) {
        [self removeAllSubViews];
        
        NSMutableArray *buttons = NSMutableArray.new;
        self.buttons = buttons;
        for (int i = 0; i < _stateArrray.count; i++) {
            XMHCredentiaOrderStateItemModel *model = _stateArrray[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:model.title forState:UIControlStateNormal];
            [button setTitleColor:kColor6 forState:UIControlStateNormal];
            [button setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
            button.titleLabel.font = FONT_SIZE(14);
            [self addSubview:button];
            [buttons addObject:button];
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.selected = model.selcet;
            
            NSInteger badge = [model.badge integerValue];
            if (badge > 0) {
                UILabel *badgeLabel = UILabel.new;
                badgeLabel.backgroundColor = kBtn_Commen_Color;
                badgeLabel.font = FONT_SIZE(12);
                badgeLabel.textColor = UIColor.whiteColor;
                badgeLabel.layer.cornerRadius = 6;
                badgeLabel.layer.masksToBounds = YES;
                badgeLabel.textAlignment = NSTextAlignmentCenter;
                [button addSubview:badgeLabel];
                NSString *badgeNum;
                if (badge > 99) {
                    badgeNum = @"99+";
                }else{
                    badgeNum = model.badge;
                }
                badgeLabel.text = badgeNum;
                [badgeLabel sizeToFit];
                [badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(12);
                    make.width.mas_equalTo(badgeLabel.width + 10);
                    make.left.equalTo(button.titleLabel.mas_right).offset(-8);
                    make.bottom.equalTo(button.titleLabel.mas_top).offset(5);
                }];                
            }
            
            UIView *lineView = UIView.new;
            lineView.backgroundColor = kBtn_Commen_Color;
            lineView.layer.cornerRadius = 1.5;
            lineView.layer.masksToBounds = YES;
            lineView.tag = 2000;
            [button addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(25, 3));
                make.bottom.equalTo(button);
                make.centerX.equalTo(button);
            }];
            lineView.hidden = !button.selected;
        }
        
        [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self);
            make.bottom.equalTo(self);
        }];
        [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    }
}

- (void)buttonClick:(UIButton *)sender {
    NSInteger tag = sender.tag - 1000;
    XMHCredentiaOrderStateItemModel *model = _stateArrray[tag];
    
    for (XMHCredentiaOrderStateItemModel *amodel in _stateArrray) {
        amodel.selcet = NO;
    }
    model.selcet = YES;
    
    [self loadSubView];
    
    if (self.didSelectBlock) self.didSelectBlock(self, model);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
