//
//  FTFormVC.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormVC.h"
#import "FTFormHeader.h"

@interface FTFormVC ()

@end

@implementation FTFormVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏 cell 后的线
    self.tableView.tableFooterView = UIView.new;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
//    self.tableView.separatorColor
}

- (void)setForm:(FTForm *)form {
    _form = form;
    [self.tableView reloadData];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.form.formSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FTFormSection *formSection = self.form.formSections[section];
    return formSection.formRowsHidden.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTFormSection *formSection = self.form.formSections[indexPath.section];
    FTFormRow *formRow = formSection.formRowsHidden[indexPath.row];
    
    // 通类字符串转换成类
    Class cellClass = NSClassFromString(formRow.cellClass);
    NSString *cellIdentifier = formRow.cellClass;

    FTFormBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    formRow.cell = cell;
    
    // 处理分割线
    CGFloat separatorInsetLeft = formRow.separatorHidden ? tableView.frame.size.width : 0;
    cell.separatorInset = UIEdgeInsetsMake(0, separatorInsetLeft, 0, 0);
    
    [cell configRow:formRow];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    FTFormSection *formSection = self.form.formSections[section];
    return formSection.sectionEdge;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    headerView.backgroundColor = UIColor.clearColor;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FTFormSection *formSection = self.form.formSections[indexPath.section];
    FTFormRow *formRow = formSection.formRowsHidden[indexPath.row];
    
    if (formRow.isEnable == NO) return;
    
    FTFormAction *action = formRow.action;
    if (action.classVC) {
        UIViewController *vc = action.classVC.new;
        
        
        // 给vc传row
        if ([vc conformsToProtocol:@protocol(FTFormActionViewControllerProtocol)]) {
            UIViewController <FTFormActionViewControllerProtocol> *newVC = (UIViewController <FTFormActionViewControllerProtocol> *)vc;
            newVC.row = formRow;
            
            // 给vc传参
            if ([vc respondsToSelector:@selector(confitParam:)]) {
                [newVC confitParam:action.param];
            }
        }
        
        if (action.model == FTFormActionModelPush && self.navigationController) {
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

#pragma mark - Public

/**
 获取表单数据

 @return 字典
 */
- (NSDictionary *)getFormParam {
    NSMutableDictionary *param = NSMutableDictionary.new;
    for (int i = 0; i < self.form.formSections.count; i++) {
        FTFormSection *formSection = self.form.formSections[i];
        NSArray *rowArray = formSection.formRowsHidden;
        for (int j = 0; j < rowArray.count; j++) {
            FTFormRow *row = rowArray[j];
            NSDictionary *rowDic = [row.universalConversion conversionParam];
            [param addEntriesFromDictionary:rowDic];
        }
    }
    return param;
}

/**
 校验表单

 @return 校验失败集合
 */
- (NSArray <FTFormParamVerifyResult *> *)paramVerify {
    NSMutableArray *errorArray = NSMutableArray.new;
    for (int i = 0; i < self.form.formSections.count; i++) {
        FTFormSection *formSection = self.form.formSections[i];
        NSArray *rowArray = formSection.formRowsHidden;
        for (int j = 0; j < rowArray.count; j++) {
            FTFormRow *row = rowArray[j];
            if (row.requeit) {
                FTFormParamVerifyResult *result = [row.paramVerify verify];
                // 验证失败
                if (result.success == NO) {
                    [errorArray addObject:result];
                }
            }
            
        }
    }
    return errorArray;
}

#pragma mark - FTFormVCProtocol

- (void)rowValueDidChangeRow:(FTFormRow *)row newValue:(id)newValue oldValue:(id)oldValue {
    
}

@end
