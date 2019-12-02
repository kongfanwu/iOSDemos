//
//  TJGuKeCardSelectCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJGuKeTopModel.h"
@interface TJGuKeCardSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, copy)void (^TJGuKeCardSelectCellBlock)(NSString * index);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;
@property (nonatomic, assign)NSInteger type;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (nonatomic, strong)TJGuKeTopModel * topModel;
@end
