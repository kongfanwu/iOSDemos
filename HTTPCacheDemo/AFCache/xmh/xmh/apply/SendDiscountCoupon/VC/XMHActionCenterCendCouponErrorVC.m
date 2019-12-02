//
//  XMHActionCenterCendCouponErrorVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterCendCouponErrorVC.h"
#import "XMHActionSendCouponErrorCell.h"
@interface XMHActionCenterCendCouponErrorVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIView * containerView;
@end

@implementation XMHActionCenterCendCouponErrorVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [ColorTools colorWithHexString:@"#A7A7A7"];
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)]];
    [self initSubViews];
 
}
- (void)initSubViews
{
    UIScrollView *bg = UIScrollView.new;
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    UIView * containerView = UIView.new;
    containerView.layer.cornerRadius = 10;
    containerView.layer.masksToBounds = YES;
    containerView.backgroundColor = [UIColor whiteColor];
    _containerView = containerView;
    [bg addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(273 + 44);
        make.left.right.equalTo(bg);
        make.top.mas_equalTo(self.view.height - (273 + 44) - kSafeAreaBottom);
        make.width.mas_equalTo(self.view.width);
    }];

    UIView * titleConatiner = UIView.new;
    titleConatiner.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:titleConatiner];
    [titleConatiner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(containerView);
        make.height.mas_equalTo(44);
    }];

    UILabel * lb = UILabel.new;
    lb.textColor = kColor3;
    lb.font = FONT_SIZE(15);
    lb.text = @"库存不足";
    [titleConatiner addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(titleConatiner);
    }];

    UIButton * send = UIButton.new;
    send.tag = 1;
    [send setTitle:@"发送" forState:UIControlStateNormal];
    send.titleLabel.font = FONT_SIZE(15);
    [send setTitleColor:kColorTheme forState:UIControlStateNormal];
    [titleConatiner addSubview:send];
    [send  bk_addEventHandler:^(id sender) {
        [self dis:sender];
    } forControlEvents:UIControlEventTouchUpInside];
    [send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(titleConatiner);
    }];

    UIButton * cancel = UIButton.new;
    cancel.tag = 2;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = FONT_SIZE(15);
    [cancel setTitleColor:kColorTheme forState:UIControlStateNormal];
    [titleConatiner addSubview:cancel];
    [cancel bk_addEventHandler:^(id sender) {
        [self dis:sender];
    } forControlEvents:UIControlEventTouchUpInside];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.mas_equalTo(send.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(titleConatiner);
    }];

    UILabel *lbNotice = UILabel.new;
    lbNotice.text = @"优惠券库存不足，请多补充一些以防其他功能不能正常使用！";
    lbNotice.font = FONT_SIZE(11);
    [containerView addSubview:lbNotice];
    lbNotice.textColor = [ColorTools colorWithHexString:@"#FFAF19"];
    [lbNotice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(titleConatiner.mas_bottom).mas_offset(10);
    }];

    UITableView * tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tb.delegate = self;
    tb.dataSource = self;
    tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    [containerView addSubview:tb];
    [tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbNotice.mas_bottom).mas_offset(15);
        make.left.right.mas_equalTo(containerView);
        make.bottom.mas_equalTo(containerView.mas_bottom).mas_offset(-10);
    }];
}
- (void)dis:(UIButton *)btn
{
    if (btn.tag == 1) {
        if (_XMHActionCenterCendCouponErrorVCBlock) {
            _XMHActionCenterCendCouponErrorVCBlock(_dataSource);
        }
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)dismiss:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];
    if([_containerView.layer containsPoint:point]) {
        [self dis:nil];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kXMHActionSendCouponErrorCell = @"kXMHActionSendCouponErrorCell";
    XMHActionSendCouponErrorCell * cell = [tableView dequeueReusableCellWithIdentifier:kXMHActionSendCouponErrorCell];
    if (!cell) {
        cell = loadNibName(@"XMHActionSendCouponErrorCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row] index:indexPath.row];
    cell.XMHActionSendCouponErrorCellBlock = ^(XMHCouponSendErrorModel * _Nonnull model) {
        if ([_dataSource containsObject:model]) {
            [_dataSource replaceObjectAtIndex:[_dataSource indexOfObject:model] withObject:model];
        }
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//        return 10;
    return _dataSource.count;
}

@end
