//
//  ViewController.m
//  XLFormDemo
//
//  Created by KFW on 2019/5/28.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "ViewController.h"
#import "XMHSelectVC.h"
#import <MapKit/MapKit.h>
#import "CLLocationValueTrasformer.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (void)initializeForm {
    XLFormDescriptor * form; //模拟tableview结构
    XLFormSectionDescriptor * section;//模拟section结构
    XLFormRowDescriptor * row;//模拟row结构
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"Add Event"];
    
    // First section
    section = [XLFormSectionDescriptor formSection];
    // 设置multivaluedTag formValues 输出结果以 multivaluedTag value 为key.  row value 放入数组里
//    section.multivaluedTag = @"multivaluedTag";
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:@"Title" forKey:@"textField.placeholder"];
    row.tag = @"name";
    row.required = YES;
//    row.disabled = @(YES);
    [section addFormRow:row];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title2" rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:@"Title" forKey:@"textField.placeholder"];
    row.tag = @"name2";
    
    [section addFormRow:row];
    
    
    // Second Section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
   
    // Location
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"location" rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:@"Location" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // costom textField
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"CostomTextFieldTag" rowType:XMHFormRowDescriporTypeTextField];
    row.title = @"CostomTextField";
    row.value = @"124";
    // 不可编辑
//    row.disabled = @(YES);
    // KVC 设置样式
    [row.cellConfigAtConfigure setObject:@"外部自定义" forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    // Accounting
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"percent" rowType:XLFormRowDescriptorTypeNumber title:@"Test Score"];
    NSNumberFormatter *acctFormatter = [[NSNumberFormatter alloc] init];
    [acctFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    row.valueFormatter = acctFormatter;
    row.value = @(0.75);
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];

    // selector with NibName
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kSelectorWithNibName" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Selector with NibName"];
    row.action.viewControllerClass = [XMHSelectVC class];
    row.action.viewControllerPresentationMode = XLFormPresentationModePresent;
    row.valueTransformer = [CLLocationValueTrasformer class];
//    row.useValueFormatterDuringInput = YES;
    row.value = [[CLLocation alloc] initWithLatitude:-33 longitude:-56];
    [section addFormRow:row];

    // 单选
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kCustomSelectors" rowType:XLFormRowDescriptorTypeButton title:@"Custom Selectors"];
    row.action.viewControllerClass = [XMHSelectVC class];
    row.cellStyle = UITableViewCellStyleValue1;
    row.action.viewControllerPresentationMode = XLFormPresentationModePresent;
    row.value = @"value";
    [section addFormRow:row];
    

    
    self.form = form;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"add" style:0 target:self action:@selector(validateForm:)];
}

#pragma mark - actions

-(void)validateForm:(UIBarButtonItem *)buttonItem
{
    NSArray * array = [self formValidationErrors];
    NSLog(@"%@", array);
    
    NSLog(@"%@", [self formValues]);
    NSLog(@"%@", [self httpParameters]);
    
}

#pragma mark - XLFormDescriptorDelegate

/**
 当value被改变的时候回调
 */
-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
    NSLog(@"%@", rowDescriptor.tag);
    NSString *tag = rowDescriptor.tag;
    // 获取 row mdoel
    XLFormRowDescriptor * startDateDescriptor = [self.form formRowWithTag:tag];
    // 获取cell
    XLFormDateCell * dateStartCell = (XLFormDateCell *)[startDateDescriptor cellForFormController:self];
}

@end
