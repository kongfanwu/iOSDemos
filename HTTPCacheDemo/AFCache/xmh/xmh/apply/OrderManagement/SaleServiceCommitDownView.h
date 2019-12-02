//
//  SaleServiceCommitDownView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleServiceCommitDownView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tbHeight;

@end
