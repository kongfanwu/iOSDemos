//
//  MzzIndicatorsViewController.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/6.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzIndicatorsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *txtInPut;
@property (weak, nonatomic) IBOutlet UILabel *referenceLabel;
@property (weak, nonatomic) IBOutlet UITextView *indicatorsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopConstraint;

@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *joinCode;
@property(nonatomic,strong)NSString *storeCode;
@property(nonatomic,strong)NSString *indexId;

-(void)indicatorsWithTitle:(NSString *)title andWithRefrence:(NSString *)refrence andSuggest:(NSString *)suggest;
@end
