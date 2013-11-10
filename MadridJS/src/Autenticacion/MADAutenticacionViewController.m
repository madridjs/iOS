//
//  MADAutenticacionViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADAutenticacionViewController.h"





@implementation MADAutenticacionViewController


ER9AppDelegate *appDelegada;
-(void)viewDidLoad{

    appDelegada = (ER9AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    _backend = [MADBackend iniciarDesdeFichero];
    _calendario = [MADEventoCalendario iniciarDesdeFichero];

    
    
    if (!self.backend) {
        NSLog(@"No hay token hay que pedir uno a [Meetup]");
    }
    
    if (!self.calendario) {
        NSLog(@"No hay calendario va ver que hacer uno");
    }
    
    
    
    
}


-(void)viewDidAppear:(BOOL)animated{

   
    
    
    if (self.backend) {
        
        
        dispatch_queue_t meetup_api_cola = dispatch_queue_create("MEETUP_EVENT_REST", NULL);
        
        dispatch_async(meetup_api_cola, ^{
           [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
         
            [self.backend getUltimosEventos:10];
            [self.backend getEventosPasados:10];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                appDelegada.calendario =self.calendario;
                appDelegada.backend = self.backend;
             
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
