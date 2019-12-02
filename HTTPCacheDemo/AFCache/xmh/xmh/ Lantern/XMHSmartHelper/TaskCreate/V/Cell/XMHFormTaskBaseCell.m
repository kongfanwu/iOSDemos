//
//  XMHFormTaskBaseCell.m
//  xmh
//
//  Created by kfw on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskBaseCell.h"

@implementation XMHFormTaskBaseCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configUI];
}

- (void)configUI {
    self.textFieldMaxNumberOfCharacters = @(NSIntegerMax);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = UIColor.whiteColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.layer.mask = nil;
    [self.rowDescriptor.sectionDescriptor.formRows enumerateObjectsUsingBlock:^(XLFormRowDescriptor *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // section 只有一个cell
        if (self.rowDescriptor == obj && idx == 0 && self.rowDescriptor.sectionDescriptor.formRows.count == 1) {
            [UIView addRadiusWithView:self roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
            *stop = YES;
        }
        // section 第一个cell
        else if (self.rowDescriptor == obj && idx == 0) {
            [UIView addRadiusWithView:self roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
            *stop = YES;
        }
        // section 最后一个cell
        else if (self.rowDescriptor == obj && idx == (self.rowDescriptor.sectionDescriptor.formRows.count - 1)) {
            [UIView addRadiusWithView:self roundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
            *stop = YES;
        }
    }];
}

-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller
{
    // XMHForm*** 自定义的类
    BOOL isXMHCustom = [self.rowDescriptor.rowType containsString:@"XMH"];
    if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPush] ||
        [self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPopover] ||
        isXMHCustom){
        
        UIViewController * controllerToPresent = nil;
        if (self.rowDescriptor.action.formSegueIdentifier){
            [controller performSegueWithIdentifier:self.rowDescriptor.action.formSegueIdentifier sender:self.rowDescriptor];
        }
        else if (self.rowDescriptor.action.formSegueClass){
            UIViewController * controllerToPresent = [self controllerToPresent];
            NSAssert(controllerToPresent, @"either rowDescriptor.action.viewControllerClass or rowDescriptor.action.viewControllerStoryboardId or rowDescriptor.action.viewControllerNibName must be assigned");
            NSAssert([controllerToPresent conformsToProtocol:@protocol(XLFormRowDescriptorViewController)], @"selector view controller must conform to XLFormRowDescriptorViewController protocol");
            UIStoryboardSegue * segue = [[self.rowDescriptor.action.formSegueClass alloc] initWithIdentifier:self.rowDescriptor.tag source:controller destination:controllerToPresent];
            [controller prepareForSegue:segue sender:self.rowDescriptor];
            [segue perform];
        }
        else if ((controllerToPresent = [self controllerToPresent])){
            NSAssert([controllerToPresent conformsToProtocol:@protocol(XLFormRowDescriptorViewController)], @"rowDescriptor.action.viewControllerClass must conform to XLFormRowDescriptorViewController protocol");
            UIViewController<XLFormRowDescriptorViewController> *selectorViewController = (UIViewController<XLFormRowDescriptorViewController> *)controllerToPresent;
            selectorViewController.rowDescriptor = self.rowDescriptor;
            selectorViewController.title = self.rowDescriptor.selectorTitle;
            
            if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPopover]) {
                UIViewController *popoverController = self.formViewController.presentedViewController;
                if (popoverController && popoverController.modalPresentationStyle == UIModalPresentationPopover) {
                    [self.formViewController dismissViewControllerAnimated:NO completion:nil];
                }
                selectorViewController.modalPresentationStyle = UIModalPresentationPopover;
                
                selectorViewController.popoverPresentationController.delegate = self;
                if (self.detailTextLabel.window){
                    selectorViewController.popoverPresentationController.sourceRect = CGRectMake(0, 0, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
                    selectorViewController.popoverPresentationController.sourceView = self.detailTextLabel;
                    selectorViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
                } else {
                    selectorViewController.popoverPresentationController.sourceRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                    selectorViewController.popoverPresentationController.sourceView = self;
                    selectorViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
                }
                
                [self.formViewController presentViewController:selectorViewController
                                                      animated:YES
                                                    completion:nil];
                [controller.tableView deselectRowAtIndexPath:[controller.tableView indexPathForCell:self]
                                                    animated:YES];
            }
            else {
                [controller.navigationController pushViewController:selectorViewController animated:YES];
            }
        }
        else if (self.rowDescriptor.selectorOptions){
            XLFormOptionsViewController * optionsViewController = [[XLFormOptionsViewController alloc] initWithStyle:UITableViewStyleGrouped titleHeaderSection:nil titleFooterSection:nil];
            optionsViewController.rowDescriptor = self.rowDescriptor;
            optionsViewController.title = self.rowDescriptor.selectorTitle;
            
            if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPopover]) {
                optionsViewController.modalPresentationStyle = UIModalPresentationPopover;
                
                optionsViewController.popoverPresentationController.delegate = self;
                if (self.detailTextLabel.window){
                    optionsViewController.popoverPresentationController.sourceRect = CGRectMake(0, 0, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
                    optionsViewController.popoverPresentationController.sourceView = self.detailTextLabel;
                    optionsViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
                } else {
                    optionsViewController.popoverPresentationController.sourceRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                    optionsViewController.popoverPresentationController.sourceView = self;
                    optionsViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
                }
                
                [self.formViewController presentViewController:optionsViewController
                                                      animated:YES
                                                    completion:nil];
                [controller.tableView deselectRowAtIndexPath:[controller.tableView indexPathForCell:self]
                                                    animated:YES];
            } else {
                [controller.navigationController pushViewController:optionsViewController animated:YES];
            }
        }
    }
    else if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeMultipleSelector] || [self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeMultipleSelectorPopover])
    {
        NSAssert(self.rowDescriptor.selectorOptions, @"selectorOptions property shopuld not be nil");
        UIViewController * controllerToPresent = nil;
        XLFormOptionsViewController * optionsViewController = nil;
        if ((controllerToPresent = [self controllerToPresent])){
            optionsViewController = (XLFormOptionsViewController *)controllerToPresent;
        } else {
            optionsViewController = [[XLFormOptionsViewController alloc] initWithStyle:UITableViewStyleGrouped titleHeaderSection:nil titleFooterSection:nil];
        }
        optionsViewController.rowDescriptor = self.rowDescriptor;
        optionsViewController.title = self.rowDescriptor.selectorTitle;
        
        if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeMultipleSelectorPopover]) {
            optionsViewController.modalPresentationStyle = UIModalPresentationPopover;
            
            optionsViewController.popoverPresentationController.delegate = self;
            if (self.detailTextLabel.window){
                optionsViewController.popoverPresentationController.sourceRect = CGRectMake(0, 0, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
                optionsViewController.popoverPresentationController.sourceView = self.detailTextLabel;
                optionsViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
            } else {
                optionsViewController.popoverPresentationController.sourceRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                optionsViewController.popoverPresentationController.sourceView = self;
                optionsViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
            
            [self.formViewController presentViewController:optionsViewController
                                                  animated:YES
                                                completion:nil];
            [controller.tableView deselectRowAtIndexPath:[controller.tableView indexPathForCell:self] animated:YES];
        } else {
            [controller.navigationController pushViewController:optionsViewController animated:YES];
        }
    }
    else if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeSelectorActionSheet]){
        XLFormViewController * formViewController = self.formViewController;
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:self.rowDescriptor.selectorTitle
                                                                                  message:nil
                                                                           preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil]];
        alertController.popoverPresentationController.sourceView = formViewController.tableView;
        UIView* v = (self.detailTextLabel ?: self.textLabel) ?: self.contentView;
        alertController.popoverPresentationController.sourceRect = [formViewController.tableView convertRect:v.frame fromView:self];
        __weak __typeof(self)weakSelf = self;
        for (id option in self.rowDescriptor.selectorOptions) {
            NSString *optionTitle = [option displayText];
            if (self.rowDescriptor.valueTransformer){
                NSAssert([self.rowDescriptor.valueTransformer isSubclassOfClass:[NSValueTransformer class]], @"valueTransformer is not a subclass of NSValueTransformer");
                NSValueTransformer * valueTransformer = [self.rowDescriptor.valueTransformer new];
                NSString * transformedValue = [valueTransformer transformedValue:[option valueData]];
                if (transformedValue) {
                    optionTitle = transformedValue;
                }
            }
            [alertController addAction:[UIAlertAction actionWithTitle:optionTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [weakSelf.rowDescriptor setValue:option];
                                                                  [formViewController.tableView reloadData];
                                                              }]];
        }
        [formViewController presentViewController:alertController animated:YES completion:nil];
        [controller.tableView deselectRowAtIndexPath:[controller.form indexPathOfFormRow:self.rowDescriptor] animated:YES];
    }
    else if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeSelectorAlertView]){
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:self.rowDescriptor.selectorTitle
                                                                                  message:nil
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(self)weakSelf = self;
        for (id option in self.rowDescriptor.selectorOptions) {
            [alertController addAction:[UIAlertAction actionWithTitle:[option displayText]
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [weakSelf.rowDescriptor setValue:option];
                                                                  [weakSelf.formViewController.tableView reloadData];
                                                              }]];
        }
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil]];
        [controller presentViewController:alertController animated:YES completion:nil];
        [controller.tableView deselectRowAtIndexPath:[controller.form indexPathOfFormRow:self.rowDescriptor] animated:YES];
    }
    else if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPickerView]){
        [controller.tableView selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

-(UIViewController *)controllerToPresent
{
    id vc;
    if (self.rowDescriptor.action.viewControllerClass){
        vc = [[self.rowDescriptor.action.viewControllerClass alloc] init];
    }
    else if ([self.rowDescriptor.action.viewControllerStoryboardId length] != 0){
        UIStoryboard * storyboard =  [self storyboardToPresent];
        NSAssert(storyboard != nil, @"You must provide a storyboard when rowDescriptor.action.viewControllerStoryboardId is used");
        vc = [storyboard instantiateViewControllerWithIdentifier:self.rowDescriptor.action.viewControllerStoryboardId];
    }
    else if ([self.rowDescriptor.action.viewControllerNibName length] != 0){
        Class viewControllerClass = NSClassFromString(self.rowDescriptor.action.viewControllerNibName);
        NSAssert(viewControllerClass, @"class owner of self.rowDescriptor.action.viewControllerNibName must be equal to %@", self.rowDescriptor.action.viewControllerNibName);
        vc = [[viewControllerClass alloc] initWithNibName:self.rowDescriptor.action.viewControllerNibName bundle:nil];
    }
    
    if ([vc respondsToSelector:@selector(configParams:)]) {
        [vc configParams:self.rowDescriptor.action.nextParams];
    }
    
    return vc;
}

-(UIStoryboard *)storyboardToPresent
{
    if ([self.formViewController respondsToSelector:@selector(storyboardForRow:)]){
        return [self.formViewController storyboardForRow:self.rowDescriptor];
    }
    if (self.formViewController.storyboard){
        return self.formViewController.storyboard;
    }
    return nil;
}
@end
