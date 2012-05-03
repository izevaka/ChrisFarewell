//
//  chubbsDetailViewController.h
//  Chris5
//
//  Created by Igor Zevaka on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Message;

@interface chubbsDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Message* detailItem;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;


@end
