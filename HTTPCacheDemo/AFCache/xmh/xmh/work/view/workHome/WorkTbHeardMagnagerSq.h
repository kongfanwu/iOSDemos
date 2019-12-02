//
//  WorkTbHeardMagnagerSq.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkHeardManagerModel;
@interface WorkTbHeardMagnagerSq : UIView
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopConstraint;

+ (instancetype)loadWorkTbHeaderManagerSq;
-(void)updateWorkTbHeaderModel:(WorkHeardManagerModel *)model withRole:(NSInteger)role;

@end
