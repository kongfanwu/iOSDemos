//
//  SimulateActionSheet.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SimulateActionSheet.h"

@interface SimulateActionSheet(){
    UIColor *toolBarColor;
    UIColor *textColorNormal;
    UIColor *textColorPressed;
    UIColor *pickerBgColor;
}
@end

@implementation SimulateActionSheet
+(instancetype)styleDefault{
    SimulateActionSheet* sheet = [[SimulateActionSheet alloc]initWithFrame:CGRectMake(
                                                                                      0,
                                                                                      0,
                                                                                      UIScreen.mainScreen.bounds.size.width,
                                                                                      UIScreen.mainScreen.bounds.size.height)];
    
    [sheet setBackgroundColor:[UIColor clearColor]];
    sheet.toolBar = [sheet actionToolBar];
    sheet.pickerView = [sheet actionPicker];
    [sheet addSubview:sheet.toolBar];
    [sheet addSubview:sheet.pickerView];
    
    return sheet;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        toolBarColor =[UIColor whiteColor];
        textColorNormal = kIm_Background_Color_c;
        textColorPressed = kBtn_Commen_Color;
        pickerBgColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return self;
}
-(void)setupInitPostion:(UIViewController *)controller{
    [UIApplication.sharedApplication.keyWindow?UIApplication.sharedApplication.keyWindow:UIApplication.sharedApplication.windows[0]
                                                                              addSubview:self];
    [self.superview bringSubviewToFront:self];
    CGFloat pickerViewYpositionHidden = UIScreen.mainScreen.bounds.size.height;
    [self.pickerView setFrame:CGRectMake(self.pickerView.frame.origin.x,
                                         pickerViewYpositionHidden,
                                         self.pickerView.frame.size.width,
                                         self.pickerView.frame.size.height)];
    [self.toolBar setFrame:CGRectMake(self.toolBar.frame.origin.x,
                                      pickerViewYpositionHidden,
                                      self.toolBar.frame.size.width,
                                      self.toolBar.frame.size.height)];
}
-(void)show:(UIViewController *)controller{
    [self setupInitPostion:controller];
    
    CGFloat toolBarYposition = UIScreen.mainScreen.bounds.size.height -
    (self.pickerView.frame.size.height + self.toolBar.frame.size.height);
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [self setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
                         [controller.view setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         [controller.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         
                         [self.toolBar setFrame:CGRectMake(self.toolBar.frame.origin.x,
                                                           toolBarYposition,
                                                           self.toolBar.frame.size.width,
                                                           self.toolBar.frame.size.height)];
                         
                         [self.pickerView setFrame:CGRectMake(self.pickerView.frame.origin.x,
                                                              toolBarYposition+self.toolBar.frame.size.height,
                                                              self.pickerView.frame.size.width,
                                                              self.pickerView.frame.size.height)];
                     }
                     completion:nil];
    
}
-(void)dismiss:(UIViewController *)controller{
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [self setBackgroundColor:[UIColor clearColor]];
                         [controller.view setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
                         [controller.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
                         [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             UIView* v = (UIView*)obj;
                             [v setFrame:CGRectMake(v.frame.origin.x,
                                                    UIScreen.mainScreen.bounds.size.height,
                                                    v.frame.size.width,
                                                    v.frame.size.height)];
                         }];
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
    
}

-(UIView *)actionToolBar{
    UIView *tools = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 44)];
    tools.backgroundColor = toolBarColor;
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor: [ColorTools colorWithHexString:@"F10180"] forState:UIControlStateHighlighted];
    [cancle setTitleColor: [ColorTools colorWithHexString:@"F10180"] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(actionCancle) forControlEvents:UIControlEventTouchUpInside];
    [cancle sizeToFit];
    [tools addSubview:cancle];
    
    cancle.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *cancleConstraintLeft = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeLeading multiplier:1.0f constant:10.0f];
    NSLayoutConstraint *cancleConstrainY = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
    [tools addConstraint:cancleConstraintLeft];
    [tools addConstraint:cancleConstrainY];
    
    UIButton *ok = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [ok setTitle:@"确定" forState:UIControlStateNormal];
    [ok setTitleColor: [ColorTools colorWithHexString:@"F10180"] forState:UIControlStateNormal];
    [ok setTitleColor: [ColorTools colorWithHexString:@"F10180"] forState:UIControlStateHighlighted];
    [ok addTarget:self action:@selector(actionDone) forControlEvents:UIControlEventTouchUpInside];
    [ok sizeToFit];
    [tools addSubview:ok];
    
    ok.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *okConstraintRight = [NSLayoutConstraint constraintWithItem:ok attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-10.0f];
    NSLayoutConstraint *okConstraintY = [NSLayoutConstraint constraintWithItem:ok attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
    [tools addConstraint:okConstraintRight];
    [tools addConstraint:okConstraintY];
    
    return tools;
}

-(UIPickerView *)actionPicker;{
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(self.pickerView.frame.origin.x,
                                                                         self.bounds.size.height,
                                                                         self.bounds.size.width,
                                                                         216)];
    picker.showsSelectionIndicator=YES;
    [picker setBackgroundColor:pickerBgColor];
    
    return picker;
}

-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)anime{
    [_pickerView selectRow:row inComponent:component animated:anime];
}

-(NSInteger)selectedRowInComponent:(NSInteger)component{
    return [_pickerView selectedRowInComponent:component];
}

-(void)actionDone{
    if([_delegate respondsToSelector:@selector(actionDone)]){
        [_delegate actionDone];
    }
}

-(void)actionCancle{
    if ([_delegate respondsToSelector:@selector(actionCancle)]) {
        [_delegate actionCancle];
    }
}
-(void)setDelegate:(id<SimulateActionSheetDelegate>)delegate{
    _delegate = delegate;
    _pickerView.delegate = delegate;
}
@end
