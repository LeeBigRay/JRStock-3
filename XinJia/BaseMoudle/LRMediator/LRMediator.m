//
//  LRMediator.m
//  LRBaseAppDemo
//
//  Created by 李瑞 on 2017/5/27.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "LRMediator.h"
#import "NSString+SNHString.h"
NSString * const kSNHMediatorTargetKey = @"target";
NSString * const kSNHMediatorActionKey = @"action";

@interface LRMediator () {

    id<LRMediatorDelegate> _errorResponser;
}

@end
@implementation LRMediator
+(LRMediator *)sharedMediator{
    static LRMediator * _defaultMediator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultMediator = [[LRMediator alloc]init];
    });
    return _defaultMediator;
}

-(void)setErrorResponer:(id<LRMediatorDelegate>)aErrorResponser{
    if (aErrorResponser != nil && aErrorResponser != _errorResponser) {
        _errorResponser = aErrorResponser;
    }
}

-(id)performTarget:(NSString *)aTarget action:(NSString *)aAction params:(NSDictionary *)aParams{
    if (SNHIsEmptyString(aTarget) || SNHIsEmptyString(aAction)) {

        if ([_errorResponser respondsToSelector:@selector(mediator:notFoundComponentsWithReason:info:)]) {

            return [_errorResponser mediator:self
                notFoundComponentsWithReason:LRMediatorErrorReasonParameterError
                                        info:nil];
        }

        return nil;
    }

    NSString * targetString = [NSString stringWithFormat:@"Target_%@",aTarget];
    NSString * actionString = [NSString stringWithFormat:@"Action_%@:",aAction];

    Class targetClass = NSClassFromString(targetString);
    SEL actionSelector = NSSelectorFromString(actionString);

    if (nil == targetClass) {

        if ([_errorResponser respondsToSelector:@selector(mediator:notFoundComponentsWithReason:info:)]) {
            return  [_errorResponser mediator:self
                 notFoundComponentsWithReason:LRMediatorErrorReasonNoTarget
                                         info:@{kSNHMediatorTargetKey:aTarget,
                                                kSNHMediatorActionKey:aAction}];
        }

        return nil;
    }

    if ([targetClass respondsToSelector:actionSelector]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [targetClass performSelector:actionSelector withObject:aParams];
#pragma clang diagnostic pop
    } else {

        if ([_errorResponser respondsToSelector:@selector(mediator:notFoundComponentsWithReason:info:)]) {
            return [_errorResponser mediator:self
                notFoundComponentsWithReason:LRMediatorErrorReasonActionNotImp
                                        info:@{kSNHMediatorTargetKey:aTarget,
                                               kSNHMediatorActionKey:aAction}];
        }
    }
    
    return nil;
}


/*
 scheme://[target]/[action]?[params]

 url sample:
 aaa://targetA/actionB?id=1234
 */

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion
{
    if (![url.scheme isEqualToString:self.appSchema]) {
        // 这里就是针对远程app调用404的简单处理了，根据不同app的产品经理要求不同，你们可以在这里自己做需要的逻辑
        return @(NO);
    }

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    if (SNHIsNotEmpty(urlString) && [urlString rangeOfString:@"http"].location != NSNotFound) {
        NSError * error = nil;
        NSDataDetector * dataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink
                                                                        error:&error];
        NSArray<NSTextCheckingResult *> * results = [dataDetector matchesInString:urlString options:0 range:NSMakeRange(0, urlString.length)];
        if (results.count > 0) {
            NSRange range = results.firstObject.range;
            if (range.location != NSNotFound) {
                NSString * link = [urlString substringWithRange:range];
                if (range.location - 1 > 0 ) {
                    NSString * key = [urlString substringToIndex:range.location - 1];
                    if (SNHIsNotEmpty(link) && SNHIsNotEmpty(key)) {
                        [params setObject:link forKey:key];
                    }
                }
            }
        }
    } else {
        for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
            NSArray *elts = [param componentsSeparatedByString:@"="];
            if([elts count] < 2) continue;
            [params setObject:[elts lastObject] forKey:[elts firstObject]];
        }
    }
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }

    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:params];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}
@end
