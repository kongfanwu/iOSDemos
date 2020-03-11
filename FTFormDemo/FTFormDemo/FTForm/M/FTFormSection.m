//
//  FTFormSection.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormSection.h"
#import "FTFormRow.h"
#import "FTForm.h"

@implementation FTFormSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray<FTFormRow *> *)formRowsHidden {
    NSMutableArray<FTFormRow *> *rowArray = NSMutableArray.new;
    for (FTFormRow *row in self.formRows) {
        if (!row.isHiden) {
            [rowArray addObject:row];
        }
    }
    return rowArray;
}

#pragma mark - Lazy

- (NSMutableArray<FTFormRow *> *)formRows {
    if (_formRows) return _formRows;
    _formRows = NSMutableArray.new;
    return _formRows;
}

#pragma mark - Public

/**
 添加row
 */
- (void)addRow:(FTFormRow *)row {
    row.formSection = self;
    [self.formRows addObject:row];
}

@end
