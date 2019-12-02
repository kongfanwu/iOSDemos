//
//  BillConfirmCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillConfirmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
@property (weak, nonatomic) IBOutlet UIButton *btnChange;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;

@property (nonatomic, copy) void (^btnBillConfirmCellBlock)(NSString *state, NSInteger section);

@property (nonatomic, copy) void (^btnBillConfirmCellModifyBlock)(NSMutableDictionary *dic, NSInteger section);
@property (nonatomic, copy) void (^btnBillConfirmCellDelBlock)(NSMutableDictionary *dic, NSInteger section);
- (void)freshBillConfirmCell0:(NSMutableDictionary *)dic withsection:(NSInteger)section;
- (void)freshBillConfirmCell1:(NSMutableDictionary *)dic withsection:(NSInteger)section;
- (void)freshBillConfirmCell2:(NSMutableDictionary *)dic withsection:(NSInteger)section;
- (void)freshBillConfirmCell3:(NSMutableDictionary *)dic withsection:(NSInteger)section;
- (void)freshBillConfirmCell4:(NSMutableDictionary *)dic withsection:(NSInteger)section;
- (void)freshBillConfirmCell5:(NSMutableDictionary *)dic withsection:(NSInteger)section;

@end
