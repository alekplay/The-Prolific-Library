//
//  CheckoutTimeFormatter.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 28.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "CheckoutTimeFormatter.h"

@implementation CheckoutTimeFormatter

+ (CheckoutTimeFormatter *)sharedFormatter {
    static CheckoutTimeFormatter *_sharedFormatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFormatter = [[self alloc] init];
    });
    
    return _sharedFormatter;
}

- (instancetype)init {
    if (self = [super init]) {
       self.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    return self;
}

- (NSString *)convertAndFormatDateString:(NSString *)string {
    [self setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *date = [self dateFromString:string];
    
    [self setTimeStyle:NSDateFormatterShortStyle];
    [self setDateStyle:NSDateFormatterMediumStyle];
    [self setTimeZone:[NSTimeZone localTimeZone]];
    
    return [self stringFromDate:date];
}

@end
