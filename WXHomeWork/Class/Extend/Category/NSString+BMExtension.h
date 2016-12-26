//
//  NSString+Category.h
//  WilliamFramework
//
//  Created by Well on 15/7/13.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BMExtension)

#pragma mark - 过滤html特殊字符
/**
 *  过滤html特殊字符
 *
 *  @return 过滤后的string
 */
- (NSString *)ignoreHTMLSpecialString;

#pragma mark - MD5加密
/**
 *  MD5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5String;

#pragma mark - 判断是否为空
/**
 *  判断是否为空
 *
 *  @return YES：空  NO：非空
 */
- (BOOL)isBlankString;

#pragma mark - 字符串是否为手机号
/**
 *  字符串是否为手机号
 *
 *  @return YES：是  NO：不是
 */
- (BOOL)isPhoneNumber;

#pragma mark - 字符串去掉特殊符号
/**
 *  去掉某些元素  - ，（ ， ）
 *
 */
+(NSString *) stringDeleteString:(NSString *)str;

#pragma mark - 判断是否为金额
/**
 *  判断是否为金额
 */
-(BOOL)isValidateAmountOfMoney;

#pragma mark - 字符串是否为邮箱
/**
 *  字符串是否为邮箱
 *
 *  @return YES：是  NO：不是
 */
- (BOOL)isAvailableEmail;

#pragma mark - 用户名是否合法
/**
 *  用户名是否合法，验证规则：
 *  只含有汉字、数字、字母、下划线不能以下划线开头和结尾
 *
 *  @return YES：合法 NO：不合法
 */
- (BOOL)isValidUsername;

#pragma mark - 判断是否为纯数字
/**
 *   判断是否为数字
 */
- (BOOL)isValidateNumber;

#pragma mark - 判断是否为正数
/**
 *   判断是否为正数
 */
- (BOOL)isValidatePositiveNumber;

#pragma mark - 判断是否为正数
/**
 *   判断密码
 */
- (BOOL)isValidatePassword;

#pragma mark - 验证身份证是否合法
/**
 *   验证身份证是否合法
 */
- (BOOL)isValidate18PaperId;

#pragma mark - 验证固定电话
/**
 *   验证固定电话
 */
- (BOOL)isValidateFixedLine;

#pragma mark - 验证中英文字符
/**
 *   验证中英文字符
 */
- (BOOL)isValidatechineseAndEngSet;

#pragma mark - 验证是否是中文
/**
 *  验证是否是中文
 */
-(BOOL)isValidaeChinese;
#pragma mark - 时间和字符串相互转化
/**
 *  日期转化为字符串
 *
 *  @param date 日期
 *
 *  @return 日期字符串 e.g. @"2015-07-13"
 */
+ (NSString *)dateStringFromDate:(NSDate *)date ;

#pragma mark - 日期转化为时间
/**
 *  日期转化为时间
 *
 *  @param date 日期
 *
 *  @return 时间字符串 e.g. @"23:14"
 */
+ (NSString *)timeStringFromDate:(NSDate *)date;

#pragma mark - 日期转化为年月日＋时间
/**
 *  日期转化为年月日＋时间
 *
 *  @param date 日期
 *
 *  @return 年月日时间 e.g. @"2015-07-17 23:14"
 */
+ (NSString *)dateTimeStringFromDate:(NSDate *)date;

#pragma mark - string 转 年月日
/**
 *  string 转 年月日
 */
- (NSDate *)dateFromString;

#pragma mark -  string 转 time
/**
 *  string 转 time
 */
- (NSDate *)timeFromString;

#pragma mark -  string 转 年月日时分
/**
 *  string 转 年月日时分
 */
- (NSDate *)dateTimeFromString;

#pragma mark - 使用UTF－8格式编码URL
/**
 *  使用UTF－8格式编码URL
 *
 *  @return 编码后的URL字符串
 */
- (NSString *)urlUseUTF8Encoding;

#pragma mark - 将UTF－8格式的URL字符串解码
/**
 *  将UTF－8格式的URL字符串解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)urlUseUTF8Decoding;

#pragma mark - HTML转换为NSAttributedString给UIlable使用
/**
 HTML转换为NSAttributedString给UIlable使用
 **/
- (NSAttributedString *)stringHTMLToNSAttributedString;

#pragma mark - 获取字符串高度
/**
 * 获取字符串高度
 */
- (float)getStringHeightWithFont:(UIFont *)uFont andWidth:(float)width;

#pragma mark - 计算文字宽度
/**
 * 计算文字宽度
 */
- (float)getStringWidthFont:(UIFont *)uFont andWidth:(float)heigth;

#pragma mark - 字符串转字典
/**
 *  字符串转字典
 */
- (NSDictionary *)stringToNsDictionary;
@end
