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
@property (weak, nonatomic) IBOutlet UILabel *checkedOutHeader;

@end

@implementation BookDetailViewController

#pragma mark INITIALIZATION

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    self.categoryLabel.text = [NSString stringWithFormat:@"Categories: %@", self.book.category];
    
    if (self.book.publisher != nil && self.book.publisher != (id)[NSNull null]) {
        self.publisherLabel.text = [NSString stringWithFormat:@"Publisher: %@", self.book.publisher];
    } else {
        [self.publisherLabel removeFromSuperview];
        [self.view setNeedsLayout];
    }

    if (self.book.lastCheckedOutBy != nil && self.book.lastCheckedOutBy != (id)[NSNull null] && self.book.lastCheckedOut != nil && self.book.lastCheckedOut != (id)[NSNull null]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:self.book.lastCheckedOut];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        self.checkedOutLabel.text = [NSString stringWithFormat:@"%@ at %@", self.book.lastCheckedOutBy, dateString];
    } else {
        [self.checkedOutLabel removeFromSuperview];
        [self.checkedOutHeader removeFromSuperview];
        [self.view setNeedsLayout];
    }
}

#pragma mark ACTIONS

- (IBAction)checkOutButtonDidPress:(id)sender {
    [self askForName];
}

- (IBAction)shareButtonDidPress:(id)sender {
    NSString *text = [NSString stringWithFormat:@"Check out this awesome book by %@ named %@", self.book.author, self.book.title];
    NSString *urlString = [NSString stringWithFormat:@"http://www.google.com/search?hl=en&q={%@}&btnI=I ", self.book.title];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSArray *objects = @[text, url];
    
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:objects applicationActivities:nil];
    NSArray *excludeActivities = @[UIActivityTypePostToWeibo, UIActivityTypeMessage, UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop];
    avc.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:avc animated:YES completion:nil];
}

#pragma mark BOOKS HTTP CLIENT DELEGATE

- (void)booksHTTPClient:(BooksHTTPClient *)client didUpdateBook:(id)book {
    [self.navigationController popViewControllerAnimated:YES];
    // ADD SPINNER, SAVE DATA IN TABLE
}

- (void)booksHTTPClient:(BooksHTTPClient *)client didFailWithError:(NSError *)error {
    // ADD ERROR MESSAGE
}

// CLEAN UP CODE

#pragma mark ALERT VIEW (DELEGATE)

- (void)askForName {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter your name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Checkout", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Checkout"]) {
        NSString *name = [[alertView textFieldAtIndex:0] text];
        
        if ([name length] > 0) {
            BooksHTTPClient *client = [BooksHTTPClient sharedClient];
            client.delegate = self;
            [client checkOutBook:self.book forUser:name];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't checkout book" message:@"You need to provide a name before checking out your book" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Ok"]) {
        [self askForName];
    }
}

@end
