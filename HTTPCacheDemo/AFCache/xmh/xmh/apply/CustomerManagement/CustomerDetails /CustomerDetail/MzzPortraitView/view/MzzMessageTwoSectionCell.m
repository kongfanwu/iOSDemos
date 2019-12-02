//
//  MzzMessageTwoSectionCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/11/21.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzMessageTwoSectionCell.h"
#import "MzzMessageOneCell.h"
#import "MzzMessageTwoCell.h"

@interface MzzMessageTwoSectionCell()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)NSArray *cellArray;
@property (nonatomic ,strong)UITableView *cellTb;
@property (nonatomic ,assign) NSInteger current;//选中第几个标题对应的tableview
@property (nonatomic ,assign) NSInteger titleCount;
@property (nonatomic ,assign) NSInteger heightTb;
@property(nonatomic,strong)MzzPortraitModel *model;
@end
@implementation MzzMessageTwoSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(NSArray *)cellArray
{
    if (!_cellArray) {
        _cellArray = [NSArray array];
    }
    return _cellArray;
}

//切换标题展示内容底部scrollerview
-(UITableView *)cellTb
{
    if (!_cellTb) {
        _cellTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.heightTb) style:UITableViewStylePlain];
        _cellTb.delegate = self;
        _cellTb.dataSource = self;
        _cellTb.scrollEnabled=NO;
    }
    return _cellTb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)cellWithModel:(MzzPortraitModel *)user_PortraitModel andWithBtnSelect:(NSInteger)btnSelect andWithViewHeight:(NSInteger)viewHeight
{
    self.current = btnSelect;
    self.heightTb = viewHeight;
    self.model = user_PortraitModel;
    if (user_PortraitModel.list.count > 0) {
        self.cellArray =user_PortraitModel.list[self.current].content_list;
    }
    self.titleCount =user_PortraitModel.list.count;
    [self addSubview:self.cellTb];
    [self.cellTb reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MzzPortraitListModel *model = self.cellArray[indexPath.row];
    if (model.is_select == 1) {
        return  68;
    }else{
        return  48;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MzzPortraitListModel *model = self.cellArray[indexPath.row];
        if (model.is_select == 1) {
            static NSString *Cellindentifier = @"MzzMessageTwoCell";
            MzzMessageTwoCell *cell;
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MzzMessageTwoCell" owner:nil options:nil] firstObject];
            }else{
                cell  = [tableView dequeueReusableCellWithIdentifier:Cellindentifier];
            }
            [cell setModel:model];
            return cell;
        }else{
            static NSString *Cellindentifier = @"MzzMessageOneCell";
            MzzMessageOneCell *cell;
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MzzMessageOneCell" owner:nil options:nil] firstObject];
            }else{
                cell  = [tableView dequeueReusableCellWithIdentifier:Cellindentifier];
            }
            [cell setModel:model];
            return cell;
        }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MzzPortraitListModel *model = self.cellArray[indexPath.row];
    if (_toIndicatorsVC) {
        _toIndicatorsVC(model.index_name,[NSString stringWithFormat:@"%@%@%@%@%@%@",@"参考值：",model.reference_value_min,@"%",@"~",model.reference_value_max,@"%"],model.suggest,model.index_id);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
