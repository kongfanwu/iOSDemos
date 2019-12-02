//
//  MzzCustomerInfoCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzCustomerInfoCell.h"
#import "MzzDengjiModel.h"



@implementation MzzCustomerInfoCell
{
    UIImageView *_imageview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)ismust:(BOOL)ismust{
      _imageview.hidden = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImage *image = [UIImage imageNamed:@"mzxiaoxingxing"];
        _imageview = [[UIImageView alloc] initWithImage:image];
        _imageview.frame  = CGRectMake(15, 20, 5, 5);
        [_imageview sizeToFit];
        _imageview.hidden = YES;
        [self.contentView addSubview:_imageview];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [ColorTools colorWithHexString:@"#333333"];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLbl];
        
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.borderStyle =UITextBorderStyleNone;
        _textField.returnKeyType = UIReturnKeyDone;
//        _textField.textColor = [ColorTools colorWithHexString:@"#cccccc"];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_textField];
    }
    return self;
}

- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel{
    _titleLbl.text = [[data objectForKey:@"title"] stringByAppendingString: @":"];
    _textField.placeholder =[data objectForKey:@"detitle"];
    switch (indexpath.section ) {
        case 0:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.name) {
                         _textField.text = InfoModel.name;
                    }
                   
                }
                    break;
                case 1:
                {
                    if (InfoModel.mobile) {
                         _textField.text = InfoModel.mobile;
                    }
                   
                }
                    break;
                case 2:
                {
                    if (InfoModel.wx) {
                         _textField.text = InfoModel.wx;
                    }
                   
                }
                    break;
                case 3:
                {
                    if (InfoModel.birthday) {
                        _textField.text =InfoModel.birthday;
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.imp ==1) {
                        _textField.text = @"已有卡项顾客";
                    }else if (InfoModel.imp == 0){
                        _textField.text = @"新顾客";
                    }
                }
                    break;
                case 1:
                {
                    if (InfoModel.grade_name) {
                         _textField.text = InfoModel.grade_name;
                    }
//                    switch (InfoModel.grade) {
//                        case -1:
//
//                            break;
//                        case 0:
//                            _textField.text =@"粉丝";
//                            break;
//                        case 1:
//                            _textField.text =@"新人";
//                            break;
//                        case 2:
//                            _textField.text =@"达人";
//                            break;
//                        case 3:
//                            _textField.text =@"一星会员";
//                            break;
//                        case 4:
//                            _textField.text =@"二星会员";
//                            break;
//                        case 5:
//                            _textField.text =@"标准会员";
//                            break;
//                        case 6:
//                            _textField.text =@"准a客";
//                            break;
//                        case 7:
//                            _textField.text =@"a客";
//                            break;
//                        case 8:
//                            _textField.text =@"2a客";
//                            break;
//                        case 9:
//                            _textField.text =@"3a客";
//                            break;
//                        case 10:
//                            _textField.text =@"4a客";
//                            break;
//                        case 11:
//                            _textField.text =@"大a客";
//                            break;
//                        default:
//                            break;
//                    }
                   
                }
                    break;
                case 2:
                {
                    if (InfoModel.store_name) {
                         _textField.text = InfoModel.store_name;
                    }
                   
                }
                    break;
                case 3:
                {
                    if (InfoModel.jis) {
                          _textField.text = InfoModel.jis;
                    }
                  
                }
                    break;
                case 4:
                {
                    if (InfoModel.dao) {
                        _textField.text = InfoModel.dao;
                    }
                
                }
                    break;
                case 5:
                {
                    if (InfoModel.jd_time) {
                        _textField.text =InfoModel.jd_time ;
                    }
                }
                    break;
                case 6:
                {
                    if (InfoModel.last_fw_time) {
                     
                        _textField.text =InfoModel.last_fw_time;
                    }
                   
                }
                    break;
                case 7:
                {
                    if (InfoModel.last_shop_time) {
    
                        _textField.text =InfoModel.last_shop_time;
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.area_name) {
                         _textField.text = InfoModel.area_name;
                    }
                   
                }
                    break;
                case 1:
                {
                    if (InfoModel.address) {
                         _textField.text = InfoModel.address;
                    }
                   
                }
                    break;
                case 2:
                {
                    if (InfoModel.company) {
                          _textField.text = InfoModel.company;
                    }
                  
                }
                    break;
                case 3:
                {
                    if (InfoModel.post) {
                         _textField.text = InfoModel.post;
                    }
                   
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
   
    //frame
    CGSize titleSize = [_titleLbl.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _titleLbl.frame = CGRectMake(26, (self.contentView.height -titleSize.height) * .5 , 100, titleSize.height);

    _textField.frame = CGRectMake(SCREEN_WIDTH - 145 - 15, (self.contentView.height -30) * .5 , 145, 30);

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.returnclick) {
        self.returnclick(textField);
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.returnclick) {
        self.returnclick(textField);
    }
}
@end

@implementation MzzCustomerInfoPickerCell
{
    UIImageView *_imageview;
    NSArray * _dataList;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)ismust:(BOOL)ismust{
    _imageview.hidden = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _dataList = nil;
        UIImage *image = [UIImage imageNamed:@"mzxiaoxingxing"];
        _imageview = [[UIImageView alloc] initWithImage:image];
        _imageview.frame  = CGRectMake(15, 20, 5, 5);
        [_imageview sizeToFit];
        _imageview.hidden = YES;
        [self.contentView addSubview:_imageview];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [ColorTools colorWithHexString:@"#333333"];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLbl];
        
        _textField = [[MzzPickerTextField alloc] init];
        _textField.borderStyle =UITextBorderStyleNone;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.delegate = self;
        [self.contentView addSubview:_textField];
        WeakSelf;
        [_textField setDoneclick:^(UITextField *textField) {
            if (weakSelf.doneclick) {
                weakSelf.doneclick(textField);
            }
        }];
        [_textField setCencelclick:^(UITextField *textField) {
            if (weakSelf.cencelclick) {
                weakSelf.cencelclick(textField);
            }
        }];
    }
    return self;
}

- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel{
    _titleLbl.text = [[data objectForKey:@"title"] stringByAppendingString: @":"];
    _textField.placeholder =[data objectForKey:@"detitle"];
    switch (indexpath.section ) {
        case 0:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.name) {
                        _textField.text = InfoModel.name;
                    }
                    
                }
                    break;
                case 1:
                {
                    if (InfoModel.mobile) {
                        _textField.text = InfoModel.mobile;
                    }
                    
                }
                    break;
                case 2:
                {
                    if (InfoModel.wx) {
                        _textField.text = InfoModel.wx;
                    }
                    
                }
                    break;
                case 3:
                {
                    if (InfoModel.birthday) {
                        _textField.text = InfoModel.birthday;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel) {
                        if (InfoModel.imp == 1) {
                            _textField.text = @"已有卡项顾客";
                        }else if (InfoModel.imp == 0){
                            _textField.text = @"新顾客";
                        }
                    }
                }
                    break;
                case 1:
                {
                    if (InfoModel.grade_name) {
                        _textField.text = InfoModel.grade_name;
                    }
                }
                    break;
                case 2:
                {
                    if (InfoModel.store_name) {
                        _textField.text = InfoModel.store_name;
                    }
                    
                }
                    break;
                case 3:
                {
                    if (InfoModel.jis_name) {
                        _textField.text = InfoModel.jis_name;
                    }else{
                        _textField.placeholder = @"请选择归属技师";
                    }
                    
                }
                    break;
                case 4:
                {
                    if (InfoModel.dao_name) {
                        _textField.text = InfoModel.dao_name;
                    }else{
                        _textField.placeholder = @"请选择归属导购";
                    }
                    
                }
                    break;
                case 5:
                {
                    if (InfoModel.jd_time) {
                       
                        _textField.text =InfoModel.jd_time ;
                    }
                }
                    break;
                case 6:
                {
                    if (InfoModel.last_fw_time) {
                        
                        _textField.text =InfoModel.last_fw_time;
                    }
                    
                }
                    break;
                case 7:
                {
                    if (InfoModel.last_shop_time) {
                        _textField.text =InfoModel.last_shop_time;
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.area_name) {
                        _textField.text = InfoModel.area_name;
                    }
                    
                }
                    break;
                case 1:
                {
                    if (InfoModel.address) {
                        _textField.text = InfoModel.address;
                    }
                    
                }
                    break;
                case 2:
                {
                    if (InfoModel.company) {
                        _textField.text = InfoModel.company;
                    }
                    
                }
                    break;
                case 3:
                {
                    if (InfoModel.post) {
                        _textField.text = InfoModel.post;
                    }
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
        }
    }
    //frame
    CGSize titleSize = [_titleLbl.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _titleLbl.frame = CGRectMake(26, (self.contentView.height -titleSize.height) * .5 , 100, titleSize.height);
    
    _textField.frame = CGRectMake(SCREEN_WIDTH - 145 - 15 - 15, (self.contentView.height -30) * .5 , 145, 30);
}

- (void)setupPickerdata:(NSArray *)dataList {
    _dataList = dataList;
    [_textField setupData:_dataList];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_isStore && !_isConfirm && _haveBillInfo) {
        [textField resignFirstResponder];
        [[[MzzHud alloc] initWithTitle:@"提示" message:@"更改门店将清空顾客账单资料，请确认" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
            if (index == 0) {
                
            }else{
                _isConfirm = YES;
                [textField becomeFirstResponder];
                [[NSNotificationCenter defaultCenter]postNotificationName:MzzInsertCustomerVC_StoreCode object:nil];
            }
        }]show];
    }
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (_isStore) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"jishi" object:nil];
//    }
//}
@end


@implementation MzzCustomerInfoDatePickerCell
{
    UIImageView *_imageview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)ismust:(BOOL)ismust{
    _imageview.hidden = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImage *image = [UIImage imageNamed:@"mzxiaoxingxing"];
        _imageview = [[UIImageView alloc] initWithImage:image];
        _imageview.frame  = CGRectMake(15, 20, 5, 5);
        [_imageview sizeToFit];
        _imageview.hidden = YES;
        [self.contentView addSubview:_imageview];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [ColorTools colorWithHexString:@"#333333"];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLbl];
        
        _textField = [[MzzDatePickerTextField alloc] init];
        _textField.borderStyle =UITextBorderStyleNone;
//        _textField.textColor = [ColorTools colorWithHexString:@"#cccccc"];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_textField];
        WeakSelf;
        [_textField setDoneclick:^(UITextField *textField) {
            if (weakSelf.doneclick) {
                weakSelf.doneclick(textField);
            }
        }];
        [_textField setCencelclick:^(UITextField *textField) {
            if (weakSelf.cencelclick) {
                weakSelf.cencelclick(textField);
            }
        }];
    }
    return self;
}

- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel{
    _titleLbl.text = [[data objectForKey:@"title"] stringByAppendingString: @":"];
    _textField.placeholder =[data objectForKey:@"detitle"];
    switch (indexpath.section ) {
        case 0:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.name) {
                        _textField.text = InfoModel.name;
                    }
                    
                }
                    break;
                case 1:
                {
                    if (InfoModel.mobile) {
                        _textField.text = InfoModel.mobile;
                    }
                    
                }
                    break;
                case 2:
                {
                    if (InfoModel.wx) {
                        _textField.text = InfoModel.wx;
                    }
                    
                }
                    break;
                case 3:
                {
                    if (InfoModel.birthday) {
                        _textField.text =InfoModel.birthday ;
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.imp ==1) {
                        _textField.text = @"已有卡项顾客";
                    }else  if (InfoModel.imp == 0){
                        _textField.text = @"新顾客";
                    }
                }
                    break;
                case 1:
                {
                    if (InfoModel.grade_name) {
                        _textField.text = InfoModel.grade_name;
                    }
//                    switch (InfoModel.grade) {
//                        case -1:
//
//                            break;
//                        case 0:
//                            _textField.text =@"粉丝";
//                            break;
//                        case 1:
//                            _textField.text =@"新人";
//                            break;
//                        case 2:
//                            _textField.text =@"达人";
//                            break;
//                        case 3:
//                            _textField.text =@"一星会员";
//                            break;
//                        case 4:
//                            _textField.text =@"二星会员";
//                            break;
//                        case 5:
//                            _textField.text =@"标准会员";
//                            break;
//                        case 6:
//                            _textField.text =@"准a客";
//                            break;
//                        case 7:
//                            _textField.text =@"a客";
//                            break;
//                        case 8:
//                            _textField.text =@"2a客";
//                            break;
//                        case 9:
//                            _textField.text =@"3a客";
//                            break;
//                        case 10:
//                            _textField.text =@"4a客";
//                            break;
//                        case 11:
//                            _textField.text =@"大a客";
//                            break;
//                        default:
//                            break;
//                    }
                    
                }
                    break;
                case 2:
                {
                    if (InfoModel.store_name) {
                        _textField.text = InfoModel.store_name;
                    }
                    
                }
                    break;
                case 3:
                {
                    if (InfoModel.jis) {
                        _textField.text = InfoModel.jis;
                    }
                    
                }
                    break;
                case 4:
                {
                    if (InfoModel.dao) {
                        _textField.text = InfoModel.dao;
                    }
                    
                }
                    break;
                case 5:
                {
                    if (InfoModel.jd_time.length > 9) {
                        
                        _textField.text =[InfoModel.jd_time substringToIndex:10] ;
                    }
                }
                    break;
                case 6:
                {
                    if (InfoModel.last_fw_time.length > 9) {
                       
                        _textField.text =[InfoModel.last_fw_time substringToIndex:10];
                    }
                    
                }
                    break;
                case 7:
                {
                    if (InfoModel.last_shop_time.length > 9) {
                     
                        _textField.text =[InfoModel.last_shop_time substringToIndex:10];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.area_name) {
                        _textField.text = InfoModel.area_name;
                    }
                    
                }
                    break;
                case 1:
                {
                    if (InfoModel.address) {
                        _textField.text = InfoModel.address;
                    }
                    
                }
                    break;
                case 2:
                {
                    if (InfoModel.company) {
                        _textField.text = InfoModel.company;
                    }
                    
                }
                    break;
                case 3:
                {
                    if (InfoModel.post) {
                        _textField.text = InfoModel.post;
                    }
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    //frame
    CGSize titleSize = [_titleLbl.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _titleLbl.frame = CGRectMake(26, (self.contentView.height -titleSize.height) * .5 , 100, titleSize.height);
    
    _textField.frame = CGRectMake(SCREEN_WIDTH - 145 - 15 -15, (self.contentView.height -30) * .5 , 145, 30);
    
}
@end


@implementation MzzCustomeAddressPickerCell
{
    UIImageView *_imageview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)ismust:(BOOL)ismust{
    _imageview.hidden = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UIImage *image = [UIImage imageNamed:@"mzxiaoxingxing"];
        _imageview = [[UIImageView alloc] initWithImage:image];
        _imageview.frame  = CGRectMake(15, 20, 5, 5);
        [_imageview sizeToFit];
        _imageview.hidden = YES;
        [self.contentView addSubview:_imageview];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [ColorTools colorWithHexString:@"#333333"];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLbl];
        
        _textField = [[MzzAddressTextField alloc] init];
        _textField.borderStyle =UITextBorderStyleNone;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_textField];
        WeakSelf;
        [_textField setDoneclick:^(UITextField *textField) {
            if (weakSelf.doneclick) {
                weakSelf.doneclick(textField);
            }
        }];
        [_textField setCencelclick:^(UITextField *textField) {
            if (weakSelf.cencelclick) {
                weakSelf.cencelclick(textField);
            }
        }];
    }
    return self;
}

- (void)setupData:(NSDictionary *)data andIndexPath:(NSIndexPath *)indexpath andInfoModel:(InfoModel *)InfoModel{
    _titleLbl.text = [[data objectForKey:@"title"] stringByAppendingString: @":"];
    _textField.placeholder =[data objectForKey:@"detitle"];
    switch (indexpath.section ) {
        case 0:
        {
            switch (indexpath.row) {
                case 0:
                {
                    if (InfoModel.name) {
                        _textField.text = InfoModel.name;
                    }
                    
                }
                    break;
                case 1:
                {
                    if (InfoModel.mobile) {
                        _textField.text = InfoModel.mobile;
                    }
                    
                }
                    break;
                case 2:
                {
                    if (InfoModel.wx) {
                        _textField.text = InfoModel.wx;
                    }
                    
                }
                    break;
                case 3:
                {
                    if (InfoModel.birthday) {
                        _textField.text = InfoModel.birthday;
                    }
                    break;
                default:
                    break;
                }
            }
            break;
        case 1:
            {
                switch (indexpath.row) {
                    case 0:
                    {
                        if (InfoModel) {
                            if (InfoModel.imp == 1) {
                                _textField.text = @"已有卡项顾客";
                            }else if (InfoModel.imp == 0){
                                _textField.text = @"新顾客";
                            }
                        }
                    }
                        break;
                    case 1:
                    {
                        if (InfoModel.grade_name) {
                            _textField.text = InfoModel.grade_name;
                        }
                    }
                        break;
                    case 2:
                    {
                        if (InfoModel.store_name) {
                            _textField.text = InfoModel.store_name;
                        }
                        
                    }
                        break;
                    case 3:
                    {
                        if (InfoModel.jis_name) {
                            _textField.text = InfoModel.jis_name;
                        }
                        
                    }
                        break;
                    case 4:
                    {
                        if (InfoModel.dao_name) {
                            _textField.text = InfoModel.dao_name;
                        }
                        
                    }
                        break;
                    case 5:
                    {
                        if (InfoModel.jd_time) {
                            
                            _textField.text =InfoModel.jd_time ;
                        }
                    }
                        break;
                    case 6:
                    {
                        if (InfoModel.last_fw_time) {
                            
                            _textField.text =InfoModel.last_fw_time;
                        }
                        
                    }
                        break;
                    case 7:
                    {
                        if (InfoModel.last_shop_time) {
                            _textField.text =InfoModel.last_shop_time;
                        }
                    }
                        break;
                    default:
                        break;
                }
            }
            break;
        case 2:
            {
                switch (indexpath.row) {
                    case 0:
                    {
                        if (InfoModel.area_name) {
                            _textField.text = InfoModel.area_name;
                        }
                        
                    }
                        break;
                    case 1:
                    {
                        if (InfoModel.address) {
                            _textField.text = InfoModel.address;
                        }
                        
                    }
                        break;
                    case 2:
                    {
                        if (InfoModel.company) {
                            _textField.text = InfoModel.company;
                        }
                        
                    }
                        break;
                    case 3:
                    {
                        if (InfoModel.post) {
                            _textField.text = InfoModel.post;
                        }
                        
                    }
                        break;
                    default:
                        break;
                }
            }
            break;
        default:
            break;
        }
    }
    //frame
    CGSize titleSize = [_titleLbl.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _titleLbl.frame = CGRectMake(26, (self.contentView.height -titleSize.height) * .5 , 100, titleSize.height);
    
    _textField.frame = CGRectMake(SCREEN_WIDTH - 145 - 15 - 15, (self.contentView.height -30) * .5 , 145, 30);
}

@end
