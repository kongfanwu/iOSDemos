//
//  JobSelector.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JobSelectorModel.h"
#import "MzzManageModel.h"
#import "MzzTitleAndDetailView.h"
@interface JobSelector : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yyyyy;

@property (weak, nonatomic) IBOutlet UIButton *firstJobBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondJobBtn;

@property (nonatomic ,strong)NSArray <NSString *>*firstTitles;
@property (nonatomic ,strong)NSArray <NSString *>*secondTitles;

@property (nonatomic ,strong)NSArray <NSString *>*firstDetails;
@property (nonatomic ,strong)NSArray <NSString *>*secondDetails;

@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle1;
@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle2;
@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle3;
@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle4;
@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle5;
@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle6;
@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle7;
@property (weak, nonatomic) IBOutlet MzzTitleAndDetailView *totle8;

@property (copy ,nonatomic)void (^firstJobOnClick)(void);
@property (copy ,nonatomic)void (^secondJobOnClick)(void);

- (IBAction)firstJobOnclick:(UIButton *)sender;
-(void)setupWithFirstName:(NSString *)firstName
           andFirstTitles:(NSArray *)firstTitles
          andFirstDetails:(NSArray *)firstDetails
            andSecondName:(NSString *)secondName
          andSecondTitles:(NSArray *)secondTitles
        andSectondDetails:(NSArray *)secondDetails;
-(void)setupWithFirstName:(NSString *)firstName andFirstTitles:(NSArray *)firstTitles andFirstDetails:(NSArray *)firstDetails;
-(void)setupWithSecondName:(NSString *)secondName andSecondTitles:(NSArray *)secondTitles andSectondDetails:(NSArray *)secondDetails;


@property (nonatomic ,copy)void (^JobClick)(NSUInteger index, NSUInteger clickNum);
@property (nonatomic ,copy)void (^JobNameClick)(NSString *jobName,MzzTitleAndDetailView* btn);
-(void)updateStyleOnlyFirstBtn;
-(void)updateStyleOnlySecondBtn;
-(void)clearColor;
@end
