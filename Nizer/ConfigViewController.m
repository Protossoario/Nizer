//
//  ConfigViewController.m
//  Nizer
//
//  Created by Eduardo Alberto Sanchez Alvarado on 11/6/14.
//  Copyright (c) 2014 Eduardo Alberto Sanchez Alvarado. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fbButton:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //set initial message
        [facebookController setInitialText:@"¡Prueba Nizer y organízate junto conmigo!"];
        
        //present the controller to the user
        [self presentViewController:facebookController animated:YES completion:nil];
        
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook Error" message:@"You may not have set Facebook correctly on your device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)twButton:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        //set initial message
        [twitterController setInitialText:@"¡Prueba la nueva aplicación de Nizer y organiza tus actividades!"];
        
        
        //present the controller to the user
        [self presentViewController:twitterController animated:YES completion:nil];
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitter Error" message:@"You may not have set Twitter correctl on your device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}
@end
