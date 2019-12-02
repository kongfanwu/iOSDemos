//
//  FWDSelectCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLJishiSearchModel.h"
#import "SLSearchManagerModel.h"
#import "MzzStoreModel.h"
@interface FWDSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
//@property (nonatomic, strong)MLJiShiModel * jisModel;
@property (nonatomic, strong)id model;
@end
