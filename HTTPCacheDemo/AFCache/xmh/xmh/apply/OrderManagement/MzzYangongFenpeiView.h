//
//  MzzYangongFenpeiView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLJishiSearchModel.h"
@interface MzzYangongFenpeiView : UIView
@property (nonatomic ,copy)void (^deleteClick)(NSInteger index);
@property (nonatomic ,copy)void (^value)(NSInteger value,MLJiShiModel *jishiModel,UITextField *textField);
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UITextField *shuruLbl;
@property (nonatomic ,strong)MLJiShiModel *jishiModel;
@end
