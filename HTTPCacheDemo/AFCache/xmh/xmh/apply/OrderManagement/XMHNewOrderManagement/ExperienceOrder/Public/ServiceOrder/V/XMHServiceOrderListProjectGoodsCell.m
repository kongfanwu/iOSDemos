//
//  XMHServiceOrderListProjectCell.m
//  xmh
//
//  Created by KFW on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderListProjectGoodsCell.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "MLJishiSearchModel.h"
#import "XMHServiceProjectModel.h"
#import "XMHServiceGoodsModel.h"

@interface XMHServiceOrderListProjectGoodsCell()
/** uibu */
@property (nonatomic, strong) UIButton *deleteButton, *addButton;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel, *dateLabel, *serviceLabel;
/** <##> */
@property (nonatomic, strong) UIView *finishUsingBGView;
/** <##> */
@property (nonatomic, strong) UIButton *trueButton, *falseButton;
/** <##> */
@property (nonatomic, strong) UILabel *jiShiTitleLabel;
/** <##> */
@property (nonatomic, strong) UIView *jiShiBgView;
@end

@implementation XMHServiceOrderListProjectGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:UIImageName(@"order_close") forState:UIControlStateNormal];
        [self.contentView addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
        }];
        __weak typeof(self) _self = self;
        [_deleteButton bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            if (self.deleteBlock) self.deleteBlock(self);
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(14);
        _titleLabel.textColor = kColor3;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
            make.right.equalTo(_deleteButton.mas_left);
        }];
        
        self.dateLabel = UILabel.new;
        _dateLabel.font = FONT_SIZE(12);
        _dateLabel.textColor = kColor9;
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        }];
        
        [self.contentView addSubview:self.finishUsingBGView];
        [self.finishUsingBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(172);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(-37);
            make.centerY.equalTo(_dateLabel);
        }];
        
        self.jiShiTitleLabel = UILabel.new;
        _jiShiTitleLabel.font = FONT_SIZE(12);
        _jiShiTitleLabel.textColor = kColor9;
        [self.contentView addSubview:_jiShiTitleLabel];
        [_jiShiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(_dateLabel.mas_bottom).offset(10);
        }];
        
        self.jiShiBgView = UIView.new;
        [self.contentView addSubview:_jiShiBgView];
        [_jiShiBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_jiShiTitleLabel);
            make.left.equalTo(_jiShiTitleLabel.mas_right);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
    }
    return self;
}

- (UIView *)finishUsingBGView {
    if (_finishUsingBGView) return _finishUsingBGView;
    _finishUsingBGView = UIView.new;
    
    UILabel *titleLabel = UILabel.new;
    titleLabel.font = FONT_SIZE(12);
    titleLabel.textColor = kColor9;
    titleLabel.text = @"是否用完";
    [_finishUsingBGView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.equalTo(_finishUsingBGView);
    }];
    
    UIButton *trueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.trueButton = trueButton;
    [trueButton setTitle:@"是" forState:UIControlStateNormal];
    [trueButton setTitleColor:kColor9 forState:UIControlStateNormal];
    trueButton.titleLabel.font = FONT_SIZE(12);
    [trueButton setImage:UIImageName(@"service_normal") forState:UIControlStateNormal];
    [trueButton setImage:UIImageName(@"service_select") forState:UIControlStateSelected];
    [trueButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_finishUsingBGView addSubview:trueButton];
    [trueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 25));
        make.left.equalTo(titleLabel.mas_right);
        make.centerY.equalTo(_finishUsingBGView);
    }];
    [trueButton setTitleEdgeInsets:UIEdgeInsetsMake(0, trueButton.imageView.frame.size.width + 5, 0.0,0.0)];
    trueButton.selected = YES;
    
    UIButton *falseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.falseButton = falseButton;
    [falseButton setTitle:@"否" forState:UIControlStateNormal];
    [falseButton setTitleColor:kColor9 forState:UIControlStateNormal];
    falseButton.titleLabel.font = FONT_SIZE(12);
    [falseButton setImage:UIImageName(@"service_normal") forState:UIControlStateNormal];
    [falseButton setImage:UIImageName(@"service_select") forState:UIControlStateSelected];
    [falseButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_finishUsingBGView addSubview:falseButton];
    [falseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 25));
        make.right.equalTo(_finishUsingBGView);
        make.centerY.equalTo(_finishUsingBGView);
    }];
    [falseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, falseButton.imageView.frame.size.width + 5, 0.0,0.0)];
    
    return _finishUsingBGView;
}

- (void)loadJiShiViewModelList:(NSArray <MLJiShiModel *> *)modelList {
    _jiShiTitleLabel.text = modelList.count ? @"服务技师：" : @"请选择技师：";

    [_jiShiBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *lastNameLabel;
    for (int i = 0; i < modelList.count; i++) {
        MLJiShiModel *model = modelList[i];
        
        UILabel *nameLabel = UILabel.new;
        nameLabel.font = FONT_SIZE(12);
        nameLabel.textColor = kColor9;
        nameLabel.text = model.name;
        [_jiShiBgView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            if (lastNameLabel) {
                make.top.equalTo(lastNameLabel.mas_bottom).offset(10);
            } else {
                make.top.mas_equalTo(0);
            }
        }];
        
        lastNameLabel = nameLabel;
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:UIImageName(@"qingkong") forState:UIControlStateNormal];
        deleteButton.tag = 1000 + i;
        [_jiShiBgView addSubview:deleteButton];
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.equalTo(nameLabel);
            make.right.mas_equalTo(-5);
        }];
        // 删除技师
        __weak typeof(self) _self = self;
        [deleteButton bk_addEventHandler:^(UIButton *sender) {
            __strong typeof(_self) self = _self;
            NSInteger tag = sender.tag - 1000;
            SLS_Pro *amodel = (SLS_Pro *)self.model;
            [amodel.jiShiList removeObjectAtIndex:tag];
            [self loadJiShiViewModelList:amodel.jiShiList];
            
            if (self.deleteJiShiBlock) self.deleteJiShiBlock(self, self.indexPath);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:UIImageName(@"service_add") forState:UIControlStateNormal];
    [_jiShiBgView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(-5);
        make.bottom.equalTo(_jiShiBgView);
        if (lastNameLabel) {
            make.top.equalTo(lastNameLabel.mas_bottom);
        } else {
            make.top.mas_equalTo(0);
        }
    }];
    // 添加技师
    __weak typeof(self) _self = self;
    [addButton bk_addEventHandler:^(UIButton *sender) {
        __strong typeof(_self) self = _self;
        if (self.addJiShiBlock) self.addJiShiBlock(self, self.indexPath);
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureWithModel:(id)model {
    [super configureWithModel:model];
    SLS_Pro *amodel = (SLS_Pro *)model;
    // 项目
    if ([model isKindOfClass:[SLS_Pro class]] || [model isKindOfClass:[SLPro_ListM class]] ||
        [model isKindOfClass:[XMHServiceProjectModel class]]) {
        _finishUsingBGView.hidden = YES;
    }
    // 产品
    else if ([model isKindOfClass:[SLGoodModel class]] || [model isKindOfClass:[SLGoods_ListM class]] ||
             [model isKindOfClass:[XMHServiceGoodsModel class]]) {
        _finishUsingBGView.hidden = NO;
    }
    _titleLabel.text = amodel.name;
    _dateLabel.text = [NSString stringWithFormat:@"%ld分钟", amodel.shichang];
    [self loadJiShiViewModelList:amodel.jiShiList];
    
    if (((SLGoodModel *)self.model).is_end) {
        self.trueButton.selected = YES;
        self.falseButton.selected = NO;
    } else {
        self.trueButton.selected = NO;
        self.falseButton.selected = YES;
    }
}

#pragma mark - Evnet

- (void)selectEvent:(UIButton *)sender {
    if (sender == _trueButton) {
        _trueButton.selected = YES;
        _falseButton.selected = NO;
        
        // 产品
        if ([self.model isKindOfClass:[SLGoodModel class]] || [self.model isKindOfClass:[SLGoods_ListM class]] || [self.model isKindOfClass:[XMHServiceGoodsModel class]]) {
            ((SLGoodModel *)self.model).is_end = YES;
        }
    } else {
        _trueButton.selected = NO;
        _falseButton.selected = YES;
        // 产品
        if ([self.model isKindOfClass:[SLGoodModel class]] || [self.model isKindOfClass:[SLGoods_ListM class]] || [self.model isKindOfClass:[XMHServiceGoodsModel class]]) {
            ((SLGoodModel *)self.model).is_end = NO;
        }
    }
}
@end
