//
//  Messages.m
//  Chris5
//
//  Created by Igor Zevaka on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Messages.h"
@implementation Message
@synthesize from,message, messageId; 
@end

@implementation Messages

-(void) addMessage:(Message*)message;
{
    [self executeUpdate:@"insert into messages(name, message) values (?, ?)", message.from, message.message];
    [self logError];
}

-(NSArray*) messages
{
    FMResultSet *result = [self executeQuery:@"select rowid, name, message from messages;"];
    NSMutableArray *messages = [NSMutableArray array];
    
    while ([result next]) {
        Message *m = [[Message alloc] init];
        
        m.messageId = [result objectForColumnIndex:0];
        m.from = [result stringForColumnIndex:1];
        m.message = [result stringForColumnIndex:2];
        [messages addObject:m];
    }
    return messages;
}

+ (Messages*)sharedInstance {
	
    static Messages* instance=nil;
    
	if (!instance) 
    {
		NSString* path = [self getSavePath];
        
		instance = [Messages databaseWithPath:path];
		[instance open];
        //create from scratch
        [instance makeTables];
	}
	return instance;
}

+ (NSString*) getSavePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    return [documentsDirectory stringByAppendingPathComponent:@"messages.sqlite"];
}

- (void) makeTables
{
    [self runCommandAndLog:@"create table if not exists messages"
     "(name text,"
     "message text)"];
}

- (void) runCommandAndLog: (NSString*)cmd
{
    [self executeUpdate:cmd];
    [self logError];
}
- (void) logError
{
    if ([self hadError])
    {
        NSLog(@"Error executing database query %@", self.lastErrorMessage);
    }
}
@end
