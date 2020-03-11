
//
//  FTTInformationCell.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/18.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTTInformationCell.h"
#import "FTTInformationModel.h"
#import "FTFormRow.h"
#import "FTTChectButtonModel.h"
#import "FTTChectView.h"
#import "ViewControllerProtocol.h"

@interface FTTInformationCell()
@property (nonatomic, strong) UILabel *titleLabel, *detailTitleLable;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *arryCount;

@end
@implementation FTTInformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.bgView = UIView.new;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}
- (void)configRow:(FTFormRow *)row
{
     self.arryCount = row.value;
     NSMutableArray *buttonArry = row.buttonCheck;
    
    UIButton *lastView = nil;
    UIButton *lastRowView = nil;
    int lastChu = -1;
    
    for (int i = 0; i < _arryCount.count; i++) {
        FTTInformationModel *model = _arryCount[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:model.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_bgView addSubview:button];
        
        UIButton *selectbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectbutton.backgroundColor = [UIColor whiteColor];
        selectbutton.layer.borderColor = [UIColor grayColor].CGColor;
        selectbutton.layer.borderWidth = 1;
        selectbutton.layer.cornerRadius = 5;
        selectbutton.layer.masksToBounds = YES;
        selectbutton.tag = i;
        [selectbutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:selectbutton];
    
        UILabel *detailelable = [UILabel new];
        detailelable.numberOfLines = 0;
        detailelable.textColor = [UIColor grayColor];
        detailelable.font = [UIFont systemFontOfSize:14];
        detailelable.text = model.detailTitle;
        [_bgView addSubview:detailelable];
        
        int yu = i % 1; // 0 1 2  0 1 2  0 1 2  x 轴对应的是列
        int chu = floor(i / 1);  // y 轴对应的是行
    
        if (lastChu != chu) {
            lastChu = chu;
            lastRowView = lastView;
        }
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            
            if (yu == 0) {
                make.left.equalTo(self.bgView.mas_left).offset(40);
            } else {
                make.left.equalTo(lastView.mas_right).offset(10);
            }
            
            if (chu == 0) {
                make.top.equalTo(self.bgView).offset(10);
            } else {
                make.top.equalTo(lastRowView.mas_bottom).offset(60);
            }
            
            if (i == _arryCount.count - 1) {
                make.bottom.equalTo(self.bgView).offset(-60);
            }
        }];
        
        selectbutton.selected = model.select;
        if (model.select) {
            selectbutton.backgroundColor = [UIColor colorWithRed:233/255.0 green:29/255.0 blue:135/255.0 alpha:1];
        } else {
            selectbutton.backgroundColor = [UIColor whiteColor];
        }
 
        [selectbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            
            if (yu == 0) {
                make.left.equalTo(self.bgView.mas_left).offset(20);
            } else {
                make.left.equalTo(lastView.mas_right).offset(10);
            }
            
            if (chu == 0) {
                make.top.equalTo(self.bgView).offset(15);
            } else {
                make.top.equalTo(lastRowView.mas_bottom).offset(60);
            }
            
            if (i == _arryCount.count - 1) {
                make.bottom.equalTo(self.bgView).offset(-60);
            }
        }];
        
        lastView = button;
        
        [detailelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button.mas_bottom).offset(10);
            make.left.mas_equalTo(self.bgView.mas_left).offset(10);
            make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        }];
        
      
        FTTChectView *checkButtonView = [[FTTChectView alloc] init];
        checkButtonView.backgroundColor = [UIColor whiteColor];
        checkButtonView.buttonArry = buttonArry; //检查按钮的model
        checkButtonView.select = model.select;
        [self addSubview:checkButtonView];
        [checkButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_bottom);
            make.left.mas_equalTo(self.bgView.mas_left);
            make.right.mas_equalTo(self.bgView.mas_right);
            make.height.mas_equalTo(60);
        }];
    }
}

-(void)click:(UIButton *)button
{
     UITableViewController <ViewControllerProtocol> *tableVC = (UITableViewController <ViewControllerProtocol> *)self.viewController;
      FTTInformationModel *model = _arryCount[button.tag];
    [_arryCount enumerateObjectsUsingBlock:^(FTTInformationModel  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.select = NO;
    }];
    model.select = YES;
    
    [tableVC.tableView reloadData];
}
@end
