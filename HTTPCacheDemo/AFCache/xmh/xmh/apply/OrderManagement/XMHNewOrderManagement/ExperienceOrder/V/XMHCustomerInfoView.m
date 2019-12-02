//
//  XMHCustomerInfoView.m
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCustomerInfoView.h"

@interface XMHCustomerInfoView()
/** YES: 搜索顾客 NO: 显示顾客 */
@property (nonatomic) BOOL isSearch;
/** <##> */
@property (nonatomic, strong) UIImageView *headImageView;
/** <##> */
@property (nonatomic, strong) UIButton *searchCustomerButton;
/** <##> */
@property (nonatomic, strong) UILabel *pointLabel, *customerInfoLabel, *nameLabel;
/** <##> */
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation XMHCustomerInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        self.headImageView = [[UIImageView alloc] initWithImage:UIImageName(@"dianjisousuoguke")];
        [self addSubview:_headImageView];
        _headImageView.userInteractionEnabled = YES;
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(46, 46));
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)];
        [_headImageView addGestureRecognizer:tap];
        
        self.searchCustomerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchCustomerButton setTitle:@"点击搜索顾客" forState:UIControlStateNormal];
        [_searchCustomerButton setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
        _searchCustomerButton.titleLabel.font = FONT_SIZE(15);
        [_searchCustomerButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchCustomerButton];
        [_searchCustomerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(16);
            make.top.mas_equalTo(7);
        }];
        
        self.pointLabel = [[UILabel alloc] init];
        _pointLabel.text = @"请先添加顾客后再进行制单";
        _pointLabel.font = FONT_SIZE(14);
        _pointLabel.textColor = kLabelText_Commen_Color_6;
        [self addSubview:_pointLabel];
        [_pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_searchCustomerButton);
            make.top.equalTo(_searchCustomerButton.mas_bottom);
        }];
        
        
        self.customerInfoLabel = [[UILabel alloc] init];
        _customerInfoLabel.text = @"顾客信息";
        _customerInfoLabel.font = FONT_SIZE(15);
        _customerInfoLabel.textColor = kLabelText_Commen_Color_6;
        [self addSubview:_customerInfoLabel];
        [_customerInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self);
        }];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:UIImageName(@"order_close") forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.mas_equalTo(0);
            make.centerY.equalTo(self);
        }];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"张三";
        _nameLabel.font = FONT_SIZE(15);
        _nameLabel.textColor = kLabelText_Commen_Color_6;
        _nameLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_deleteButton.mas_left);
            make.centerY.equalTo(self);
            make.left.equalTo(_customerInfoLabel.mas_right);
        }];
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = kColorE5E5E5;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(kSeparatorHeight);
        }];
        
        self.isSearch = YES;
    }
    return self;
}

#pragma mark - Private

- (void)setIsSearch:(BOOL)isSearch {
    _isSearch = isSearch;
    [self updateState];
}

- (void)updateState {
    if (_isSearch) {
        _headImageView.hidden = NO;
        _searchCustomerButton.hidden = NO;
        _pointLabel.hidden = NO;
        
        _customerInfoLabel.hidden = YES;
        _deleteButton.hidden = YES;
        _nameLabel.hidden = YES;
    } else {
        _headImageView.hidden = YES;
        _searchCustomerButton.hidden = YES;
        _pointLabel.hidden = YES;
        
        _customerInfoLabel.hidden = NO;
        _deleteButton.hidden = NO;
        _nameLabel.hidden = NO;
    }
}

#pragma mark - Public

/**
 配置用户信息

 @param userName 用户名+手机号
 */
- (void)configUserName:(NSString *)userName {
    if (!userName.length) {
        return;
    }
    self.isSearch = NO;
    _nameLabel.text = userName;
}

#pragma mark - Event

- (void)searchClick {
    if (self.searchBlock) self.searchBlock(self);
}

- (void)deleteClick:(UIButton *)sender {
    self.isSearch = YES;
    if (self.deleteUserBlock) self.deleteUserBlock(self);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
