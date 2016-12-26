//
//  ListResponseBaseModle.h
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import "HTTPResponseBaseModle.h"
#import "HomeListModel.h"
@interface HomePageResponseModle : HTTPResponseBaseModle

@property (nonatomic, copy) NSString *homeTitle;
@property(nonatomic, copy) NSArray<HomeListModel *> *rows;

@end
