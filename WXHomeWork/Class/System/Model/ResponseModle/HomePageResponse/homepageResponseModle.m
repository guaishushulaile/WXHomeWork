//
//  HomePageResponseModle.m
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import "HomePageResponseModle.h"

@implementation HomePageResponseModle

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"homeTitle" : @"title",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"rows" : @"HomeListModel",
             };
}

@end
