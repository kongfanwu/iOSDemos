//
//  XMHFormTextFieldCell.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormTextFieldCell : XMHFormBaseCell

/** <##> */
@property (nonatomic, strong) UITextField *textField;
/** <##> */
@property (nonatomic, strong) UILabel *valueTypeLabel;


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
