//
//  FWDSelectCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDSelectCell.h"
#import "MLJishiSearchModel.h"
#import "SLSearchManagerModel.h"
#import "MzzStoreModel.h"
#import "FWDYeJGuiShuModel.h"
@implementation FWDSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (void)setJisModel:(MLJiShiModel *)jisModel
//{
//    _lb1.text = jisModel.name;
//    _lb2.text = jisModel.phone;
//    _lb3.text = jisModel.store_name;
//    if (jisModel.isSelect) {
//        _imgV.image = [UIImage imageNamed:@"beautyxuanzhong"];
//    }else{
//        _imgV.image = [UIImage imageNamed:@"beautyweixuanzhong"];
//    }
//}
- (void)setModel:(id)model
{
    if ([model isKindOfClass:[MLJiShiModel class]]) {
        MLJiShiModel * jismodel = (MLJiShiModel *)model;
        _lb1.text = jismodel.name;
        _lb2.text = jismodel.phone;
        _lb3.text = jismodel.store_name;
        if (jismodel.isSelect) {
            _imgV.image = [UIImage imageNamed:@"beautyxuanzhong"];
        }else{
            _imgV.image = [UIImage imageNamed:@"beautyweixuanzhong"];
        }
    }else if ([model isKindOfClass:[SLManagerModel class]]){
        SLManagerModel * jismodel = (SLManagerModel *)model;
        _lb1.text = jismodel.name;
//        _lb2.text = jismodel.phone;
//        _lb3.text = jismodel.store_name;
        if (jismodel.isSelect) {
            _imgV.image = [UIImage imageNamed:@"beautyxuanzhong"];
        }else{
            _imgV.image = [UIImage imageNamed:@"beautyweixuanzhong"];
        }
    }else if ([model isKindOfClass:[FWDYeJGuiShuModel class]]){
        FWDYeJGuiShuModel * jismodel = (FWDYeJGuiShuModel *)model;
        _lb1.text = jismodel.showName;
        if (jismodel.isSelect) {
            _imgV.image = [UIImage imageNamed:@"beautyxuanzhong"];
        }else{
            _imgV.image = [UIImage imageNamed:@"beautyweixuanzhong"];
        }
    }else{
        MzzStoreModel * jismodel = (MzzStoreModel *)model;
        _lb1.text = jismodel.store_name;
//        _lb2.text = jismodel.store_code;
        if (jismodel.isSelect) {
            _imgV.image = [UIImage imageNamed:@"beautyxuanzhong"];
        }else{
            _imgV.image = [UIImage imageNamed:@"beautyweixuanzhong"];
        }
    }
}
@end
