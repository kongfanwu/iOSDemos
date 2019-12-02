//
//  XMHWorkTaskScheduleVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHWorkTaskScheduleVC.h"
#import "XMHTaskScheduleProgressBar.h"

@interface XMHWorkTaskScheduleVC ()

@property (nonatomic, strong) UILabel *titelLab;

@property (nonatomic, strong) NSMutableArray *leftData;
@property (nonatomic, strong) NSMutableArray *rightData;
@property (nonatomic, strong) NSArray *titleData;

@end

@implementation XMHWorkTaskScheduleVC
/**
 *  下面这句话会自动生成实现的协议的属性对应的成员变量。
 */
@synthesize cute_hand_rec_id = _cute_hand_rec_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.titelLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15 + Heigh_Nav , SCREEN_WIDTH, 18)];
    self.titelLab.font = FONT_SIZE(16);
    self.titelLab.textColor = kColor3;
    [self.view addSubview:self.titelLab];
    
    if (self.type == WorkTaskScheduleTypeRemind) {
        [self.navView setNavViewTitle:@"工作任务提醒" backBtnShow:YES];
        self.titelLab.text = @"合理的安排可以有效的提高工作效率";
    }else{
         self.titelLab.text = @"已经工作半天的来查看一下自己的工作成果吧";
       [self.navView setNavViewTitle:@"工作任务进度提醒" backBtnShow:YES];
    }
    self.navView.backgroundColor = kColorTheme;
    
    [self requestListData];
//    [self createProgressBar];
}
- (void)createProgressBar
{
    UIView *progressBarView = UIView.new;
    progressBarView.backgroundColor = UIColor.whiteColor;
    progressBarView.frame = CGRectMake(0, self.titelLab.bottom + 25, SCREEN_WIDTH, self.view.height - (self.titelLab.bottom + 25));
    [self.view addSubview:progressBarView];
    [progressBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(self.titelLab.bottom + 25);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    
    }];
    
    XMHTaskScheduleProgressBar *lastBar;
    
    for (int i = 0; i < _titleData.count; i++) {
        UILabel *titleLab = UILabel.new;
        titleLab.font = FONT_SIZE(14);
        titleLab.textColor = kColor6;
        titleLab.text = _titleData[i];
        [progressBarView addSubview:titleLab];
        
        UILabel *leftLab = UILabel.new;
        leftLab.font = FONT_SIZE(14);
        leftLab.textColor = kPortraitCellTitle_9072;
        leftLab.text = [_leftData safeObjectAtIndex:i];
        [progressBarView addSubview:leftLab];
        
        UILabel *rightLab = UILabel.new;
        rightLab.font = FONT_SIZE(14);
        rightLab.textColor = kColor6;
        rightLab.text = [NSString stringWithFormat:@"/%@",[_rightData safeObjectAtIndex:i]];
        [progressBarView addSubview:rightLab];
        
        XMHTaskScheduleProgressBar *progressBar = [[XMHTaskScheduleProgressBar alloc]init];
        progressBar.backgroundColor=[UIColor clearColor];
        [progressBarView addSubview:progressBar];
        progressBar.percent = [[_leftData safeObjectAtIndex:i] floatValue] / [[_rightData safeObjectAtIndex:i] floatValue];
     
        [titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(15);
//            make.width.mas_equalTo(80);
            if (lastBar) {
                make.top.equalTo(lastBar.mas_bottom).offset(15);
            }else{
                 make.top.mas_equalTo(0);
            }
        }];
        [titleLab sizeToFit];
        [leftLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(titleLab.mas_right);
            make.top.mas_equalTo(titleLab.mas_top);
            
        }];
        
        [rightLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(leftLab.mas_right);
            make.top.mas_equalTo(titleLab.mas_top);
            
        }];
        
        [progressBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(5);
            
        }];
        
         lastBar = progressBar;
        if (i == _titleData.count - 1) {
            [progressBar mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(titleLab.mas_bottom);
            }];
        }
    }

}

#pragma mark ------网络请求------
/** 列表数据 */
- (void)requestListData
{
    [XMHProgressHUD showGifImage];
    
    _titleData = @[@"接待顾客数：",@"消耗项目数：",@"消耗金额：",@"预约顾客数：",@"预约项目数：",@"扫码顾客数："];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    
    NSString * url;
    if (self.type == WorkTaskScheduleTypeRemind) {
        url = kSMARTHELPER_STANDARD_REMIND_URL;
    }else{
        url = kSMARTHELPER_STANDARD_ACTUAL_URL;
        LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
        [param setValue:self.time?self.time:@"" forKey:@"time"];//@"2019-06-10"
        [param setValue:account?account:@"" forKey:@"account"];
    }

    [YQNetworking postWithUrl:[XMHHostUrlManager url:url] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(id obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            BaseModel *baseModel = (BaseModel *)obj;
            NSDictionary *dic = baseModel.data;
            if (self.type == WorkTaskScheduleTypeRemind) {
                NSString *jiedai = dic[@"jiedai"];
                NSString *xiaohaoxiangmu = dic[@"xiaohaoxiangmu"];
                NSString *yuyueguke = dic[@"yuyueguke"];
                NSString *yuyuexiangmu = dic[@"yuyuexiangmu"];
                NSString *xiaohaojine = dic[@"xiaohaojine"];
                NSString *saoguke = dic[@"saoguke"];
                _rightData = [NSMutableArray arrayWithObjects:jiedai,xiaohaoxiangmu,xiaohaojine,yuyueguke,yuyuexiangmu,saoguke, nil];;
                _leftData = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
                
            }else{
                NSString *jiedai = dic[@"jiedai"];
                NSString *xiaohaoxiangmu = dic[@"xiaohaoxiangmu"];
                NSString *yuyueguke = dic[@"yuyueguke"];
                NSString *yuyuexiangmu = dic[@"yuyuexiangmu"];
                NSString *xiaohaojine = dic[@"xiaohaojine"];
                NSString *saoguke = dic[@"saoguke"];
                
                NSString *shi_jiedai = dic[@"shi_jiedai"];
                NSString *shi_xiaohaoxiangmu = dic[@"shi_xiaohaoxiangmu"];
                NSString *shi_yuyueguke = dic[@"shi_yuyueguke"];
                NSString *shi_yuyuexiangmu = dic[@"shi_yuyuexiangmu"];
                NSString *shi_xiaohaojine = dic[@"shi_xiaohaojine"];
                NSString *shi_saoguke = dic[@"shi_saoguke"];
                _rightData = [NSMutableArray arrayWithObjects:jiedai,xiaohaoxiangmu,xiaohaojine,yuyueguke,yuyuexiangmu,saoguke, nil];
                _leftData = [NSMutableArray arrayWithObjects:shi_jiedai,shi_xiaohaoxiangmu,shi_xiaohaojine,shi_yuyueguke,shi_yuyuexiangmu,shi_saoguke, nil];
            }

           [self createProgressBar];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
