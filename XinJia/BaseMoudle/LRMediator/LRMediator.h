//
//  LRMediator.h
//  LRBaseAppDemo
//
//  Created by 李瑞 on 2017/5/27.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LRMediatorErrorReason) {
    LRMediatorErrorReasonNoTarget,
    LRMediatorErrorReasonActionNotImp,
    LRMediatorErrorReasonParameterError, //参数错误，如aTarget或者aAction为空
};

@class LRMediator;
@protocol LRMediatorDelegate <NSObject>

/**
 *  中转发生错误时回调
 *  @discussion
 *          当aErrorReason == SNHMediatorErrorReasonParameterError 时，aInfoParams为nil
 *          否则aInfoParams的格式为{
 "target":target,
 "action":action
 }
 *
 */
- (UIViewController *)mediator:(LRMediator *)aMediator notFoundComponentsWithReason:(LRMediatorErrorReason)aErrorReason info:(NSDictionary *)aInfoParams;

@end

#ifndef LRGlobalMediator
#define LRGlobalMediator [LRMediator sharedMediator]
#endif


@interface LRMediator : NSObject
+ (LRMediator*)sharedMediator;
@property (nonatomic,copy) NSString * appSchema;
- (void)setErrorResponer:(id<LRMediatorDelegate>)aErrorResponser;

- (id)performTarget:(NSString *)aTarget
             action:(NSString *)aAction
             params:(NSDictionary *)aParams;

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion;

@end

extern NSString * const kSNHMediatorTargetKey; //target
extern NSString * const kSNHMediatorActionKey; //action
