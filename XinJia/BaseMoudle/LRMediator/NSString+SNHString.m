//
//  NSString+SNHString.m
//  Pods
//
//  Created by majian on 16/6/6.
//
//

#import "NSString+SNHString.h"
#import <CommonCrypto/CommonDigest.h>
#define kSNHNumberToString(x) @(x).stringValue;

@implementation NSString (SNHString)

BOOL SNHIsEmpty(id obj)
{
    return ((obj) == nil || [(obj) isEqual:[NSNull null]]);
}

/*!
 *  不是空对象
 */
BOOL const SNHIsNotEmpty(id obj) {

    return !SNHIsEmpty(obj);
}


/*!
 *  随机生成唯一id
 */
NSString * const SNHGeneralUUID()
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/*!
 *  是否是空字符串
 */
BOOL const SNHIsEmptyString(NSString *str) {
    return !SNHIsNotEmptyString(str);
}

/*!
 *  不是空字符串
 */
BOOL const SNHIsNotEmptyString(NSString *str) {
    return SNHIsNotEmpty(str) && [str isKindOfClass:[NSString class]] && str.length > 0;
}

NSString * SNHNoNilString(id str) {
    if (SNHIsEmpty(str)) {
        return [NSString emptyString];
    }
    
    return str;
}

/**
 *  点 .
 */
NSString * SNHDotString() {
    return [NSString dotString];
}
/**
 *  逗号 ,
 */
NSString * SNHCommaString() {
    return [NSString commaString];
}
/**
 *  换行符 \n
 */
NSString * lineBreakString() {
    return [NSString lineBreakString];
}

NSString * NSStringFromInt(int value) {
    return kSNHNumberToString(value);
}
NSString * NSStringFromNSInteger(NSInteger value) {
    return kSNHNumberToString(value);
}
NSString * NSStringFromNSUInteger(NSUInteger value) {
    return kSNHNumberToString(value);
}
NSString * NSStringFromunsignedLongLong(unsigned long long value) {
    return kSNHNumberToString(value);
}
NSString * NSStringFromCGFloat(CGFloat value) {
    return kSNHNumberToString(value);
}
NSString * NSStringFromPointer(id x) {
    return [NSString stringWithFormat:@"%p",x];
}

BOOL SNHIsEqualToString(NSString * aStr , NSString * bStr) {
    if ([aStr isKindOfClass:[NSString class]] &&
        [bStr isKindOfClass:[NSString class]]) {
        
        return [aStr isEqualToString:bStr];
    } else {
        /*
            因为此方法是判断字符串是否相等的，所以如果都不是字符串就直接返回NO
         */
        return NO;
    }
}

/**
 *  生成UUID
 *  @discussion 格式如下:
 *          2B064C33-149B-43A6-A506-33066B49AED2
            F017D24F-5CF2-4C17-B71C-CCA5FA1CA87D
 *  @return UUID
 */
NSString * const SNHGeneralUUIDString() {
    
    return [NSUUID UUID].UUIDString;
}

+ (NSString *)emptyString {
    return @"";
}

+ (NSString *)dotString {
    return @".";
}

+ (NSString *)commaString {
    return @",";
}

+ (NSString *)lineBreakString {
    return @"\n";
}

#pragma mark - 截取字符串
- (NSString *)snh_subStringWithoutRange:(NSRange)aRange {
    //前面的string
    NSString * preString = [self substringToIndex:aRange.location];
    //后面的string
    NSString * sufString = [self substringFromIndex:aRange.location + aRange.length];
    return [preString stringByAppendingString:sufString];
}

/*!
 *  删除第一个字符
 */
- (NSString *)snh_removeFirstCharacter {
    
    return [self snh_removeFirstCharacterWithCount:1];
}

- (NSString *)snh_removeFirstCharacterWithCount:(NSUInteger)aCount {
    
    if (aCount == 0 || self.length <= 0) {
        return self;
    }

    if (self.length <= aCount) {
        return [NSString emptyString];
    }
    
    return [self substringWithRange:NSMakeRange(aCount, self.length - aCount)];
}

- (NSString *)snh_removeStringFromHeader:(NSString *)aString {
    if ([self snh_containsSubstring:aString]) {
        NSRange range = [self snh_rangeOfStringFromHeader:aString];
        return [self snh_subStringWithoutRange:range];
    }
    
    return self;
}

/*!
 *  删除最后一个字符
 */
- (NSString *)snh_removeLastCharacter {

    return [self snh_removeLastCharacterWithCount:1];
}

- (NSString *)snh_removeLastCharacterWithCount:(NSUInteger)aCount {
    
    if (aCount == 0 || self.length <= 0) {
        return self;
    }
    
    if (self.length <= aCount) {
        return [NSString emptyString];
    }
    
    return [self substringWithRange:NSMakeRange(0, self.length - aCount)];
}

- (NSString *)snh_removeStringFromEnd:(NSString *)aString {
    if ([self snh_containsSubstring:aString]) {
        NSRange range = [self snh_rangeOfStringFromEnder:aString];
        return [self snh_subStringWithoutRange:range];
    }
    return self;
}

- (NSString *)snh_removeAllStrings:(NSString *)aString {
    return [self stringByReplacingOccurrencesOfString:aString withString:@""];
}

- (NSString *)snh_removeFreeWhiteSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/*!
 *  删掉行首和行尾换行符"\n"
 *  如： "\na\nb\n" ==> "a\nb"
 */
- (NSString *)snh_trimNewLine {
    if (self.length <= 0) {
        return self;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

/*!
 *  删除所有的换行符"\n"
 *  如： "\na\nb\n" ==> "ab"
 */
- (NSString *)snh_trimNewLines {
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

/**
 *  删除行首和行尾的换行符和空格
 *  如："\n a \n b \n" ==> "a \n b"
 */
- (NSString *)snh_trimNewLineAndWhiteSpace {
    if (self.length <= 0) {
        return self;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  删除所有的换行符和空格符
 *  如："\n a \n b \n" ==> "ab"
 */
- (NSString *)snh_trimNewLinesAndWhiteSpaces {
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""]
            stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (BOOL)snh_isNewLinesAndWhiteSpaces {
    return SNHIsEmptyString([self snh_trimNewLineAndWhiteSpace]);
}

- (NSString *)snh_reverseString {
    if (self.length <= 1)
        return self;
    
    NSUInteger stringLength = self.length;
    NSInteger stringIndex, reverseStringIndex;
    unichar *stringChars = calloc(sizeof(unichar), stringLength);
    unichar *reverseStringChars = calloc(sizeof(unichar), stringLength);
    
    [self getCharacters:stringChars range:NSMakeRange(0, stringLength)];
    
    for (stringIndex=stringLength-1, reverseStringIndex=0; stringIndex>=0; stringIndex--, reverseStringIndex++)
        reverseStringChars[reverseStringIndex] = stringChars[stringIndex];
    
    free(stringChars);
    
    return [[NSString alloc] initWithCharactersNoCopy:reverseStringChars length:stringLength freeWhenDone:YES];
}

/**
 全长度  {0,self.length}
 */
- (NSRange)snh_allRange {
    return NSMakeRange(0, self.length);
}

/**
 range是否越界
 */
- (BOOL)snh_isValidRange:(NSRange)range {
    NSRange interRange = NSIntersectionRange(self.snh_allRange, range);
    return NSEqualRanges(range, interRange);
}

/**
 index 是否越界
 */
- (BOOL)snh_isValidIndex:(NSUInteger)index {
    return [self snh_isValidRange:NSMakeRange(index, 1)];
}

/**
 取对应索引的字符
 */
- (NSString *)snh_stringAtIndex:(NSUInteger)index {
    if ([self snh_isValidIndex:index]) {
        return [self substringWithRange:NSMakeRange(index, 1)];
    }
    
    return @"";
}
- (unichar)snh_characterAtIndex:(NSUInteger)index {
    if ([self snh_isValidIndex:index]) {
        return [self characterAtIndex:index];
    }
    
    return 0;
}

/**
 第一个字符
 */
- (NSString *)snh_firstString {
    return [self snh_stringAtIndex:0];
}
- (unichar)snh_firstCharactor {
    return [self snh_characterAtIndex:0];
}

/**
 最后一个字符
 */
- (NSString *)snh_lastString {
    return [self snh_stringAtIndex:self.length - 1];
}
- (unichar )snh_lastCharactor {
    return [self snh_characterAtIndex:self.length - 1];
}

/**
 让第一个字符 大写
 */
//- (NSString *)snh_upperFirstChar {
//    if (SNHIsEmptyString(self)) {
//        return self;
//    }
//    
//    NSString * firstString = [self snh_firstString];
//    if ([firstString snh_isAllString]) { //检测第一个字符是否是字符串
//        if ([firstString snh_isAllLowerString]) {
//            return [[firstString uppercaseString] stringByAppendingString:[self snh_removeFirstCharacter]];
//        }
//    }
//    
//    return self;
//}

/**
 让第一个字符 小写
 */
//- (NSString *)snh_lowerFirstChar {
//    if (SNHIsEmptyString(self)) {
//        return self;
//    }
//    
//    NSString * firstString = [self snh_firstString];
//    if ([firstString snh_isAllString]) { //检测第一个字符是否是字符串
//        if ([firstString snh_isAllUpperString]) {
//            return [[firstString lowercaseString] stringByAppendingString:[self snh_removeFirstCharacter]];
//        }
//    }
//    
//    return self;
//}

#pragma mark - 判断类型


- (NSString *)snh_32md5 {
    const char *cStr = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  [NSString stringWithString: output].uppercaseString;
}

- (NSString *)snh_128md5 {
    const char *cStr = self.UTF8String;
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_BLOCK_BYTES * 2];
    
    for(int i = 0; i < CC_MD5_BLOCK_BYTES; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  [NSString stringWithString: output].uppercaseString;
}

- (NSString *)snh_toString {
    
    return self;
}

//- (NSNumber *)snh_toNumber {
//    if ([self snh_isFloatValue]) {
//        return [self snh_toDoubleNumber];
//    }
//    
//    return [self snh_toLongLongNumber];
//}

- (NSNumber *)snh_toDoubleNumber {
    
    return @(self.doubleValue);
}

- (NSNumber *)snh_toFloatNumber {
    
    return @(self.floatValue);
}

- (NSNumber *)snh_toIntegerNumber {
    
    return @(self.integerValue);
}

- (NSNumber *)snh_toLongNumber {
    
    return @(self.intValue);
}

- (NSNumber *)snh_toLongLongNumber {
    
    return @(self.longLongValue);
}

- (NSURL *)snh_toURL {
    return [NSURL URLWithString:self];
}

- (NSURL *)snh_toFileURL {
    return [NSURL fileURLWithPath:self];
}

- (NSString *)snh_toPinyin
{
    if ([self length] == 0)
    {
        return @"";
    }
    NSMutableString *pinyin = [self mutableCopy];
    
    if (!CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO))
    {
        return @"";
    }
    return pinyin;
}



/**
 从头搜索字符串
 @example "4&12345&234"
 searchedString为 "&"  则 range = {1,1}
  如果searchedString为 "34" 则 range = {4,2}
 */
- (NSRange)snh_rangeOfStringFromHeader:(NSString *)searchedString {
    return [self rangeOfString:searchedString options:NSLiteralSearch];
}

/**
 从尾部搜索字符串
 @example "4&12345&234"
 searchedString为 "&" 则range = {6,1}
如果searchedString为 "34" 则 range = {9,2}
 */
- (NSRange)snh_rangeOfStringFromEnder:(NSString *)searchedString {
    return [self rangeOfString:searchedString options:NSBackwardsSearch];
}

#pragma mark - 容错方法
- (NSString *)snh_appendString:(NSString *)string {
    if (SNHIsEmptyString(string)) {
        return self;
    }
    
    return [self stringByAppendingString:string];
}

- (NSString *)snh_stringByAppendingURLPathComponent:(NSString *)aString {
    BOOL needSep1 = ![[self snh_lastString] isEqualToString:@"/"];
    BOOL needSep2 = ![[aString snh_firstString] isEqualToString:@"/"];
    
    if (needSep1 && needSep2) {
        aString = [@"/" snh_appendString:aString];
    } else if (!needSep1 && !needSep2) {
        aString = [aString snh_removeFirstCharacter];
    }
    
    return [self snh_appendString:aString];
}

- (BOOL)snh_containsSubstring:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

#pragma mark - 正则判断方法
/**
 *  是否是合法的URL
 */
- (BOOL)snh_isValidURL {
    
    NSError * error = nil;
    NSDataDetector * dataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink
                                                                    error:&error];
    NSArray<NSTextCheckingResult *> * results = [dataDetector matchesInString:self
                                                                      options:0
                                                                        range:NSMakeRange(0, self.length)];
    return results.count == 1;
}

/**
 *  是否是合法的邮件
 */
- (BOOL)snh_isValidEmail {
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,16}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emailTest evaluateWithObject:self];
}

/**
- (BOOL)snh_isValidPhoneNumber {
    NSError * error = nil;
    NSDataDetector * dataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypePhoneNumber
                                                                    error:&error];
    NSArray<NSTextCheckingResult *> * results = [dataDetector matchesInString:self
                                                                      options:0
                                                                        range:NSMakeRange(0, self.length)];
    return results.count == 1;
}
*/

- (NSString *)stringValue {
    return self;
}

#pragma mark - 编码
- (NSString *)snh_urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef)self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\|~ "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString *)snh_urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

#pragma mark - Data与String互转
+ (instancetype)snh_stringWithUTF8Data:(NSData *)data {
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (nullable NSData *)snh_dataUsingUTF8Encoding {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 路径相关
/*
 不带类型的文件名字   aaa
 */
- (NSString *)snh_fileNameWithoutType {
    NSString * fullName = [self snh_fileFullName];
    NSString * fullType = [self snh_fileFullType];
    if ([fullName hasSuffix:fullType]) {
        NSRange range = [fullName rangeOfString:fullType options:NSBackwardsSearch]; //从后往前匹配
        if (range.location != NSNotFound) {
            return [fullName substringToIndex:range.location];
        }
    }
    return @"";
}
/*
 文件的完整名字    aaa.zip
 */
- (NSString *)snh_fileFullName {
    return self.lastPathComponent;
}
/*
 文件的类型 zip
 */
- (NSString *)snh_fileType {
    return self.pathExtension;
}

- (NSString *)snh_fileFullType {
    return [@"." stringByAppendingString:[self snh_fileType]];
}

static NSString * snh_file_KBs = @"1024";
static NSString * snh_file_MBs = @"1048576"; //1048576
static NSString * snh_file_GBs = @"1073741824"; //1073741824
static NSString * snh_file_TBs = @"1099511627776"; //1099511627776
static NSArray * snh_file_sizes;
static NSArray * snh_file_sizes_simple;
__attribute__((constructor)) static void initFileNormalSize(void)
{
    snh_file_sizes = @[@{@"size": snh_file_TBs,@"unit":@"TB"},
                       @{@"size": snh_file_GBs,@"unit":@"GB"},
                       @{@"size": snh_file_MBs,@"unit":@"MB"},
                       @{@"size": snh_file_KBs,@"unit":@"KB"},
                       @{@"size": @"0",@"unit":@"B"}];
    
    snh_file_sizes_simple = @[@{@"size": snh_file_TBs,@"unit":@"T"},
                              @{@"size": snh_file_GBs,@"unit":@"G"},
                              @{@"size": snh_file_MBs,@"unit":@"M"},
                              @{@"size": snh_file_KBs,@"unit":@"K"},
                              @{@"size": @"0",@"unit":@"B"}];
}

#pragma mark - 文件大小相关
+ (NSString *)snh_stringWithFileSize:(unsigned long long)fileSize {
    return [NSStringFromunsignedLongLong(fileSize) snh_toFileSize];
}

/**
 返回格式: 12.00G 等
 */
+ (NSString *)snh_stringWithSimpleFileSize:(unsigned long long)fileSize {
    return [NSStringFromunsignedLongLong(fileSize) snh_toSimpleFileSize];
}
/**
 返回格式: 12.00GB 等
 */
- (NSString *)snh_toFileSize {
    return [self snh_toFileSize:NO];
}
/**
 返回格式: 12.00G 等
 */
- (NSString *)snh_toSimpleFileSize {
    return [self snh_toFileSize:YES];
}

- (NSString *)snh_toFileSize:(BOOL)isSimple {
    NSArray * oriFileSizeInfo = snh_file_sizes;
    if (isSimple) {
        oriFileSizeInfo = snh_file_sizes_simple;
    }
    unsigned long long fileSizeOri = self.longLongValue;
    for (NSDictionary * sizeDict in oriFileSizeInfo) {
        if ([sizeDict[@"size"] compare:self options:NSNumericSearch] != NSOrderedDescending) {
            CGFloat fileSize = 0;
            if ([sizeDict[@"size"] floatValue] <= 0) {
                fileSize = fileSizeOri;
            } else {
                fileSize = fileSizeOri / [sizeDict[@"size"] floatValue];
            }
            return [NSString stringWithFormat:@"%.2f%@", fileSize,sizeDict[@"unit"]];
        }
    }
    
    return @"0.00B";
}

- (NSString *)snh_removePathExtension {
    NSString * filePath = self;
    if (SNHIsNotEmptyString(filePath.pathExtension)) {
        return [filePath snh_removeStringFromEnd:[SNHDotString() stringByAppendingString:filePath.pathExtension]];
    }

    return filePath;
}

/**
 拼接成完整的文件名
 aaa  jpg ==> aaa.jpg
 aaa  .jpg ==> aaa.jpg
 aaa. jpg ==> aaa.jpg
 */
- (NSString *)snh_appendingPathExtension:(NSString *)pathExtension {
    NSString * pathName = self;
    BOOL pathNameHasDot = [pathName hasSuffix:@"."];
    BOOL pathExtensionHasDot = [pathExtension hasPrefix:@"."];
    if ((pathNameHasDot && !pathExtensionHasDot) || (!pathNameHasDot && pathExtensionHasDot)) {
        return [pathName stringByAppendingString:pathExtension];
    } else if (!pathNameHasDot && !pathExtensionHasDot) {
        return [NSString stringWithFormat:@"%@.%@",pathName,pathExtension];
    } else if (pathExtensionHasDot && pathNameHasDot) {
        return [NSString stringWithFormat:@"%@%@",pathName,[pathExtension snh_removeFirstCharacter]];
    }

    return self;
}

#pragma mark - 时间相关
+ (NSString *)snh_stringHHmmssWithTime:(int)time {
    int hour = time / 3600;
    int minute = (time - hour * 3600) / 60;
    int second = time - hour * 3600 - minute * 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
}
+ (NSString *)snh_stringmmssWithTime:(int)time {
    return [[self snh_stringHHmmssWithTime:time] substringWithRange:NSMakeRange(3, 5)];
}

/**
 将 01:01:20或者 01:20等格式的时间转成以秒为单位的时间
 */
- (NSUInteger)snh_timeStringToSeconds {
    NSUInteger secondTime = 0;
    NSString * duration = self;
    NSArray * timeArrayI = [duration componentsSeparatedByString:@":"];
    if (timeArrayI.count >= 1 && timeArrayI.count <= 3 ) {
        NSUInteger hour = 0;
        NSUInteger minute = 0;
        NSUInteger second = 0;
        
        if (timeArrayI.count == 3) {
            hour = [timeArrayI.firstObject integerValue];
            minute = [timeArrayI[1] integerValue];
        } else if (timeArrayI.count == 2) {
            minute = [timeArrayI.firstObject integerValue];
        }
        
        second = [timeArrayI.lastObject integerValue];
        
        secondTime = hour * 60 * 60 + minute * 60 + second;
    }
    
    return secondTime;
}

#pragma mark - 粘贴板
//- (void)snh_copyToPasteBoard {
//    UIPasteboard * pasteBoard = [UIPasteboard generalPasteboard];
//    [pasteBoard setString:self];
//}

@end




