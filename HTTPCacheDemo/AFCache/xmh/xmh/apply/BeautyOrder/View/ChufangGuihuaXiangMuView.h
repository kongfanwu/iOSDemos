//
//  ChufangGuihuaXiangMuView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChufangGuihuaXiangMuView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UITableView *tbview;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UILabel *lb6;

@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;


- (float)getChufangGuihuaXiangMuViewHeight;
- (void)freshTiem:(NSString *)timeStr;
@end
