//
//  MADProximoTableViewController.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADMeetup.h"

@interface MADProximoTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *evento;
@property (strong, nonatomic) MADMeetup *meet;


@end
