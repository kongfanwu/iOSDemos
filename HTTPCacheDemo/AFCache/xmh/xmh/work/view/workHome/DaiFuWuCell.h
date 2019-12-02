//
//  DaiFuWuCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiFuWuCell : UITableViewCell
/*
 头像（imageview1）
 标题(1)：姓名(5)
 标题(2)：时间(6)
 项目(3)：内容(7)
 次数(4)：内容(8)
 
            btn1开单  btn2修改
 line1线
 （9)平台提醒
 */

@property (weak, nonatomic) IBOutlet UIImageView *imageview1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (strong ,nonatomic)UIButton *tishiBtn;
@property (copy ,nonatomic)void (^click)(void);
/**
*刷新待服务-服务内容
*/
- (void)reloadworkDaiFuWuCellFuWuNeiRong;
/**
 *刷新待服务-销售内容
 */
- (void)reloadworkDaiFuWuCellXiaoShouNeiRong;


@end
