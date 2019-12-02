//
//  WorkTopView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorkHeardManagerModel;
@interface WorkTopView : UIView
- (instancetype)initWithFrame:(CGRect)frame withMessageArray:(WorkHeardManagerModel *)model andRole:(NSInteger)role;
-(void)updateLoad:(CGRect)frame withNum:(NSInteger)num withModel:(WorkHeardManagerModel *)model andRole:(NSInteger)role;


@end
