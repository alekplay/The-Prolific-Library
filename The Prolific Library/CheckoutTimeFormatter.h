//
//  CheckoutTimeFormatter.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 28.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckoutTimeFormatter : NSDateFormatter

+ (CheckoutTimeFormatter *)sharedFormatter;

- (NSString *)convertAndFormatDateString:(NSString *)string;

@end
