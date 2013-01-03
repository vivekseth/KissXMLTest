//
//  DetailViewVC.m
//  KissXMLTest
//
//  Created by Vivek Seth on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewVC.h"
#include "DDXML.h"
#include "Singleton.h"


@implementation DetailViewVC
@synthesize DetailViewWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
    //[self.DetailViewWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.giftof5.org"]]];
    self.title = [Singleton sharedSingleton].SelectedBodyTitle;
    [self.DetailViewWebView loadHTMLString:[Singleton sharedSingleton].SelectedBodyHTML baseURL:nil];
    
    
}

- (void)viewDidUnload
{
    [self setDetailViewWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //return YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
