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
    ER9AppDelegate *appDelegada = (ER9AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.backend = appDelegada.backend;

}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MADMeetup *meet = self.backend.listado_eventos[indexPath.row];
    
    
    if ([meet.estado isEqualToString:@"upcoming"]) {
        MADMeetupProximoViewCell *celda = [tableView dequeueReusableCellWithIdentifier:meet.estado];
       /* celda.evento_prox.text = meet.nombre;
        celda.personas.text = [NSString stringWithFormat:@"%i", meet.personas];
        celda.fecha.text = [ MADUtil construirFecha:meet.tiempo];
        celda.direccion.text = @"Calle silicio";//meet.how_to_find;
        */
        
        celda.proximo_evento.text =  meet.nombre;
        celda.punto_encuentro.text = meet.direccion.direccion;
    
        return celda;
    }
    
    if ([meet.estado isEqualToString:@"past"]) {
        
        MADMeetupPasadoViewCell *celda = [tableView dequeueReusableCellWithIdentifier:meet.estado];
       /* celda.evento.text = meet.nombre;
        celda.personas.text = [NSString stringWithFormat:@"%i", meet.personas];
        celda.fecha.text = [MADUtil construirFecha:meet.tiempo];
        */
        celda.evento_pasado.text = meet.nombre;
        celda.punto_encuentro.text = meet.direccion.direccion;
        
        return celda;
        
    }
    //NSLog(@"-> %@",[meet.tiempo description]);
    
    return NULL;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    int count = self.backend.listado_eventos.count;
    
    return count;//[self.backend.listado_eventos count];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setMeet:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        MADMeetup *meet = [self.backend.listado_eventos objectAtIndex:indexPath.row];
        [destination setValue:meet forKey:@"meet"];
    }
    
    


}



@end
