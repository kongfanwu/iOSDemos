//
//  BookCustomerCollectionViewCell.h
//  xmh
//
//  Created by 李晓明 on 2017/11/23.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  

#import <UIKit/UIKit.h>
@class LolHomeGuKeModel;
@interface BookCustomerCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic)  UILabel *lb1;
@property (strong, nonatomic)  UILabel *lb2;
@property (strong, nonatomic)  UILabel *lb3;
@property (strong, nonatomic)  LolHomeGuKeModel * model;
@end
