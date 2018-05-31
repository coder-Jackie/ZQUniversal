//
//  NSString+SKString.m
//  WuWuTexiForDriver
//
//  Created by youngxiansen on 15/9/17.
//  Copyright (c) 2015年 AQiang. All rights reserved.
//

#ifdef DEBUG
#define SKTestStrLog(...) NSLog(__VA_ARGS__)
#else
#define SKTestStrLog(...)
#endif



#import "NSString+SKString.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (SKString)

/**
 *  计算文字的高度
 *  @param str   要显示的字符串
 *  @param width 屏幕上显示字符串的宽度
 *  @param font  定义字符串的字体 这个必须和Xib里字体保持一致
 */
+(CGFloat)sizeofString:(NSString*)str withMaxWidth:(CGFloat)width withFont:(UIFont*)font
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 999999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return size.height;
}

#pragma mark --日期相关--
/** 将日期转成字符串 */
+(NSString *)transfromDateToString:(NSDate *)date withformotStr:(NSString *)formotStr{
    //@"EEE MMM dd HH:mm:ss ZZZ yyyy"
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:formotStr];
    NSString * dateString = [format stringFromDate:date];
    return dateString;
}

/**
 *  将时间戳转成日期字符串
 *  @param timeStr   时间戳
 *  @param formotStr 日期字符串的格式
 */
+(NSString *)transfromTimeStrToString:(NSString *)timeStr formatStr:(NSString *)formatStr{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]/1000.0];
    //@"EEE MMM dd HH:mm:ss ZZZ yyyy"
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:formatStr];
    NSString * dateString = [format stringFromDate:date];
    return dateString;
}

/** 将日期转成时间戳 */
+(NSString*)transfromDateToTimeStr:(NSDate*)date
{
    NSString* timeStr;
    if (date) {
        timeStr = [NSString stringWithFormat:@"%.0lf",(date.timeIntervalSince1970)];
    }
    else{
        NSDate* currentDate = [NSDate date];
        timeStr = [NSString stringWithFormat:@"%.0lf",(currentDate.timeIntervalSince1970)];
    }
    if ([NSString isNilOrEmptyString:timeStr]) {
        SKTestStrLog(@"**************时间戳为空****************");
    }
    
    return timeStr;
}

/** 获取今天是星期几 */
+(NSString*)getCurrentWeekday
{
    NSDateComponents *componets;
    NSString* weekStr;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    }
    else{
        componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    }
    
    NSInteger weekday = componets.weekday;//a就是星期几，1代表星期日，2代表星期一，后面依次
    switch (weekday) {
        case 1: weekStr = NSLocalizedString(@"date.sunday", nil);break;
        case 2: weekStr = NSLocalizedString(@"date.monday", nil);break;
        case 3: weekStr = NSLocalizedString(@"date.tuesday", nil);break;
        case 4: weekStr = NSLocalizedString(@"date.wednesday", nil);break;
        case 5: weekStr = NSLocalizedString(@"date.thursday", nil);break;
        case 6: weekStr = NSLocalizedString(@"date.friday", nil);break;
        case 7: weekStr = NSLocalizedString(@"date.saturday", nil);break;
        default:    break;
    }
    return weekStr;
}


/** 以后存储调用这个方法--注意只存字符串--存储的时候不做判断 */
+(void)storeObject:(id)object forKey:(NSString*)keyName
{
    if ([object isKindOfClass:[NSNull class]]) {
        
         SKTestStrLog(@"**********存%@对应的valued是null**********",keyName);
    }

    if (!object) {
        SKTestStrLog(@"**********存%@对应的valued为nil**********",keyName);
    }
    if ([object isEqualToString:@""])
    {
        SKTestStrLog(@"**********存%@对应的valued是空字符串**********",keyName);
    }
    [[NSUserDefaults standardUserDefaults]setObject:object forKey:keyName];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

/** 以后获取值调用这个方法 */
+(NSString*)getObjectWithKey:(NSString*)keyName
{
    NSString* obj = [[NSUserDefaults standardUserDefaults]objectForKey:keyName];
    if (obj)
    {
        if ([obj isEqualToString:@""]) {
            SKTestStrLog(@"**********取出%@为空字符串**********",keyName);
        }
        return obj;
    }
    if (!obj) {
        SKTestStrLog(@"**********取出%@为nil**********",keyName);
        return nil;
    }
   
    return nil;
}

/**
 *  判断字符串是否为nil或者nil,或者null
 */
+(BOOL)isNilOrEmptyString:(NSString*)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        SKTestStrLog(@"**********传入的字符串%@为NULL**********",string);
        return YES;
    }

    if ([string isEqualToString:@""] ) {
        SKTestStrLog(@"**********传入的字符串%@为空**********",string);
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
       if (!string) {
        SKTestStrLog(@"**********传入的字符串%@为nil**********",string);
        return YES;
    }
    return NO;
}


#pragma mark --正则判断--

/**
 *  判断字符串是否是纯数字 YES纯数字NO不是纯数字
 */
+(BOOL)isAllNumWithString:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            SKTestStrLog(@"不是纯数字");
            return NO;
        }
    }
    return YES;
}

/** 判断手机号是否合法 */
+(BOOL)isValidateMobileString:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(147)|(145)|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/** 判断邮箱是否合法 */
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}
/**
 *  判断字符串中是否有数字YES有数字NO没有数字
 *  @return YES有数字NO没有数字
 */
+(BOOL)isStringHaveNumberWithStr:(NSString*)str
{
    for (int i = 0; i < [str length]; i++)
    {
        unichar subChar = [str characterAtIndex:i];
        
        if (subChar > 47 && subChar < 58)
        {
            return YES;
        }
    }
    return NO;
}

/**
 *  判断字符串中是否有英语字母YES有数字NO没有数字
 *  @return YES有数字NO没有数字
 */
+(BOOL)isStringHaveLetterWithStr:(NSString*)str
{
    for (int i = 0; i < [str length]; i++)
    {
        unichar subChar = [str characterAtIndex:i];
    
        if (subChar >=65 && subChar <= 90)
        {
            return YES;
        }
        
        if (subChar >= 97 && subChar <= 122) {
            return YES;
        }
    }
    return NO;
}

/** 判断身份证号是否合法YES合法NO不合法 */
+(BOOL)isValidateIdentityCard:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7+ ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9+ ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10+ ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5+ ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4+ ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2+ [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

/** 判断车牌号是否合法YES合法NO不合法 */
+(BOOL)isValidateCarNumber:(NSString *)carNo
{
    if ([NSString isNilOrEmptyString:carNo]) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


/** 判断银行卡号是否合法YES合法NO不合法 */
+(BOOL)isValidateBankCardNumber:(NSString *)bankCardNumber
{
    if ([bankCardNumber isEqualToString:@""] || !bankCardNumber) {
        return NO;
    }
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[bankCardNumber length];
    int lastNum = [[bankCardNumber substringFromIndex:cardNoLength-1] intValue];
    
    bankCardNumber = [bankCardNumber substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankCardNumber substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}


/** 判断密码 只能输入字母和数字 */
+(BOOL)isValidatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/** 判断url是否有效 */
+(BOOL)isValidateUrlStr:(NSString*)str
{
    NSString*regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:str];
}


/** 必须输入2-8个汉字 */
+ (BOOL)isValidateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

/**
 * 判断字符串是否包含特殊字符
 * 可以输入字符和数字,汉字下划线
 */
+ (BOOL)isContainsSpecialChar:(NSString*)str
{
    NSString *specialCharRegex = @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$"; //匹配特殊字符
    NSPredicate *specialCharTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialCharRegex];
    return ![specialCharTest evaluateWithObject:str];
}

/**
 *  只能是纯数字,不能是小数,或者以0头,不是是负数
 */
+(BOOL)isValidNumber:(NSString*)numStr
{
    
    if ([numStr hasPrefix:@"0"]) {
        SKTestStrLog(@"----------数字不能以0开头------------");
        return NO;
    }
    
    if ([numStr hasPrefix:@"-"]) {
        SKTestStrLog(@"---------不能是负数----------");
        return NO;
    }
    
    if ([numStr rangeOfString:@"."].location != NSNotFound) {
        SKTestStrLog(@"----------不能有小数点------------");
        return NO;
    }
    //  不是纯数字
    unichar c;
    for (int i=0; i<numStr.length; i++) {
        c=[numStr characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

/**
 *  检查是否有中文
 */
+ (BOOL)isHaveChineseInString:(NSString *)string
{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

#pragma mark --其他--
/** 获取系统的版本号 */
+(NSString*)getCurrentVersion
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

- (NSString *)MD5
{
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

/**
 *  移除价格字符串最后一个元字
 */
+(NSString*)skRemoveLastStringYuan:(NSString*)str
{
    NSString* tempStr = str;
    if ([tempStr rangeOfString:@"元"].location != NSNotFound) {
         tempStr = [tempStr stringByReplacingOccurrencesOfString:@"元" withString:@""];
    }
    return tempStr;
}

/** 加密手机号的中间四位 */
+(NSString*)getSafePhoneNumber:(NSString*)phone
{
    if ([NSString isValidateMobileString:phone]) {
        NSString* newPhone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4)withString:@"****"];
        return newPhone;
    }
    NSLog(@"**********不是合法的手机号**********");
    return @"";
}

+(NSString *)getCachePath{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* urls = [fileManager URLsForDirectory:NSCachesDirectory
                                        inDomains:NSUserDomainMask];
    NSURL* cachesURL =[urls objectAtIndex:0];
    NSString* cachesPath = [cachesURL path];
    return cachesPath;
}

/**
 *  看保留几位小数 
 *  num 为保留的小数
 */
+(NSString*)skHandleFloatNumber:(NSString*)str
{
    if ([str isKindOfClass:[NSNull class]]||str==nil||[str isEqualToString:@"<null>"]) {
        str = @"";
    }
    if ([str rangeOfString:@"¥"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    }
    NSString *specialCharRegex = @"^[A-Za-z\u4E00-\u9FA5_-]+$"; //匹配特殊字符
    NSPredicate *specialCharTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialCharRegex];
    if ([specialCharTest evaluateWithObject:str]) {
        return str;
    }
    NSInteger num = 2;
    switch (num) {
        case 0:
            str = [NSString stringWithFormat:@"%.0f",[str floatValue]];
            break;
        case 1:
            str = [NSString stringWithFormat:@"%.1f",[str floatValue]];
            break;
        case 2:
            str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
            break;
        case 3:
            str = [NSString stringWithFormat:@"%.3f",[str floatValue]];
            break;
            
        default:
            break;
    }
    return str;
}

/**
 *  取整数 如果小数部分大于0的话整数加1
 */
+(NSString*)getUpperIntString:(NSString*)str
{
    if ([str rangeOfString:@"."].location != NSNotFound) {
        NSArray* arr = [str componentsSeparatedByString:@"."];
        if ([arr[1] integerValue] > 0) {
            return [NSString stringWithFormat:@"%ld",([arr[0] integerValue]+1)];
        }
        else{
            return str;
        }
    }
    return str;
}

/**
 *  强制把小写专成大写
 */
+(NSString*)changeLowerCharToUpper:(NSString*)str
{
    for (int i = 0; i < [str length]; i++)
    {
        unichar subChar = [str characterAtIndex:i];
        
        //大写
        if (subChar >= 65 && subChar <= 90)
        {
            continue;
        }
        
        //小写
        if (subChar >= 97 && subChar <= 122) {
            str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c",subChar] withString:[NSString stringWithFormat:@"%c",subChar-32]];
            continue;
        }
    }
    return str;
}

/**
 *  判断密码是否是字母数字下划线,不是不让输入
 */
+(BOOL)isValidePasswordChar:(NSString*)str
{
    if ([str isEqualToString:@"_"]) {
        return YES;
    }

    
    for (int i = 0; i < [str length]; i++)
    {
        unichar subChar = [str characterAtIndex:i];
        
        //数字
        if (subChar >= 48 && subChar <= 57) {
            return YES;
        }
        //大写
        if (subChar >= 65 && subChar <= 90)
        {
            return YES;
        }
        
        //小写
        if (subChar >= 97 && subChar <= 122) {
            return YES;
        }
        
    }
    
    return NO;
}

/**
 *  判断输入的是否是数字,不是数字不让输入
 */
+(BOOL)isValideNumberChar:(NSString*)str
{
    
    for (int i = 0; i < [str length]; i++)
    {
        unichar subChar = [str characterAtIndex:i];
        //数字
        if (subChar >= 48 && subChar <= 57) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

-(NSString *)URLDecodedString
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}


/**
 是否输入的是表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                    
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }else if (hs == 0x200d){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark - 字数计算
+ (int)countWord:(NSString*)s

{
    
    int i,l=0,a=0,b=0;
    NSUInteger n=[s length];
    unichar c;
    for(i=0;i<n;i++){
        
        c=[s characterAtIndex:i];
        
        if(isblank(c)){
            
            b++;
            
        }else if(isascii(c)){
            
            a++;
            
        }else{
            
            l++;
            
        }
        
    }
    
    if(a==0 && l==0) return 0;
    int all = l+(int)ceilf((float)(a+b)/2.0);

    return all;
    
}

+ (NSString *)disable_emoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}


/**
 获取字符数
 */
+(int)getCharCount:(NSString*)text{
    //得到中英文混合字符串长度 方法1
    int strlength = 0;
    char* p = (char*)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
//    ZQLog(@"---%d---",strlength);
    return strlength;
}

+(BOOL)canEditTextfield:(UITextField*)textField string:(NSString*)string textFieldType:(SKTextFieldLimitType)type {
    
    if ([string isEqualToString:@"\n"]||[string isEqualToString:@""]) {
        return YES;
    }
    
    if (type == SKTextFieldLimitTypePhone) {
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        return canChange;
    }
    else if (type == SKTextFieldLimitTypeMoney){
        
        if ([NSString isNilOrEmptyString:textField.text]) {
            if ([string isEqualToString:@"."]) {
                return NO;
            }
        }
        if ([textField.text isEqualToString:@"0"]) {
            if ([string isEqualToString:@"."]) {
                return YES;
            }
            else{
                return NO;
            }
        }
        else if ([textField.text isEqualToString:@"0."]){
            
        }
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            else{
                NSArray *arr = [textField.text componentsSeparatedByString:@"."];
                if ([arr[1] length] >= 2) {
                    return NO;
                }
            }
        }
        
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        return canChange;

    }
    
    return YES;
}

+ (NSString *)transformDictionaryToUrlFormatStr:(NSDictionary*)dic
{
    if (!dic) {
        return @"";
    }
    NSMutableArray *urlElements = [NSMutableArray array];
    NSArray *keyArray = [dic allKeys];
    for (NSString *key in keyArray) {
        NSString *valueString = [dic objectForKey:key];
        NSString *formattedString = [NSString stringWithFormat:@"%@=%@", key, valueString];
        [urlElements addObject:formattedString];
    }
    NSString *finalString = [urlElements componentsJoinedByString:@"&"];
    return finalString;
}
@end
