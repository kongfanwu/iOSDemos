//
//  SimulateActionSheet.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SimulateActionSheetDelegate <UIPickerViewDelegate>
//点击取消的回调接口
-(void)actionCancle;
//点击确定的回调接口
-(void)actionDone;

@end

@interface SimulateActionSheet : UIView

@property(assign, nonatomic) id<SimulateActionSheetDelegate> delegate;
@property(strong, nonatomic)UIView* toolBar;
@property(strong, nonatomic)UIPickerView* pickerView;

+(instancetype)styleDefault;
-(void)show:(UIViewController *)controller;
-(void)dismiss:(UIViewController *)controller;
//选中指定的行列
-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)anime;
//获取被选中的行列
-(NSInteger)selectedRowInComponent:(NSInteger)component;

@end
