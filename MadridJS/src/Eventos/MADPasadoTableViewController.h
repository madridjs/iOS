//
//  MADPasadoTableViewController.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 04/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADMeetup.h"
#import "MADUtil.h"


@interface MADPasadoTableViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UILabel *evento;
@property (weak, nonatomic) IBOutlet UILabel *fecha;
@property (strong, nonatomic) MADMeetup *meet;





@end
