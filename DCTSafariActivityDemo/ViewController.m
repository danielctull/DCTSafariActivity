//
//  ViewController.m
//  DCTSafariActivity
//
//  Created by Daniel Tull on 09.01.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "ViewController.h"
#import <DCTSafariActivity/DCTSafariActivity.h>

@implementation ViewController

- (IBAction)showActivities:(id)sender {

	NSArray *items = @[[NSURL URLWithString:@"http://apple.com"]];
	NSArray *activities = @[[DCTSafariActivity new]];

	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
																						 applicationActivities:activities];

	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
		[self presentViewController:activityViewController animated:YES completion:NULL];
		return;
	}


}

@end
