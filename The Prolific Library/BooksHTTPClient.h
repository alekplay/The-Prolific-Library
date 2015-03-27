//
//  BooksHTTPClient.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 26.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "Book.h"

@class BooksHTTPClient;

@protocol BooksHTTPClientDelegate <NSObject>
@optional
- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateWithBooks:(id)books;
- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateBook:(id)book;
- (void)booksHTTPClient:(BooksHTTPClient *)client didAddBook:(id)book;
- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error;
@end

@interface BooksHTTPClient : AFHTTPSessionManager
@property (nonatomic, weak) id<BooksHTTPClientDelegate> delegate;
+ (BooksHTTPClient *)sharedClient;
- (void)getBooks;
- (void)checkOutBook:(Book *)book forUser:(NSString *)name;
- (void)addBook:(NSDictionary *)bookDict;
@end