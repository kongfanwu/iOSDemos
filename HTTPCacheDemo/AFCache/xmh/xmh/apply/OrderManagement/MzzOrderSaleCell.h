//
//  MzzOrderSaleCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/2.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "SANewDingDanListModel.h"

@interface MzzOrderSaleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *downBgView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UIButton *btnState;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lbtoBuyTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbBuyTimeTitle;

@property (strong, nonatomic) SANewDingDanModel * saleModel;
@property (nonatomic ,assign)NSInteger framework_function_main_role;

@property (nonatomic ,copy)void(^btn1SaleClick)(SANewDingDanModel *,NSString *);
@property (nonatomic ,copy)void(^btn2SaleClick)(SANewDingDanModel *,NSString *);
@property (nonatomic ,copy)void(^btn3SaleClick)(SANewDingDanModel *,NSString *);
@end
