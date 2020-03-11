//
//  FTForm.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTForm.h"
#import "FTFormSection.h"

@implementation FTForm

#pragma mark - Lazy

- (NSMutableArray<FTFormSection *> *)formSections {
    if (_formSections) return _formSections;
    _formSections = NSMutableArray.new;
    return _formSections;
}

#pragma mark - Public

/**
 添加section
 */
- (void)addSection:(FTFormSection *)formSection {
    formSection.form = self;
    [self.formSections addObject:formSection];
}

@end
