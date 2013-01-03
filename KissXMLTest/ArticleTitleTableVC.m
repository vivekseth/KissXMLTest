//
//  ArticleTitleTableVC.m
//  KissXMLTest
//
//  Created by Vivek Seth on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleTitleTableVC.h"
#include "DDXML.h"
#include "Singleton.h"
#import "FlattenHTML.h"


@implementation ArticleTitleTableVC
@synthesize ActivityIndicator = _ActivityIndicator;

@synthesize ArticleTitles = _ArticleTitles;
@synthesize ArticleBodiesHTML = _ArticleBodiesHTML;
@synthesize ArticleBodiesText = _ArticleBodiesText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self RefreshListings:nil];
}

- (void)viewDidUnload
{
    [self setActivityIndicator:nil];
    [super viewDidUnload];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ArticleTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleTitleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.ArticleTitles objectAtIndex:indexPath.row] stringValue];
    cell.detailTextLabel.text = [self.ArticleBodiesText objectAtIndex:indexPath.row];
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToDetailView"])
    {
        [Singleton sharedSingleton].SelectedBodyHTML = [[self.ArticleBodiesHTML objectAtIndex:[self.tableView indexPathForSelectedRow].row] stringValue];
        [Singleton sharedSingleton].SelectedBodyTitle =    [[self.ArticleTitles objectAtIndex:[self.tableView indexPathForSelectedRow].row] stringValue];
    }
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //[Data sharedData].SelectedArticleBody = [[[Data sharedData].ArticleBodyArray objectAtIndex:indexPath.row] stringValue];
    
    //NSLog(@"%@", [Data sharedData].SelectedArticleBody);
    
    
}

- (IBAction)RefreshListings:(id)sender {
    
    NSString *tmp = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://lifehacker.com/vip.xml"] encoding:NSUTF8StringEncoding error:nil];
    NSData *xmlData = [tmp dataUsingEncoding:NSUTF8StringEncoding];
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    
    self.title = [[[xmlDoc nodesForXPath:@"//channel/title" error:nil] objectAtIndex:0] stringValue];
    
    NSArray *ArticleTitleArray = [xmlDoc nodesForXPath:@"//channel/item/title" error:nil];
    NSLog(@"%i", [ArticleTitleArray count]);
    self.ArticleTitles = [ArticleTitleArray mutableCopy];
    
    self.ArticleBodiesHTML = [[xmlDoc nodesForXPath:@"//channel/item/description" error:nil] mutableCopy];
    NSLog(@"%i", [self.ArticleBodiesHTML count]);
    
    NSMutableArray *TempArticleBodiesText = [[NSMutableArray alloc] init];
    NSLog(@"%i", [TempArticleBodiesText count]);
    
    for (int i = 0; i<[self.ArticleBodiesHTML count]; i++) {
        NSLog(@"%@", @"");
        NSLog(@"%@", @"");
        NSLog(@"%@", @"");
        NSLog(@"%@", @"");
        
        NSString *PreEditedText = [[self.ArticleBodiesHTML objectAtIndex:i] stringValue];
        NSString *CleanBodyText = [self flattenHTML:PreEditedText];
        NSString *TrimmedAndCleanBodyText = [CleanBodyText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ];
        
        NSLog(@"%@", TrimmedAndCleanBodyText);
        
        [TempArticleBodiesText addObject:TrimmedAndCleanBodyText];
        
    }
    NSLog(@"%i", [TempArticleBodiesText count]);
    
    self.ArticleBodiesText = TempArticleBodiesText;
    
    NSLog(@"%i", [self.ArticleBodiesText count]);
    [self.tableView reloadData];
    
    //[self.ActivityIndicator stopAnimating];
    
}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *thescanner;
    NSString *text = nil;
    
    thescanner = [NSScanner scannerWithString:html];
    
    while ([thescanner isAtEnd] == NO) {
        
        // find start of tag
        [thescanner scanUpToString:@"<" intoString:NULL] ; 
        
        // find end of tag
        [thescanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@>", text] withString:@" "];
        
    } // while //
    
    return html;
    
}


@end
