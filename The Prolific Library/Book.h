//
//  Book.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 26.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSDate *lastCheckedOut;
@property (nonatomic, strong) NSString *lastCheckedOutBy;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic) NSInteger ID;

@end
