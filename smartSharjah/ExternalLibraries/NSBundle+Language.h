//
//  NSBundle+Language.h
//  DoT
//
//  Created by Zeeshan Ahmad Butt on 09/05/2018.
//  Copyright © 2018 Zeeshan Ahmad Butt. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef USE_ON_FLY_LOCALIZATION

@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

@end

#endif
