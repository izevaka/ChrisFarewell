//
//  chubbsMasterViewController.h
//  Chris5
//
//  Created by Igor Zevaka on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMessageController.h"

@class chubbsDetailViewController;

@interface chubbsMasterViewController : UITableViewController<NewMessageControllerDelegate> {
    NSArray *messages;
}

@property (strong, nonatomic) chubbsDetailViewController *detailViewController;


@end
