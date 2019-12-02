//
//  XMHVipDiscountDetailBaseView.m
//  xmh
//
//  Created by 杜彩艳 on 2019/4/13.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHVipDiscountDetailBaseView.h"
#import "ZheKouModel.h"
#import "SASaleListModel.h"
#import "XMHBaseTableView.h"
#import "XMHVipDisDetailCell.h"
#import "XMHVipDisDetailCell.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHVipDiscountDetailBaseView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *zheKouStoredCards;//会员折扣数据

@property (nonatomic, strong) UIImageView *noDataView;//无数据

@property (nonatomic, strong)UILabel *couponLab;

@property (nonatomic, strong)XMHBaseTableView *tableView;
@end

@implementation XMHVipDiscountDetailBaseView
- (instancetype)initWithFrame:(CGRect)frame zheKouStoredCards:(NSMutableArray *)zheKouStoredCards model:(ZheKouStored_Card*)model;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zhekouModel = model;
        self.zheKouStoredCards = zheKouStoredCards;
        [self createSubViews];
    }
    return self;
}
- (void)setDetailModel:(SaleModel *)detailModel
{
    _detailModel = detailModel;
    self.couponLab.text = self.detailModel.name;
}
- (void)createSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = self.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.layer.mask = cornerRadiusLayer;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
     [closeBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.top.mas_equalTo(kMargin);
    }];
    
    UILabel *couponLab = [[UILabel alloc]init];
    couponLab.text = self.detailModel.name;
    couponLab.font = [UIFont systemFontOfSize:15];
    couponLab.textColor = kLabelText_Commen_Color_3;
    couponLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:couponLab];
    
    [couponLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.centerY.mas_equalTo(closeBtn.mas_centerY);
    }];
    self.couponLab = couponLab;
    
    UIView *line =[[UIView alloc]init];
    line.backgroundColor = Separator_LineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44);
        make.height.mas_equalTo(Separator_Line_Height);
        make.right.left.mas_equalTo(self);
    }];
    
    

    CGRect rect = self.frame;
    self.tableView = [[XMHBaseTableView alloc]initWithFrame:CGRectMake(0, 45, rect.size.width, rect.size.height - 45) style:UITableViewStylePlain];
    self.tableView.emptyEnable = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
}


#pragma mark -- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.zheKouStoredCards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * XMHVipDisDetailCellID = @"XMHVipDisDetailCellID";
    XMHVipDisDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:XMHVipDisDetailCellID];
    
    if (!cell) {
        cell = [[XMHVipDisDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XMHVipDisDetailCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColor.whiteColor;
    }
    
    ZheKouStored_Card *model = [self.zheKouStoredCards safeObjectAtIndex:indexPath.row];
    
    if (model.ID == self.zhekouModel.ID) {
        model.selected = self.zhekouModel.selected;
        self.zhekouModel = model;
    }else{
        model.selected = NO;
    }

    cell.selectedDetail = ^(ZheKouStored_Card * _Nonnull model) {
        self.zhekouModel = model;
        if (_selectedModel) {
            _selectedModel(model);
            
        }
    };
    [cell refreshCellModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZheKouStored_Card *model = [self.zheKouStoredCards safeObjectAtIndex:indexPath.row];
    if (_selectedModel) {
        _selectedModel(model);
        
    }
}
- (void)sureBtnClick
{
    [self removeFromSuperview];
    WeakSelf
    if (_selectedModel) {
        _selectedModel(weakSelf.zhekouModel);
        
    }
    
}


- (void)closeBtnClick
{
    [self removeFromSuperview];
   
    if (_selectedModel) {
        _selectedModel(_zhekouModel);
    }
}

@end
