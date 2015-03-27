//
//  BookDetailViewController.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 26.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BooksHTTPClient.h"

@interface BookDetailViewController : UIViewController <BooksHTTPClientDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) Book *book;

@end
