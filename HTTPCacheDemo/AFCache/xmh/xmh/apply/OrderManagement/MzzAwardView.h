//
//  MzzAwardView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASaleListModel.h"
@interface MzzAwardView : UIView
@property (nonatomic ,strong)NSMutableArray <SaleModel *>* list;
@property (nonatomic ,assign)NSInteger user_id;
@property (nonatomic,copy)NSString *store_code;
@property (nonatomic,copy)void(^awardCommit)(NSMutableArray <SaleModel *>* list,BOOL ifdele);
@end
