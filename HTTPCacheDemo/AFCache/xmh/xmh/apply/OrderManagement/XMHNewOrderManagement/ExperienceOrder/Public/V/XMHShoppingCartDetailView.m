//
//  XMHShoppingCartDetailView.m
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHShoppingCartDetailView.h"
#import "XMHShoppingCartDetailCell.h"
#import "XMHShoppingCartManager.h"
#import "XMHBillRecShopCatDetailCell.h"
#import "XMHSaleOrderShopCartCell.h"

@interface XMHShoppingCartDetailView() <UITableViewDelegate, UITableViewDataSource>
/** <##> */
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XMHShoppingCartDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];//RGBColor(146, 146, 146);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49 - 267, SCREEN_WIDTH, 267)];
        _contentView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_contentView];
        
        
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];

        CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _contentView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _contentView.layer.mask = cornerRadiusLayer;
        
        
        UILabel *titleLabel = UILabel.new;
        titleLabel.font = FONT_SIZE(16);
        titleLabel.textColor = kColor9;
        titleLabel.text = @"已选商品";
        [_contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
        }];
        
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton setTitle:@"清空" forState:UIControlStateNormal];
        [clearButton setTitleColor:kColor6 forState:UIControlStateNormal];
        clearButton.titleLabel.font = FONT_SIZE(15);
        [clearButton setImage:UIImageName(@"qingkong") forState:UIControlStateNormal];
        [_contentView addSubview:clearButton];
        [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(70, 40));
        }];
        [clearButton setTitleEdgeInsets:UIEdgeInsetsMake(0, clearButton.imageView.frame.size.width + 3, 0.0,0.0)];
        WeakSelf
        [clearButton bk_addEventHandler:^(id sender) {
            [XMHShoppingCartManager.sharedInstance clear];
            weakSelf.dataArray = nil;
            if (weakSelf.removeSuperViewBlock) weakSelf.removeSuperViewBlock();
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.rowHeight = 30 + 11 * 2;
        [_contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.right.bottom.equalTo(_contentView);
        }];
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [_tableView reloadData];
}

#pragma mark - Event

- (void)tap {
    if (self.removeSuperViewBlock) self.removeSuperViewBlock();
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    XMHShoppingCartDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        if (_cellType  ==  ShoppingCartCellType_BillRec) {
            XMHBillRecShopCatDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMHBillRecShopCatDetailCell"];
            if (!cell) {
                cell = [[XMHBillRecShopCatDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            id model = [_dataArray safeObjectAtIndex:indexPath.row];
            [cell configModel:model];
            __weak typeof(self) _self = self;
            cell.didDeleteBlock = ^(XMHBillRecShopCatDetailCell * _Nonnull cell) {
                __strong typeof(_self) self = _self;
                self.dataArray = XMHShoppingCartManager.sharedInstance.dataArray;
                [self.tableView reloadData];
            };
          
            return cell;
            
        }else if (_cellType  == ShoppingCartCellType_SaleOrder){
            XMHSaleOrderShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMHSaleOrderShopCartCell"];
            if (!cell) {
                cell = [[XMHSaleOrderShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell configModel:_dataArray[indexPath.row]];
            __weak typeof(self) _self = self;
            cell.didDeleteBlock = ^(XMHSaleOrderShopCartCell * _Nonnull cell) {
                __strong typeof(_self) self = _self;
                self.dataArray = XMHShoppingCartManager.sharedInstance.dataArray;
                [self.tableView reloadData];
            };
            return cell;
        }else{
            cell = [[XMHShoppingCartDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            __weak typeof(self) _self = self;
            cell.didDeleteBlock = ^(XMHShoppingCartDetailCell * _Nonnull cell) {
                __strong typeof(_self) self = _self;
                self.dataArray = XMHShoppingCartManager.sharedInstance.dataArray;
                [self.tableView reloadData];
            };
        }
       
    }
   
    [cell configModel:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 移除购物车数据
        if (_cellType  ==  ShoppingCartCellType_BillRec) {
            id model = _dataArray[indexPath.row];
            [XMHShoppingCartManager.sharedInstance deleteModel:model];
            // 重新赋值新数据并刷新
            self.dataArray = XMHShoppingCartManager.sharedInstance.dataArray;
        }else if (_cellType  == ShoppingCartCellType_SaleOrder){
            id model = _dataArray[indexPath.row];
            [XMHShoppingCartManager.sharedInstance deleteModel:model];
            // 重新赋值新数据并刷新
            self.dataArray = XMHShoppingCartManager.sharedInstance.dataArray;
        }else{
            id model = _dataArray[indexPath.row];
            [XMHShoppingCartManager.sharedInstance deleteModel:model];
            // 重新赋值新数据并刷新
            self.dataArray = XMHShoppingCartManager.sharedInstance.dataArray;
        }
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
