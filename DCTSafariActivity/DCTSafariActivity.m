//
//  DCTSafariActivity.m
//  DCTSafariActivity
//
//  Created by Daniel Tull on 09.01.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "DCTSafariActivity.h"

@implementation DCTSafariActivity {
	NSURL *_URL;
}

- (NSString *)activityType {
	return [[NSBundle mainBundle] bundleIdentifier];
}

- (NSString *)activityTitle {
	return [[[self class] bundle] localizedStringForKey:@"Open in Safari" value:@"Open in Safari" table:nil];
}

- (UIImage *)activityImage {
	return [[self class] imageNamed:@"DCTSafariActivity"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
	return [self URLinActivityItems:activityItems] != nil;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
	_URL = [self URLinActivityItems:activityItems];
}

- (void)performActivity {
	[[UIApplication sharedApplication] openURL:_URL];
}

- (NSURL *)URLinActivityItems:(NSArray *)activityItems {
	__block NSURL *URL;
	[activityItems enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		*stop = [object isKindOfClass:[NSURL class]];
		if (*stop) URL = object;
	}];
	return URL;
}

+ (UIImage *)imageNamed:(NSString *)name {
	NSInteger scale = (NSInteger)[[UIScreen mainScreen] scale];
	NSBundle *bundle = [self bundle];
	NSString *device = @"";
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		device = @"~ipad";
	while (scale > 0) {
		NSString *scaleString = (scale == 1) ? @"" : [NSString stringWithFormat:@"@%ix", scale];
		NSString *resourceName = [NSString stringWithFormat:@"%@%@%@", name, device, scaleString];
		NSString *path = [bundle pathForResource:resourceName ofType:@"png"];
		UIImage *image = [UIImage imageWithContentsOfFile:path];
		if (image) return image;
		scale--;
	}
	return nil;
}

+ (NSBundle *)bundle {
	static NSBundle *bundle = nil;
	static dispatch_once_t bundleToken;
	dispatch_once(&bundleToken, ^{
		NSDirectoryEnumerator *enumerator = [[NSFileManager new] enumeratorAtURL:[[NSBundle mainBundle] bundleURL]
													  includingPropertiesForKeys:nil
																		 options:NSDirectoryEnumerationSkipsHiddenFiles
																	errorHandler:NULL];

		NSString *bundleName = [NSString stringWithFormat:@"%@.bundle", NSStringFromClass([self class])];
		for (NSURL *URL in enumerator)
			if ([[URL lastPathComponent] isEqualToString:bundleName])
				bundle = [NSBundle bundleWithURL:URL];
	});
	return bundle;
}

@end
