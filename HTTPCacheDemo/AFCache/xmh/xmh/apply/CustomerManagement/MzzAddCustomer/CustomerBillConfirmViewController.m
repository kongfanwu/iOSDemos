//
//  CustomerBillConfirmViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerBillConfirmViewController.h"
#import "BillConfirmHeader.h"
#import "BillConfirmCell.h"
#import "MzzCustomerRequest.h"
#import "AddCustomerViewController.h"
#import "CustomerBillViewController.h"
#import "MzzInsertCustomerController.h"
#import "GKGLCustomerBillVerifyFooterView.h"
#import "ShareWorkInstance.h"
#import "MzzCustomerRequest.h"
#import "UserManager.h"
@interface CustomerBillConfirmViewController ()<UIAlertViewDelegate>{
    BOOL _section0State;
    BOOL _section1State;
    BOOL _section2State;
    BOOL _section3State;
    BOOL _section4State;
    BOOL _section5State;
}
@property (nonatomic, strong)GKGLCustomerBillVerifyFooterView *footerView;
@property (nonatomic, strong)NSDictionary * resultDic;
@property (nonatomic, strong)NSMutableArray * approvalArr;
@property (nonatomic, assign)BOOL isHaveApproval;
@end

@implementation CustomerBillConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isHaveApproval = YES;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGBColor(244, 243, 243);
    [self creatNav];
    if (_isNewGKGL) {
        _tbView.tableFooterView = self.footerView;
        [self requestApprovalPersonData];
    }
}
- (GKGLCustomerBillVerifyFooterView *)footerView
{
    WeakSelf
    if (!_footerView) {
        _footerView = loadNibName(@"GKGLCustomerBillVerifyFooterView");
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
        _footerView.GKGLCustomerBillVerifyFooterViewBlock = ^(NSMutableArray * _Nonnull param) {
            weakSelf.approvalArr = param;
        };
    }
    return _footerView;
}
- (void)creatNav{
    customNav *  nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"账单确认" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
//    [nav.btnRight setImage:[UIImage imageNamed:@"beautyshanchu"] forState:UIControlStateNormal];
//    nav.btnRight.titleLabel.font = FONT_SIZE(13);
//    [nav.btnRight setTitleColor:kLabelText_Commen_Color_9 forState:UIControlStateNormal];
//    [nav.btnRight setTitleColor:kLabelText_Commen_Color_9 forState:UIControlStateHighlighted];
    
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
//    [nav.btnRight addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nav];
}
- (void)deleteEvent:(UIButton *)sender{
    BOOL isHave = NO;
    for (id obj in _dic.allValues) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)obj;
            for (NSDictionary *dic in arr) {
                if ([dic[@"state"] isEqualToString:@"1"]) {
                    isHave = YES;
                    break;
                }
            }
        }
    }
    if (isHave) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除所选项目吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        [alert show];
#pragma clang diagnostic pop
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
        {
            //删除
            for (NSString *key in _dic.allKeys) {
                id obj = _dic[key];
                if ([obj isKindOfClass:[NSMutableArray class]]) {
                    NSMutableArray *arr = (NSMutableArray *)obj;
                    for (NSInteger i = arr.count - 1; i >= 0; i--) {
                        NSMutableDictionary *dic = arr[i];
                        if ([dic[@"state"] isEqualToString:@"1"]) {
                            [arr removeObject:dic];
                        }
                    }
                }
            }
            [_tbView reloadData];
        }
            break;
        default:
            break;
    }
}
#pragma clang diagnostic pop
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BillConfirmCellCellindentifier = @"OrderServiceCellindentifier";
    BillConfirmCell *cell;
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmCell" owner:nil options:nil] firstObject];
    }else{
        cell  = [tableView dequeueReusableCellWithIdentifier:BillConfirmCellCellindentifier];
    }
//    WeakSelf;
    cell.btnBillConfirmCellModifyBlock = ^(NSMutableDictionary *dic, NSInteger section) {
        
        if (_popBlock) {
            _popBlock(YES,dic,section,_customerModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
//        CustomerBillViewController *modifyVC = [[CustomerBillViewController alloc]init];
//        modifyVC.isModify = YES;
//        modifyVC.dicModify = dic;
//        modifyVC.sectionModify = section;
//        modifyVC.customerModel = weakSelf.customerModel;
//        NSArray *arrkeys = @[@"stored_card",@"card_time",@"card_num",@"pro",@"goods",@"ticket"];
//        modifyVC.btnCustomerBillViewControllerModifyBlock = ^(NSMutableDictionary *cdic, NSInteger csection) {
//            NSMutableArray *arr = _dic[arrkeys[csection]];
//            for (NSMutableDictionary *orginDic in arr) {
//                if ([orginDic[@"unique"] isEqualToString:cdic[@"unique"]]) {
//                    for (NSString * key in orginDic.allKeys) {
//                        if (![key isEqualToString:@"unique"]) {
//                            if (cdic[key]) {
//                                NSString *valueStr = [NSString stringWithFormat:@"%@",cdic[key]];
//                                if (![valueStr isEqualToString:@""]) {
//                                    orginDic[key] = cdic[key];
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            [_tbView reloadData];
//        };
//        [self.navigationController pushViewController:modifyVC animated:NO];
    };
    
    cell.btnBillConfirmCellDelBlock = ^(NSMutableDictionary *dic, NSInteger section) {
        [[[MzzHud alloc]initWithTitle:@"是否确认删除" message:@"" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
            if (index==1) {
                switch (section) {
                    case 0:
                    {
                        NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
                        [arr removeObject:dic];
                    }
                        break;
                    case 1:
                    {
                        NSMutableArray *arr = [_dic objectForKey:@"card_time"];
                        [arr removeObject:dic];
                    }
                        break;
                    case 2:
                    {
                        NSMutableArray *arr = [_dic objectForKey:@"card_num"];
                        [arr removeObject:dic];
                    }
                        break;
                    case 3:
                    {
                        NSMutableArray *arr = [_dic objectForKey:@"pro"];
                        [arr removeObject:dic];
                    }
                        break;
                    case 4:
                    {
                        NSMutableArray *arr = [_dic objectForKey:@"goods"];
                        [arr removeObject:dic];
                    }
                        break;
                    case 5:
                    {
                        NSMutableArray *arr = [_dic objectForKey:@"ticket"];
                        [arr removeObject:dic];
                    }
                        break;
                    default:
                        
                        break;
                }
                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
                [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            }
        }] show];
    };
    
    switch (indexPath.section) {
        case 0:
        {
            NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
            if (arr) {
                if (arr.count > 0) {
                    if (indexPath.row < arr.count) {
                        NSMutableDictionary *dic = arr[indexPath.row];
                        [cell freshBillConfirmCell0:dic withsection:0];
                        cell.btnBillConfirmCellBlock = ^(NSString *state, NSInteger section) {
                            if (section == 0) {
                                dic[@"state"] = state;
                                if ([state isEqualToString:@"0"]) {
                                    _section0State = NO;
                                }else{
                                    for (NSMutableDictionary *dic in arr) {
                                        if ([dic[@"state"] isEqualToString:@"1"]) {
                                            _section0State = YES;
                                        }else{
                                            _section0State = NO;
                                            break;
                                        }
                                    }
                                }
                                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
                                [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                            }
                        };
                    }
                }
            }
        }
            break;
        case 1:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_time"];
            if (arr) {
                if (arr.count > 0) {
                    if (indexPath.row < arr.count) {
                        NSMutableDictionary *dic = arr[indexPath.row];
                        [cell freshBillConfirmCell1:dic withsection:1];
                        cell.btnBillConfirmCellBlock = ^(NSString *state, NSInteger section) {
                            if (section == 1) {
                                dic[@"state"] = state;
                                if ([state isEqualToString:@"0"]) {
                                    _section1State = NO;
                                }else{
                                    for (NSMutableDictionary *dic in arr) {
                                        if ([dic[@"state"] isEqualToString:@"1"]) {
                                            _section1State = YES;
                                        }else{
                                            _section1State = NO;
                                            break;
                                        }
                                    }
                                }
                                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
                                [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                            }
                        };
                    }
                }
            }
        }
            break;
        case 2:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_num"];
            if (arr) {
                if (arr.count > 0) {
                    if (indexPath.row < arr.count) {
                        NSMutableDictionary *dic = arr[indexPath.row];
                        [cell freshBillConfirmCell2:dic withsection:2];
                        cell.btnBillConfirmCellBlock = ^(NSString *state, NSInteger section) {
                            if (section == 2) {
                                dic[@"state"] = state;
                                if ([state isEqualToString:@"0"]) {
                                    _section2State = NO;
                                }else{
                                    for (NSMutableDictionary *dic in arr) {
                                        if ([dic[@"state"] isEqualToString:@"1"]) {
                                            _section2State = YES;
                                        }else{
                                            _section2State = NO;
                                            break;
                                        }
                                    }
                                }
                                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
                                [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                            }
                        };
                    }
                }
            }
        }
            break;
        case 3:
        {
            NSMutableArray *arr = [_dic objectForKey:@"pro"];
            if (arr) {
                if (arr.count > 0) {
                    if (indexPath.row < arr.count) {
                        NSMutableDictionary *dic = arr[indexPath.row];
                        [cell freshBillConfirmCell3:dic withsection:3];
                        cell.btnBillConfirmCellBlock = ^(NSString *state, NSInteger section) {
                            if (section == 3) {
                                dic[@"state"] = state;
                                if ([state isEqualToString:@"0"]) {
                                    _section3State = NO;
                                }else{
                                    for (NSMutableDictionary *dic in arr) {
                                        if ([dic[@"state"] isEqualToString:@"1"]) {
                                            _section3State = YES;
                                        }else{
                                            _section3State = NO;
                                            break;
                                        }
                                    }
                                }
                                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3];
                                [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                            }
                        };
                    }
                }
            }
        }
            break;
        case 4:
        {
            NSMutableArray *arr = [_dic objectForKey:@"goods"];
            if (arr) {
                if (arr.count > 0) {
                    if (indexPath.row < arr.count) {
                        NSMutableDictionary *dic = arr[indexPath.row];
                        [cell freshBillConfirmCell4:dic withsection:4];
                        cell.btnBillConfirmCellBlock = ^(NSString *state, NSInteger section) {
                            if (section == 4) {
                                dic[@"state"] = state;
                                if ([state isEqualToString:@"0"]) {
                                    _section4State = NO;
                                }else{
                                    for (NSMutableDictionary *dic in arr) {
                                        if ([dic[@"state"] isEqualToString:@"1"]) {
                                            _section4State = YES;
                                        }else{
                                            _section4State = NO;
                                            break;
                                        }
                                    }
                                }
                                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:4];
                                [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                            }
                        };
                    }
                }
            }
        }
            break;
        case 5:
        {
            NSMutableArray *arr = [_dic objectForKey:@"ticket"];
            if (arr) {
                if (arr.count > 0) {
                    if (indexPath.row < arr.count) {
                        NSMutableDictionary *dic = arr[indexPath.row];
                        [cell freshBillConfirmCell5:dic withsection:5];
                        cell.btnBillConfirmCellBlock = ^(NSString *state, NSInteger section) {
                            if (section == 5) {
                                dic[@"state"] = state;
                                if ([state isEqualToString:@"0"]) {
                                    _section5State = NO;
                                }else{
                                    for (NSMutableDictionary *dic in arr) {
                                        if ([dic[@"state"] isEqualToString:@"1"]) {
                                            _section5State = YES;
                                        }else{
                                            _section5State = NO;
                                            break;
                                        }
                                    }
                                }
                                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:5];
                                [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                            }
                        };
                    }
                }
            }
        }
            break;
        default:
            return nil;
            break;
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
            if (arr) {
                return arr.count;
            }
            return 0;
        }
            break;
        case 1:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_time"];
            if (arr) {
                return arr.count;
            }
            return 0;
        }
            break;
        case 2:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_num"];
            if (arr) {
                return arr.count;
            }
            return 0;
        }
            break;
//        case 3:
//        {
//            NSMutableArray *arr = [_dic objectForKey:@"card_course"];
//            if (arr) {
//                return arr.count;
//            }
//            return 0;
//        }
//            break;
        case 3:
        {
            NSMutableArray *arr = [_dic objectForKey:@"pro"];
            if (arr) {
                return arr.count;
            }
            return 0;
        }
            break;
        case 4:
        {
            NSMutableArray *arr = [_dic objectForKey:@"goods"];
            if (arr) {
                return arr.count;
            }
            return 0;
        }
            break;
        case 5:
        {
            NSMutableArray *arr = [_dic objectForKey:@"ticket"];
            if (arr) {
                return arr.count;
            }
            return 0;
        }
            break;
        default:
            return 0;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
            if (arr) {
                if (arr.count > 0) {
                    return 50;
                }
            }
            return 0;
        }
            break;
        case 1:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_time"];
            if (arr) {
                if (arr.count > 0) {
                    return 50;
                }
            }
            return 0;
        }
            break;
        case 2:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_num"];
            if (arr) {
                if (arr.count > 0) {
                    return 50;
                }
            }
            return 0;
        }
            break;
//        case 3:
//        {
//            NSMutableArray *arr = [_dic objectForKey:@"card_course"];
//            if (arr) {
//                if (arr.count > 0) {
//                    return 50;
//                }
//            }
//            return 0;
//        }
//            break;
        case 3:
        {
            NSMutableArray *arr = [_dic objectForKey:@"pro"];
            if (arr) {
                if (arr.count > 0) {
                    return 50;
                }
            }
            return 0;
        }
            break;
        case 4:
        {
            NSMutableArray *arr = [_dic objectForKey:@"goods"];
            if (arr) {
                if (arr.count > 0) {
                    return 50;
                }
            }
            return 0;
        }
            break;
        case 5:
        {
            NSMutableArray *arr = [_dic objectForKey:@"ticket"];
            if (arr) {
                if (arr.count > 0) {
                    return 50;
                }
            }
            return 0;
        }
            break;
        default:
            return 0;
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
            if (arr) {
                if (arr.count > 0) {
                    BillConfirmHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmHeader" owner:nil options:nil] firstObject];
                    header.lbTitle.text = @"储值卡";
                    header.btn1.selected = _section0State;
                    header.btnBillConfirmHeaderBlock = ^(NSString *state,BOOL boolState) {
                        for (NSMutableDictionary *dic in arr) {
                            if (dic) {
                                dic[@"state"] = state;
                            }
                        }
                        _section0State = boolState;
                        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
                        [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    };
                    return header;
                }
            }
            return nil;
        }
            break;
        case 1:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_time"];
            if (arr) {
                if (arr.count > 0) {
                    BillConfirmHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmHeader" owner:nil options:nil] firstObject];
                    header.lbTitle.text = @"时间卡";
                    header.btn1.selected = _section1State;
                    header.btnBillConfirmHeaderBlock = ^(NSString *state,BOOL boolState) {
                        for (NSMutableDictionary *dic in arr) {
                            if (dic) {
                                dic[@"state"] = state;
                            }
                        }
                        _section1State = boolState;
                        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
                        [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    };
                    return header;
                }
            }
            return nil;
        }
            break;
        case 2:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_num"];
            if (arr) {
                if (arr.count > 0) {
                    BillConfirmHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmHeader" owner:nil options:nil] firstObject];
                    header.lbTitle.text = @"任选卡";
                    header.btn1.selected = _section2State;
                    header.btnBillConfirmHeaderBlock = ^(NSString *state,BOOL boolState) {
                        for (NSMutableDictionary *dic in arr) {
                            if (dic) {
                                dic[@"state"] = state;
                            }
                        }
                        _section2State = boolState;
                        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
                        [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    };
                    return header;
                }
            }
            return nil;
        }
            break;
//        case 3:
//        {
//            NSMutableArray *arr = [_dic objectForKey:@"card_course"];
//            if (arr) {
//                if (arr.count > 0) {
//                    BillConfirmHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmHeader" owner:nil options:nil] firstObject];
//                    header.lbTitle.text = @"特惠卡";
//                    header.btn1.selected = _section3State;
//                    header.btnBillConfirmHeaderBlock = ^(NSString *state,BOOL boolState) {
//                        for (NSMutableDictionary *dic in arr) {
//                            if (dic) {
//                                dic[@"state"] = state;
//                            }
//                        }
//                        _section3State = boolState;
//                        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3];
//                        [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
//                    };
//                    return header;
//                }
//            }
//            return nil;
//        }
//            break;
        case 3:
        {
            NSMutableArray *arr = [_dic objectForKey:@"pro"];
            if (arr) {
                if (arr.count > 0) {
                    BillConfirmHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmHeader" owner:nil options:nil] firstObject];
                    header.lbTitle.text = @"项目";
                    header.btn1.selected = _section3State;
                    header.btnBillConfirmHeaderBlock = ^(NSString *state,BOOL boolState) {
                        for (NSMutableDictionary *dic in arr) {
                            if (dic) {
                                dic[@"state"] = state;
                            }
                        }
                        _section3State = boolState;
                        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3];
                        [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    };
                    return header;
                }
            }
            return nil;
        }
            break;
        case 4:
        {
            NSMutableArray *arr = [_dic objectForKey:@"goods"];
            if (arr) {
                if (arr.count > 0) {
                    BillConfirmHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmHeader" owner:nil options:nil] firstObject];
                    header.lbTitle.text = @"产品";
                    header.btn1.selected = _section4State;
                    header.btnBillConfirmHeaderBlock = ^(NSString *state,BOOL boolState) {
                        for (NSMutableDictionary *dic in arr) {
                            if (dic) {
                                dic[@"state"] = state;
                            }
                        }
                        _section4State = boolState;
                        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:4];
                        [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    };
                    return header;
                }
            }
            return nil;
        }
            break;
        case 5:
        {
            NSMutableArray *arr = [_dic objectForKey:@"ticket"];
            if (arr) {
                if (arr.count > 0) {
                    BillConfirmHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"BillConfirmHeader" owner:nil options:nil] firstObject];
                    header.lbTitle.text = @"票券";
                    header.btn1.selected = _section5State;
                    header.btnBillConfirmHeaderBlock = ^(NSString *state,BOOL boolState) {
                        for (NSMutableDictionary *dic in arr) {
                            if (dic) {
                                dic[@"state"] = state;
                            }
                        }
                        _section5State = boolState;
                        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:5];
                        [_tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    };
                    return header;
                }
            }
            return nil;
        }
            break;
        default:
            return nil;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
            if (arr) {
                if (arr.count > 0) {
                    return 123;
                }
            }
            return 0;
        }
            break;
        case 1:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_time"];
            if (arr) {
                if (arr.count > 0) {
                    return 123;
                }
            }
            return 0;
        }
            break;
        case 2:
        {
            NSMutableArray *arr = [_dic objectForKey:@"card_num"];
            if (arr) {
                if (arr.count > 0) {
                    return 150;
                }
            }
            return 0;
        }
            break;
        case 3:
        {
            NSMutableArray *arr = [_dic objectForKey:@"pro"];
            if (arr) {
                if (arr.count > 0) {
                    return 150;
                }
            }
            return 0;
        }
            break;
        case 4:
        {
            NSMutableArray *arr = [_dic objectForKey:@"goods"];
            if (arr) {
                if (arr.count > 0) {
                    return 177;
                }
            }
            return 0;
        }
            break;
        case 5:
        {
            NSMutableArray *arr = [_dic objectForKey:@"ticket"];
            if (arr) {
                if (arr.count > 0) {
                    return 96;
                }
            }
            return 0;
        }
            break;
        default:
            return 0;
            break;
    }
}
- (IBAction)btnConfirm:(UIButton *)sender {
    
    for (NSString *key in _dic.allKeys) {
        id obj = _dic[key];
        if ([obj isKindOfClass:[NSMutableArray class]]) {
//            NSMutableArray *arr = (NSMutableArray *)obj;
//            for (NSMutableDictionary *dic in arr) {
//                [dic removeObjectForKey:@"name"];
//                [dic removeObjectForKey:@"state"];
//                [dic removeObjectForKey:@"unique"];
//            }
        }
    }
//    NSString *jsonStr = _dic.jsonData;
//    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc]init];
//    [parmsDic setValue:jsonStr forKey:@"data"];
//    [MzzCustomerRequest requestBillAddParams:parmsDic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
//        if (isSuccess) {
//
//            for (UIViewController *temp in self.navigationController.viewControllers) {
//                if ([temp isKindOfClass:[AddCustomerViewController class]]) {
//                    [self.navigationController popToViewController:temp animated:NO];
//                }
//            }
//        }
//    }];

    
    if (_isNewGKGL) {
        [_dic removeObjectForKey:@"token"];
        [_dic removeObjectForKey:@"user_id"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"user_id"]  = [NSString stringWithFormat:@"%ld",_customerModel.uid];
        params[@"bill"] = _dic;
        NSMutableDictionary *approval = [NSMutableDictionary dictionary];
        approval[@"code"] = _resultDic[@"code"];
        approval[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
        NSString * approvalPerson = @"";
        for (int i = 0; i < _approvalArr.count; i++) {
            NSDictionary * subDic = _approvalArr[i];
            if ([subDic[@"selected"] isEqualToString:@"1"]) {
                approvalPerson = subDic[@"id"];
            }
        }
        /** 校验审批人是否选择 */
        if ([[NSString stringWithFormat:@"%@",approvalPerson] length] <= 0) {
            [MzzHud toastWithTitle:@"提示" message:@"请选择审批人"];
            return;
        }
        approval[@"approvalPerson"] = approvalPerson;
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        approval[@"account_id"] =[NSString stringWithFormat:@"%ld", model.data.ID];
        [approval setValue:[NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id] forKey:@"fram_id"];
        params[@"approval"] = approval;
        NSMutableDictionary *data =  [NSMutableDictionary dictionary];
        data[@"data"] = params.jsonData;
        if (!_isHaveApproval) {
            [MzzHud toastWithTitle:@"提示" message:@"没有设置审批流程，请联系管理员设置！"];
            return;
        }
        [MzzCustomerRequest requestTotal_AddParams:data resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                [MzzHud toastWithTitle:@"提示" message:@"提交成功"  complete:^{
                    //提交成功
                    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:NO];
                }];
            }else{
                [MzzHud toastWithTitle:@"提示" message:@"提交失败"];
            }
        }];
        return;
    }
    
    if (_delegate) {
        [_delegate getBillDicDelgateMethod:_dic];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:MzzInsertCustomerVC_BillInfoDic object:nil userInfo:_dic];
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[AddCustomerViewController class]]) {
            [self.navigationController popToViewController:temp animated:NO];
        }
        if ([temp isKindOfClass:[MzzInsertCustomerController class]]) {
            [self.navigationController popToViewController:temp animated:NO];
        }
    }
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------网络请求------
- (void)requestApprovalPersonData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * userid = [NSString stringWithFormat:@"%ld",_customerModel.uid];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_customerModel.store_code?_customerModel.store_code:@"" forKey:@"store_code"];
    [param setValue:userid?userid:@"" forKey:@"user_id"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CUSTOMERBILLL_APPROVAL_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _resultDic = resultDic;
            if ([resultDic[@"approvalPerson"] count] == 0) {
                _isHaveApproval = NO;
            }
            [_footerView updateGKGLCustomerBillVerifyFooterViewParam:resultDic];
        }else{}
    }];
}
@end

