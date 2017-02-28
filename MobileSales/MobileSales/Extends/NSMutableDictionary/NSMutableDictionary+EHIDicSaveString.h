//
//  NSMutableDictionary+EHIDicSaveString.h
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (EHIDicSaveString)

-(void)saveString:(NSString *)string forKey:(id)key;

@end
