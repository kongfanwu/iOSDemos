//
//  GKGLAddCustomer.m
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLAddCustomerVC.h"
#import "GKGLAddCustomerCell.h"
#import "GKGLCellModel.h"
#import "MzzCustomerRequest.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetStringPicker.h"
#import "UserManager.h"
#import "ActionSheetDatePicker.h"
#import "NSString+Check.h"
#import "RolesTools.h"
//#import <CoreActionSheetPicker/ActionSheetDatePicker.h>
@interface GKGLAddCustomerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)UIButton * submitBtn;
@property (nonatomic, strong)NSMutableArray *storeDataSource;
@property (nonatomic, strong)NSMutableArray *jisDataSource;
@property (nonatomic, strong)NSMutableArray *pickDataSource;
@property (nonatomic, strong)NSMutableArray *cardDataSource;
@property (nonatomic, assign)NSInteger selectIndex;
@property (nonatomic, copy)NSString * storeCode;
@property (nonatomic, copy)NSString * imp;
@property (nonatomic, copy)NSString * jis;
@property (nonatomic, copy)NSString * last_fw_time;
@property (nonatomic, copy)NSString * lastSelectStoreCode;
@end

@implementation GKGLAddCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _storeDataSource = [[NSMutableArray alloc] init];
    _jisDataSource = [[NSMutableArray alloc] init];
    _pickDataSource = [[NSMutableArray alloc] init];
    _dataSource = [[NSMutableArray alloc] init];
    if ([RolesTools getUserMainRole] == 8 ||[RolesTools getUserMainRole] == 9||[RolesTools getUserMainRole] == 10) {
        LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        _jis = infomodel.data.account;
        [_dataSource addObjectsFromArray:@[[GKGLCellModel createModelTitle:@"顾客姓名：" placeHolder:@"请输入会员姓名" cellType:CellTypeInput],[GKGLCellModel createModelTitle:@"手机号：" placeHolder:@"请输入会员手机号" cellType:CellTypeInput],[GKGLCellModel createModelTitle:@"顾客属性：" placeHolder:@"请选择顾客属性" cellType:CellTypeUnknow],[GKGLCellModel createModelTitle:@"所属门店：" placeHolder:@"请选择所属门店" cellType:CellTypeUnknow],[GKGLCellModel createModelTitle:@"归属技师：" placeHolder:@"" value:infomodel.data.name cellType:CellTypeUnknow],[GKGLCellModel createModelTitle:@"最后到店：" placeHolder:@"请选择最后到店时间" cellType:CellTypeUnknow]]];
    }else{
        [_dataSource addObjectsFromArray:@[[GKGLCellModel createModelTitle:@"顾客姓名：" placeHolder:@"请输入会员姓名" cellType:CellTypeInput],[GKGLCellModel createModelTitle:@"手机号：" placeHolder:@"请输入会员手机号" cellType:CellTypeInput],[GKGLCellModel createModelTitle:@"顾客属性：" placeHolder:@"请选择顾客属性" cellType:CellTypeUnknow],[GKGLCellModel createModelTitle:@"所属门店：" placeHolder:@"请选择所属门店" cellType:CellTypeUnknow],[GKGLCellModel createModelTitle:@"归属技师：" placeHolder:@"请选择所属技师" cellType:CellTypeUnknow],[GKGLCellModel createModelTitle:@"最后到店：" placeHolder:@"请选择最后到店时间" cellType:CellTypeUnknow]]];
    }
    
    [self.navView setNavViewTitle:@"添加顾客" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.submitBtn];
    
    [self requestStoreData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav , SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav ) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.scrollEnabled = NO;
    }
    return _tbView;
}
- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.frame = CGRectMake(15, 380, SCREEN_WIDTH - 15 * 2, 44);
        _submitBtn.titleLabel.font = FONT_SIZE(17);
        _submitBtn.backgroundColor = kColorTheme;
        _submitBtn.layer.cornerRadius = 3;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn addTarget:self action:@selector(requestSubmitData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLAddCustomerCell = @"kGKGLAddCustomerCell";
    GKGLAddCustomerCell * addCustomer = [tableView dequeueReusableCellWithIdentifier:kGKGLAddCustomerCell];
    if (!addCustomer) {
        addCustomer =  loadNibName(@"GKGLAddCustomerCell");
    }
    __weak typeof(self) _self = self;
    addCustomer.GKGLAddCustomerCellBlock = ^(GKGLCellModel * _Nonnull model) {
        __strong typeof(_self) self = _self;
        [self.dataSource replaceObjectAtIndex:[self.dataSource indexOfObject:model] withObject:model];
    };
    [addCustomer updateGKGLAddCustomerCellModel:_dataSource[indexPath.row]];
    return addCustomer;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    GKGLAddCustomerCell * cell = [_tbView cellForRowAtIndexPath:indexPath.row]
    _selectIndex = indexPath.row;
    [_pickDataSource removeAllObjects];
    if (indexPath.row == 2) {
        [_pickDataSource addObjectsFromArray:@[@"已有卡老顾客",@"新顾客"]];
        
    }else if (indexPath.row == 3){
        for (NSDictionary * dict in _storeDataSource) {
            [_pickDataSource addObject:dict[@"store_name"]];
        }
    }else if (indexPath.row == 4){
        for (NSDictionary * dict in _jisDataSource) {
            [_pickDataSource addObject:dict[@"name"]];
        }
    }else if(indexPath.row == 5){
        [[[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date]
                                               target:self action:@selector(dateWasSelected:element:) origin:[_tbView cellForRowAtIndexPath:indexPath]] showActionSheetPicker];
    }else{}
    if (_pickDataSource.count ==0) return;
    [ActionSheetStringPicker showPickerWithTitle:nil rows:_pickDataSource initialSelection:0 target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:[_tbView cellForRowAtIndexPath:indexPath]];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    NSIndexPath * IndexPath = [_tbView indexPathForCell:(GKGLAddCustomerCell *)element];
    GKGLCellModel * model = _dataSource[IndexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    model.value = _last_fw_time = [formatter stringFromDate:selectedDate];
    [_tbView reloadData];
}
- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    NSIndexPath * IndexPath = [_tbView indexPathForCell:(GKGLAddCustomerCell *)element];
    GKGLCellModel * model = _dataSource[IndexPath.row];
    model.value = _pickDataSource[selectedIndex.integerValue];
    
    if (_selectIndex == 2) {
        if ([selectedIndex integerValue] == 0) {
            _imp = @"1";
        }else if ([selectedIndex integerValue] == 1){
            _imp = @"0";
        }else{}
    }else if (_selectIndex == 3){
        NSString * selectName = model.value;
        for (NSDictionary * dict in _storeDataSource) {
            if ([dict[@"store_name"] isEqualToString:selectName]) {
                _storeCode = dict[@"store_code"];
                if (![_lastSelectStoreCode isEqualToString:_storeCode]) {
                    GKGLCellModel * model = _dataSource[_selectIndex + 1];
                    model.value = @"";
                    _jis = nil;
                }
                _lastSelectStoreCode = _storeCode;
                [self requestJisData];
            }
        }
    }else if (_selectIndex == 4){
        NSString * selectName = model.value;
        for (NSDictionary * dict in _jisDataSource) {
            if ([dict[@"name"] isEqualToString:selectName]) {
                _jis = dict[@"account"];
            }
        }
    }
    /** 门店 */
    /** 技师默认展示逻辑 */
//    NSString * selectName = model.value;
//    if (IndexPath.row == 3) {
//        for (NSDictionary * dict in _storeDataSource) {
//            if ([dict[@"store_name"] isEqualToString:selectName]) {
//                NSString * storeCode = dict[@"store_code"];
//                LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
//                if ([infomodel.data.store_code isEqualToString:storeCode]) {
//                    GKGLCellModel * model = _dataSource[4];
//                    model.value = infomodel.data.name;
//                    [_tbView reloadData];
//                }
//            }
//        }
//    }
    [_tbView reloadData];
//    self.selectedIndex = [selectedIndex intValue];
//
//    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
//    self.animalTextField.text = (self.animals)[(NSUInteger) self.selectedIndex];
}
- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark ------网络请求------
/** 提交数据 */
- (void)requestSubmitData
{
    [self.view endEditing:YES];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    GKGLCellModel * model0 = _dataSource[0];
    NSString * name = model0.value;
    
    GKGLCellModel * model1 = _dataSource[1];
    NSString * mobile = model1.value;
    if (name.length <= 0) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入顾客姓名"];
        return;
    }
    if (mobile.length <= 0) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入顾客手机号"];
        return;
    }
    if (![mobile isMobileNumber]) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入正确顾客手机号"];
        return;
    }
    if (_imp.length <= 0) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择顾客属性"];
        return;
    }
    if (_storeCode.length <= 0) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择顾客归属门店"];
        return;
    }
    if (_jis.length <= 0) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择顾客归属技师"];
        return;
    }
    if (_last_fw_time.length <= 0) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择顾客最后到店时间"];
        return;
    }
    [param setValue:name?name:@"" forKey:@"name"];
    [param setValue:mobile?mobile:@"" forKey:@"mobile"];
    [param setValue:_imp?_imp:@"" forKey:@"imp"];
    if ([RolesTools getUserMainRole] == 8 ||[RolesTools getUserMainRole] == 9||[RolesTools getUserMainRole] == 10) {
        _storeCode = _storeDataSource[0][@"store_code"];
         LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        _jis = infomodel.data.account;
    }
    [param setValue:_storeCode?_storeCode:@"" forKey:@"store_code"];
    [param setValue:_jis?_jis:@"" forKey:@"jis"];
    [param setValue:_last_fw_time?_last_fw_time:@"" forKey:@"last_fw_time"];
    _submitBtn.userInteractionEnabled = NO;
    [MzzCustomerRequest requestGKGLAddCustomer:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"提交成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:2];
        }else{}
        _submitBtn.userInteractionEnabled = YES;
    }];
}
/** 获取门店数据 */
- (void)requestStoreData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_ADDCUSTOMER_STORELIST_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_storeDataSource addObjectsFromArray:resultDic[@"list"]];
            if ([RolesTools getUserMainRole] == 8 ||[RolesTools getUserMainRole] == 9||[RolesTools getUserMainRole] == 10) {
                GKGLCellModel * model = _dataSource[3];
                model.value = _storeDataSource[0][@"store_name"];
                _storeCode = _storeDataSource[0][@"store_code"];
                _lastSelectStoreCode = _storeCode;
                [_tbView reloadData];
            }
        }else{}
    }];
}
/** 获取技师数据 */
- (void)requestJisData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_storeCode?_storeCode:@"" forKey:@"store_code"];
    [param setValue:@"jis" forKey:@"type"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_ADDCUSTOMER_JISLIST_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_jisDataSource removeAllObjects];
            [_jisDataSource addObjectsFromArray:resultDic[@"list"]];
            
        }else{}
    }];
}
@end
