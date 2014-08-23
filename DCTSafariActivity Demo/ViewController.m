//
//  ViewController.m
//  DCTSafariActivity
//
//  Created by Daniel Tull on 09.01.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

@import DCTSafariActivity;
#import "ViewController.h"

@interface ViewController () <UIPopoverControllerDelegate>
@property (nonatomic) UIPopoverController *popover;
@end

@implementation ViewController

- (IBAction)showActivities:(UIButton *)sender {

	NSArray *items = @[[NSURL URLWithString:@"http://apple.com"]];
	NSArray *activities = @[[DCTSafariActivity new]];

	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
																						 applicationActivities:activities];

	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
		[self presentViewController:activityViewController animated:YES completion:NULL];
		return;
	}

	self.popover = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
	self.popover.delegate = self;

	[self.popover presentPopoverFromRect:sender.frame
								  inView:self.view
				permittedArrowDirections:UIPopoverArrowDirectionAny
								animated:YES];
	self.popover.passthroughViews = @[];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
	self.popover = nil;
}

@end
