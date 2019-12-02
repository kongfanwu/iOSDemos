//
//  LTabThreeView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTabThreeView : UIView
@property(nonatomic,strong)UILabel *chooseLabel;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *gaoButton;
@property(nonatomic,strong)UIButton *diButton;

@property (nonatomic, copy) void (^btnGaoButton)(void);

@property (nonatomic, copy) void (^btnDiButton)(void);

@property (nonatomic, copy) void (^btnChoose)(void);
- (void)updateTabThreeViewTitles:(NSString *)title withType:(NSString *)type;

@end
