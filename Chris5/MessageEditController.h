//
//  MessageEditController.h
//  Chris5
//
//  Created by Igor Zevaka on 3/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageEditController;

@protocol MessageEditControllerDelegate <NSObject>

- (void) messageControllerDidCancel:(MessageEditController*)controller;
- (void) messageControllerDidSave:(MessageEditController*)controller;

@end

@interface MessageEditController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView* textView;
@property (weak, nonatomic) id<MessageEditControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
