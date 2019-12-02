//
//  GKGLCustomerInfoEditVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerInfoEditVC.h"
#import "GKGLAddCustomerCell.h"
#import "GKGLCellModel.h"
#import "ActionSheetDatePicker.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetStringPicker.h"
#import "MzzCustomerRequest.h"
#import "ActionSheetCustomPicker.h"
@interface GKGLCustomerInfoEditVC ()<UITableViewDelegate,UITableViewDataSource,ActionSheetCustomPickerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)UIButton * commitBtn;
@property (nonatomic, strong)NSMutableArray *classDataSource;
@property (nonatomic, strong)NSMutableArray *jisDataSource;
@property (nonatomic, strong)NSMutableArray *pickDataSource;
@property (nonatomic, strong)NSMutableArray *data0Source;
@property (nonatomic, strong)NSMutableArray *data1Source;
@property (nonatomic, strong)NSMutableArray *data2Source;
@property (nonatomic, copy)NSString * daogou;
@property (nonatomic, copy)NSString * classKey;
@property (nonatomic, copy)NSString * birthday;
@property (nonatomic, copy)NSString * area_name;
@property (nonatomic, copy)NSString * last_shop_time;
@property (nonatomic,strong) NSArray *addressArr; // 解析出来的最外层数组
@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,strong) ActionSheetCustomPicker *picker; // 选择器
@end

@implementation GKGLCustomerInfoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    _data0Source = [[NSMutableArray alloc] init];
    _data1Source = [[NSMutableArray alloc] init];
    _data2Source = [[NSMutableArray alloc] init];
    _classDataSource = [[NSMutableArray alloc] init];
    _jisDataSource = [[NSMutableArray alloc] init];
    _pickDataSource = [[NSMutableArray alloc] init];
    self.view.backgroundColor = kColorE;
    [self.navView setNavViewTitle:@"基本信息" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [_data0Source addObjectsFromArray:@[
                                        [GKGLCellModel createModelTitle:@"微信号：" placeHolder:@"请输入微信账号" value:_param[@"wx"] cellType:CellTypeInput],
                                        [GKGLCellModel createModelTitle:@"生日：" placeHolder:@"请选择会员生日" value:_param[@"birthday"] cellType:CellTypeUnknow]]
                                        ];
    [_data1Source addObjectsFromArray:@[
                                        [GKGLCellModel createModelTitle:@"会员等级：" placeHolder:@"请选择会员等级" value:_param[@"grade_name"] cellType:CellTypeUnknow],
                                        [GKGLCellModel createModelTitle:@"归属导购：" placeHolder:@"请选择归属导购" value:_param[@"dao_name"] cellType:CellTypeUnknow],
                                        [GKGLCellModel createModelTitle:@"最后消费：" placeHolder:@"请选择最后消费时间" value:_param[@"last_shop_time"] cellType:CellTypeUnknow]]
                                        ];
    [_data2Source addObjectsFromArray:@[
                                        [GKGLCellModel createModelTitle:@"现住地区：" placeHolder:@"请选择现住地区" value:_param[@"area_name"] cellType:CellTypeUnknow],
                                        [GKGLCellModel createModelTitle:@"详细地址：" placeHolder:@"请输入详细地址" value:_param[@"address"] cellType:CellTypeInput],
                                        [GKGLCellModel createModelTitle:@"工作单位：" placeHolder:@"请输入工作单位" value:_param[@"company"] cellType:CellTypeInput],
                                        [GKGLCellModel createModelTitle:@"担任职务：" placeHolder:@"请输入担任职务" value:_param[@"post"] cellType:CellTypeInput]]
                                        ];
    [_dataSource addObject:_data0Source];
    [_dataSource addObject:_data1Source];
    [_dataSource addObject:_data2Source];
    
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.commitBtn];
    
    [self requestDaoGOuData];
    [self requestCustomerClassData];
    
    if (self.selections.count) {
        self.index1 = [self.selections[0] integerValue];
        self.index2 = [self.selections[1] integerValue];
        self.index3 = [self.selections[2] integerValue];
    }
    //    [self getInformation];
    [self calculateFirstData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT -  Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        if (@available(iOS 11.0, *)) {
        //            _tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //        } else {
        //            self.edgesForExtendedLayout = UIRectEdgeNone;
        //        }
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.titleLabel.font = FONT_SIZE(17);
        _commitBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 44 - 90, SCREEN_WIDTH - 30, 44);
        [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _commitBtn.backgroundColor = kColorTheme;
        [_commitBtn addTarget:self action:@selector(requestCommitCustomerInfoData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLAddCustomerCell = @"kGKGLAddCustomerCell";
    GKGLAddCustomerCell * addCustomer = [tableView dequeueReusableCellWithIdentifier:kGKGLAddCustomerCell];
    if (!addCustomer) {
        addCustomer =  loadNibName(@"GKGLAddCustomerCell");
    }
    addCustomer.GKGLAddCustomerCellBlock = ^(GKGLCellModel * _Nonnull model) {
        [_dataSource[indexPath.section] replaceObjectAtIndex:[_dataSource[indexPath.section] indexOfObject:model] withObject:model];
    };
    [addCustomer updateGKGLAddCustomerCellModel:_dataSource[indexPath.section][indexPath.row]];
    return addCustomer;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section]count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[UIView alloc] init];
    footer.backgroundColor = kColorE;
    return footer;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_pickDataSource removeAllObjects];
    if ((indexPath.section == 0 && indexPath.row ==1)||(indexPath.section == 1 && indexPath.row == 2)) {
        [[[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date]
                                               target:self action:@selector(dateWasSelected:element:) origin:[_tbView cellForRowAtIndexPath:indexPath]] showActionSheetPicker];
    }
    if (indexPath.section == 1&&indexPath.row == 0) {
        for (NSDictionary * dict in _classDataSource) {
            [_pickDataSource addObject:dict[@"name"]];
        }
    }
    if (indexPath.section == 1&&indexPath.row == 1) {
        for (NSDictionary * dict in _jisDataSource) {
            [_pickDataSource addObject:dict[@"name"]];
        }
    }
    if (indexPath.section == 2 && indexPath.row ==0) {
        [self loadSheetPicker];
    }
    if (_pickDataSource.count ==0) return;
    [ActionSheetStringPicker showPickerWithTitle:nil rows:_pickDataSource initialSelection:0 target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:[_tbView cellForRowAtIndexPath:indexPath]];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.navView.backgroundColor = kColorTheme;
}
- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    NSIndexPath * IndexPath = [_tbView indexPathForCell:(GKGLAddCustomerCell *)element];
    GKGLCellModel * model = _dataSource[IndexPath.section][IndexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    model.value = [formatter stringFromDate:selectedDate];
    if ((IndexPath.section == 0 && IndexPath.row ==1)) {
        _birthday = model.value;
    }
    if ((IndexPath.section == 0 && IndexPath.row ==2)) {
        _last_shop_time = model.value;
    }
    [_tbView reloadData];
}
- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    NSIndexPath * IndexPath = [_tbView indexPathForCell:(GKGLAddCustomerCell *)element];
    GKGLCellModel * model = _dataSource[IndexPath.section][IndexPath.row];
    model.value = _pickDataSource[selectedIndex.integerValue];
    
    if (IndexPath.section == 1&&IndexPath.row == 0) {
        for (NSDictionary * dict in _classDataSource) {
            if ([dict[@"name"] isEqualToString:model.value]) {
                _classKey = dict[@"key"];
            }
        }
    }
    if (IndexPath.section == 1&&IndexPath.row == 1) {
        for (NSDictionary * dict in _jisDataSource) {
            if ([dict[@"name"] isEqualToString:model.value]) {
                _daogou = dict[@"account"];
            }
        }
    }
    [_tbView reloadData];
}
- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}
- (void)loadFirstData
{
    // 注意JSON后缀的东西和Plist不同，Plist可以直接通过contentOfFile抓取，Json要先打成字符串，然后用工具转换
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSLog(@"%@",path);
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    self.addressArr =  [NSJSONSerialization JSONObjectWithData:[((NSString *)jsonStr) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];;
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.addressArr)
    {
        NSString *name = dict.allKeys.firstObject;
        [firstName addObject:name];
    }
    // 第一层是省份 分解出整个省份数组
    self.provinceArr = firstName;
}
- (void)calculateFirstData
{
    // 拿出省的数组
    [self loadFirstData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.addressArr[self.index1] allValues].firstObject) {
        
        NSString *name1 = cityName.allKeys.firstObject;
        [cityNameArr addObject:name1];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    //                             index1对应省的字典         市的数组 index2市的字典   对应市的数组
    // 这里的allValue是取出来的大数组，取第0个就是需要的内容
    self.districtArr = [[self.addressArr[self.index1] allValues][0][self.index2] allValues][0];
}
- (void)loadSheetPicker
{
    self.picker = [[ActionSheetCustomPicker alloc]initWithTitle:@"" delegate:self showCancelButton:YES origin:self.view initialSelections:@[@(self.index1),@(self.index2),@(self.index3)]];
    self.picker.tapDismissAction  = TapActionSuccess;
    // 可以自定义左边和右边的按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
//    button.frame = CGRectMake(0, 0, 44, 44);
//    [button setTitle:@"取消" forState:UIControlStateNormal];
//
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
//    button1.frame = CGRectMake(0, 0, 44, 44);
//    [button1 setTitle:@"确定" forState:UIControlStateNormal];
//    [self.picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:button]];
//    [self.picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:button1]];
    
    //    [self.picker addCustomButtonWithTitle:@"再来一次" value:@(1)];
    [self.picker showActionSheetPicker];
}
#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate Implementation
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr[row];break;
        case 1: return self.countryArr[row];break;
        case 2:return self.districtArr[row];break;
        default:break;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    if (!label)
    {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
    }
    
    NSString * title = @"";
    switch (component)
    {
        case 0: title =   self.provinceArr[row];break;
        case 1: title =   self.countryArr[row];break;
        case 2: title =   self.districtArr[row];break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            //            [self calculateData];
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            //            [self calculateData];
            [self calculateFirstData];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
            self.index3 = row;
            break;
        default:break;
    }
}

- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}
// 点击done的时候回调
- (void)actionSheetPickerDidSucceed:(ActionSheetCustomPicker *)actionSheetPicker origin:(id)origin
{
    NSMutableString *detailAddress = [[NSMutableString alloc] init];
    if (self.index1 < self.provinceArr.count) {
        NSString *firstAddress = self.provinceArr[self.index1];
        [detailAddress appendString:firstAddress];
    }
    if (self.index2 < self.countryArr.count) {
        NSString *secondAddress = self.countryArr[self.index2];
        [detailAddress appendString:secondAddress];
    }
    if (self.index3 < self.districtArr.count) {
        NSString *thirfAddress = self.districtArr[self.index3];
        [detailAddress appendString:thirfAddress];
    }
    GKGLCellModel *model = _dataSource[2][0];
    model.value = detailAddress;
    _area_name = detailAddress;
    [_tbView reloadData];
}

- (NSArray *)provinceArr
{
    if (_provinceArr == nil) {
        _provinceArr = [[NSArray alloc] init];
    }
    return _provinceArr;
}
-(NSArray *)countryArr
{
    if(_countryArr == nil)
    {
        _countryArr = [[NSArray alloc] init];
    }
    return _countryArr;
}

- (NSArray *)districtArr
{
    if (_districtArr == nil) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}

-(NSArray *)addressArr
{
    if (_addressArr == nil) {
        _addressArr = [[NSArray alloc] init];
    }
    return _addressArr;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark ------网络请求------
/** 获取顾客基本信息 */
- (void)requestCommitCustomerInfoData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    GKGLCellModel * model0 = _dataSource[0][0];
    NSString * wx = model0.value;
    
    GKGLCellModel * model1 = _dataSource[2][1];
    NSString * address = model1.value;
    
    GKGLCellModel * model2 = _dataSource[2][2];
    NSString * company = model2.value;
    
    GKGLCellModel * model3 = _dataSource[2][3];
    NSString * post = model3.value;
    
    [param setValue:_param[@"id"]?_param[@"id"]:@"" forKey:@"user_id"];
    [param setValue:wx?wx:@"" forKey:@"wx"];
    [param setValue:_birthday?_birthday:@"" forKey:@"birthday"];
    [param setValue:_classKey?_classKey:@"" forKey:@"grade"];
    [param setValue:_daogou?_daogou:@"" forKey:@"dao"];
    [param setValue:_last_shop_time?_last_shop_time:@"" forKey:@"last_shop_time"];
    [param setValue:@"area_name" forKey:@"area_name"];
    [param setValue:address?address:@"" forKey:@"address"];
    [param setValue:company?company:@"" forKey:@"company"];
    [param setValue:post?post:@"" forKey:@"post"];
    [param setValue:_area_name?_area_name:@"" forKey:@"area_name"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CUSTOMERINFOEDIT_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_tbView reloadData];
            [XMHProgressHUD showOnlyText:@"修改成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:2];
        }else{}
    }];
}
/** 会员等级数据 */
- (void)requestCustomerClassData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CUSTOMERCLASS_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_classDataSource addObjectsFromArray:resultDic[@"list"]];
        }else{}
    }];
    
}
/** 导购数据数据 */
- (void)requestDaoGOuData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_param[@"store_code"]?_param[@"store_code"]:@"" forKey:@"store_code"];
    [param setValue:@"dao" forKey:@"type"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_ADDCUSTOMER_JISLIST_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_jisDataSource addObjectsFromArray:resultDic[@"list"]];
        }else{}
    }];
}
@end
