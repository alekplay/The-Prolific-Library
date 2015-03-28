//
//  MainTableViewController.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 23.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksHTTPClient.h"
#import "BookDetailViewController.h"
#import "AddBookViewController.h"

@interface MainTableViewController : UITableViewController <BooksHTTPClientDelegate, UIAlertViewDelegate, BookDetailVCDelegate, AddBookVCDelegate>

@end
