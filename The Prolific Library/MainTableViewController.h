//
//  MainTableViewController.h
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 23.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksHTTPClient.h"

@interface MainTableViewController : UITableViewController <BooksHTTPClientDelegate>

@end
