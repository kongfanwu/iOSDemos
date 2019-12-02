//
//  OrderTopHeardView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTopHeardView : UIView
@property (copy, nonatomic) void (^firstJobOnClick)();
@property (copy, nonatomic) void (^secondJobOnClick)();
@property (copy, nonatomic) void (^moreJobOnClick)(BOOL select);

@property (nonatomic ,copy)void (^touchClick)(NSUInteger index, NSUInteger clickNum);

-(void)setupWithFirstName:(NSString *)firstName andFirstTitles:(NSArray *)firstTitles andFirstDetails:(NSArray *)firstDetails andSecondName:(NSString *)secondName andSecondTitles:(NSArray *)secondTitles andSectondDetails:(NSArray *)secondDetails;
-(void)setupWithFirstName:(NSString *)firstName andFirstTitles:(NSArray *)firstTitles andFirstDetails:(NSArray *)firstDetails;
-(void)setupWithSecondName:(NSString *)secondName andSecondTitles:(NSArray *)secondTitles andSectondDetails:(NSArray *)secondDetails;


@end
