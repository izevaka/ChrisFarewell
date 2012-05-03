//
//  Messages.h
//  Chris5
//
//  Created by Igor Zevaka on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface Message : NSObject
@property (strong, nonatomic) NSString* from;
@property (strong, nonatomic) NSString* message;
@property (strong, nonatomic) NSNumber* messageId;
@property (strong, nonatomic) UIImage* photo;
@end

@interface Messages :  FMDatabase

//operations
-(void) addMessage:(Message*)message;
-(void) deleteMessage:(Message*)message;
@property (strong, nonatomic, readonly) NSArray* messages;


//internals
- (void) makeTables;
- (void) runCommandAndLog: (NSString*)cmd;
- (void) logError;

+ (Messages*)sharedInstance;
+ (NSString*) getSavePath;

@end
