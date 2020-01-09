//
//  LanguageManager.h
//  DoT
//
//  Created by Zeeshan Ahmad Butt on 09/05/2018.
//  Copyright © 2018 Zeeshan Ahmad Butt. All rights reserved.
//

#import <Foundation/Foundation.h>
#define USE_ON_FLY_LOCALIZATION

typedef NS_ENUM(NSInteger, ELanguage)
{
    ELanguageEnglish,
    ELanguageArabic,
    
    ELanguageCount
};

@interface LanguageManager : NSObject

+ (void)setupCurrentLanguage;
+ (NSArray *)languageStrings;
+ (NSString *)currentLanguageString;
+ (NSString *)currentLanguageCode;
+ (NSInteger)currentLanguageIndex;
+ (void)saveLanguageByIndex:(NSInteger)index;
+ (BOOL)isCurrentLanguageRTL;

@end
