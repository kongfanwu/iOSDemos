//
//  MzzCustomerInfoCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzDatePickerTextField.h"
#import "MzzPickerTextField.h"
#import "MzzCustomerInfoModel.h"
#import "MzzAddressTextField.h"
typedef void(^DoneBtnOnclick)(UITextField *textField);
typedef void(^CencelBtnOnclick)(UITextField *textField);
typedef void(^ReturnBtnOnclick)(UITextField *textField);


@interface MzzCustomerInfoCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic ,strong)UILabel *titleLbl;
@property(nonatomic ,strong)UITextField *textField;
@property(nonatomic ,copy)ReturnBtnOnclick returnclick;
- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel;
-(void)ismust:(BOOL)ismust;
@end

@interface MzzCustomerInfoPickerCell : UITableViewCell <UITextFieldDelegate>
@property(nonatomic ,strong)UILabel *titleLbl;
@property(nonatomic ,strong)MzzPickerTextField *textField;
@property (nonatomic,copy)DoneBtnOnclick doneclick;
@property (nonatomic,copy)CencelBtnOnclick cencelclick;
@property (nonatomic,assign)BOOL isStore;
@property (nonatomic,assign)BOOL isConfirm;
@property (nonatomic,assign)BOOL haveBillInfo;
- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel;
- (void)setupPickerdata:(NSArray *)dataList;
-(void)ismust:(BOOL)ismust;
@end

@interface MzzCustomerInfoDatePickerCell : UITableViewCell
@property(nonatomic ,strong)UILabel *titleLbl;
@property(nonatomic ,strong)MzzDatePickerTextField *textField;
@property (nonatomic,copy)DoneBtnOnclick doneclick;
@property (nonatomic,copy)CencelBtnOnclick cencelclick;
- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel;
-(void)ismust:(BOOL)ismust;
@end

@interface MzzCustomeAddressPickerCell : UITableViewCell
@property(nonatomic ,strong)UILabel *titleLbl;
@property(nonatomic ,strong)MzzAddressTextField *textField;
@property (nonatomic,copy)DoneBtnOnclick doneclick;
@property (nonatomic,copy)CencelBtnOnclick cencelclick;
- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel;
-(void)ismust:(BOOL)ismust;
@end
