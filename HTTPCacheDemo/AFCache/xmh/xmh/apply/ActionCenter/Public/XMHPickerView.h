//
//  XMHPickerView.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

/* 自定义使用方式
 NSMutableArray *dataArray = NSMutableArray.new;
 XMHItemModel *model;
 model = XMHItemModel.new;
 model.title = @"1";
 [dataArray addObject:model];
 
 model = XMHItemModel.new;
 model.title = @"2";
 [dataArray addObject:model];
 
 model = XMHItemModel.new;
 model.title = @"3";
 [dataArray addObject:model];
 
 XMHPickerView *pickerView = [[XMHPickerView alloc] init];
 pickerView.dataArray = (NSMutableArray *)@[dataArray];
 pickerView.type = PickerViewTypeCustom;
 pickerView.selectComponent = 0;
 [self.view addSubview:pickerView];
 [pickerView setSureBlock:^(XMHItemModel *  _Nonnull model) {
 
 }];
 */

#import <UIKit/UIKit.h>
#import "XMHItemModel.h"

typedef NS_ENUM(NSInteger, PickerViewType) {
    PickerViewTypeStatus, //投放状态
    PickerViewTypeUserLimits, //使用限制
    PickerViewTypeSendLimits, //发放限制
    PickerViewTypeAddType, //添加优惠券-添加方式
    PickerViewTypeCustom, // 自定义
};
NS_ASSUME_NONNULL_BEGIN
@protocol XMHPickerViewResultDelegate <NSObject>
@optional

- (void)pickerView:(UIView *)pickerView result:(NSString *)string;

@end

@interface XMHPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *picker;
@property (nonatomic,strong)UIDatePicker *datePicke;
@property(nonatomic,assign)PickerViewType type;
/** 数据源 */
@property(nonatomic,strong)NSMutableArray *dataArray;
/** 默认选中第一列 */
@property (nonatomic,assign)NSInteger selectComponent;
/** 默认选中第二列 */
@property (nonatomic,assign)NSInteger selectSecRow;
@property(nonatomic,weak)id<XMHPickerViewResultDelegate>delegate;

/** <#type#> */
@property (nonatomic, copy) void (^sureBlock)(id model);
@property (nonatomic, copy) void (^timesSureBlock)(NSString * time);
@property (nonatomic, copy) void (^dismissBlock)();
@end

NS_ASSUME_NONNULL_END
