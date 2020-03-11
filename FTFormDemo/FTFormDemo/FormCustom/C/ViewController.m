//
//  ViewController.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
/*
 1 点击事件
 2 弹出哪个VC
 3 弹出方式
 4 传参数
 5 返回参数
 */

#import "ViewController.h"
#import "FTFormHeader.h"
#import "FTSelectVC.h"
#import "FTMenDianModel.h"
#import "FTButtonModel.h"
#import "ViewControllerProtocol.h"
#import "FTTInformationModel.h"
#import "FTTChectButtonModel.h"
#import "FTTInformationCell.h"
#import "FTFormConst.h"

NSString * const gukeguanliKey = @"gukeguanli";

@interface ViewController () <ViewControllerProtocol>
/** <##> */
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blueColor;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:0 target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self getData];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = button;
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor grayColor];
    [button setBackgroundImage:[UIView imageWithColor:UIColor.blackColor size:CGSizeMake(100, 40)] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIView imageWithColor:UIColor.redColor size:CGSizeMake(100, 40)] forState:UIControlStateHighlighted];
    [self.view addSubview:button];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.button.frame = CGRectMake(0, 400, 100, 40);
}

- (void)getData {
    //表
    FTForm *form = FTForm.new;
    
    FTFormSection *formSection;
    FTFormRow *row;
    
    formSection = FTFormSection.new;
    formSection.sectionEdge = 40;
    [form addSection:formSection];
    
    
    FTMenDianModel *model = FTMenDianModel.new;
    model.Id = @"100";
    model.name = @"10";
    
    row = FTFormRow.new;
    [formSection addRow:row];
    row.tag = @"name";
    row.title = @"*姓名";
//    row.value = model;
    row.cellClass = FTForm_FTFormInputCell;

    row.action.classVC = FTSelectVC.class;
    row.action.model = FTFormActionModelPresent;
    row.action.param = @{@"key" : @"value"};
    // value 转换器
    [row.universalConversion setConversionValueBlock:^NSString * _Nonnull(FTFormRow * _Nonnull row) {
        FTMenDianModel *menDianmodel = row.value;
        return [NSString stringWithFormat:@"%@%@", menDianmodel.name, @"折"];
    }];

    // 获取row转换器
    [row.universalConversion setConversionParamBlock:^NSDictionary * _Nonnull(FTFormRow * _Nonnull row) {
        FTMenDianModel *menDianmodel = row.value;
        return @{row.tag : menDianmodel.name};
    }];

    row.requeit = NO;
    // 校验 block 返回（校验）对象（成功或失败，msg:提示语）
    [row.paramVerify setVerifyBlock:^FTFormParamVerifyResult * _Nonnull(FTFormRow * _Nonnull row) {
        BOOL success = NO;
        NSString *msg = [NSString stringWithFormat:@"%@校验失败", row.tag];
        FTMenDianModel *menDianmodel = row.value;
        if ([menDianmodel.name isEqualToString:@"11"]) {
            success = YES;
            msg = @"成功";
        }
        return [FTFormParamVerifyResult createSuccess:success msg:msg];
    }];

    row = FTFormRow.new;
    [formSection addRow:row];
    row.tag = @"name1";
    row.title = @"姓名1";
//    row.value = @"1";
    row.cellClass = FTForm_FTFormInputCell;

    row.action.classVC = FTSelectVC.class;
    row.action.model = FTFormActionModelPresent;
    row.action.param = @{@"key" : @"value"};

    [row.universalConversion setConversionValueBlock:^NSString * _Nonnull(FTFormRow * _Nonnull row) {
        return [NSString stringWithFormat:@"%@%@", row.value, @"元"];
    }];
    row.enable = [NSString stringWithFormat:@"%@.value == NULL", @"name"];
    
    row = FTFormRow.new;
    [formSection addRow:row];
    row.tag = @"name2";
    row.title = @"姓名2";
    //    row.value = @"1";
    row.cellClass = FTForm_FTFormInputCell;
    
    row.action.classVC = FTSelectVC.class;
    row.action.model = FTFormActionModelPresent;
    row.action.param = @{@"key" : @"value"};
    
    [row.universalConversion setConversionValueBlock:^NSString * _Nonnull(FTFormRow * _Nonnull row) {
        return [NSString stringWithFormat:@"%@%@", row.value, @"元"];
    }];
    row.enable = [NSString stringWithFormat:@"%@.value == NULL", @"name1"];
    
    /*
    row = FTFormRow.new;
    [formSection addRow:row];
    row.tag = gukeguanliKey;
    row.title = @"顾客管理";
    row.value = @(NO);
    row.cellClass = FTForm_FTFormInputCell;
    
    row = FTFormRow.new;
    [formSection addRow:row];
    row.tag = @"baoyouguke";
    row.title = @"保有顾客";
    NSArray *valueArray = [self createButtonModel];
    row.value = valueArray;
    row.cellClass = FTForm_FTFormButtonsCell;
    row.hidden = [NSString stringWithFormat:@"%@.value=1", gukeguanliKey];
    
    row = FTFormRow.new;
    [formSection addRow:row];
    row.tag = @"baoyouguke";
    row.title = @"活动顾客";
    NSArray *valueArray1 = [self createButtonModel];
    row.value = valueArray1;
    row.cellClass = FTForm_FTFormButtonsCell;
    row.hidden = [NSString stringWithFormat:@"%@.value=1", gukeguanliKey];
    
    row = FTFormRow.new;
    [formSection addRow:row];
    row.tag = @"baoyouguke";
    row.title = @"有效顾客";
    NSArray *valueArray2 = [self createButtonModel];
    row.value = valueArray2;
    row.cellClass = FTForm_FTFormButtonsCell;
    row.hidden = [NSString stringWithFormat:@"%@.value=1", gukeguanliKey];
*/
//    row = FTFormRow.new;
//    [formSection addRow:row];
//    row.tag = gukeguanliKey;
//    row.title = @"检索范围（带*势必选项)";
//    row.value = @(NO);
//    row.cellClass = FTForm_FTFormInputCell;
//
//    row = FTFormRow.new;
//    [formSection addRow:row];
//    row.tag = @"baoyouguke";
//    row.title = @"筛选门店";
//    row.cellClass = FTForm_FTFormInputCell;
//    row.hidden = [NSString stringWithFormat:@"%@.value=1", gukeguanliKey];
//
//    row = FTFormRow.new;
//    [formSection addRow:row];
//    row.tag = @"baoyouguke";
//    row.title = @"帅选技师";
//    row.cellClass = FTForm_FTFormInputCell;
//    row.hidden = [NSString stringWithFormat:@"%@.value=1", gukeguanliKey];
//
//    row = FTFormRow.new;
//    [formSection addRow:row];
//    row.tag = @"baoyouguke";
//    row.title = @"帅选时间";
//    row.cellClass = FTForm_FTFormInputCell;
//    row.hidden = [NSString stringWithFormat:@"%@.value=1", gukeguanliKey];
//
//    row = FTFormRow.new;
//    [formSection addRow:row];
//    row.tag = @"baoyouguke";
//    row.title = @"帅选时间";
//    NSMutableArray *valueArray = [self createInformationModel];
//    row.value = valueArray;
//    NSMutableArray *arryModel = [self chectButton];
//    row.buttonCheck = arryModel;
//    row.cellClass = FTForm_FTForminformationCell;
//    row.hidden = [NSString stringWithFormat:@"%@.value=1", gukeguanliKey];
    
    self.form = form;
}

- (NSArray *)createButtonModel {
    NSMutableArray *models = NSMutableArray.new;
    FTButtonModel *model;
    
    model = FTButtonModel.new;
    [models addObject:model];
    model.title = @"10人一下";
    
    model = FTButtonModel.new;
    [models addObject:model];
    model.title = @"10-20人";
    
    model = FTButtonModel.new;
    [models addObject:model];
    model.title = @"20-30人";
    
    model = FTButtonModel.new;
    [models addObject:model];
    model.title = @"30-40";
    
    model = FTButtonModel.new;
    [models addObject:model];
    model.title = @"40以上";
    
    model = FTButtonModel.new;
    [models addObject:model];
    model.title = @"自定义";
    model.type = FTButtonModelTypeCustom;
    return models;
}

-(NSMutableArray *)createInformationModel
{
    NSMutableArray *models = NSMutableArray.new;
    FTTInformationModel *model;
    
    model = [FTTInformationModel new];
    model.title = @"基础信息";
//    model.select = YES;
    model.detailTitle = @"指标包括:入职时间、年龄阶段、员工等级、员工岗位";
    [models addObject:model];
    
    model = [FTTInformationModel new];
    model.title = @"管理顾客";
    model.detailTitle = @"指标包括:保有顾客、活动顾客、有效顾客、休眠顾客、流失顾客、标准会员";
    [models addObject:model];
    
    model = [FTTInformationModel new];
    model.title = @"顾客行为";
    model.detailTitle = @"指标包括:会员普及率、客y平均消耗单价、客单次消耗项目数。到店的次数";
    [models addObject:model];
    
    model = [FTTInformationModel new];
    model.title = @"工作行为";
    model.detailTitle = @"指标包括:销售业绩、消耗业绩、每日接待客次、每日服务项目数、每日预约顾客数、每月规划处方数";
    [models addObject:model];
    
    return models;
}

-(NSMutableArray *)chectButton
{
    NSMutableArray *models = [NSMutableArray new];
    FTTChectButtonModel *model;
    
    model = [FTTChectButtonModel new];
    model.title = @"重置";
    [models addObject:model];
    
    model = [FTTChectButtonModel new];
    model.title = @"检索";
    [models addObject:model];
    
    return models;
}
- (void)rightItemClick:(UIBarButtonItem *)item {
    
    NSArray *resultArray = [self paramVerify];
    if (resultArray.count) {
        FTFormParamVerifyResult *result = resultArray.firstObject;
        NSLog(@"%@", result.msg);
        return;
    }
    
    NSDictionary *param = [self getFormParam];
    NSLog(@"%@", param);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    FTFormSection *formSection = self.form.formSections[indexPath.section];
    FTFormRow *formRow = formSection.formRowsHidden[indexPath.row];
    
    // 顾客管理
    if ([formRow.tag isEqualToString:gukeguanliKey]) {
        BOOL valueBool = [formRow.value boolValue];
        formRow.value = @(!valueBool);
    }
}


#pragma mark - ViewControllerProtocol

/**
 按钮点击回调
 
 @param row <#row description#>
 @param buttonModel <#buttonModel description#>
 */
- (void)buttonClickRow:(FTFormRow *)row buttonModel:(FTButtonModel *)buttonModel {
//    buttonModel.select = !buttonModel.select;
    NSArray *arry = row.value;
    [arry enumerateObjectsUsingBlock:^(FTButtonModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.select = NO;
    }];
    buttonModel.select = YES;
    
    [self.tableView reloadData];
}

/**
 添加自定义
 
 @param row <#row description#>
 @param customButtonModel <#customButtonModel description#>
 */
- (void)addCustomRow:(FTFormRow *)row customButtonModel:(FTButtonModel *)customButtonModel {
    // 创建默认类型，自定义添加的按钮
    FTButtonModel *model = FTButtonModel.new;
    model.title = customButtonModel.title;
    
    if ([row.value isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *valueArray = row.value;
        [valueArray insertObject:model atIndex:valueArray.count - 1];
    }
    customButtonModel.title = @"自定义";
    
    [self.tableView reloadData];
}

#pragma mark - FTFormVCProtocol

- (void)rowValueDidChangeRow:(FTFormRow *)row newValue:(id)newValue oldValue:(id)oldValue {
    [super rowValueDidChangeRow:row newValue:newValue oldValue:oldValue];
    
    BOOL isEnable = YES;
    for (int i = 0; i < self.form.formSections.count; i++) {
        FTFormSection *formSection = self.form.formSections[i];
        NSArray *rowArray = formSection.formRowsHidden;
        for (int j = 0; j < rowArray.count; j++) {
            FTFormRow *row = rowArray[j];
            NSLog(@"row.isEnable:%d", row.isEnable);
            if (row.isEnable == NO) {
                isEnable = NO;
                break;
            }
        }
    }
    
    self.button.highlighted = isEnable;
}

@end
