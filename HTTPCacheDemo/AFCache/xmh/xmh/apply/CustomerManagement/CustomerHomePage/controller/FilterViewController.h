//
//  FilterViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MzzFilterCommitModel;
@interface FilterViewController : UIViewController
@property (nonatomic, copy)void (^FilterViewControllerBlock)(MzzFilterCommitModel * model);
@property (nonatomic ,strong)MzzFilterCommitModel * commitModel;
@end
