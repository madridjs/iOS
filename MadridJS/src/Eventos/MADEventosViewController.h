//
//  MADEventosViewController.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADBackend.h"
#import "MADMeetupPasadoViewCell.h"
#import "MADMeetupProximoViewCell.h"
#import "ER9AppDelegate.h"
#import "MADUtil.h"

@interface MADEventosViewController : UITableViewController <UIWebViewDelegate,UIWebViewDelegate,UITableViewDelegate>


@property MADBackend *backend;

@end

