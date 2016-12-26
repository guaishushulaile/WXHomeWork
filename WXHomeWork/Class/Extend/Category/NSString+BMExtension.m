//
//  NSString+Category.m
//  WilliamFramework
//
//  Created by Well on 15/7/13.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import "NSString+BMExtension.h"

// MD5加密
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BMExtension)

#pragma mark - 过滤html特殊字符
/**
 *  过滤html特殊字符
 *
 *  @return 过滤后的string
 */
- (NSString *)ignoreHTMLSpecialString {
    NSString *returnStr = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    // 如果还有别的特殊字符，请添加在这里
    /*
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ge;" withString:@"—"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"®"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
     */
    return returnStr;
}

#pragma mark - MD5加密

/**
 *  MD5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ].uppercaseString;
}

#pragma mark - 判断是否为空
/**
 *  判断是否为空
 *
 *  @return YES：空  NO：非空
 */
- (BOOL)isBlankString {
    
    if (self == nil || self == NULL) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self containsString:@"null"]) {
        return YES;
    }
    
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length == 0) {
        return YES;
    }
    
    if ([self isEqualToString:@"(null)"] || [self isEqualToString:@"null"] || [self isEqualToString:@"<null>"]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - 字符串是否为手机号
/**
 *  字符串是否为手机号
 *
 *  @return YES：是  NO：不是
 */
- (BOOL)isPhoneNumber {
    //
//    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378]|7[7])\\d)\\d{7}$";          // 包含电信4G 177号段
//    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    //
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    BOOL res1 = [regextestmobile evaluateWithObject:self];
//    BOOL res2 = [regextestcm evaluateWithObject:self];
//    BOOL res3 = [regextestcu evaluateWithObject:self];
//    BOOL res4 = [regextestct evaluateWithObject:self];
//    
//    if (res1 || res2 || res3 || res4) {
//        return YES;
//    }
//    return NO;
    NSString *MOBILE = @"^1[3,4,5,7,8]\\d{9}$";//@"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSString *str_tel = [NSString stringDeleteString:self];
    return [regextestmobile evaluateWithObject:self];
}

#pragma mark - 字符串去掉特殊符号
/**
 *  去掉某些元素  - ，（ ， ）
 *
 */
+(NSString *) stringDeleteString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == '-' || c == '(' || c == ')') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    NSString *newstr1 = [newstr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newstr1;
}

#pragma mark - 字符串是否为邮箱
/**
 *  字符串是否为邮箱
 *
 *  @return YES：是  NO：不是
 */
- (BOOL)isAvailableEmail {
    NSString *emailRegEx =
    @"^([a-zA-Z0-9]+[_|\\-|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\-|\\.]?)*[a-zA-Z0-9]+(\\.[a-zA-Z]{2,3})+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //先把NSString转换为小写
    NSString *lowerString = self.lowercaseString;
    
    return [regExPredicate evaluateWithObject:lowerString];
}

#pragma mark - 用户名是否合法
/**
 *  用户名是否合法，验证规则：
 *  只含有汉字、数字、字母、下划线不能以下划线开头和结尾
 *
 *  @return YES：合法 NO：不合法
 */
- (BOOL)isValidUsername {
    NSString *userNameRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}


#pragma mark - 判断是否为纯数字
/**
 *   判断是否为数字
 */
- (BOOL)isValidateNumber {
    NSString *numberRegex = @"[0-9]+";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [passwordPredicate evaluateWithObject:self];
}

#pragma mark - 判断是否为正数
/**
 *   判断是否为正数
 */
- (BOOL)isValidatePositiveNumber {
    NSString *numberRegex = @"^\\+?[1-9][0-9]*$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [passwordPredicate evaluateWithObject:self];
}

#pragma mark - 时间和字符串相互转化
/**
 *  日期转化为字符串
 *
 *  @param date 日期
 *
 *  @return 日期字符串 e.g. @"2015-07-13"
 */
+ (NSString *)dateStringFromDate:(NSDate *)date  {
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        return [formatter stringFromDate:date];
    }
}
#pragma mark - 日期转化为时间
/**
 *  日期转化为时间
 *
 *  @param date 日期
 *
 *  @return 时间字符串 e.g. @"23:14"
 */
+ (NSString *)timeStringFromDate:(NSDate *)date {
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"hh:mm";
        return [formatter stringFromDate:date];
    }
}

#pragma mark - 日期转化为年月日＋时间
/**
 *  日期转化为年月日＋时间
 *
 *  @param date 日期
 *
 *  @return 年月日时间 e.g. @"2015-07-17 23:14"
 */
+ (NSString *)dateTimeStringFromDate:(NSDate *)date {
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd hh:mm";
        return [formatter stringFromDate:date];
    }
}

#pragma mark - string 转 date
/**
 *  string 转 年月日
 */
- (NSDate *)dateFromString {
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        return [formatter dateFromString:self];
    }
}

#pragma mark -  string 转 time
/**
 *  string 转 time
 */
- (NSDate *)timeFromString {
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"hh:mm";
        return [formatter dateFromString:self];
    }
}

#pragma mark -  string 转 年月日时分
/**
 *  string 转 年月日时分
 */
- (NSDate *)dateTimeFromString {
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd HH:mm";
        formatter.locale = [NSLocale systemLocale];
        return [formatter dateFromString:self];
    }
}

#pragma mark - 使用UTF－8格式编码URL
/**
 *  使用UTF－8格式编码URL
 *
 *  @return 编码后的URL字符串
 */
- (NSString *)urlUseUTF8Encoding {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 将UTF－8格式的URL字符串解码
/**
 *  将UTF－8格式的URL字符串解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)urlUseUTF8Decoding {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - HTML转换为NSAttributedString给UIlable使用
/**
 HTML转换为NSAttributedString给UIlable使用
 **/
- (NSAttributedString *)stringHTMLToNSAttributedString {
    return [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}

#pragma mark - 获取字符串高度
/**
 * 获取字符串高度
 */
- (float)getStringHeightWithFont:(UIFont *)uFont andWidth:(float)width {
    NSDictionary *attribute = @{NSFontAttributeName:uFont};
    
    CGSize reSize = [self boundingRectWithSize:CGSizeMake(width, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                     NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    return reSize.height + 1;
}

#pragma mark - 计算文字宽度
/**
 * 计算文字宽度
 */
- (float)getStringWidthFont:(UIFont *)uFont andWidth:(float)heigth {
    NSDictionary *attribute = @{NSFontAttributeName:uFont};
    
    CGSize reSize = [self boundingRectWithSize:CGSizeMake(0, heigth)
                                       options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                     NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    return reSize.width + 1;
}

#pragma mark - 验证固定电话
/**
 *   验证固定电话
 */
- (BOOL)isValidateFixedLine {
    NSString *fixedLineRegex = @"(^0\\d{2}-?\\d{8}$)|(^0\\d{3}-?\\d{7,8}$)|(^\\(0\\d{2}\\)-?\\d{8}$)|(^\\(0\\d{3}\\)-?\\d{7,8}$)";//@"^(0[0-9]{2,3})-([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$";
    NSPredicate *predicateMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", fixedLineRegex];
//    NSString *str_tel = [NSString stringDeleteString:self];
    return [predicateMobile evaluateWithObject:self];
}

#pragma mark - 判断是否为正数
/**
 *   判断密码
 */
- (BOOL)isValidatePassword {
    NSString *passwordRegex = @"[A-Z0-9a-z]{6,20}";
    NSPredicate *predicatePassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [predicatePassword evaluateWithObject:self];
}

#pragma mark - 其他
/**
 *  判断是否在地区码内
 *
 *  @param code 地区码
 *
 *  @return 是否在地区码内
 */
- (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    
    return YES;
}

#pragma mark - 获取指定范围的字符串
/**
 *  获取指定范围的字符串
 *
 *  @param str    目标字符串
 *  @param value1 字符串的开始下标
 *  @param value2 字符串的结束下标
 *
 *  @return 截取后的字符串
 */
- (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger)value2;
{
    return [str substringWithRange:NSMakeRange(value1, value2)];
}

#pragma mark - 验证身份证是否合法
/**
 *   验证身份证是否合法
 */
- (BOOL)isValidate18PaperId {
    //判断位数
    if ([self length] != 15 && [self length] != 18) {
        return NO;
    }
    NSString *carid = self;
    
    long lSumQT = 0;
    
    //加权因子
    int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    unsigned char sChecker[11] = {'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i <= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
    }
    
    //判断地区码
    NSString *sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince]) {
        
        return NO;
        
    }
    
    //判断年月日是否有效
    
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01", strYear, strMonth, strDay]];
    
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId = [carid UTF8String];
    
    //检验长度
    if (18 != strlen(PaperId)) return -1;
    
    //校验数字
    for (int i = 0; i < 18; i++) {
        if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    //验证最末的校验码
    for (int i = 0; i <= 16; i++) {
        lSumQT += (PaperId[i] - 48) * R[i];
    }
    
    if (sChecker[lSumQT % 11] != PaperId[17]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - 验证中英文字符
/**
 *   验证中英文字符
 */
- (BOOL)isValidatechineseAndEngSet {
    NSString *const regularExpression = @"^[\u4e00-\u9fa5_a-zA-Z]+$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        NSLog(@"error %@", error);
    }
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, [self length])];
    return numberOfMatches > 0;
}

#pragma mark - 验证是否是中文
/**
 *  验证是否是中文
 */
-(BOOL)isValidaeChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark - 字符串转字典
/**
 *  字符串转字典
 */
- (NSDictionary *)stringToNsDictionary {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        return NSDictionary.new;
    }
    return dic;
}


/**
 *  获取指定范围的字符串
 *
 *  @param str    目标字符串
 *  @param value1 字符串的开始下标
 *  @param value2 字符串的结束下标
 *
 *  @return 截取后的字符串
 */
+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger)value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

#pragma mark - 判断是否为金额
/**
 *  判断是否为金额
 */
-(BOOL)isValidateAmountOfMoney
{
    NSString *numberRegex = @"^(([1-9]\\d*)|0)(\\.\\d{1,2})?$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [passwordPredicate evaluateWithObject:self];
}


@end
