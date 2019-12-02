//
//  XMHTicketVC.m
//  xmh
//
//  Created by KFW on 2019/3/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTicketVC.h"
#import "XMHTicketModel.h"
#import "XMHTicketCell.h"

@interface XMHTicketVC () <UITableViewDelegate, UITableViewDataSource>
/** <##> */
@property (nonatomic, strong) NSArray *useModelArray, *noModelArray;
/**  */
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
/** <##> */
@property (nonatomic, strong) UIButton *useButton, *noButton;
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
/** <##> */
@property (nonatomic, strong) XMHTicketModel *selectModel;
@end

@implementation XMHTicketVC

- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(146, 146, 146);
    
    UIControl *bgViwe = [UIControl new];
    bgViwe.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:bgViwe];
    [bgViwe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof(self) _self = self;
    [bgViwe bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.contentView];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [self.contentView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.top.equalTo(_contentView);
    }];
    [closeBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [UILabel new];
    _titleLabel.textColor = kColor3;
    _titleLabel.font = FONT_SIZE(15);
    _titleLabel.text = @"优惠券";
    [_contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.equalTo(closeBtn.mas_left);
    }];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeBtn.mas_bottom);
        make.left.right.equalTo(_contentView);
        make.height.mas_equalTo(1);
    }];
    
    // 获取可使用，不可使用数据源
    self.useModelArray = [XMHTicketModel useModelArray:self.ticketModelArray];
    self.noModelArray = [XMHTicketModel noModelArray:self.ticketModelArray];
    
    // 初始化获取默认选中的数据
    [_useModelArray enumerateObjectsUsingBlock:^(XMHTicketModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(_self) self = _self;
        if (obj.select) {
            self.selectModel = obj;
            *stop = YES;
        }
    }];
    
    self.useButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_useButton setTitle:[NSString stringWithFormat:@"可用优惠券(%ld)", _useModelArray.count] forState:UIControlStateNormal];
    [_useButton setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    [_useButton setTitleColor:kColor6 forState:UIControlStateNormal];
    _useButton.titleLabel.font = FONT_SIZE(15);
    [_useButton addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_useButton];
    [_useButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.equalTo(_contentView).multipliedBy(0.5);
    }];
    
    UIView *buttonLineView = [self buttonLineView];
    [_useButton addSubview:buttonLineView];
    [buttonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 3));
        make.bottom.centerX.equalTo(_useButton);
    }];
    
    self.noButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_noButton setTitle:[NSString stringWithFormat:@"不可用优惠券(%ld)", _noModelArray.count] forState:UIControlStateNormal];
    [_noButton setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    [_noButton setTitleColor:kColor6 forState:UIControlStateNormal];
    _noButton.titleLabel.font = FONT_SIZE(15);
    [_noButton addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_noButton];
    [_noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.left.equalTo(_useButton.mas_right);
        make.height.mas_equalTo(40);
        make.width.equalTo(_contentView).multipliedBy(0.5);
    }];
    
    UIView *buttonLineView2 = [self buttonLineView];
    [_noButton addSubview:buttonLineView2];
    [buttonLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 3));
        make.bottom.centerX.equalTo(_noButton);
    }];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 106;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_useButton.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(_contentView);
    }];
    
    [self changeClick:_useButton];
}

- (UIView *)buttonLineView {
    UIView *buttonLineView = UIView.new;
    buttonLineView.backgroundColor = kBtn_Commen_Color;
    buttonLineView.layer.cornerRadius = 2;
    buttonLineView.layer.masksToBounds = YES;
    buttonLineView.tag = 1000;
    return buttonLineView;
}

#pragma mark - Lazy

- (UIView *)contentView {
    if (_contentView) return _contentView;
    
    CGFloat contentViewHeight = self.view.height * 0.73;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - contentViewHeight, self.view.width, contentViewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = _contentView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _contentView.layer.mask = cornerRadiusLayer;
    return _contentView;
}

#pragma mark - Event

- (void)changeClick:(UIButton *)sender {
    if (sender == _useButton) {
        _useButton.selected = YES;
        _noButton.selected = NO;
        UIView *buttonLineView = [_useButton viewWithTag:1000];
        buttonLineView.hidden = NO;
        
        UIView *buttonLineView2 = [_noButton viewWithTag:1000];
        buttonLineView2.hidden = YES;
        
        self.dataArray = _useModelArray;
    } else {
        _useButton.selected = NO;
        _noButton.selected = YES;
        
        UIView *buttonLineView = [_useButton viewWithTag:1000];
        buttonLineView.hidden = YES;
        
        UIView *buttonLineView2 = [_noButton viewWithTag:1000];
        buttonLineView2.hidden = NO;
        
        self.dataArray = _noModelArray;
    }
    [_tableView reloadData];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHTicketModel *model = _dataArray[indexPath.row];
    if ([model isKindOfClass:[XMHTicketModel class]]) {
        static NSString *cellIdentifier = @"Cell";
        XMHTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil) {
            cell = [[XMHTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell configModel:_dataArray[indexPath.row]];
        return cell;
    }
    return UITableViewCell.new;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (XMHTicketModel *model in _dataArray) {
        model.select = NO;
    }
    
    XMHTicketModel *model = _dataArray[indexPath.row];
    if ([model use] && self.selectModel != model) {
        model.select = YES;
        [tableView reloadData];
        
        self.selectModel = model;
    } else {
        self.selectModel = nil;
    }
    
    if (self.didSelectBlock) self.didSelectBlock(self, self.selectModel);
/** 选中 取消弹窗 ywl */
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
