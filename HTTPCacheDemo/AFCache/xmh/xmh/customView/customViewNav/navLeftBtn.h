//
//  navLeftBtn.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navLeftBtn : UIButton
// 标题、下拉箭头
@property(nonatomic, strong)UILabel *lb1;
@property(nonatomic, strong)UIImageView *imageview1;

- (void)reloadnavLeftBtn:(NSString *)leftTitleStr;

@end
