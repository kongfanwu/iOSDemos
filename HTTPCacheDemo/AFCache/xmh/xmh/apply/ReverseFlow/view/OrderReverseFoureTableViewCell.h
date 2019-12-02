//
//  OrderReverseFoureTableViewCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReverseFoureTableViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *txtLable;
@property (nonatomic, copy) void (^OrderReverseFoureCellBlock)(NSString *beizhu);

@end
