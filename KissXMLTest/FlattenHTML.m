//
//  FlattenHTML.m
//  KissXMLTest
//
//  Created by Vivek Seth on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlattenHTML.h"

@implementation FlattenHTML

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
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //

    //NSMutableArray * hello;
    
    //[hello ]
    
//    [[NSArray arrayWithObjects:nil] mutableCopy]
    
    return html;
    
}



@end
