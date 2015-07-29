//
//  ToastManager.h
//  SSDExercise
//
//  Created by 李 智恒 on 15/7/26.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

//为了解决CRToast的部分属性不遵循Swift中AnyObject协议，只好用OC生成options字典

#import <Foundation/Foundation.h>

@interface ToastManager : NSObject

+ (ToastManager *)sharedManager;

- (NSDictionary *)generateOptionsWithCorrection:(BOOL) correction andRightAnswer:(NSString *)answer;
- (NSDictionary *)generateOptionsForClearUserRecord: (BOOL) result;

@end
