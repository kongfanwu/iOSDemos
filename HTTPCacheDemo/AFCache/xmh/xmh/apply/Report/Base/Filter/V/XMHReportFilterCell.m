//
//  XMHReportFilterCell.m
//  xmh
//
//  Created by ald_ios on 2019/7/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHReportFilterCell.h"
#import "MYTreeItem.h"
#import "XMHReportFilterOrganizeListModel.h"
@interface XMHReportFilterCell ()
/** 名称 */
@property (nonatomic, strong)UILabel * lb;
/** 复选框 */
@property (nonatomic, strong)UIButton * btn;
/** 箭头 */
@property (nonatomic, strong)UIImageView * more;
/** 分割线 */
@property (nonatomic, strong)UIView * line;
@property (nonatomic, strong) MYTreeItem *treeItem;
@property (nonatomic, strong) UIButton *checkButton;
@end
@implementation XMHReportFilterCell


#pragma mark - Init

+ (instancetype)cellWithTableView:(UITableView *)tableView andTreeItem:(MYTreeItem *)item {
    
    static NSString *ID = @"MYTreeTableViewCell";
    XMHReportFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XMHReportFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.treeItem = item;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.indentationWidth = 15;
        self.selectionStyle   = UITableViewCellSelectionStyleNone;
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
    UIView *line = UIView.new;
    _line = line;
    line.backgroundColor = kSeparatorColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton * btn = UIButton.new;
    [btn addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn = btn;
    [btn setImage:UIImageName(@"coupon_weixuan") forState:UIControlStateNormal];
    [btn setImage:UIImageName(@"coupon_xuanzhong") forState:UIControlStateSelected];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(39, 39));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
//    btn.backgroundColor = kColorTheme;
    
    UILabel * lb = UILabel.new;
    lb.text = @"name";
    lb.font = FONT_SIZE(16);
    lb.textColor = kColor3;
    _lb = lb;
    [self.contentView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn.mas_right).offset(10);
        make.centerY.mas_equalTo(btn.mas_centerY);
    }];
    
    UIImageView * more = UIImageView.new;
    more.image = UIImageName(@"yijiyemian_youjiantou");
    _more = more;
    [self.contentView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        //        make.size.mas_equalTo(CGSizeMake(41, 11));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat minX = 15 + self.indentationLevel * self.indentationWidth;
    
    [_btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(minX);
    }];
    
}

#pragma mark - Setter

- (void)setTreeItem:(MYTreeItem *)treeItem {
    _treeItem = treeItem;
    
    self.indentationLevel = treeItem.level;
    _lb.text = treeItem.name;
    self.more.image = treeItem.isLeaf ? nil : [UIImage imageNamed:@"yijiyemian_youjiantou"];
    /** 叶子节点 文字 分割线 问题 */
    if (treeItem.isLeaf) {
        _line.hidden = YES;
        _lb.font = FONT_SIZE(13);
        _lb.textColor = kColor6;
    }else{
        _lb.font = FONT_SIZE(16);
        _lb.textColor = kColor3;
        _line.hidden = NO;
    }
    [self refreshArrow];
    [self.btn setImage:[self getCheckImage] forState:UIControlStateNormal];
    
}

- (void)setIsShowArrow:(BOOL)isShowArrow {
    _isShowArrow = isShowArrow;
    
    if (!isShowArrow && self.imageView.image) {
        self.more.image = nil;
    }
}

- (void)setIsShowCheck:(BOOL)isShowCheck {
    _isShowCheck = isShowCheck;

}


#pragma mark - Public Method

- (void)updateItem {
    // 刷新 title 前面的箭头方向
    [UIView animateWithDuration:0.25 animations:^{
        [self refreshArrow];
    }];
}


#pragma mark - Private Method

- (void)refreshArrow {
    
    if (self.treeItem.isExpand) {
        self.more.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.more.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)checkButtonClick:(UIButton *)sender {
    if (self.checkButtonClickBlock) {
        self.checkButtonClickBlock(self.treeItem);
    }
}

- (UIImage *)getCheckImage {
    
    switch (self.treeItem.checkState) {
        case MYTreeItemDefault:
            return [UIImage imageNamed:@"duoxuan_weixuan"];
            break;
        case MYTreeItemChecked:
            return [UIImage imageNamed:@"duoxuan_xuanzhong"];
            break;
        case MYTreeItemHalfChecked:
            return [UIImage imageNamed:@"duoxuan_weixuan"];
            break;
        default:
            return nil;
            break;
    }
}



- (void)updateCellModel:(XMHReportFilterOrganizeModel *)model
{
    _btn.userInteractionEnabled = NO;
    _more.hidden = YES;
    _lb.text = model.name;
    _btn.selected = model.selected;
}
@end
