//
//  MineInformationController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/14.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MineInformationController.h"
#import "MineInfoLocalModel.h"
#import "MineInfoIconCell.h"
#import "MineInfoTextCell.h"
#import "MineInfoTitleCell.h"
#import "MineRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "MineInformationModel.h"
#import <YYWebImage/YYWebImage.h>
#import "MineInfoChangePhoneController.h"
#import "MineInfoSexCell.h"
#import "MineInfoDateCell.h"
#import "ActionSheetCustomPicker.h"
#import "YYModel.h"
#import "Base64.h"

#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"

@interface MineInformationController ()<UITableViewDelegate,UITableViewDataSource,ActionSheetCustomPickerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate, TZImagePickerControllerDelegate>
@property (nonatomic,strong) NSArray *addressArr; // 解析出来的最外层数组
@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,strong) ActionSheetCustomPicker *picker; // 选择器


@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic,strong) UITableView * tb;
@property (nonatomic,strong) NSArray * models;
@property (nonatomic,strong) MineInformationModel * informationModel;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * uid;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,strong) UIImage * imgIcon;
@end

@implementation MineInformationController
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WeakSelf
    [self.navView setNavViewTitle:@"我的资料" backBtnShow:YES rightBtnTitle:@"提交"];
    self.navView.backgroundColor = kBtn_Commen_Color;
    self.navView.NavViewRightBlock = ^{
        [weakSelf subimt];
    };
    [self initBaseData];
    [self initSubViews];
    if (self.selections.count) {
        self.index1 = [self.selections[0] integerValue];
        self.index2 = [self.selections[1] integerValue];
        self.index3 = [self.selections[2] integerValue];
    }
//    [self getInformation];
    [self calculateFirstData];
    
}
- (void)initBaseData
{
    _models = @[@[[MineInfoLocalModel initWithTitle:@"头像" content:nil isShow:YES]],@[[MineInfoLocalModel initWithTitle:@"真是姓名:" content:nil isShow:NO],[MineInfoLocalModel initWithTitle:@"手机号:" content:nil isShow:YES],[MineInfoLocalModel initWithTitle:@"账号:" content:nil isShow:NO]],@[[MineInfoLocalModel initWithTitle:@"实名信息:" content:nil isShow:YES],[MineInfoLocalModel initWithTitle:@"性别:" content:nil isShow:YES],[MineInfoLocalModel initWithTitle:@"身份证号:" content:nil isShow:NO],[MineInfoLocalModel initWithTitle:@"出生日期:" content:nil isShow:YES],[MineInfoLocalModel initWithTitle:@"地区:" content:nil isShow:YES],[MineInfoLocalModel initWithTitle:@"现住地区:" content:nil isShow:NO],[MineInfoLocalModel initWithTitle:@"银行卡号:" content:nil isShow:NO],]];
    
}
- (void)getInformation
{
    
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    _uid = accountId;
    [MineRequest requestInformationId:accountId resultBlock:^(MineInformationModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _informationModel = model;
            [_tb reloadData];
        }
    }];
}
- (void)initSubViews
{
//    [self creatNav];
    [self createTb];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"我的资料" withleftImageStr:@"back" withRightStr:@"提交"];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnRight addTarget:self action:@selector(subimt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)subimt
{
    if (!(_sex.length > 0)) {
        if ([_informationModel.sex isEqualToString:@"男"]) {
            _sex = @"1";
        }else{
            _sex = @"2";
        }
    }
//    NSData * data = UIImagePNGRepresentation(_imgIcon);
    NSData * data = [_imgIcon imageCompressToData];
    NSString * imgData = [Base64 stringByEncodingData:data];
    [MineRequest requestModdfyInformationUid:_uid headImg:imgData name:_informationModel.name sex:_sex idCard:_informationModel.id_card birthday:_informationModel.birth_day area:_informationModel.area address:_informationModel.address phone:nil code:nil bankCard:nil bank:_informationModel.bank_card openBank:nil cardholder:nil resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self getInformation];
        }
    }];
}
- (void)createTb
{
    UITableView * tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStyleGrouped];
    tb.dataSource = self;
    tb.delegate = self;
    tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    tb.backgroundColor = kColorF5F5F5;
    tb.sectionHeaderHeight = 10.f;
    tb.sectionFooterHeight = 0.0f;
    _tb = tb;
    [self.view addSubview:tb];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        MineInfoIconCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MineInfoIconCell" owner:nil options:nil]lastObject];
        cell.lbTitle.text = @"头像";
        cell.btn.hidden = NO;
        [cell.imgV yy_setImageWithURL:[NSURL URLWithString:_informationModel.head_img] placeholder:kDefaultCustomerImage];
        return cell;
    }else if (indexPath.section ==1){
        MineInfoTextCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MineInfoTextCell" owner:nil options:nil]lastObject];
        if (indexPath.row ==0) {
            cell.lbTitle.text = @"真实姓名:";
            cell.tfContent.text = _informationModel.name;
        }else if (indexPath.row==1){
            cell.lbTitle.text = @"手机号:";
            cell.tfContent.text = _informationModel.phone;
            cell.btnMore.hidden = NO;
            cell.tfContent.userInteractionEnabled = NO;
             _informationModel.phone = cell.tfContent.text;
        }else{
//            cell.lbTitle.text = @"账号:";
//            cell.tfContent.text = _informationModel.account;
//            cell.tfContent.userInteractionEnabled = NO;
        }
        return cell;
        
    }else{
        if (indexPath.row ==0) {
           MineInfoTitleCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MineInfoTitleCell" owner:nil options:nil]lastObject];
           cell.lbTitle.text = @"实名信息";
           return cell;
        }else{
            MineInfoSexCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MineInfoSexCell" owner:nil options:nil]lastObject];
            if (indexPath.row ==1){
                cell.lbTitle.text = @"性别:";
                cell.tfContent.text = _informationModel.sex;
                if (!(_informationModel.sex.length > 0)) {
                    cell.tfContent.placeholder = @"请选择性别";
                }
                [cell.tfContent setupData:@[@"男",@"女"]];
                __weak typeof(self) _self = self;
                cell.tfContent.doneclick = ^(UITextField *textField) {
                    __strong typeof(_self) self = _self;
                    if ([textField.text isEqualToString:@"男"]) {
                        self.sex = @"1";
                    }else{
                        self.sex = @"2";
                    }
                };
                _informationModel.sex = cell.tfContent.text;
                return cell;
            
            }else if (indexPath.row ==3) {
                MineInfoDateCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MineInfoDateCell" owner:nil options:nil]lastObject];
                cell.lbTitle.text = @"出生日期:";
                cell.tfContent.text = _informationModel.birth_day;
                if (!(_informationModel.birth_day.length > 0)) {
                    cell.tfContent.placeholder = @"请选择出生日期";
                }
                __weak typeof(self) _self = self;
                cell.tfContent.doneclick = ^(UITextField *textField) {
                    __strong typeof(_self) self = _self;
                    self.informationModel.birth_day = textField.text;
                };
                return cell;
            }else{
                 MineInfoTextCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"MineInfoTextCell" owner:nil options:nil]lastObject];
                    if (indexPath.row ==2){
                    cell.lbTitle.text = @"身份证号:";
                    cell.tfContent.text = _informationModel.id_card;
                    if (!(_informationModel.id_card.length > 0)) {
                        cell.tfContent.placeholder = @"请填写身份证号";
                    }
                        __weak typeof(self) _self = self;
                    cell.MineInfoTextCellBlockBlock = ^(NSString *str) {
                        __strong typeof(_self) self = _self;
                        self.informationModel.id_card  = str;
                    };
                }else if (indexPath.row ==4){
                    cell.lbTitle.text = @"地区:";
                    cell.tfContent.text = _informationModel.area;
                    if (_address.length > 0) {
                        cell.tfContent.text = _address;
                    }
                    if (!(_informationModel.area.length > 0)) {
                        cell.tfContent.placeholder = @"请选择省份市区";
                    }
                    _informationModel.area = cell.tfContent.text;
                    cell.btnMore.hidden = NO;
                    cell.tfContent.userInteractionEnabled = NO;
                }else if (indexPath.row ==5){
                    cell.lbTitle.text = @"现住地区:";
                    cell.tfContent.text = _informationModel.address;
                    if (!(_informationModel.address.length > 0)) {
                        cell.tfContent.placeholder = @"请输入详细地址";
                    }
                    __weak typeof(self) _self = self;
                    cell.MineInfoTextCellBlockBlock = ^(NSString *str) {
                        __strong typeof(_self) self = _self;
                        self.informationModel.address = str;
                    };
                }else{
                    cell.lbTitle.text = @"银行卡号:";
                    cell.tfContent.text = _informationModel.bank_card;
                    if (!(_informationModel.bank_card.length > 0)) {
                        cell.tfContent.placeholder = @"请输入银行卡号";
                    }
                    _informationModel.bank_card = cell.tfContent.text;
                }
                return cell;
            }
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else if (section ==1){
        return 2;
    }else{
        return 6;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==2){
        if (indexPath.row ==0) {
            return 32;
        }else{
            return 44;
        }
    }else{
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {//修改头像
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
        [sheet showInView:self.view];
#pragma clang diagnostic pop
    }else if (indexPath.section ==1){
        if (indexPath.row ==1) {//修改手机号
            MineInfoChangePhoneController * next = [[MineInfoChangePhoneController alloc] initWithNibName:@"MineInfoChangePhoneController" bundle:[NSBundle mainBundle]];
            [next infoModel:_informationModel];
            [self.navigationController pushViewController:next animated:NO];
        }
    }else{
        if (indexPath.row ==0) {//实名信息
            
        }else if (indexPath.row ==1){//选择性别
            
        }else if (indexPath.row ==2){//身份证号
            
        }else if (indexPath.row ==3){//出生日期
            
            
        }else if (indexPath.row ==4){//地区
            [self loadSheetPicker];
        }if (indexPath.row ==5){//现住地区
//            [self loadSheetPicker];
        }else{//银行卡号
            
        }
    }
}
- (void)loadSheetPicker
{
    self.picker = [[ActionSheetCustomPicker alloc]initWithTitle:@"选择地区" delegate:self showCancelButton:YES origin:self.view initialSelections:@[@(self.index1),@(self.index2),@(self.index3)]];
    self.picker.tapDismissAction  = TapActionSuccess;
    // 可以自定义左边和右边的按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, 44, 44);
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [self.picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:button]];
    [self.picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:button1]];
    
    //    [self.picker addCustomButtonWithTitle:@"再来一次" value:@(1)];
    [self.picker showActionSheetPicker];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getInformation];
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

    _address = detailAddress;
    [_tb reloadData];
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
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(id)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushTZImagePickerController];
    }
}
#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
#pragma clang diagnostic pop
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            __weak typeof(self) _self = self;
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        __strong typeof(_self) self = _self;
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
#pragma clang diagnostic pop

    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        __weak typeof(self) _self = self;
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            __strong typeof(_self) self = _self;
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}
#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
  WeakSelf
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:weakSelf pushPhotoPickerVc:YES];
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif =NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.width - 2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    __weak typeof(self) _self = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        __strong typeof(_self) self = _self;
        
        self.imgIcon = photos[0];
        [weakSelf subimt];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerVc = imagePickerController;
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        _imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    _imgIcon = image;  //给UIimageView赋值已经选择的相片
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
@end
