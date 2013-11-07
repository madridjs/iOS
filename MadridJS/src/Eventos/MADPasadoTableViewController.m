//
//  MADPasadoTableViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 04/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADPasadoTableViewController.h"

@implementation MADPasadoTableViewController


-(void)viewDidAppear:(BOOL)animated{


    self.evento.text = self.meet.nombre;
    self.fecha.text  = [MADUtil construirFecha: self.meet.tiempo];
    
    
    
}





-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{

    NSLog(@"test %@",identifier);

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    NSString *ruta =  [segue identifier];
    UIViewController *destination = segue.destinationViewController;
   
    
    
    
    if ([destination respondsToSelector:@selector(setTexto:)]) {
       
        if ([ruta isEqualToString:@"descripcion"]) {
            [destination setValue:self.meet.desc_charla forKey:@"texto"];
        }
        
        if ([ruta isEqualToString:@"biografia"]) {
            [destination setValue:self.meet.bio_charla forKey:@"texto"];
        }
    }
    
    
}


@end
