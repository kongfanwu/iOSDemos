//
//  BookCustomerTableViewCell.h
//  xmh
//
//  Created by 李晓明 on 2017/11/23.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolHomeGuKeModel;
@interface BookCustomerTableViewCell : UITableViewCell
@property (nonatomic, copy)void (^BookCustomerTableViewCellBlock)(LolHomeGuKeModel * obj);
@property (nonatomic, strong)NSMutableArray * dataArr;
@end
