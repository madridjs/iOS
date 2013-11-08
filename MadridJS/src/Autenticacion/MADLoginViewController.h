//
//  MADLoginViewController.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 04/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADBackend.h"
#import "Constantes.h"
#import "MADUtil.h"

@interface MADLoginViewController : UIViewController  <UIWebViewDelegate>


@property (strong, nonatomic) NSData *datos;
@property (weak, nonatomic) IBOutlet UIWebView *navegadorWeb;
@property (weak, nonatomic) id delegado;


@end
