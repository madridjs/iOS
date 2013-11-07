//
//  MADAutenticacionViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADAutenticacionViewController.h"





@implementation MADAutenticacionViewController



-(void)viewDidLoad{


    /*
     https://secure.meetup.com/oauth2/authorize
     ?client_id=YOUR_CONSUMER_KEY
     &response_type=code
     &redirect_uri=YOUR_CONSUMER_REDIRECT_URI
     */
    
    
    
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  /*
    NSString *token = @""; //[defaults objectForKey:MEETUP_PARAMETER_TOKEN];
    
    
    if ([token isEqual:@""]) {
        [_indicadorProgreso startAnimating];
        [self realizarAutenticacionOAuth];
    }else{
        
    }
    
    */


}


-(void)realizarAutenticacionOAuth{


    

    
}


-(void)viewDidAppear:(BOOL)animated{

   
    
    
    if (self.backend) {
        
        ER9AppDelegate *appDelegada = (ER9AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        dispatch_queue_t meetup_api_cola = dispatch_queue_create("MEETUP_EVENT_REST", NULL);
        
        dispatch_async(meetup_api_cola, ^{
           
            [self.backend getUltimosEventos:10];
            [self.backend getEventosPasados:10];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                appDelegada.backend = self.backend;
                [self performSegueWithIdentifier:@"eventos" sender:Nil];
            });
            
        });
   
      
    }else{

        
        [self performSegueWithIdentifier:@"login" sender:Nil];
        NSLog(@"Heinz");
    }


}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

  UIViewController *destination = segue.destinationViewController;

    
    if ([destination respondsToSelector:@selector(setDelegado:)]) {
        [destination setValue:self forKey:@"delegado"];
        
    }
    
    

}

@end
