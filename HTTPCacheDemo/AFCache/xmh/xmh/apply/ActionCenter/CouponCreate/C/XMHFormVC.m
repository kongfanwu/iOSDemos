//
//  XMHFormVC.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormVC.h"
#import "XMHFormTableView.h"
#import "XMHFormModel.h"
#import "XMHFormSectionModel.h"
#import "XMHFormDataCreate.h"
#import "XMHPickerView.h"
#import "XMHCouponStoreVC.h"
#import "XHMCouponMultipleAlertVC.h"
#import "XMHCouponRequest.h"
#import "XMHItemModel.h"
#import "XHMCouponPayAlertVC.h"
#import "XMHCouponGoodsVC.h"
#import "UIImagePickerController+BlocksKit.h"
#import "UIImageAdditions.h"
#import "UIImage+Reduce.h"
#import "ApproveRequest.h"
#import "Base64.h"
#import "XMHSuccessAlertView.h"
#import "XMHActionCenterSendVC.h"
#import "XMHSendCouponVC.h"

@interface XMHFormVC () <XMHFormTableViewDelegate, XMHPickerViewResultDelegate>
/** <##> */
@property (nonatomic, strong) XMHFormTableView *tableView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** <##> */
@property (nonatomic, strong) XMHFormDataCreate *formDataCreate;
/** <##> */
@property (nonatomic, strong) NSIndexPath *indexPath;
/** <##> */
@property (nonatomic, strong) XMHFormModel *currentModel;
/** <##> */
@property (nonatomic, strong) UIImagePickerController *picker;
/** <##> */
@property (nonatomic) BOOL isAction;
/** 激活需要支付价格 */
@property (nonatomic) CGFloat payPrice;
@end

@implementation XMHFormVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _couponType = XMHActionCouponTypeXianJin;
        self.isAction = NO;
        self.payPrice = 0;
        self.formDataCreate = XMHFormDataCreate.new;
        self.edit = YES;
        self.createType = XMHActionCreateTypeCreate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.edit) {
        [self.navView setNavViewTitle:@"创建" backBtnShow:YES];
    }else{
        [self.navView setNavViewTitle:@"优惠券详情" backBtnShow:YES];
    }
    
    self.navView.backgroundColor = kBtn_Commen_Color;
    self.view.backgroundColor = kBackgroundColor;
    
    UIButton *submitBtn;
    if (_edit) {
        submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
        [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        submitBtn.titleLabel.font = FONT_SIZE(17);
        submitBtn.backgroundColor = kColorTheme;
        [submitBtn cornerRadius:3];
        [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kSafeAreaBottom);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(44);
        }];
    }
    
    self.tableView = [[XMHFormTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.aDelegate = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSafeAreaTop + kNavigationBarHeight + 10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        if (_edit) {
            make.bottom.equalTo(submitBtn.mas_top).offset(-10);
        } else {
            make.bottom.mas_equalTo(-kSafeAreaBottom);
        }
    }];
    
    [self getData];
}

#pragma mark - request

- (void)getData {
    if (_couponType == XMHActionCouponTypeXianJin) {
        self.dataArray = [_formDataCreate createFormListCouponModel:_couponModel edit:_edit createType:_createType];
    } else if (_couponType == XMHActionCouponTypeZheKou) {
        self.dataArray = [_formDataCreate createFormZheKouListCouponModel:_couponModel edit:_edit createType:_createType];
    } else if (_couponType == XMHActionCouponTypeLiPin) {
        self.dataArray = [_formDataCreate createFormLiPinListCouponModel:_couponModel edit:_edit createType:_createType];
    }
    
    _tableView.dataArray = _dataArray;
    [_tableView reloadData];
    
    // 默认设置所有门店
    if (!_couponModel) {
        XMHFormModel *formMdoel = [_formDataCreate formModelfromServiceKey:@"store_codes"];
        [XMHCouponStoreVC getDataComplete:^(NSArray<XMHCouponStoreModel *> * _Nonnull dataArray) {
            formMdoel.dataArrayAll = YES;
            formMdoel.dataArray = dataArray;
            formMdoel.value = @"所有门店";
            [self.tableView reloadData];
        }];
    }
}

/**
 获取商家顾客等级
 */
- (void)getGradeDataComplete:(void(^)(NSArray *dataArray))complete {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    [XMHCouponRequest requestGradeParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        NSMutableArray *dataArray = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[XMHItemModel class] json:model.data[@"list"]];
        
        XMHItemModel *itemModel = XMHItemModel.new;
        itemModel.idStr = @"all";
        itemModel.title = @"全选";
        [dataArray insertObject:itemModel atIndex:0];
        
        if (complete) complete(dataArray);
    }];
}

#pragma mark - click

- (void)submitClick {
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    
    NSMutableDictionary *param = NSMutableDictionary.new;
    param[@"usable_type"] = @"2";
    param[@"token"] = model.data.token;
    param[@"id"] = _couponModel.uid;
    param[@"isSave"] = @(1);// 默认0：读取 ， 1：保存
    param[@"account"] = model.data.account;
    param[@"account_id"] = @(model.data.ID).stringValue;
    param[@"join_code"] = joinCode;

    NSMutableDictionary *rulesDic;
    NSMutableArray *rulesArray = NSMutableArray.new;
    
    for (int i = 0; i < _dataArray.count; i++) {
        XMHFormSectionModel *sectionModel = _dataArray[i];
        for (int j = 0; j < sectionModel.sectionArray.count; j++) {
            XMHFormModel *formModel = sectionModel.sectionArray[j];
            if (IsEmpty(formModel.serviceKey)) {
                continue;
            }
            NSLog(@"%@ %@", formModel.serviceKey, formModel.value);
            // 校验必填项
            __block NSString *desc;
            if (![XMHFormDataCreate checkMustParamFormModel:formModel block:^(NSString * _Nonnull des) {
                desc = des;
            }]) {
                [[[MzzHud alloc] initWithTitle:@"" message:desc leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:nil hiddenCancelBtn:YES] show];
                return;
            }
           
            // 优惠券类型
            if ([formModel.serviceKey isEqualToString:@"type"]) {
                param[formModel.serviceKey] = formModel.valueId;
            }
            // 使用限制 描述转id
            else if ([formModel.serviceKey isEqualToString:@"limit_type"]) {
                param[formModel.serviceKey] = formModel.valueId;
            }
            // 发放限制 描述转id
            else if ([formModel.serviceKey isEqualToString:@"purview"]) {
                param[formModel.serviceKey] = formModel.valueId;
            }
            // 使用期限
            else if ([formModel.serviceKey isEqualToString:@"delay"]) {
                param[formModel.serviceKey] = formModel.value;
                param[@"duration"] = formModel.value2;
            }
            // 可使用门店
            else if ([formModel.serviceKey isEqualToString:@"store_codes"]) {
                param[formModel.serviceKey] = [[XMHFormDataCreate getStoreCodeFormModel:formModel] yy_modelToJSONString];
            }
            // 会员等级
            else if ([formModel.serviceKey isEqualToString:@"vipLevel"]) {
                rulesDic = NSMutableDictionary.new;
                [rulesArray addObject:rulesDic];
//                rulesDic[@"rules[0][symbol]"] = @"and";
//                rulesDic[@"rules[0][type]"] = @(0);
//                rulesDic[@"rules[0][sort]"] = @(1);
//                rulesDic[@"rules[0][condition2]"] = @"";
//                rulesDic[@"rules[0][condition1]"] = [XMHFormDataCreate getVipLevelFormModel:formModel];
                rulesDic[@"symbol"] = @"and";
                rulesDic[@"type"] = @(0);
                rulesDic[@"sort"] = @(1);
                rulesDic[@"condition2"] = @"";
                rulesDic[@"condition1"] = [XMHFormDataCreate getVipLevelFormModel:formModel];
            }
            // 订单商品
            else if ([formModel.serviceKey isEqualToString:@"orderGoods"]) {
                rulesDic = NSMutableDictionary.new;
                [rulesArray addObject:rulesDic];
//                rulesDic[@"rules[1][symbol]"] = @"and";
//                rulesDic[@"rules[1][type]"] = @(1);
//                rulesDic[@"rules[1][sort]"] = @(2);
//                rulesDic[@"rules[1][condition2]"] = @"";
//                rulesDic[@"rules[1][condition1]"] = [XMHFormDataCreate getOrderGoodsFormModel:formModel];
                rulesDic[@"symbol"] = @"and";
                rulesDic[@"type"] = @(1);
                rulesDic[@"sort"] = @(2);
                rulesDic[@"condition2"] = @"";
                rulesDic[@"condition1"] = [XMHFormDataCreate getOrderGoodsFormModel:formModel];
            }
            // 使用渠道
            else if ([formModel.serviceKey isEqualToString:@"platform"]) {
                rulesDic = NSMutableDictionary.new;
                [rulesArray addObject:rulesDic];
//                rulesDic[@"rules[2][symbol]"] = @"and";
//                rulesDic[@"rules[2][type]"] = @(2);
//                rulesDic[@"rules[2][sort]"] = @(3);
//                rulesDic[@"rules[2][condition2]"] = @"";
//                rulesDic[@"rules[2][condition1]"] = [XMHFormDataCreate getPlatformFormModel:formModel];
                rulesDic[@"symbol"] = @"and";
                rulesDic[@"type"] = @(2);
                rulesDic[@"sort"] = @(3);
                rulesDic[@"condition2"] = @"";
                rulesDic[@"condition1"] = [XMHFormDataCreate getPlatformFormModel:formModel];
            }
            // 支付使用
            else if ([formModel.serviceKey isEqualToString:@"pay"]) {
                rulesDic = NSMutableDictionary.new;
                [rulesArray addObject:rulesDic];
                // isAction YES:激活可使用 NO:不激活可使用
//                NSDictionary *valueDic2 = [formModel.payModel yy_modelToJSONObject];
//                rulesDic[@"rules[3][symbol]"] = @"and";
//                rulesDic[@"rules[3][type]"] = @(5);
//                rulesDic[@"rules[3][sort]"] = @(4);
//                rulesDic[@"rules[3][condition2]"] = @"";
//                rulesDic[@"rules[3][condition1]"] = [valueDic2 yy_modelToJSONString];
                rulesDic[@"symbol"] = @"and";
                rulesDic[@"type"] = @(5);
                rulesDic[@"sort"] = @(4);
                rulesDic[@"condition2"] = @"";
                rulesDic[@"condition1"] = [formModel.payModel yy_modelToJSONObject];
                
            }
            else {
                param[formModel.serviceKey] = formModel.value;
            }
        }
    }
    
    param[@"rules"] = [rulesArray yy_modelToJSONString];
    
    NSLog(@"%@", [param yy_modelToJSONString]);
    [XMHCouponRequest requestCouponEditParams:param resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        XMHSuccessAlertView *successAlertView = [[XMHSuccessAlertView alloc] initWithTitle:self.couponModel ? @"修改成功" : @"创建成功" cancelButtonTitle:@"取消" otherButtonTitles:@"去发放" click:^(NSInteger index) {
            if (index == 0) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            XMHSendCouponVC * next = [[XMHSendCouponVC alloc] init];
            [self.navigationController pushViewController:next animated:YES];
            __weak typeof(self) _self = self;
            [next setNavigationBackBlock:^{
                __strong typeof(_self) self = _self;
                UIViewController *vc = [self searchNavigationStackStringVC:@"XMHCouponListVC"];
                [self.navigationController popToViewController:vc animated:YES];
            }];
        }];
        [successAlertView.otherBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
        [successAlertView show];
    }];
}

#pragma mark - XMHFormTableViewDelegate

/**
 切换优惠券类型
 */
- (void)didChangeCouponType:(XMHItemModel *)itemModel indexPath:(NSIndexPath *)indexPath {
    XMHFormSectionModel *sectionModel = _dataArray[indexPath.section];
    XMHFormModel *model = sectionModel.sectionArray[indexPath.row];
    if (!model.isEdit) return;
//    if (!_edit) return;
    
    // 相同不切换
    if (self.couponType == itemModel.type) return;
    
    self.couponType = itemModel.type;
    [self getData];
}

/**
 添加logo
 */
- (void)addPhotoClick:(XMHFormModel *)formModel {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    self.picker = picker;
    __weak typeof(self) _self = self;
    [picker setBk_didFinishPickingMediaBlock:^(UIImagePickerController *picker, NSDictionary *dic) {
        __strong typeof(_self) self = _self;
        UIImage *image = dic[UIImagePickerControllerOriginalImage];
        image = [image fixOrientation]; // 处理图片翻转
        image = [UIImage scaledCopyOfSize:CGSizeMake(300, 300) image:image]; // 等比缩放
        NSData *data = [image imageCompressToData]; // 转data
        NSArray *imgs = @[[Base64 stringByEncodingData:data]]; // base64
        // 上传
        [ApproveRequest requestUploadImg:imgs resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (!isSuccess) {
                [SVProgressHUD setInfoImage:UIImageName(@"1")];
                [SVProgressHUD showInfoWithStatus:@"上传图片失败"];
                return;
            }
            NSString *imageUrl = [model.data[@"list"] firstObject];
            MzzLog(@"imageUrl:%@", imageUrl)
            
            // 设置数据
            XMHFormModel *formMdoel = [self.formDataCreate formModelfromServiceKey:@"shop_logo"];
            formMdoel.value = imageUrl;
            [self.tableView reloadData];
        }];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [picker setBk_didCancelBlock:^(UIImagePickerController *picker) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.picker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"本地图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.picker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)tableView:(XMHFormTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    XMHFormSectionModel *sectionModel = _dataArray[indexPath.section];
    XMHFormModel *model = sectionModel.sectionArray[indexPath.row];
    self.currentModel = model;
    // 使用限制
    if ([model.serviceKey isEqualToString:@"limit_type"]) {
        if (!_edit) return;
        XMHPickerView *pickerView = [[XMHPickerView alloc] init];
        pickerView.type = PickerViewTypeUserLimits;
        pickerView.selectComponent = 0;
        pickerView.delegate = self;
        [self.view addSubview:pickerView]; 
    }
    //发放限制
    else if ([model.serviceKey isEqualToString:@"purview"]) {
        if (!_edit) return;
        XMHPickerView *pickerView = [[XMHPickerView alloc] init];
        pickerView.type = PickerViewTypeSendLimits;
        pickerView.selectComponent = 0;
        pickerView.delegate = self;
        [self.view addSubview:pickerView];
    }
    // 可使用门店
    else if ([model.serviceKey isEqualToString:@"store_codes"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XMHFormModel *formMdoel = [_formDataCreate formModelfromServiceKey:@"store_codes"];
            XMHCouponStoreVC *vc = XMHCouponStoreVC.new;
            vc.edit = _edit;
            vc.selectArray = (NSMutableArray *)formMdoel.dataArray;
            vc.dataArrayAll = formMdoel.dataArrayAll;
            [self presentViewController:vc animated:YES completion:nil];
            [vc setSelectBlock:^(NSMutableArray<XMHCouponStoreModel *> * _Nonnull selectList, BOOL isAll) {
                MzzLog(@"%@", selectList);
                formMdoel.dataArray = selectList;
                formMdoel.value = isAll ? @"所有门店" : [NSString stringWithFormat:@"已选择%ld家门店", selectList.count];
                formMdoel.dataArrayAll = isAll;
                [tableView reloadData];
            }];
        });
    }
    // 会员等级
    else if ([model.serviceKey isEqualToString:@"vipLevel"]) {
        __weak typeof(self) _self = self;
        [self getGradeDataComplete:^(NSArray *dataArray) {
            __strong typeof(_self) self = _self;
            XMHFormModel *formMdoel = [_formDataCreate formModelfromServiceKey:@"vipLevel"];
            XHMCouponMultipleAlertVC *vc = XHMCouponMultipleAlertVC.new;
            vc.edit = _edit;
            vc.titleStr = @"顾客等级";
            vc.dataArray = dataArray;
            vc.selectArray = formMdoel.dataArray;
            vc.dataArrayAll = formMdoel.dataArrayAll;
            [self presentViewController:vc animated:YES completion:nil];
            [vc setSelectBlock:^(NSMutableArray<XMHItemModel *> * _Nonnull selectList, BOOL isAll) {
                MzzLog(@"%@", selectList);
                
                NSMutableString *value = NSMutableString.new;
                for (int i = 0; i < selectList.count; i++) {
                    XMHItemModel *model = selectList[i];
                    if (i == selectList.count - 1) {
                        [value appendFormat:@"%@", model.title];
                    } else {
                        [value appendFormat:@"%@、", model.title];
                    }
                }
                
                formMdoel.dataArray = selectList;
                formMdoel.value = isAll ? @"全部等级" : value;
                formMdoel.dataArrayAll = isAll;
                [tableView reloadData];
            }];
        }];
    }
    // 订单商品
    else if ([model.serviceKey isEqualToString:@"orderGoods"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XMHFormModel *formMdoel = [_formDataCreate formModelfromServiceKey:@"orderGoods"];
            
            if (formMdoel.dataArrayAll || IsEmpty(formMdoel.dataArray)) {
                [XMHCouponGoodsVC getDataBlock:^(NSMutableArray * _Nonnull dataArray) {
                    [self pushCouponGoodsVC:formMdoel dataArray:dataArray];
                }];
            } else {
                [self pushCouponGoodsVC:formMdoel dataArray:(NSMutableArray *)formMdoel.dataArray];
            }
        });
    }
    // 使用渠道
    else if ([model.serviceKey isEqualToString:@"platform"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XMHFormModel *formMdoel = [_formDataCreate formModelfromServiceKey:@"platform"];
            XHMCouponMultipleAlertVC *vc = XHMCouponMultipleAlertVC.new;
            vc.edit = _edit;
            vc.titleStr = @"使用渠道";
            vc.dataArray = [XMHFormDataCreate platformList];
            vc.selectArray = formMdoel.dataArray;
            vc.dataArrayAll = formMdoel.dataArrayAll;
            [self presentViewController:vc animated:YES completion:nil];
            [vc setSelectBlock:^(NSMutableArray<XMHItemModel *> * _Nonnull selectList, BOOL isAll) {
                MzzLog(@"%@", selectList);
                
                NSMutableString *value = NSMutableString.new;
                for (int i = 0; i < selectList.count; i++) {
                    XMHItemModel *model = selectList[i];
                    if (i == selectList.count - 1) {
                        [value appendFormat:@"%@", model.title];
                    } else {
                        [value appendFormat:@"%@、", model.title];
                    }
                }
                
                formMdoel.dataArray = selectList;
                formMdoel.value = isAll ? @"全部渠道" : value;
                formMdoel.dataArrayAll = isAll;
                [tableView reloadData];
            }];
        });
    }
    // 支付使用
    else if ([model.serviceKey isEqualToString:@"pay"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!_edit) return;
            
            XHMCouponPayAlertVC *vc = XHMCouponPayAlertVC.new;
            vc.titleStr = @"使用渠道";
            vc.payModel = model.payModel;
            [self presentViewController:vc animated:YES completion:nil];
            __weak typeof(self) _self = self;
            // isAction YES:激活可使用 NO:不激活可使用
            [vc setSelectBlock:^(BOOL isAction, CGFloat payPrice) {
                __strong typeof(_self) self = _self;
                self.isAction = isAction;
                self.payPrice = payPrice;
                
                XMHCouponPayInfoModel *payModel = XMHCouponPayInfoModel.new;
                payModel.status = _isAction ? @"1" : @"2";
                payModel.money = @(payPrice).stringValue;
                
                XMHFormModel *formMdoel = [_formDataCreate formModelfromServiceKey:@"pay"];
                formMdoel.payModel = payModel;
                formMdoel.value = [formMdoel.payModel valueDes];
                [tableView reloadData];
            }];
        });
    }
}

#pragma mark - XMHPickerViewResultDelegate

- (void)pickerView:(UIView *)pickerView result:(NSString *)string {
    
    
    if ([self.currentModel.serviceKey isEqualToString:@"limit_type"]){
        for (XMHItemModel *itemMdoel in [XMHFormDataCreate limitTypeList]) {
            if ([itemMdoel.title isEqualToString:string]) {
                self.currentModel.value = itemMdoel.title;
                self.currentModel.valueId = @(itemMdoel.ID).stringValue;
                
                [self.tableView reloadData];
            }
        }
    }else if ([self.currentModel.serviceKey isEqualToString:@"purview"]){
        for (XMHItemModel *itemMdoel in [XMHFormDataCreate sendLimitList]) {
            if ([itemMdoel.title isEqualToString:string]) {
                self.currentModel.value = itemMdoel.title;
                self.currentModel.valueId = @(itemMdoel.ID).stringValue;
                
                [self.tableView reloadData];
            }
        }
    }
}

- (void)pushCouponGoodsVC:(XMHFormModel *)formMdoel dataArray:(NSMutableArray *)dataArray {
    XMHCouponGoodsVC *vc = XMHCouponGoodsVC.new;
    vc.edit = _edit;
    vc.selectArray = dataArray;
    vc.dataArrayAll = formMdoel.dataArrayAll;
    [self presentViewController:vc animated:YES completion:nil];
    [vc setSelectBlock:^(NSMutableArray<XMHServiceGoodsModel *> * _Nonnull selectList, BOOL isAll) {
        MzzLog(@"%@", selectList);
        formMdoel.dataArray = selectList;
        formMdoel.value = isAll ? @"全部商品" : [NSString stringWithFormat:@"订单商品（已选%lu）", (unsigned long)selectList.count];
        formMdoel.dataArrayAll = isAll;
        [self.tableView reloadData];
    }];
}

@end
