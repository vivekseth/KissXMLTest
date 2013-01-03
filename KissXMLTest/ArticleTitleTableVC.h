//
//  ArticleTitleTableVC.h
//  KissXMLTest
//
//  Created by Vivek Seth on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTitleTableVC : UITableViewController

@property (nonatomic, retain) NSMutableArray *ArticleTitles;
@property (nonatomic, retain) NSMutableArray *ArticleBodiesHTML;
@property (nonatomic, retain) NSMutableArray *ArticleBodiesText;
- (IBAction)RefreshListings:(id)sender;
- (NSString *)flattenHTML:(NSString *)html;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;

@end
