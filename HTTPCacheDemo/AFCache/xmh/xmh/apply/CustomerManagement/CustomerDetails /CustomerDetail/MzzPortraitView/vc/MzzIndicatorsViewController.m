//
//  MzzIndicatorsViewController.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/6.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzIndicatorsViewController.h"
#import "MzzCustomerRequest.h"
@interface MzzIndicatorsViewController ()


@end

@implementation MzzIndicatorsViewController
{
    NSString * _title;
    NSString * _refrence;
    NSString * _suggest;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.toTopConstraint.constant = Heigh_Nav;
    [self creatNav];
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",_title,@": "];
    self.referenceLabel.text = _refrence;
    self.indicatorsLabel.text = _suggest;
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"填写指标" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
-(void)pop{
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)indicatorsWithTitle:(NSString *)title andWithRefrence:(NSString *)refrence andSuggest:(NSString *)suggest
{
    _title = title;
    _refrence = refrence;
    _suggest = suggest;

}
- (IBAction)sureButtonAction:(id)sender {
    
    if ([self.txtInPut.text intValue]>=100||[self.txtInPut.text intValue]<=0) {
        [MzzHud toastWithTitle:@"提示" message:@"只可输入0-100之间的数值，最多输入两位小数"];
    }else{
        
       NSString *str = [self decimalwithFloatV:[self.txtInPut.text doubleValue]];

        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.uid,@"user_id",self.joinCode,@"join_code",self.storeCode,@"store_code",self.indexId,@"index_id",str,@"number", nil];
        WeakSelf;
        [MzzCustomerRequest requestAddIndicatorsParams:dic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                [weakSelf.navigationController popViewControllerAnimated:NO];
            }
        }];
    }
}
-(NSString *) decimalwithFloatV:(double)floatV{
    
    NSNumber *number = @(floatV);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = 2;
    return  [formatter stringFromNumber:number];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
