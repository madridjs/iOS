//
//  MADProximoTableViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADProximoTableViewController.h"

@implementation MADProximoTableViewController


-(void)viewDidAppear:(BOOL)animated{
    
    
    self.evento.text = self.meet.nombre;
    
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
    
    if ([destination respondsToSelector:@selector(setDireccion:)]) {
            [destination setValue:self.meet.direccion forKey:@"direccion"];
        
    }
    
    
    
    
}


@end
