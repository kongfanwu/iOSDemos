//
//  TwoBtnChoiseSectionHeader.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TwoBtnChoiseSectionType){
    TwoBtnChoiseSectionTypeZhangDan, //账单明细
    TwoBtnChoiseSectionTypeGuKe,    //顾客处方
};
@interface TwoBtnChoiseSectionHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (nonatomic, copy)void(^TwoBtnChoiseSectionHeaderBlock)(TwoBtnChoiseSectionType type);
- (void)reFreshTwoBtnChoiseSectionHeader:(TwoBtnChoiseSectionType)type;
@end
