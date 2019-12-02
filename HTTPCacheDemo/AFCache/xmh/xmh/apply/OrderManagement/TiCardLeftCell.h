//
//  TiCardLeftCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLTi_CardModel.h"
#import "SLSCourseExper.h"
#import "TiCardTypeDefine.h"
@interface TiCardLeftCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UIImageView *imGegnduo;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (strong, nonatomic)NSMutableArray *indexArr;

- (void)freshTiCardLeftCell:(SLTi_CardModel *)model;
@property (nonatomic, copy) void (^btnTiCardLeftCellBlock)(TiCardType type, NSInteger index, NSInteger whice);
@property (nonatomic, copy) void (^btnShowLeftCellBlock)(TiCardType type, NSMutableArray * index,NSInteger row);

@end
