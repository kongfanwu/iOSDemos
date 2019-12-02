//
//  JobSelector.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "JobSelector.h"
#import "MzzTitleAndDetailView.h"
#import "MzzManageModel.h"
@interface JobSelector ()


@property (weak, nonatomic) IBOutlet UILabel *tipView;
@property (assign,nonatomic)BOOL notOnClick;
@property (assign ,nonatomic)CGFloat yTiaozheng;
@end
@implementation JobSelector

- (IBAction)firstJobOnclick:(UIButton *)sender {
   
    if (sender.currentTitle.length < 3) {
         _tipView.frame = CGRectMake(_firstJobBtn.x + 15, _firstJobBtn.bottom + 2, _firstJobBtn.width - 30, 2);
    }else{
        _tipView.frame = CGRectMake(_firstJobBtn.x , _firstJobBtn.bottom + 2, _firstJobBtn.width , 2);
    }
   
    
    [sender setSelected:YES];
    [_secondJobBtn setSelected:NO];
    if (_notOnClick == NO) {
        if (_firstJobOnClick) {
            self.firstJobOnClick();
        }
    }
    _notOnClick = NO;
    //刷新数据
    [self layoutButtons:_firstTitles.count];
    for (int i  = 0; i < _firstTitles.count; i ++) {
        switch (i) {
            case 0:
            {
                [_totle1 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle1.titleLbl.text,_totle1);
                    }
                }];
            }
                break;
            case 1:
            {
                [_totle2 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle2.titleLbl.text,_totle2);
                    }
                }];
            }
                break;
            case 2:
            {
                [_totle3 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle3.titleLbl.text,_totle3);
                    }
                }];
            }
                break;
            case 3:
            {
                [_totle4 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle4.titleLbl.text,_totle4);
                    }
                }];
            }
                break;
            case 4:
            {
                [_totle5 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle5.titleLbl.text,_totle5);
                    }
                }];
            }
                break;
            case 5:
            {
                [_totle6 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle6.titleLbl.text,_totle6);
                    }
                }];
            }
                break;
            case 6:
            {
                [_totle7 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle7.titleLbl.text,_totle7);
                    }
                }];
            }
                break;
            case 7:
            {
                [_totle8 setTitle:_firstTitles[i] andDetail:_firstDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(0, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle8.titleLbl.text,_totle8);
                    }
                }];
            }
                break;
        }
    }
    [self clearColor];
}
- (IBAction)secondJobOnclick:(UIButton *)sender {
    if (sender.currentTitle.length < 3) {
        _tipView.frame = CGRectMake(_secondJobBtn.x + 15, _secondJobBtn.bottom + 2, _secondJobBtn.width- 30, 2);
    }else{
        _tipView.frame = CGRectMake(_secondJobBtn.x , _secondJobBtn.bottom + 2, _secondJobBtn.width, 2);
    }
    
    
    [sender setSelected:YES];
    [_firstJobBtn setSelected:NO];
    if (_notOnClick == NO) {
        if (_secondJobOnClick) {
            self.secondJobOnClick();
        }
    }
    _notOnClick = NO;;
 
    //刷新数据
    [self layoutButtons:_secondTitles.count];
    for (int i  = 0; i < _secondTitles.count; i ++) {
        switch (i) {
            case 0:
            {
                [_totle1 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle1.titleLbl.text,_totle1);
                    }
                }];
            }
                break;
            case 1:
            {
                [_totle2 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle2.titleLbl.text,_totle2);
                    }
                }];
            }
                break;
            case 2:
            {
                [_totle3 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle3.titleLbl.text,_totle3);
                    }
                }];
            }
                break;
            case 3:
            {
                [_totle4 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle4.titleLbl.text,_totle4);
                    }
                }];
            }
                break;
            case 4:
            {
                [_totle5 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle5.titleLbl.text,_totle5);
                    }
                }];
            }
                break;
            case 5:
            {
                [_totle6 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle6.titleLbl.text,_totle6);
                    }
                }];
            }
                break;
            case 6:
            {
                [_totle7 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle7.titleLbl.text,_totle7);
                    }
                }];
            }
                break;
            case 7:
            {
                [_totle8 setTitle:_secondTitles[i] andDetail:_secondDetails[i] andClick:^(MzzTitleAndDetailView *view) {
                    if (_JobClick) {
                        self.JobClick(1, view.tag);
                    }
                    if (_JobNameClick) {
                        self.JobNameClick(_totle8.titleLbl.text,_totle8);
                    }
                }];
            }
                break;
        }
    }
    [self clearColor];
}

- (void)layoutButtons:(NSUInteger)totleCont{
    //适配
    if (totleCont ==7) {
        _totle1.x = 0;
        _totle1.width = SCREEN_WIDTH / 4;
        
        _totle2.x = SCREEN_WIDTH / 4;;
        _totle2.width = SCREEN_WIDTH / 4;
        
        _totle3.x = SCREEN_WIDTH / 4 *2;
        _totle3.width = SCREEN_WIDTH / 4;
        
        _totle4.x =  SCREEN_WIDTH / 4 *3;
        _totle4.width = SCREEN_WIDTH / 4;
        
        _totle5.x = 0;
        _totle5.width = SCREEN_WIDTH / 3;
        
        _totle6.x = SCREEN_WIDTH / 3;
        _totle6.width = SCREEN_WIDTH / 3;
        
        _totle7.x = SCREEN_WIDTH / 3 * 2;
        _totle7.width = SCREEN_WIDTH / 3;
        
        _totle8.x = SCREEN_WIDTH / 3 * 3;
        _totle8.width = 0;
    }
    
    if (totleCont == 8) {
        _totle1.x = 0;
        _totle1.width = SCREEN_WIDTH / 4;
        
        _totle2.x = SCREEN_WIDTH / 4;;
        _totle2.width = SCREEN_WIDTH / 4;
        
        _totle3.x = SCREEN_WIDTH / 4 *2;
        _totle3.width = SCREEN_WIDTH / 4;
        
        _totle4.x =  SCREEN_WIDTH / 4 *3;
        _totle4.width = SCREEN_WIDTH / 4;
        
        _totle5.x = 0;
        _totle5.width = SCREEN_WIDTH / 4;
        
        _totle6.x = SCREEN_WIDTH / 4;
        _totle6.width = SCREEN_WIDTH / 4;
        
        _totle7.x = SCREEN_WIDTH / 4 * 2;
        _totle7.width = SCREEN_WIDTH / 4;
        
        _totle8.x = SCREEN_WIDTH / 4 * 3;
        _totle8.width = SCREEN_WIDTH / 4;
    }
}



-(void)awakeFromNib {
    [super awakeFromNib];
    [_firstJobBtn setTitleColor:[ColorTools colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_secondJobBtn setTitleColor:[ColorTools colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_firstJobBtn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
    [_secondJobBtn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
    _tipView.backgroundColor = kBtn_Commen_Color;
    _notOnClick = YES;
}
-(void)clearColor{
    [_totle1.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle1.detailLbl setTextColor:kLabelText_Commen_Color_3];
   
    
    [_totle2.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle2.detailLbl setTextColor:kLabelText_Commen_Color_3];
    
    [_totle3.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle3.detailLbl setTextColor:kLabelText_Commen_Color_3];
    
    [_totle4.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle4.detailLbl setTextColor:kLabelText_Commen_Color_3];
    
    [_totle5.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle5.detailLbl setTextColor:kLabelText_Commen_Color_3];
    
    [_totle6.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle6.detailLbl setTextColor:kLabelText_Commen_Color_3];
    
    [_totle7.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle7.detailLbl setTextColor:kLabelText_Commen_Color_3];
    
    [_totle8.titleLbl setTextColor:[ColorTools colorWithHexString:@"#999999"]];
    [_totle8.detailLbl setTextColor:kLabelText_Commen_Color_3];
}

-(void)setupWithFirstName:(NSString *)firstName andFirstTitles:(NSArray *)firstTitles andFirstDetails:(NSArray *)firstDetails andSecondName:(NSString *)secondName andSecondTitles:(NSArray *)secondTitles andSectondDetails:(NSArray *)secondDetails{
    [_firstJobBtn setTitle:firstName forState:UIControlStateNormal];
    [_secondJobBtn setTitle:secondName forState:UIControlStateNormal];
    _firstTitles = firstTitles;
    _firstDetails = firstDetails;
    _secondTitles = secondTitles;
    _secondDetails = secondDetails;
    _notOnClick = YES;
    _firstJobBtn.hidden = NO;
    _secondJobBtn.hidden = NO;
    _tipView.hidden = NO;
     _yyyyy.constant = 46;
    [self firstJobOnclick:_firstJobBtn];
}
-(void)setupWithFirstName:(NSString *)firstName andFirstTitles:(NSArray *)firstTitles andFirstDetails:(NSArray *)firstDetails{
    [_firstJobBtn setTitle:firstName forState:UIControlStateNormal];
    _firstTitles = firstTitles;
    _firstDetails = firstDetails;
     _notOnClick = YES;
    _firstJobBtn.hidden = NO;
    _secondJobBtn.hidden = NO;
    _tipView.hidden = NO;
     _yyyyy.constant = 46;
    [self firstJobOnclick:_firstJobBtn];
}
-(void)setupWithSecondName:(NSString *)secondName andSecondTitles:(NSArray *)secondTitles andSectondDetails:(NSArray *)secondDetails{
    [_secondJobBtn setTitle:secondName forState:UIControlStateNormal];
    _secondTitles = secondTitles;
    _secondDetails = secondDetails;
    _notOnClick = YES;
    _firstJobBtn.hidden = NO;
    _secondJobBtn.hidden = NO;
    _tipView.hidden = NO;
    _yyyyy.constant = 46;
    [self secondJobOnclick:_secondJobBtn];
}
-(void)updateStyleOnlyFirstBtn{
    _tipView.hidden = YES;
    _secondJobBtn.hidden = YES;
    _firstJobBtn.centerX = self.centerX;
//    _yyyyy.constant = 0;
//    self.height = 170 - 46;
    [self firstJobOnclick:_firstJobBtn];
}
-(void)updateStyleOnlySecondBtn{
    _tipView.hidden = YES;
    _secondJobBtn.centerX = self.centerX;
    _firstJobBtn.hidden = YES;
//     _yyyyy.constant = 0;
//    self.height = 170 - 46;
    [self secondJobOnclick:_secondJobBtn];
}
@end
