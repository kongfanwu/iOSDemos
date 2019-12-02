//
//  XMHCredentialYejiShouHouView.m
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentialYejiShouHouView.h"

@interface XMHCredentialYejiShouHouView()
/** <##> */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation XMHCredentialYejiShouHouView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setDataArray:(NSArray<XMHCredentiaOrderStateItemModel *> *)dataArray {
    _dataArray = dataArray;
    [self loadSubView];
}

- (void)loadSubView {
    if (_dataArray.count) {
        [self removeAllSubViews];
        
        NSMutableArray *buttons = NSMutableArray.new;
        self.buttons = buttons;
        for (int i = 0; i < _dataArray.count; i++) {
            XMHCredentiaOrderStateItemModel *model = _dataArray[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.numberOfLines = 2;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setTitle:model.title forState:UIControlStateNormal];
            [button setTitleColor:kColor6 forState:UIControlStateNormal];
            [button setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
            button.titleLabel.font = FONT_SIZE(14);
            [self addSubview:button];
            [buttons addObject:button];
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.selected = model.selcet;
            
            UIView *lineView = UIView.new;
            lineView.backgroundColor = kColorE5E5E5;
            [button addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kSeparatorHeight);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(15);
                make.bottom.mas_equalTo(-15);
            }];
        }
        
        [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self);
            make.bottom.equalTo(self);
        }];
        [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        
        UIView *lineView2 = UIView.new;
        lineView2.backgroundColor = kColorE5E5E5;
        [self addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kSeparatorHeight);
            make.left.right.top.mas_equalTo(0);
        }];
    }
}

- (void)buttonClick:(UIButton *)sender {
    NSInteger tag = sender.tag - 1000;
    XMHCredentiaOrderStateItemModel *model = _dataArray[tag];
    
    for (XMHCredentiaOrderStateItemModel *amodel in _dataArray) {
        amodel.selcet = NO;
    }
    model.selcet = YES;
    
    [self loadSubView];
    
    self.selectMdoel = model;
    
    if (self.didSelectBlock) self.didSelectBlock(self, model);
}

@end
