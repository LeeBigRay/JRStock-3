//
//  NSString+SNHString.h
//  Pods
//
//  Created by majian on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
//#if __has_include(<SNHFoundation/SNHFoundation.h>)
//#import <SNHFoundation/NSScanner+SNHFoundationAdd.h>
//#import <SNHFoundation/NSObject+SNHObject.h>
//#else
//    #import "NSScanner+SNHFoundationAdd.h"
//    #import "NSObject+SNHObject.h"
//#endif

NS_ASSUME_NONNULL_BEGIN
/*!
 *  随机生成唯一id
 */
extern NSString * const SNHGeneralUUID();

/*!
 *  是否是空字符串
 */
extern BOOL const SNHIsEmptyString(NSString *str);

/*!
 *  不是空字符串
 */
extern BOOL const SNHIsNotEmptyString(NSString *str);

extern BOOL const SNHIsNotEmpty(id obj);

/**
 *  生成UUID
 *  @discussion 格式如下:
 *          2B064C33-149B-43A6-A506-33066B49AED2
            F017D24F-5CF2-4C17-B71C-CCA5FA1CA87D
 *  @return UUID
 */
extern NSString * const _Nonnull SNHGeneralUUIDString();

/*!
 *  剔除空字符串
 */
extern NSString * _Nonnull SNHNoNilString(id str);

/**
 *  点 .
 */
extern NSString * _Nonnull SNHDotString();
/**
 *  逗号 ,
 */
extern NSString * _Nonnull SNHCommaString();
/**
 *  换行符 \n
 */
extern NSString * _Nonnull lineBreakString();

/*
 将数字转成字符串
 */
extern NSString * _Nonnull NSStringFromInt(int value);
extern NSString * _Nonnull NSStringFromNSInteger(NSInteger value);
extern NSString * _Nonnull NSStringFromNSUInteger(NSUInteger value);
extern NSString * _Nonnull NSStringFromunsignedLongLong(unsigned long long value);
extern NSString * _Nonnull NSStringFromCGFloat(CGFloat value);
/*
 将对象的内存地址转成字符串
 */
extern NSString * _Nonnull NSStringFromPointer(id x);

/**
 *  判断两个字符串是否相等
 */
extern BOOL SNHIsEqualToString(NSString * aStr , NSString * bStr);

@interface NSString (SNHString)

/**
 *  空字符串 @""
 */
+ (NSString *)emptyString;

/**
 *  点 .
 */
+ (NSString *)dotString;

/**
 *  逗号 ,
 */
+ (NSString *)commaString;

/**
 *  换行符 \n
 */
+ (NSString *)lineBreakString;

#pragma mark - 截取字符串
/**
 去除aRange对应的string
 */
- (NSString *)snh_subStringWithoutRange:(NSRange)aRange;

/*!
 *  删除第一个字符
 */
- (NSString *)snh_removeFirstCharacter;

/*!
 *  删除字符串的最前面几个字符
 */
- (NSString *)snh_removeFirstCharacterWithCount:(NSUInteger)aCount;

/**
 从前往后 删除 最先匹配的aString
 */
- (NSString *)snh_removeStringFromHeader:(NSString *)aString;

/*!
 *  删除最后一个字符
 */
- (NSString *)snh_removeLastCharacter;

/*!
 *  删除字符串的最后aCount个字符
 */
- (NSString *)snh_removeLastCharacterWithCount:(NSUInteger)aCount;

/**
 从后往前 删除 最先匹配的aString
 */
- (NSString *)snh_removeStringFromEnd:(NSString *)aString;

/**
 删除已出现的所有aString
 */
- (NSString *)snh_removeAllStrings:(NSString *)aString;

/*!
 *  删除头部和尾部多余的空白字符
 */
- (NSString *)snh_removeFreeWhiteSpace;

/*!
 *  删掉行首和行尾换行符"\n"
 *  如： "\na\nb\n" ==> "a\nb"
 */
- (NSString *)snh_trimNewLine;

/*!
 *  删除所有的换行符"\n"
 *  如： "\na\nb\n" ==> "ab"
 */
- (NSString *)snh_trimNewLines;

/**
 *  删除行首和行尾的换行符和空格
 *  如："\n a \n b \n" ==> "a \n b"
 */
- (NSString *)snh_trimNewLineAndWhiteSpace;

/**
 *  删除所有的换行符和空格符
 *  如："\n a \n b \n" ==> "ab"
 */
- (NSString *)snh_trimNewLinesAndWhiteSpaces;

/**
 是否是换行符和空格符组成
 */
- (BOOL)snh_isNewLinesAndWhiteSpaces;

/**
 反转字符串 "abc" ==> "cba"
 */
- (NSString *)snh_reverseString;

/**
 全长度  {0,self.length}
 */
- (NSRange)snh_allRange;

/**
 range是否越界
 */
- (BOOL)snh_isValidRange:(NSRange)range;

/**
 index 是否越界
 */
- (BOOL)snh_isValidIndex:(NSUInteger)index;

/**
 取对应索引的字符
 */
- (NSString *)snh_stringAtIndex:(NSUInteger)index;
- (unichar)snh_characterAtIndex:(NSUInteger)index;

/**
 第一个字符
 */
- (NSString *)snh_firstString;
- (unichar)snh_firstCharactor;

/**
 最后一个字符
 */
- (NSString *)snh_lastString;
- (unichar )snh_lastCharactor;

/**
 让第一个字符 大写
 */
- (NSString *)snh_upperFirstChar;

/**
 让第一个字符 小写
 */
- (NSString *)snh_lowerFirstChar;

#pragma mark - 判断类型

/*!
 *  128位md5加密
 */
- (NSString *)snh_128md5;

/*!
 *  32位md5加密
 */
- (NSString *)snh_32md5;

/**
 *  以下方法均为将字符串转为对应类型的Number类型
 */
- (NSNumber *)snh_toDoubleNumber;
- (NSNumber *)snh_toFloatNumber;
- (NSNumber *)snh_toIntegerNumber;
- (NSNumber *)snh_toLongNumber;
- (NSNumber *)snh_toLongLongNumber;

/**
 *  转成URL
 */
- (NSURL *)snh_toURL;
/*
 转成本地URL
 */
- (NSURL *)snh_toFileURL;
/**
 转成拼音
 */
@property (nonatomic,readonly,copy) NSString * snh_toPinyin;

- (NSString *)snh_toString;
- (NSNumber *)snh_toNumber;

/**
 从头搜索字符串
 @example "4&12345&234"
 如果searchedString为 "&"  则 range = {1,1}
 如果searchedString为 "34" 则 range = {4,2}
 */
- (NSRange)snh_rangeOfStringFromHeader:(NSString *)searchedString;

/**
 从尾部搜索字符串
 @example "4&12345&234"
 如果searchedString为 "&" 则range = {6,1}
 如果searchedString为 "34" 则 range = {9,2}
 */
- (NSRange)snh_rangeOfStringFromEnder:(NSString *)searchedString;

#pragma mark - 容错方法
/**
 *  附加字符串   
 *  如：
 *     正常情况
 *          [@"aa" snh_appendString:@"bb"] ==> "aabb"
 *
 *     异常情况
 *          [@"aa" snh_appendString:nil] ==> "aa" ps:此处的nil,<null>,或者""都是返回原字符串
 */
- (NSString *)snh_appendString:(NSString *)string;

/**
 拼接成 完整的URL路径
 */
- (NSString *)snh_stringByAppendingURLPathComponent:(NSString *)aString;

/**
 是否包含string
 */
- (BOOL)snh_containsSubstring:(NSString *)string;

#pragma mark - 正则判断方法
/**
 *  是否是合法的URL
 */
- (BOOL)snh_isValidURL;

/**
 *  是否是合法的邮件
 */
- (BOOL)snh_isValidEmail;

//- (BOOL)snh_isValidPhoneNumber;

#pragma mark - 编码
- (NSString *)snh_urlEncodedString;
- (NSString *)snh_urlDecodedString;

#pragma mark - Data与String互转
- (nullable NSData *)snh_dataUsingUTF8Encoding;
+ (instancetype)snh_stringWithUTF8Data:(NSData *)data;

#pragma mark - 路径相关
/*
 不带类型的文件名字   aaa
 */
- (NSString *)snh_fileNameWithoutType;
/*
 文件的完整名字    aaa.zip
 */
- (NSString *)snh_fileFullName;
/*
 文件的类型 zip
 */
- (NSString *)snh_fileType;
/*
 文件类型   .zip
 */
- (NSString *)snh_fileFullType;

#pragma mark - 文件大小相关
/**
 返回格式: 12.00GB 等
 */
+ (NSString *)snh_stringWithFileSize:(unsigned long long)fileSize;
/**
 返回格式: 12.00G 等
 */
+ (NSString *)snh_stringWithSimpleFileSize:(unsigned long long)fileSize;
/**
 返回格式: 12.00GB 等
 */
- (NSString *)snh_toFileSize;
/**
 返回格式: 12.00G 等
 */
- (NSString *)snh_toSimpleFileSize;
/**
 isSimple == YES  返回格式: 12.00G 等
 isSimple == NO  返回格式: 12.00GB 等
 */
- (NSString *)snh_toFileSize:(BOOL)isSimple;

/**
 移除文件类型后缀
 aaa.zip ==> aaa
 */
- (NSString *)snh_removePathExtension;

/**
 拼接成完整的文件名
 aaa  jpg ==> aaa.jpg
 aaa  .jpg ==> aaa.jpg
 aaa. jpg ==> aaa.jpg
 */
- (NSString *)snh_appendingPathExtension:(NSString *)pathExtension;

#pragma mark - 时间相关
//00:00:00
+ (NSString *)snh_stringHHmmssWithTime:(int)time;
//00:00
+ (NSString *)snh_stringmmssWithTime:(int)time;
/**
 将 01:01:20或者 01:20等格式的时间转成以秒为单位的时间
 */
- (NSUInteger)snh_timeStringToSeconds;
#pragma mark - 粘贴板
- (void)snh_copyToPasteBoard;



@end
NS_ASSUME_NONNULL_END
