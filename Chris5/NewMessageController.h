//
//  NewMessageController.h
//  Chris5
//
//  Created by Igor Zevaka on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageEditController.h"

@class NewMessageController;
@class Message;



@protocol NewMessageControllerDelegate <NSObject, MessageEditControllerDelegate, UITextFieldDelegate>

- (void) detailsControllerDidCancel:(NewMessageController*)controller;
- (void) detailsControllerDidSave:(NewMessageController*)controller;

@end

@interface NewMessageController : UIViewController< UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) id<NewMessageControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UITextField *fromTextField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UIButton *buttonCamera;
@property (strong, nonatomic) Message *message;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)showCamera:(id)sender;

@end
