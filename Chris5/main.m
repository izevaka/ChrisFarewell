//
//  main.m
//  Chris5
//
//  Created by Igor Zevaka on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "chubbsAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        @try { 
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([chubbsAppDelegate class]));
        }
        @catch(NSException *ex) {
            NSLog(@"%@\n\n%@", ex.reason, ex.callStackSymbols);
        }
    }
}
