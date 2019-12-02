//
//  CustomerFrameModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerFrameModel.h"

@implementation CustomerFrameModel
+(instancetype)customerFrameWithCustomerModel:(CustomerModel *)customerModel{
    CustomerFrameModel *customerFrame = [[CustomerFrameModel alloc] init];
    customerFrame.customerModel = customerModel;
    return customerFrame;
}

-(void)setCustomerModel:(CustomerModel *)customerModel{
    _customerModel = customerModel;
    //头像frame
    CGFloat margin = 6;
    CGFloat marginX = 10;
    CGFloat iconW = 57;
    CGFloat iconH = 57;
    _iconUrlFrame = CGRectMake(10, 15, iconW, iconH);
    //姓名frame
    CGSize nameSize = [customerModel.uname boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    CGFloat nameX = CGRectGetMaxX(self.iconUrlFrame) +marginX;
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    _nameFrame = CGRectMake(nameX, 15, nameW+150, nameH);
    //等级frame
    CGSize levelSize = [[NSString stringWithFormat:@"%ld",customerModel.grade] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size;
    CGFloat levelX = CGRectGetMaxX(self.iconUrlFrame) +marginX;
    CGFloat levelY = CGRectGetMaxY(self.nameFrame)+margin;
    CGFloat levelW = levelSize.width;
    CGFloat levelH = levelSize.height;
    _levelFrame = CGRectMake(levelX, levelY, levelW+150, levelH);
    //门店
    CGSize storeSize = [customerModel.mdname boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size;
    CGFloat storeX = CGRectGetMaxX(self.iconUrlFrame) +marginX;
    CGFloat storeY = CGRectGetMaxY(self.levelFrame)+margin;
    CGFloat storeW = storeSize.width;
    CGFloat storeH = storeSize.height;
    _storeFrame = CGRectMake(storeX, storeY, storeW+150, storeH);
    //技师
    CGSize waiterSize = [customerModel.jis boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size;
    CGFloat waiterX = CGRectGetMaxX(self.iconUrlFrame) +marginX;
    CGFloat waiterY = CGRectGetMaxY(self.storeFrame)+margin;
    CGFloat waiterW = waiterSize.width;
    CGFloat waiterH = waiterSize.height;
    _waiterFrame = CGRectMake(waiterX, waiterY, waiterW+150, waiterH);
    //调至门店
    CGSize toSize = [customerModel.tdname boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size ;
    CGFloat toX = CGRectGetMaxX(self.iconUrlFrame)+marginX;
    CGFloat toY = CGRectGetMaxY(self.waiterFrame) + 20;
    CGFloat toW = toSize.width;
    CGFloat toH = toSize.height;
    _toFrame = CGRectMake(toX, toY, toW+150, toH);
    //调至门店类型
    CGSize toTypeSize = [customerModel.tdtype boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size ;
    CGFloat toTypeX = CGRectGetMaxX(self.iconUrlFrame)+marginX;
    CGFloat toTypeY = CGRectGetMaxY(self.toFrame) + margin;
    CGFloat toTypeW = toTypeSize.width;
    CGFloat toTypeH = toTypeSize.height;
    _toTypeFrame = CGRectMake(toTypeX, toTypeY, toTypeW+150, toTypeH);
    //顾客状态
    CGFloat statusW = 26 * 3;
    CGFloat statusH = 50 ;
    _statusFrame = CGRectMake(SCREEN_WIDTH-statusW-margin, 0, statusW, statusH );
    //完善资料
    _btnFrame = CGRectMake(CGRectGetMaxX(_statusFrame) - 70, CGRectGetMaxY(_statusFrame)+margin, 62, 27);
    //行高
    if (customerModel.tdtype) {
        _rowHeight = CGRectGetMaxY(_toTypeFrame) + 15;
    }else{
        _rowHeight = CGRectGetMaxY(_waiterFrame) + 15;
    }
    
}
@end
