//
//  ToastManager.m
//  SSDExercise
//
//  Created by 李 智恒 on 15/7/26.
//  Copyright (c) 2015年 李 智恒. All rights reserved.
//

#import "ToastManager.h"
#import "UIKit/UIkit.h"
#import "CRToast.h"

@implementation ToastManager
+ (NSDictionary *)generateOptionsWithCorrection:(BOOL) correction andRightAnswer:(NSString *)answer
{
    //设置字号大小
    UIFont *font = [UIFont systemFontOfSize:16];
    
    //基本的optios字典，无论用户选对或选错
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:
         @(NSTextAlignmentCenter), kCRToastTextAlignmentKey,
         @(CRToastAnimationTypeSpring), kCRToastAnimationInTypeKey,
         @(CRToastAnimationTypeSpring), kCRToastAnimationOutTypeKey,
         @(CRToastAnimationDirectionTop), kCRToastAnimationInDirectionKey,
         @(CRToastAnimationDirectionTop), kCRToastAnimationOutDirectionKey,
         @(CRToastAnimationTypeSpring), kCRToastAnimationInTypeKey,
         @(CRToastAnimationTypeSpring), kCRToastAnimationOutTypeKey,
         @(0.5), kCRToastAnimationInTimeIntervalKey,
         @(0.5), kCRToastAnimationOutTimeIntervalKey,
         @(0.8), kCRToastTimeIntervalKey,
         @(CRToastTypeNavigationBar), kCRToastNotificationTypeKey,
         font,kCRToastFontKey,
        nil];
    
    if (correction) {
        //选对时，文字为"回答正确"，颜色为深红色
        [options setObject:@"回答正确" forKey:kCRToastTextKey];
        [options setObject:[UIColor colorWithRed:36/255.0 green:127/255.0 blue:63/255.0 alpha:1] forKey:kCRToastBackgroundColorKey];
    }else {
        //选错时，文字为"错误，正确答案为(正确的选项)，颜色为深绿色"
        [options setObject:[NSString stringWithFormat:@"错误，正确答案为%@", answer] forKey:kCRToastTextKey];
        [options setObject:[UIColor colorWithRed:200/255.0 green:0 blue:0 alpha:1] forKey:kCRToastBackgroundColorKey];
        
    }
    
    
    return options;
}


@end
