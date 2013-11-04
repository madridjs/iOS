//
//  MADEventosViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//
#import "MADEventosViewController.h"

@implementation MADEventosViewController 




-(void)viewDidLoad{
    


    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MADMeetup *meet = self.backend.listado_eventos[indexPath.row];
    
    MADMeetupPasadoViewCell *celda = [tableView dequeueReusableCellWithIdentifier:@"evento_past"];

    
    if (!celda) {
        celda = [[MADMeetupPasadoViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"evento_past"];
      
    }
    celda.evento.text = meet.nombre;
    celda.personas.text = [NSString stringWithFormat:@"%i", meet.personas];
    
    return celda;   
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    int count = self.backend.listado_eventos.count;
    
    return count;//[self.backend.listado_eventos count];
}




@end
