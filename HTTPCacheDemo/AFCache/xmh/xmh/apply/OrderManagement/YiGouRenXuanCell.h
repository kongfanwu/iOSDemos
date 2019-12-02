//
//  YiGouRenXuanCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/24.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAZhiHuanPorListModel.h"

@interface YiGouRenXuanCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;


@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbnum;
@property (weak, nonatomic) IBOutlet UIButton *btnReduce;

@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UILabel *lb12;
@property (weak, nonatomic) IBOutlet UILabel *lb13;
@property (weak, nonatomic) IBOutlet UILabel *lb14;
@property (weak, nonatomic) IBOutlet UILabel *lb15;
@property (weak, nonatomic) IBOutlet UITextField *texF15;

@property (weak, nonatomic) IBOutlet UIButton *btnQuanBu;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btnShop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hsToBotemConstraint;

- (void)freshYiGouRenXuanCell:(SAZhiHuanPorModel *)model withIfChuZhi:(BOOL )ifChuZhi;

@property (nonatomic, copy) void (^btnMoreYiGouRenXuanCellBlock)(SAZhiHuanPorModel *model);

@property (nonatomic, copy) void (^btnReduceYiGouRenXuanCellBlock)(SAZhiHuanPorModel *model,NSInteger addFlag);

@property (nonatomic, copy) void (^btnQuanBuYiGouRenXuanCellBlock)(SAZhiHuanPorModel *model);

@property (nonatomic, copy) void (^btnShopYiGouRenXuanCellBlock)(SAZhiHuanPorModel *model);


@end
