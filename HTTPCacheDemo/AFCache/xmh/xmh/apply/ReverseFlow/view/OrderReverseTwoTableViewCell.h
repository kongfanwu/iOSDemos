//
//  OrderReverseTwoTableViewCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReverseTwoTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *realPayLabel;
@property (weak, nonatomic) IBOutlet UIView *payOneView;
@property (weak, nonatomic) IBOutlet UIView *payTwoView;
@property (weak, nonatomic) IBOutlet UIView *payThreeView;
@property (weak, nonatomic) IBOutlet UIView *payFoureView;
@property (weak, nonatomic) IBOutlet UILabel *payOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *payThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payFoureLabel;
@property (weak, nonatomic) IBOutlet UITextField *collectField;

@property (nonatomic, copy) void (^OrderReverseOneCellBlock)(NSString *MoneyStr);

@property (nonatomic, copy) void (^OrderReverseTwoCellBlock)(NSString *payStr);
-(void)updatedata:(NSMutableArray *)array;


@end
