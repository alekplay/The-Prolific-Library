## The Prolific Library
###### Coding challenge for Prolific Interactive iOS Internship

---

This app queries a server to get the latest list of books available in the Prolific Library. 

By tapping on a book, you can either:

* Check it out, which means adding your name and current timestamp as the latest "checkout"
* Edit it, changing anything from title, to author, publisher, and tags
* Share it on Facebook and Twitter, including an automatically genereted link to Google's "I'm feeling lucky" search

By tapping on add, you can:

* Create a new book

By tapping on clear, you can:

* Delete all books from the server

By swiping right on a book, you can:

* Delete this book only

---

#### Implementation Details:

I used Apple's recommended `Model-View-Controller` architecture to lay out this app. The Groups in Xcode does not necessarily represent everything that they contain, but I tried to putting everything where it would make the most sense to keep the sidebar clean. 

The app consists of three controllers, one for the `tableview` displaying all books, one for the `detailview` displaying one book, and one for the `add/edit-view`. Each of these utilize a shared subclass of the `AFHTTPSessionManager` that handles all the server communication.

All books are of object `Book`, which is a subclass of `NSObject`. I have also subclassed `NSDateFormatter` to clean up some code in one of the controllers, and to reuse it other places in the app if that will be necessery in the future. 

I have also subclassed `UITableViewCell` to create a custom cell that fits better with the size and content of the app. In addition, I have subclassed the `UIActivityViewController` which is responsible for handling the sharing aspects of the app. This also generates a link to Google's "I'm feeling lucky" search, so when sharing on Facebook or Twitter the post is accompanied by a relevant link, most often to the purchase page on Amazon.

The app is made exclusively in `Objective-C`, using `AutoLayout` and `Storyboards`. It is iPhone 4+ compatible, and runs on iOS7. I believe I have implemented all features you required, following the wireframes closely. 

I have not done too much to change the UX/UI, as I'm currently very busy trying to get two Apple Watch apps out by its launch date, in addition to midterms and other schoolwork. However, I do have some ideas that I believe would look very good (mostly UI related). 

---

#### Attributions:

This app would not have been this easy without the fantastic [AFNetworking library](https://github.com/AFNetworking/AFNetworking)
