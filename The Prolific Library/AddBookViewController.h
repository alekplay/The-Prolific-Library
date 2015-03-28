//
//  AddBookViewController.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 27.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksHTTPClient.h"
#import "Book.h"

typedef enum {
    AddBookVCStyleAddingBook,
    AddBookVCStyleEditingBook
} AddBookVCStyle;

@class AddBookViewController;

@protocol AddBookVCDelegate <NSObject>
@optional
- (void)addBook:(Book *)book;
- (void)updateBook:(Book *)book;
@end

@interface AddBookViewController : UIViewController <BooksHTTPClientDelegate, UIAlertViewDelegate>
@property (nonatomic, weak) id<AddBookVCDelegate>delegate;
@property (nonatomic, strong) Book *book;
@property AddBookVCStyle currentStyle;

@end