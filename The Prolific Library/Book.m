//
//  Book.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 26.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "Book.h"

@implementation Book

#pragma mark INITIALIZATION

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setUpBookWithDictionary:dict];
    }
    
    return self;
}

- (void)updateBookWithDictionary:(NSDictionary *)dict {
    [self setUpBookWithDictionary:dict];
}

- (void)setUpBookWithDictionary:(NSDictionary *)dict {
    self.author = [dict objectForKey:@"author"];
    self.category = [dict objectForKey:@"categories"];
    self.lastCheckedOut = [dict objectForKey:@"lastCheckedOut"];
    self.lastCheckedOutBy = [dict objectForKey:@"lastCheckedOutBy"];
    self.publisher = [dict objectForKey:@"publisher"];
    self.title = [dict objectForKey:@"title"];
    self.url = [dict objectForKey:@"url"];
    self.ID = [[dict objectForKey:@"id"] integerValue];
}

@end