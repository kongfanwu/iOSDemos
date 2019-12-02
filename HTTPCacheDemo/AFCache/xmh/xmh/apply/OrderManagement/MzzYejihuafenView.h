//
//  MzzYejihuafenView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzStoreModel.h"
#import "SLSearchManagerModel.h"
#import "MLJishiSearchModel.h"

@interface MzzYejihuafenView : UIView
@property (weak, nonatomic) IBOutlet UIButton *yejiguishu;
@property (weak, nonatomic) IBOutlet UIButton *mendianguishu;
@property (weak, nonatomic) IBOutlet UIButton *dianzhangguishu;
@property (weak, nonatomic) IBOutlet UIButton *yuangonghuishu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yuangongguishuHeight;
@property (weak, nonatomic) IBOutlet UIView *YuangongguishuListView;
@property (weak, nonatomic) IBOutlet UITextField *gonggongyeji;
@property (nonatomic ,strong)UIViewController *superVc;

@property (nonatomic, copy) void (^clickJs)(NSInteger count);


//备注信息
@property (weak, nonatomic) IBOutlet UITextView *beizhu;
//业绩总比
@property (nonatomic ,assign)float totalBfb;
//公共业绩百分比
@property (nonatomic ,assign)float gonggongyejiBfb;
//业绩归属：售前业绩 售中业绩 售后业绩
@property (nonatomic ,copy)NSString *selectYejiguishu;
//选中的门店
@property (nonatomic ,strong)MzzStoreModel *selectStoreModel;
//选中的店长
@property (nonatomic ,strong)SLManagerModel *selectManagerModel;
//当前添加的技师
@property (nonatomic ,strong)MLJiShiModel *selectJiShiModel;
//选中的技师们
@property (nonatomic ,strong)NSMutableArray *yuangongArrays;
@property (nonatomic, copy)NSString * storeCode;
@end
