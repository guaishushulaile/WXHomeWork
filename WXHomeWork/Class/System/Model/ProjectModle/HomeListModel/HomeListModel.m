//
//  HomeListModel.m
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import "HomeListModel.h"

@implementation HomeListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"homeDescription" : @"description",
             };
}


@end
