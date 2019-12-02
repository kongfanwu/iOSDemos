//
//  BeautyJianGeWeakCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/21.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyChoiseJishiModel.h"
@interface BeautyJianGeWeakCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;

- (void)refreshBeautyJianGeWeakCell:(NSString *)str;
- (void)refreshBeautyJianGeWeakCellWithSelect:(BOOL)isSelect;
- (void)reFreshBeautyChoicejishiCell:(BeautyChoiseJishiList *)model;
- (void)refreshWorkChoiceCell:(NSString *)str;
@end
