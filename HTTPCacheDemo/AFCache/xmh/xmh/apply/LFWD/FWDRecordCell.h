//
//  FWDRecordCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWDRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ContainerView;
//@property (nonatomic, strong)NSMutableArray * imgsArr;
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, copy) void (^FWDRecordCellBlock)(NSMutableArray *imgs);
@property (nonatomic, copy) void (^FWDRecordCellTBlock)(NSMutableArray *imgs);

/** 新版本 */
@property (nonatomic) BOOL isNewVersion;

@end
