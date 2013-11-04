//
//  MADAutenticacionViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADAutenticacionViewController.h"


#define MEETUP_AUTHENTICATE_URL @"https://secure.meetup.com/oauth2/authorize"

#define MEETUP_CLIENT_ID @"u4ts648g220dch7tppat121i2r"

#define MEETUP_CLIENT_SECRET @"4a01f783b381733772e444a6b1873b"

#define MEETUP_REDIRECT_URI @"http://www.madridjs.org"

#define MEETUP_PARAMETER_TOKEN @"access_token"

@implementation MADAutenticacionViewController



-(void)viewDidLoad{


    /*
     https://secure.meetup.com/oauth2/authorize
     ?client_id=YOUR_CONSUMER_KEY
     &response_type=code
     &redirect_uri=YOUR_CONSUMER_REDIRECT_URI
     */
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults objectForKey:MEETUP_PARAMETER_TOKEN];
    
    
    if (![token isEqual:@""]) {
        [_indicadorProgreso startAnimating];
        [self realizarAutenticacionOAuth];
    }else{
        
    }
    
    
    


}


-(void)realizarAutenticacionOAuth{


    
    NSString *autenticarURLString= [NSString stringWithFormat:@"%@?client_id=%@&response_type=token&redirect_uri=%@", MEETUP_AUTHENTICATE_URL, MEETUP_CLIENT_ID, MEETUP_REDIRECT_URI];
    
    NSLog(@"url-> %@",autenticarURLString);
    
    
    
    NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:autenticarURLString]];
    
    
    
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:webRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ([data length] > 0 && error == nil){
                                   [self performSegueWithIdentifier:@"eventos" sender:data];
                          
                               }
                               else if (error != nil) NSLog(@"Error: %@", error);
    }];
    
}





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

  UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setBackend:)]) {
     [destination setValue:_backend forKey:@"backend"];
        
    }
    
    if ([destination respondsToSelector:@selector(setDatos:)]) {
        NSData *data = sender;
        [destination setValue:data forKey:@"datos"];
        
    }
    
    

}

@end
