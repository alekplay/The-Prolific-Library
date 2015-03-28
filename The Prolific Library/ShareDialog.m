//
//  ShareDialog.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 28.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "ShareDialog.h"

@implementation ShareDialog

- (instancetype)initWithBook:(NSString *)bookTitle andAuthor:(NSString *)authorName {
    NSString *text = [NSString stringWithFormat:@"Check out this awesome book by %@ named %@", authorName, bookTitle];
    NSString *urlString = [NSString stringWithFormat:@"http://www.google.com/search?hl=en&q={%@}&btnI=I ", bookTitle];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSArray *objects = @[text, url];
    
    if (self = [super initWithActivityItems:objects applicationActivities:nil]) {
        NSArray *excludeActivities = @[UIActivityTypePostToWeibo, UIActivityTypeMessage, UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop];
        self.excludedActivityTypes = excludeActivities;
    }
    
    return self;
}

@end
