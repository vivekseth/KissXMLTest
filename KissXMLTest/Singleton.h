//
//  Singleton.h
//  KissXMLTest
//
//  Created by Vivek Seth on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject {
    
}

@property (nonatomic, retain) NSString *SelectedBodyHTML;
@property (nonatomic, retain) NSString *SelectedBodyTitle;

+(Singleton*)sharedSingleton;
-(void)sayHello;
@end
