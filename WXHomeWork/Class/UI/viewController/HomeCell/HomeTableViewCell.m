//
//  HomeTableViewCell.m
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.TitleLab.textColor = [UIColor blueColor];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
