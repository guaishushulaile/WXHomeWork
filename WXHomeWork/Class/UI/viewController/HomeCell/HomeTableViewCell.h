//
//  HomeTableViewCell.h
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UIImageView *matchImage;// 文字配图

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTrailConstrant;// content右边距

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstrant;// content高度（<=）


@end
