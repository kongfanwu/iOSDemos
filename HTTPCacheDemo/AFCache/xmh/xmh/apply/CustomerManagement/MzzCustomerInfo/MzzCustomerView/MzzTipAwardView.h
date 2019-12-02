//
//  MzzTipAwardView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJDropdownMenu.h"
@interface MzzTipAwardView : UIView
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *jiangzengleixing;
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *jiangzengneirong;
@property (weak, nonatomic) IBOutlet UILabel *jiangzengshuliang;
@property (weak, nonatomic) IBOutlet UILabel *jiangzengjiazhi;
@property (weak, nonatomic) IBOutlet UIButton *quxiao;
@property (weak, nonatomic) IBOutlet UIButton *tianjia;
@property (weak, nonatomic) IBOutlet UIButton *jianhao;
@property (weak, nonatomic) IBOutlet UIButton *jiahao;
@end
