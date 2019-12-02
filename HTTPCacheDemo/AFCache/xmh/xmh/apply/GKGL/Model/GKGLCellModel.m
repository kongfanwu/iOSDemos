//
//  GKGLCellModel.m
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCellModel.h"

@implementation GKGLCellModel
+ (instancetype)createModelTitle:(NSString *)title placeHolder:(NSString *)placeHolder cellType:(CellType)cellType
{
    return [GKGLCellModel createModelTitle:title placeHolder:placeHolder value:@"" cellType:cellType];
}
+ (instancetype)createModelTitle:(NSString *)title placeHolder:(NSString *)placeHolder value:(NSString *)value cellType:(CellType)cellType
{
    GKGLCellModel * model = [[GKGLCellModel alloc] init];
    model.title = title;
    model.placeHolder = placeHolder;
    model.cellType = cellType;
    model.value = value;
    return model;
}
@end
