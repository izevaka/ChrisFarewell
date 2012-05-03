//
//  chubbsMasterViewController.m
//  Chris5
//
//  Created by Igor Zevaka on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "chubbsDetailViewController.h"
#import "chubbsMasterViewController.h"
#import "Messages.h"

@implementation chubbsMasterViewController

@synthesize detailViewController = _detailViewController;


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (chubbsDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
    
    UIImageView *chris = [[UIImageView alloc] init];
    chris.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"chrishulbertclosed.png"], [UIImage imageNamed:@"chrishulbertopen.png"], nil]; 
    chris.animationDuration = .2; 
    chris.animationRepeatCount =0;      
    chris.frame = CGRectMake(0, 0, 36, 42);
    [chris startAnimating];
        
    self.navigationItem.titleView = chris;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    messages = [[Messages sharedInstance] messages];

    return messages.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel *textLabel = (UILabel*)[cell viewWithTag:102];
    Message* message = [messages objectAtIndex:indexPath.row];
    textLabel.text = message.from;
    
    UIImageView *chris = (UIImageView*)[cell viewWithTag:100];
    
    if (!message.photo) {
        
        if (!chris.animationImages) {
            chris.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"chrishulbertclosed.png"], [UIImage imageNamed:@"chrishulbertopen.png"], nil]; 
            chris.animationDuration = (arc4random() % 10) / 50.0 + 0.3 ; 
            chris.animationRepeatCount =0;      
        }
        
        if (!chris.isAnimating)
        {
            [chris startAnimating];
        }
    } else {
        chris.animationImages = nil;
        chris.image = message.photo;
    }
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell* cell = sender;
    NSInteger row = [self.tableView indexPathForCell:cell].row;
    
	if ([segue.identifier isEqualToString:@"AddMessage"] || [segue.identifier isEqualToString:@"EditWholeMessage"])
	{
		UINavigationController *navigationController = 
        segue.destinationViewController;
		NewMessageController  *newMessageController = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
        
		newMessageController.delegate = self;
        
        if ([segue.identifier isEqualToString:@"EditWholeMessage"])
        {
            newMessageController.message = [messages objectAtIndex:row];
        }
	}
    
    if ([segue.identifier isEqualToString:@"ShowMessage"])
    {   
		chubbsDetailViewController  *detailsController = segue.destinationViewController;
        detailsController.detailItem = [messages objectAtIndex:row];
    }
    
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.isEditing) {
        [self performSegueWithIdentifier:@"EditWholeMessage" sender:[tableView cellForRowAtIndexPath:indexPath] ];
    } else {
        [self performSegueWithIdentifier:@"ShowMessage" sender:[tableView cellForRowAtIndexPath:indexPath]];        
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (void) detailsControllerDidCancel:(NewMessageController*)controller
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void) detailsControllerDidSave:(NewMessageController*)controller
{
    [[Messages sharedInstance] addMessage:controller.message];
    [self dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (IBAction)edit:(id)sender
{
    if (self.tableView.isEditing) 
    {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit:)];
    }
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        [[Messages sharedInstance] deleteMessage: [messages objectAtIndex: indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
