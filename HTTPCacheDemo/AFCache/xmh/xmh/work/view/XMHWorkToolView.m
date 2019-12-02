//
//  XMHWorkToolView.m
//  xmh
//
//  Created by KFW on 2019/4/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHWorkToolView.h"

@implementation XMHWorkToolViewItemModel
+ (instancetype)createTitle:(NSString *)title imageName:(NSString *)imageName type:(XMHWorkToolViewType)type {
    XMHWorkToolViewItemModel *model = XMHWorkToolViewItemModel.new;
    model.title = title;
    model.imageName = imageName;
    model.type = type;
    return model;
}
@end

@interface XMHWorkToolView()
/** <##> */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** <##> */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation XMHWorkToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setRole:(NSInteger)role {
    _role = role;
    
    [self getData];
    
    [self loadSubView];
}

- (void)getData {
    /*
     、11导购
     
     店长 - 销售制单 服务制单 添加顾客
     4技术店长、5销售店长、6售前店长
     
     店经理 - 审批应用 会员调店 添加顾客
     1管理层、3店经理、
     
     前台 - 快速收款 添加顾客
     7前台、
     
     技师 - 销售制单 服务制单 一件预约 添加顾客
     8售后美容师、9售前美容师、10售中美容师、
     
     */
    
    self.dataArray = NSMutableArray.new;
    // 店长
    if (_role == 4 || _role == 5 || _role == 6) {
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"销售制单" imageName:@"huigongzuo_xiaoshouzhidan" type:XMHWorkToolViewTypeSales]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"服务制单" imageName:@"huigongzuo_fuwuzhidan" type:XMHWorkToolViewTypeService]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"添加顾客" imageName:@"huigongzuo_tianjiaguke" type:XMHWorkToolViewTypeAddUser]];
    }
    // 店经理
    else if (_role == 1 || _role == 3) {
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"审批应用" imageName:@"huigongzuo_shenpiyingyong" type:XMHWorkToolViewTypeShenPi]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"会员调店" imageName:@"huigongzuo_huiyuantiaodian" type:XMHWorkToolViewTypeTiaoDian]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"添加顾客" imageName:@"huigongzuo_tianjiaguke" type:XMHWorkToolViewTypeAddUser]];
    }
    // 前台
    else if (_role == 7) {
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"快速收款" imageName:@"huigongzuo__kuaisushoukuan" type:XMHWorkToolViewTypeShouKuan]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"添加顾客" imageName:@"huigongzuo_tianjiaguke" type:XMHWorkToolViewTypeAddUser]];
    }
    // 技师
    else if (_role == 8 || _role == 9 || _role == 10) {
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"销售制单" imageName:@"huigongzuo_xiaoshouzhidan" type:XMHWorkToolViewTypeSales]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"服务制单" imageName:@"huigongzuo_fuwuzhidan" type:XMHWorkToolViewTypeService]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"一键预约" imageName:@"huigongzuo_yijianyuyue" type:XMHWorkToolViewTypeYuYue]];
        [self.dataArray addObject:[XMHWorkToolViewItemModel createTitle:@"添加顾客" imageName:@"huigongzuo_tianjiaguke" type:XMHWorkToolViewTypeAddUser]];
    }
}

- (void)loadSubView {
    [self removeAllSubViews];
    self.buttons = NSMutableArray.new;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        XMHWorkToolViewItemModel *model = self.dataArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:UIImageName(model.imageName) forState:UIControlStateNormal];
        btn.tag = 1000 + i;
        [self addSubview:btn];
        __weak typeof(self) _self = self;
        [btn bk_addEventHandler:^(UIButton *sender) {
            __strong typeof(_self) self = _self;
            XMHWorkToolViewItemModel *model = self.dataArray[sender.tag - 1000];
            if (self.didSelectBlock) self.didSelectBlock(model);
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_buttons addObject:btn];
        
        UILabel *label = UILabel.new;
        label.font = FONT_SIZE(13);
        label.textColor = kColor3;
        label.text = model.title;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom).offset(5);
            make.centerX.equalTo(btn);
        }];
        
        if (model.type == XMHWorkToolViewTypeShouKuan) {
            btn.enabled = NO;
        }
    }

    if (_buttons.count > 1) {
        [_buttons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(49);
        }];
        [_buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:30 tailSpacing:30];
    }
}




@end
