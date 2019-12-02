//
//  XMHSalesOrderJishiSelectorVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSalesOrderJishiSelectorVC.h"
#import "SLRequest.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "MLJishiSearchModel.h"
#import "XMHSelectJiShiCell.h"
@interface XMHSalesOrderJishiSelectorVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) UITextField *textField;
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
/** <##> */
@property (nonatomic, strong) NSArray *dataArray;
/** <##> */
@property (nonatomic, strong) MLJiShiModel *selectJiShiModel;
@end


@implementation XMHSalesOrderJishiSelectorVC


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
    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [closeBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    closeBtn.titleLabel.font = FONT_SIZE(15);
    [_contentView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(_contentView);
        make.left.mas_equalTo(5);
    }];
    [closeBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kLabelText_Commen_Color_ea007e forState:UIControlStateNormal];
    sureBtn.titleLabel.font = FONT_SIZE(15);
    [_contentView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(_contentView);
        make.right.mas_equalTo(-5);
    }];
    [sureBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        if (self.selectBlock) self.selectBlock(self, self.selectJiShiModel);
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeBtn.mas_bottom);
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.equalTo(_contentView);
    }];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    searchBtn.titleLabel.font = FONT_SIZE(15);
    [_contentView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(lineView.mas_bottom).offset(4);
        make.right.mas_equalTo(-5);
    }];
    [searchBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self.view endEditing:YES];
        
        // 搜索技师数据
        [self getDataText:self.textField.text];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:UIImageName(@"order_search")];
    leftView.frame = CGRectMake(5, 0, 16, 17);
    
    UIView *leftBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16 + 10, 17)];
    [leftBGView addSubview:leftView];
    
    self.textField = [[UITextField alloc] init];
    _textField.layer.cornerRadius = 3;
    _textField.layer.masksToBounds = YES;
    _textField.backgroundColor = kColorF5F5F5;
    _textField.font = FONT_SIZE(14);
    _textField.placeholder = @"搜索外店技师，输入姓名/手机号";
    [_textField setValue:kColor9 forKeyPath:@"_placeholderLabel.textColor"];
    _textField.leftView = leftBGView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [_contentView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBtn);
        make.left.mas_equalTo(15);
        make.right.equalTo(searchBtn.mas_left).offset(-15);
        make.height.mas_equalTo(34);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textField.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(_contentView);
    }];
    
    [self requestJishuDada];
}

/**
 获取技术数据
 */
- (void)requestJishuDada
{
    _dataArray = [NSMutableArray array];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    NSString *store_code = [ShareWorkInstance shareInstance].store_code;
    if (store_code) {
        [parms setValue:store_code forKey:@"store_code"];
    }
    NSString * framId = [NSString stringWithFormat:@"%ld",model.data.join_code[0].fram_id];
    [parms setValue:framId?framId:@"" forKey:@"fram_id"];
    [SLRequest requesSearchJisParams:parms resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _dataArray = model.list;
            [self.tableView reloadData];
        }
    }];
}

/**
 搜索技术
 
 @param text 搜索字段
 */
- (void)getDataText:(NSString *)text {
    // 搜索技师数据
    NSNumber *framId = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = framId;
    params[@"q"] = text;
    [SLRequest requesSearchJisParams:params resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        self.dataArray = model.list;
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Lazy

- (UIView *)contentView {
    if (_contentView) return _contentView;
    
    CGFloat contentViewHeight = self.view.height * 0.47;
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

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHSelectJiShiCell *cell = [XMHSelectJiShiCell createCellWithTable:tableView];
    [cell configureWithModel:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (MLJiShiModel *jiShiModel in _dataArray) {
        jiShiModel.isSelect = NO;
    }
    MLJiShiModel *jiShiModel = _dataArray[indexPath.row];
    jiShiModel.isSelect = YES;
    [tableView reloadData];
    
    self.selectJiShiModel = jiShiModel;
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
