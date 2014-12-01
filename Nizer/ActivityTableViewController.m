//
//  ActivityTableViewController.m
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import "ActivityTableViewController.h"

@interface ActivityTableViewController () {
    NSArray *activities;
    ApiBD *bd;
    
    NSDictionary *imageURLs;
}

@end


@implementation ActivityTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    bd = [ApiBD getSharedInstance];
    activities = [bd getActivities];
    
    imageURLs = [[NSDictionary alloc] initWithObjectsAndKeys:
                 @"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xfp1/v/t1.0-9/10417672_10152382426231986_776175205685495542_n.jpg?oh=3cf863683dc22b54a4af5ac47b475e03&oe=55041901&__gda__=1426826833_051fb1fc0d0e1e70b3f1145f8a3bab05", @"Work",
                 @"https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xaf1/v/t1.0-9/1507695_10152382427371986_2865981758027457610_n.jpg?oh=cd6876666d4a994137277f79df742f9f&oe=54D55E86&__gda__=1423194417_7f5d9894471aa04d7e125c4fea8ca1e6", @"School",
                 @"https://scontent-a-dfw.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/10600445_10152382415676986_1742701827263845868_n.jpg?oh=4e1a5a00ba8de1d4f91cceba13bb4440&oe=551DF060", @"Athletic",
                 @"https://scontent-a-dfw.xx.fbcdn.net/hphotos-xpa1/v/t1.0-9/10351320_10152382426236986_4861230843249376205_n.jpg?oh=3e9122d70f7dd050945d856b4eda335d&oe=55191AEA", @"Artistic",
                 @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xfa1/v/t1.0-9/10622864_10152382434981986_925683974272555287_n.jpg?oh=ac583cd4c2904dcb4d277fc0e01b380b&oe=54D3EAF4&__gda__=1427459455_a706eaff33ce969c30e07c757f142eb3", @"Fun",
                 @"https://scontent-b-dfw.xx.fbcdn.net/hphotos-xap1/v/t1.0-9/10253853_10152382438796986_3143754855293109642_n.jpg?oh=d619055e22d6156fbd8cb31ea0bb0da6&oe=5503EF9D", @"Entertainment",
                 @"https://scontent-a-dfw.xx.fbcdn.net/hphotos-xap1/v/t1.0-9/10480225_10152382432251986_6115265794701888256_n.jpg?oh=9b0410be8b4f56807eedd1f43a40d1ed&oe=550156A0", @"Shopping",
                 nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [activities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Activity" forIndexPath:indexPath];
    Activity *activity = activities[[indexPath row]];
    
    cell.nameLabel.text = [activity name];
    
    [cell loadWebViewImage:[imageURLs objectForKey:activity.category]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openActivity"]) {
        [(TimerViewController*)[segue destinationViewController] setActivity:activities[[[self.tableView indexPathForSelectedRow] row]]];
    }
}

- (IBAction)unwindToActivityTableViewController:(UIStoryboardSegue *)segue {
    activities = [bd getActivities];
    [self.tableView reloadData];
}


@end
