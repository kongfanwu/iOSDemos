//
//  FWDController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWDController : UIViewController
@property (nonatomic,assign)NSInteger user_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, strong) NSMutableDictionary *commitDic;
@end
