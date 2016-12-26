//
//  NSData+OWExtension.m
//  ProjectSample
//
//  Created by OceanWang on 15/12/10.
//  Copyright © 2015年 OceanWang. All rights reserved.
//

#import "NSData+OWExtension.h"
#import <CommonCrypto/CommonCryptor.h>
@implementation NSData (OWExtension)

#pragma mark - nsdata转换NSDictionary
/**
 nsdata转换NSDictionary
 **/
-(NSDictionary *)NSDataToNSDictionary
{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
}

@end
