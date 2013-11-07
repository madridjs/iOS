//
//  MADEventosVC.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADEventosVC.h"

@implementation MADEventosVC



-(void)viewDidLoad{
    ER9AppDelegate *appDelegada = (ER9AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.backend = appDelegada.backend;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MADMeetup *meet = self.backend.listado_eventos[indexPath.row];
    
    
    if ([meet.estado isEqualToString:@"past"]) {

        MADEventoViewCell *eventoCell = [collectionView dequeueReusableCellWithReuseIdentifier:meet.estado forIndexPath:indexPath];
        
        eventoCell.eventoNombre.text = meet.nombre;
        eventoCell.javascripter.text =  [NSString stringWithFormat:@"%d", meet.personas];
        eventoCell.estado.text = @"pasado";
    
        eventoCell.layer.borderColor = [UIColor blueColor].CGColor;
    
        
        return eventoCell;
    }
    
    if ([meet.estado isEqualToString:@"upcoming"]) {
        
        MADEventoProxViewCell *eventoCell = [collectionView dequeueReusableCellWithReuseIdentifier:meet.estado forIndexPath:indexPath];
        
        eventoCell.evento_nombre.text = meet.nombre;
        eventoCell.javascripter.text =  [NSString stringWithFormat:@"%d", meet.personas];
        eventoCell.estado.text = @"proximamente";
        
        eventoCell.Informacion.tag = indexPath.row;
        eventoCell.Mapa.tag = indexPath.row;
        eventoCell.calendario.tag = indexPath.row;
        
        //eventoCell.layer.cornerRadius = 2;
        //eventoCell.layer.borderWidth = 1;
        eventoCell.layer.borderColor = [UIColor redColor].CGColor;
        
        return eventoCell;
    }
    
    
    return NULL;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.backend.listado_eventos.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSString *ruta =  [segue identifier];
    UIViewController *destination = segue.destinationViewController;

    //NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];

    int index = 0;
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = sender;
        index = btn.tag;
    }
    
    MADMeetup *meet = [self.backend.listado_eventos objectAtIndex:index];
    
    
    if ([destination respondsToSelector:@selector(setDireccion:)]) {
        [destination setValue:meet.direccion forKey:@"direccion"];
        
    }
    
    if ([destination respondsToSelector:@selector(setTexto:)]) {
        [destination setValue:meet.descripcion forKey:@"texto"];
        
    }

}


- (IBAction)mostrarMapa:(id)sender {
    
    [self performSegueWithIdentifier:@"mapa" sender:sender];
}

- (IBAction)mostrarInformacion:(id)sender {
}
@end
