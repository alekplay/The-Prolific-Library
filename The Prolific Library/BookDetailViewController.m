//
//  BookDetailViewController.m
//  The Prolific Library
//
//  Created by Aleksander Skjølsvik on 26.03.15.
//  Copyright (c) 2015 Aleksander Skjølsvik. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkedOutLabel;

@end

@implementation BookDetailViewController

#pragma mark INITIALIZATION

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    if (self.book.publisher != nil) {
        self.publisherLabel.text = [NSString stringWithFormat:@"Publisher: %@", self.book.publisher];
    } else {
        //[self.publisherLabel removeFromSuperview];
    }
    if (self.book.category != nil) {
        self.categoryLabel.text = [NSString stringWithFormat:@"Categories: %@", self.book.category];
    } else {
        //[self.publisherLabel removeFromSuperview];
    }
    if (self.book.lastCheckedOutBy != nil && self.book.lastCheckedOut != nil) {
        self.checkedOutLabel.text = [NSString stringWithFormat:@"%@ at %@", self.book.lastCheckedOutBy, self.book.lastCheckedOut];
    }
    
}

#pragma mark ACTIONS

- (IBAction)checkOutButtonDidPress:(id)sender {
    NSLog(@"Checking out book...");
}

@end
