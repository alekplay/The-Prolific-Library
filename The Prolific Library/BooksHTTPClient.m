//
//  BooksHTTPClient.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 26.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "BooksHTTPClient.h"

static NSString *const ProlificOnlineURLString = @"http://prolific-interview.herokuapp.com/550b498009533d00094f2e3d/";

@implementation BooksHTTPClient

#pragma mark INITIALIZATION

+ (BooksHTTPClient *)sharedClient {
    static BooksHTTPClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:ProlificOnlineURLString]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark SERVER COMMUNICATIONS

- (void)getBooks {
    [self GET:@"books" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didUpdateWithBooks:)]) {
            [self.delegate booksHTTPClient:self didUpdateWithBooks:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(booksHTTPClient:didFailWithError:)]) {
            [self.delegate booksHTTPClient:self didFailWithError:error];
        }
    }];
}

@end