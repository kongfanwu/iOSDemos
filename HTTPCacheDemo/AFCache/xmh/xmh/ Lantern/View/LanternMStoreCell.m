//
//  LanternMStoreCell.m
//  xmh
//
//  Created by ald_ios on 2019/2/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMStoreCell.h"
#import "LSelectBaseModel.h"
#import "MzzStoreModel.h"
@interface LanternMStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end
@implementation LanternMStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateCellModel:(MzzStoreModel *)model
{
    _lb.text = model.store_name?model.store_name:@"";
    if (model.isSelect) {
        _img.image = UIImageName(@"zhinengguanjia_xuanzhong");
        _lb.textColor = kColorTheme;
    }else{
        _img.image = UIImageName(@"zhinengguanjia_weixuan");
    }
}
- (void)updateCellParam:(NSMutableDictionary *)param
{
    _lb.text = param[@"name"]?param[@"name"]:@"";
    if ([param[@"select"]boolValue]) {
        _img.image = UIImageName(@"zhinengguanjia_xuanzhong");
        _lb.textColor = kColorTheme;
    }else{
        _img.image = UIImageName(@"zhinengguanjia_weixuan");
        _lb.textColor = kColor3;
    }
}
@end
