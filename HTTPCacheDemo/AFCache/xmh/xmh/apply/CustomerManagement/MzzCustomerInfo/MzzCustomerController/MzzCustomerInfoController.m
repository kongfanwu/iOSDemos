//
//  MzzCustomerInfoController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzCustomerInfoController.h"
#import "MzzCustomerInfoCell.h"
#import "MzzCustomerRequest.h"
//#import <MBProgressHUD/MBProgressHUD.h>
#import "ShareWorkInstance.h"
#import "MzzDengjiModel.h"
#import "MzzStoreModel.h"
#import "MzzWaiterModel.h"
#import "CustomerManageViewController.h"
#import "NSString+Check.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
@interface MzzCustomerInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSArray *datalist;
@property (nonatomic ,strong)MzzAccountList *jishiList;
@property (nonatomic ,strong)MzzAccountList *daogouList;
@property (nonatomic ,strong)MzzDengjiModel *dengjiList;
@property (nonatomic ,strong)MzzStoreList *mendianList;
@property (nonatomic ,copy)NSString *uid;
@end

@implementation MzzCustomerInfoController
{
    UITableView *_tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self creatTableview];
    [self requsetData];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jishi) name:@"jishi" object:nil];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"基本信息" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)creatTableview{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.estimatedRowHeight = 0;
    _tableview.estimatedSectionHeaderHeight = 0;
    _tableview.estimatedSectionFooterHeight = 0;
    UIView * tbFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    tbFooter.backgroundColor = kBackgroundColor;
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(15, 55, tbFooter.width - 30, 44);
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    commitBtn.backgroundColor = kBtn_Commen_Color;
    [commitBtn addTarget:self action:@selector(commint) forControlEvents:UIControlEventTouchUpInside];
    [tbFooter addSubview:commitBtn];
    _tableview.tableFooterView = tbFooter;
    [self.view addSubview:_tableview];
}

- (void)setupCustomerId:(NSString *)uid storeCode:(NSString *)stordCode{
    //请求顾客基本信息
    _uid = uid;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:uid forKey:@"id"];
    [dic setValue:stordCode forKey:@"store_code"];
    [MzzCustomerRequest requestCustomerInfoParams:dic resultBlock:^(InfoModel *projectModel, BOOL isSuccess, NSDictionary *errorDic) {
   
        if (isSuccess) {
            _infoModel = projectModel;
            _infoModel.uid = uid;
            if (_infoModel.store_code) {
                 [self requestJisAndDaogou];
            }
             [self KVO];
            [_tableview reloadData];
        }
    }];
}
- (void)setInfoModel:(InfoModel *)infoModel{
    _infoModel = infoModel;
    if (!_infoModel) {
        _infoModel = [[InfoModel alloc] init];
        _infoModel.imp = -1;
        _infoModel.grade = -1;
         LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSInteger  framework_function_main_role = model.data.join_code[0].framework_function_main_role;
        if (framework_function_main_role == 8 || framework_function_main_role == 9 || framework_function_main_role == 10) {
            _infoModel.jis = model.data.account;
            _infoModel.jis_name = model.data.name;
        }
    }
     [self KVO];
    [_tableview reloadData];
    if (_infoModel.store_code) {
        [self requestJisAndDaogou];
    }
}
- (void)KVO{
    [_infoModel addObserver:self forKeyPath:@"store_name" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"store_name"]) {
        //门店筛选
        for (int i = 0; i <_mendianList.list.count; i++) {
            MzzStoreModel *store = [_mendianList.list objectAtIndex:i];
            if ([store.store_name isEqualToString:_infoModel.store_name]) {
                _infoModel.store_code = store.store_code;
            }
        }
        [self requestJisAndDaogou];
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)requsetData{
    //TODO
    _datalist = @[@[@{@"title":@"姓名",@"detitle":@"请输入会员姓名"},@{@"title":@"手机号",@"detitle":@"请输入会员手机号"},@{@"title":@"微信号",@"detitle":@"请输入会员微信号"},@{@"title":@"生日",@"detitle":@"请选择会员生日"}],@[@{@"title":@"顾客属性",@"detitle":@"请选择顾客属性"},@{@"title":@"会员等级",@"detitle":@"请选择会员等级"},@{@"title":@"所属门店",@"detitle":@"请选择所属门店"},@{@"title":@"归属技师",@"detitle":@"请选择归属技师"},@{@"title":@"归属导购",@"detitle":@"请选择归属导购"},@{@"title":@"进店时间",@"detitle":@"请选择入点时间"},@{@"title":@"最后到店",@"detitle":@"请选择最后到店时间"},@{@"title":@"最后消费",@"detitle":@"请选择最后消费时间"}],@[@{@"title":@"现住地区",@"detitle":@"请选择现住地区"},@{@"title":@"详细地址",@"detitle":@"请输入详细地址"},@{@"title":@"工作单位",@"detitle":@"请输入工作单位"},@{@"title":@"担任职务",@"detitle":@"请输入担任职务"}]];
    
    
   
    //请求会员等级信息
    [MzzCustomerRequest requestCustomerLevelParams:nil resultBlock:^(MzzDengjiModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        _dengjiList = listModel;
        [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    //请求门店信息
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    [MzzCustomerRequest requestStoreListParams:params resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        _mendianList = listModel;
        [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}


- (void)requestJisAndDaogou{
    //请求技师信息
    NSMutableDictionary *typeDic = [NSMutableDictionary dictionary];
    [typeDic setValue:@"jis" forKey:@"type"];
    [typeDic setValue:[ShareWorkInstance shareInstance].join_code forKey:@"join_code"];
    [typeDic setValue:_infoModel.store_code forKey:@"store_code"];
    [MzzCustomerRequest requestAccountParams:typeDic resultBlock:^(MzzAccountList *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
        _jishiList = customerMessageModel;
        [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    NSMutableDictionary *typeDic2 = [NSMutableDictionary dictionary];
    [typeDic2 setValue:@"dao" forKey:@"type"];
    [typeDic2 setValue:[ShareWorkInstance shareInstance].join_code forKey:@"join_code"];
    [typeDic2 setValue:_infoModel.store_code forKey:@"store_code"];
    //请求导购信息
    [MzzCustomerRequest requestAccountParams:typeDic2 resultBlock:^(MzzAccountList *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
        _daogouList = customerMessageModel;
        [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)commint{

    if (!_infoModel.name || [_infoModel.name isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入会员姓名"];
        return;
    }
    if (!_infoModel.mobile || [_infoModel.mobile isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入会员手机号"];
          return;
    }
    if ( ![_infoModel.mobile isMobileNumber]) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入正确手机号"];
        return;
    }
    if (_infoModel.imp == -1) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择会员属性"];
          return;
    }
//    if (_infoModel.grade == -1) {
//        [MzzHud toastWithTitle:@"提示" message:@"请选择会员等级"];
//          return;
//    }
    if (!_infoModel.store_name) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择所属门店"];
        return;
    }
    if (!_infoModel.jis_name ) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择归属技师"];
        return;
    }
    if (!_infoModel.last_fw_time ) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择最后到店时间"];
          return;
    }
    
    if ([_delegate respondsToSelector:@selector(customerInfoController:andCustomerInfo:)]) {
        //修改infoModel相关值
       
        
        //技师
        for (int i = 0; i <_jishiList.list.count; i++) {
            MzzAccountModel *account = [_jishiList.list objectAtIndex:i];
            if ([account.name isEqualToString:_infoModel.jis_name]) {
                _infoModel.jis = account.account;
            }
        }
        
        //导购
        for (int i = 0; i <_daogouList.list.count; i++) {
            MzzAccountModel *account = [_daogouList.list objectAtIndex:i];
            if ([account.name isEqualToString:_infoModel.dao_name]) {
                _infoModel.dao = account.account;
            }
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"mobile"] = _infoModel.mobile;
        if (![_infoModel.uid isEqualToString:@""]) {
            params[@"id"] = _infoModel.uid;
        }
        
        [MzzCustomerRequest requestCustomerFreezeParams:params resultBlock:^(NSNumber *ID, BOOL isSuccess, NSDictionary *errorDic) {
            if (ID.integerValue ==0) {
                //不是冻结
                if ([_delegate respondsToSelector:@selector(customerInfoController:andCustomerInfo:)]) {
                    [_delegate customerInfoController:self andCustomerInfo:_infoModel];
                }
                [XMHProgressHUD showOnlyText:@"用户基本信息已保存"];
                [self performSelector:@selector(back) withObject:nil afterDelay:2];
//                [[[MzzHud alloc] initWithTitle:@"提示" message:@"用户基本信息已保存" centerButtonTitle:@"确定" click:^(NSInteger index) {
//                    [self.navigationController popViewControllerAnimated:NO];
//                }]show];
            }else{
                //是冻结
                [[[MzzHud alloc] initWithTitle:@"提示" message:@"该用户已被冻结" leftButtonTitle:@"取消" rightButtonTitle:@"激活" click:^(NSInteger index) {
                    if (index == 0) {
                        //取消
                    }else{
                        //激活
                        NSMutableDictionary *params = [NSMutableDictionary dictionary];
                        params[@"id"] = ID;
                        params[@"store_code"] = _infoModel.store_code;
                        params[@"jis"] = _infoModel.jis;
                        [MzzCustomerRequest requestCustomerActivatParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                            if (isSuccess) {
                                [XMHProgressHUD showOnlyText:@"激活成功"];
                                for (UIViewController *temp in self.navigationController.viewControllers) {
                                    if ([temp isKindOfClass:[CustomerManageViewController class]]) {
                                        [self.navigationController popToViewController:temp animated:NO];
                                    }
                                }
                            }else{
                                [XMHProgressHUD showOnlyText:@"激活失败"];
                            }
                        }];
                    }
                }]show];
            }
        }];
    }
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//修改数据并刷新对应cell
- (void)refreshDataListWithTextField:(UITextField *)textField andIndexpath:(NSIndexPath *)indexPath{

    switch (indexPath.section ) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    _infoModel.name  = textField.text;
                }
                    break;
                case 1:
                {
                     _infoModel.mobile  = textField.text;
                    
                }
                    break;
                case 2:
                {
                    _infoModel.wx  = textField.text;
                }
                    break;
                case 3:
                {
                    
                    _infoModel.birthday = textField.text;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    if ([textField.text isEqual:@"已有卡项顾客"]) {
                        _infoModel.imp = 1;
                    }else if ([textField.text isEqual:@"新顾客"]){
                        _infoModel.imp = 0;
                    }else{
                         _infoModel.imp = -1;
                    }
                }
                    break;
                case 1:
                {
                    MzzPickerTextField *pickerTield =(MzzPickerTextField *) textField;
                    _infoModel.grade = pickerTield.selectKey;
                    _infoModel.grade_name = pickerTield.selectStr;
                }
                    break;
                case 2:
                {
                      _infoModel.store_name = textField.text;
                }
                    break;
                case 3:
                {
                     _infoModel.jis_name = textField.text;
                }
                    break;
                case 4:
                {
                     _infoModel.dao_name = textField.text;
                }
                    break;
                case 5:
                {
                    
                    _infoModel.jd_time = textField.text;
                }
                    break;
                case 6:
                {
                   
                    _infoModel.last_fw_time = textField.text;
                }
                    break;
                case 7:
                {
                    
                    _infoModel.last_shop_time = textField.text;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    _infoModel.area_name = textField.text;
                }
                    break;
                case 1:
                {
                     _infoModel.address = textField.text;
                }
                    break;
                case 2:
                {
                     _infoModel.company = textField.text;
                }
                    break;
                case 3:
                {
                     _infoModel.post = textField.text;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    [_tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
}

#pragma mark - tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section ==0) {
        return 0;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _datalist.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _datalist[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *info = @"infocell";
    static NSString *picker = @"pickercell";
    static NSString *date = @"datecell";
    static NSString *address = @"address";
    WeakSelf;
    MzzCustomerInfoCell *infocell;
    MzzCustomerInfoPickerCell *pickcell;
    MzzCustomerInfoDatePickerCell *datecell;
    MzzCustomeAddressPickerCell *addresscell;
    
    if ((indexPath.section==0 && (indexPath.row==0 ||indexPath.row==1  ||indexPath.row==2)) ||(indexPath.section==2 && (indexPath.row==1 ||indexPath.row==2  ||indexPath.row==3 ))) {
        //普通输入框
        if (!infocell) {
            infocell = [[MzzCustomerInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:info];
        }
        NSArray *arr = _datalist[indexPath.section];
        [infocell setupData:arr[indexPath.row] andIndexPath:indexPath andInfoModel:_infoModel];
        if ((indexPath.section ==0)&&(indexPath.row==0 ||indexPath.row==1) ) {
            [infocell ismust:YES];
        }
        if ((indexPath.section ==1)&&(indexPath.row==0 ||indexPath.row==2 ||indexPath.row==3||indexPath.row==6) ) {
            [infocell ismust:YES];
        }
        infocell.returnclick = ^(UITextField *textField) {
            [weakSelf refreshDataListWithTextField:textField andIndexpath:indexPath];
        };
         return infocell;
    } else if ((indexPath.section==0 &&indexPath.row==3)||((indexPath.section ==1)&&(indexPath.row==5 ||indexPath.row==6||indexPath.row==7) )){
        //日期输入框
        if (!datecell) {
            datecell = [[MzzCustomerInfoDatePickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:date];
        }
        NSArray *arr = _datalist[indexPath.section];
        [datecell setupData:arr[indexPath.row] andIndexPath:indexPath andInfoModel:_infoModel];
        if ((indexPath.section ==0)&&(indexPath.row==0 ||indexPath.row==1) ) {
            [datecell ismust:YES];
        }
        if ((indexPath.section ==1)&&(indexPath.row==0 ||indexPath.row==2 ||indexPath.row==3||indexPath.row==6) ) {
            [datecell ismust:YES];
        }
        datecell.doneclick = ^(UITextField *textField) {
            [weakSelf refreshDataListWithTextField:textField andIndexpath:indexPath];
        };
        
        datecell.cencelclick = ^(UITextField *textField) {
            [_tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
        };
        datecell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return datecell;
    }else if (indexPath.section ==2 && indexPath.row ==0 ){
     
        if (!addresscell) {
            addresscell = [[MzzCustomeAddressPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:address];
        }
            NSArray *arr = _datalist[indexPath.section];
            [addresscell setupData:arr[indexPath.row] andIndexPath:indexPath andInfoModel:_infoModel];
            addresscell.doneclick = ^(UITextField *textField) {
                [weakSelf refreshDataListWithTextField:textField andIndexpath:indexPath];
            };
            
            addresscell.cencelclick = ^(UITextField *textField) {
                [_tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
            };
            addresscell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return addresscell;
        }else{
        //选择器输入框
        if (!pickcell) {
            pickcell = [[MzzCustomerInfoPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picker];
        }
            if (indexPath.section == 1 && indexPath.row ==2) {
                pickcell.isStore = YES;
                if (_billInfoDic) {
                    pickcell.haveBillInfo = YES;
                }else{
                    pickcell.haveBillInfo = NO;
                }
            }
        NSArray *arr = _datalist[indexPath.section];
//        [pickcell setupData:arr[indexPath.row] andIndexPath:indexPath andInfoModel:_infoModel];
        if ((indexPath.section ==0)&&(indexPath.row==0 ||indexPath.row==1) ) {
            [pickcell ismust:YES];
        }
        if ((indexPath.section ==1)&&(indexPath.row==0 ||indexPath.row==2 ||indexPath.row==3||indexPath.row==6) ) {
            [pickcell ismust:YES];
        }
        if ((indexPath.section ==1) && indexPath.row==0 ) {
            //设置属性数据源
            NSArray *datalist = @[@"已有卡项顾客",@"新顾客"];
            [pickcell setupPickerdata:datalist];
        }
        if ((indexPath.section ==1) && indexPath.row==1 ) {
                [pickcell setupPickerdata:_dengjiList.list];
        }
        if ((indexPath.section ==1) && indexPath.row==2 ) {
            //设置门店数据源
            NSMutableArray *marr = [NSMutableArray array];
            for (int i = 0; i <_mendianList.list.count; i ++) {
                MzzStoreModel *store = [_mendianList.list objectAtIndex:i];
                if (store.store_name) {
                    [marr addObject:store.store_name];
                }
            }
            if (marr.count > 0) {
                [pickcell setupPickerdata:marr];
            }
            pickcell.textField.isStore = YES;
        }
        if ((indexPath.section ==1) && indexPath.row==3 ) {
            //设置技师数据源
            
            NSMutableArray *marr = [NSMutableArray array];
            for (int i = 0; i <_jishiList.list.count; i ++) {
                MzzAccountModel *account = [_jishiList.list objectAtIndex:i];
                if (account.name) {
                    [marr addObject:account.name];
                }
            }
            
            if (marr.count > 0) {
                [pickcell setupPickerdata:marr];
            }
        }
        if ((indexPath.section ==1) && indexPath.row==4 ) {
            //设置导购数据源
            NSMutableArray *marr = [NSMutableArray array];
            for (int i = 0; i <_daogouList.list.count; i ++) {
                MzzAccountModel *account = [_daogouList.list objectAtIndex:i];
                if (account.name) {
                    [marr addObject:account.name];
                }
            }
            if (marr.count > 0) {
                [pickcell setupPickerdata:marr];
            }
        }
        pickcell.doneclick = ^(UITextField *textField) {
            [weakSelf refreshDataListWithTextField:textField andIndexpath:indexPath];
        };
        
        pickcell.cencelclick = ^(UITextField *textField) {
            [_tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
        };
        [pickcell setupData:arr[indexPath.row] andIndexPath:indexPath andInfoModel:_infoModel];
        pickcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return pickcell;
    }

}

#pragma mark - Table View Delegate


-(void)dealloc{
    [_infoModel removeObserver:self forKeyPath:@"store_name" context:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)jishi{
    _infoModel.jis = nil;
    _infoModel.jis_name = nil;
    _infoModel.dao = nil;
    _infoModel.dao_name = nil;
    [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

@end
