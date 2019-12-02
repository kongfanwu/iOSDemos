//
//  OrderReverseThreeTableViewCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReverseThreeTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *guishuLable;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (nonatomic, copy) void (^OrderReverseThreeCellBlock)(NSString *phoneStr);
@property (nonatomic, copy) void (^chooseCellBlock)();

-(void)updateGuishu:(NSString *)guishu;
@end
