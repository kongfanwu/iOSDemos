//
//  MzzCustomerInfoController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzCustomerInfoModel.h"
@class MzzCustomerInfoController;
@protocol MzzCustomerInfoControllerDelegate <NSObject>
- (void)customerInfoController:(MzzCustomerInfoController *)controller andCustomerInfo:(InfoModel *)infoModel;
@end

@interface MzzCustomerInfoController : UIViewController
@property(nonatomic,strong)InfoModel *infoModel;
@property (nonatomic ,strong)NSDictionary *billInfoDic;
@property (nonatomic ,weak)id <MzzCustomerInfoControllerDelegate> delegate;
- (void)setupCustomerId:(NSString *)uid storeCode:(NSString *)stordCode;
@end
