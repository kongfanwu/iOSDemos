//
//  TJGuKeWebCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StructureModel.h"
#import "TJGuKeListModel.h"
#import "TJCardListModel.h"
@interface TJGuKeWebCell : UITableViewCell
@property (nonatomic, copy)StructureModel * model;
@property (nonatomic, copy)void (^TJGuKeWebCellBlock)(TJGuKeListModel * model);
//@property (nonatomic, copy)void (^TJCardWebCellBlock)(TJCardListModel * model);
@end
