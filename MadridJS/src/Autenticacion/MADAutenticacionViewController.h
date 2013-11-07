//
//  MADAutenticacionViewController.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADBackend.h"
#import "MADEventosViewController.h"
#import "MADLoginViewController.h"
#import "ER9AppDelegate.h"


@interface MADAutenticacionViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicadorProgreso;


//@property UIWebView *navegadorOAuth;
@property MADBackend *backend;


@end
