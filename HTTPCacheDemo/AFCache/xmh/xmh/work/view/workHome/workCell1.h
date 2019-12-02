//
//  workCell1.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

//待预约
//待跟进

@interface workCell1 : UITableViewCell

/*
 头像（imageview1）
 标题(1)：姓名(4)
 标题(2)：姓名(5)
 标题(3)：内容(6)
 */

@property (weak, nonatomic) IBOutlet UIImageView *imageview1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;

/*
 生成预约(btn1)
 */
@property (weak, nonatomic) IBOutlet UIButton *btn1;

/*
 灰色箭头背景(imageview2)
 消费不足(7)
 灰色底线(imageview3)
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageview2;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UIImageView *imageview3;

/**
 *刷新待预约
 */
- (void)reloadworkCell1DaiYuYue;
/**
 *刷新待跟进--售前跟进
 */
- (void)reloadworkCell1DaiGenJinShouQianGenJin;

/**
 *刷新待跟进--开发管控
 */
- (void)reloadworkCell1DaiGenJinKaiFaGuanKong;
/**
 *刷新待跟进--客情维护
 */
- (void)reloadworkCell1DaiGenJinKeQingWeiHu;
@end
