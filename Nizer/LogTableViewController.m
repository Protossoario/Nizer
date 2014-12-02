//
//  LogTableViewController.m
//  Nizer
//
//  Created by Equipo Nizer on 11/6/14.
//  Copyright (c) 2014 Equipo Nizer. All rights reserved.
//

#import "LogTableViewController.h"

@interface LogTableViewController () {
    NSArray *activities;
}

@end

@implementation LogTableViewController

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
    self.bd = [ApiBD getSharedInstance];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    activities = [self.bd getActivities];
    [self.tableView reloadData];
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
    return [activities count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [(Activity *)[activities objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[(Activity*)[activities objectAtIndex:section] timeLogs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeLog" forIndexPath:indexPath];
    NSArray *timelogs = [[[activities objectAtIndex:[indexPath section]] timeLogs] allObjects];
    timelogs = [timelogs sortedArrayUsingComparator:^(id obj1, id obj2) {
        TimeLog *timelog1 = obj1;
        TimeLog *timelog2 = obj2;
        return [timelog1.startDate compare:timelog2.startDate];
    }];
    TimeLog *timelog = timelogs[[indexPath row]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
    NSString *startDate = [dateFormatter stringFromDate:timelog.startDate];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *duration = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timelog.duration doubleValue]]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", startDate, duration];
    
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
    if ([[segue identifier] isEqualToString:@"openNotes"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *timelogs = [[[activities objectAtIndex:[indexPath section]] timeLogs] allObjects];
        TimeLog *timelog = timelogs[[indexPath row]];
        [(NotesTableViewController *)[segue destinationViewController] setTimelog:timelog];
    }
}

@end
