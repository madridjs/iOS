//
//  MADEventosVC.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 06/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADEventosVC.h"

@implementation MADEventosVC



-(MADEventoCalendario *)calendario{


    if (!_calendario) {
        _calendario = [[MADEventoCalendario alloc]init];
    }
    
    
    return _calendario;

}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    ER9AppDelegate *appDelegada = (ER9AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.backend = appDelegada.backend;
    
    
    
    self.calendario = appDelegada.calendario;
   
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.4 green:0.0 blue:0.0 alpha:0.5f];
    
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(actualizarEventos:) forControlEvents:UIControlEventValueChanged];
    
    [self.collectionView addSubview:refresh];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
     [self.calendario obtenerPermisos];



}



-(void)actualizarEventos:(id)sender{

    
    dispatch_queue_t meetup_api_cola = dispatch_queue_create("REFRESH_UPCOMING_EVENTS", NULL);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    
    dispatch_async(meetup_api_cola, ^{
     [self.backend getUltimosEventos:1];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
             [(UIRefreshControl *)sender endRefreshing];
        });
        
    });

}



-(void)actualizarEventosPasado{
    
    
    dispatch_queue_t meetup_api_cola = dispatch_queue_create("REFRESH_PAST_EVENTS", NULL);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    
    dispatch_async(meetup_api_cola, ^{
        [self.backend getEventosPasados:10];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
        
    });
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MADMeetup *meet = self.backend.listado_eventos[indexPath.row];
    
    
    if ([meet.estado isEqualToString:@"past"]) {

        MADEventoViewCell *eventoCell = [collectionView dequeueReusableCellWithReuseIdentifier:meet.estado forIndexPath:indexPath];
        
        eventoCell.eventoNombre.text = meet.nombre;
        eventoCell.javascripter.text =  [NSString stringWithFormat:@"%d", meet.personas];
        eventoCell.estado.text = @"pasado";
        eventoCell.fecha.text = [MADUtil construirFecha:meet.tiempo];
        eventoCell.layer.borderColor = [UIColor blueColor].CGColor;
    
        
        eventoCell.informacion.tag = indexPath.row;
        eventoCell.videos_link.tag = indexPath.row;
        eventoCell.documentos.tag = indexPath.row;

        
        if (indexPath.row == (self.backend.listado_eventos.count-2)) {
            NSLog(@"reach final");
            [self actualizarEventosPasado];
            
        }

        
        
        return eventoCell;
    }
    
    if ([meet.estado isEqualToString:@"upcoming"]) {
        
        MADEventoProxViewCell *eventoCell = [collectionView dequeueReusableCellWithReuseIdentifier:meet.estado forIndexPath:indexPath];
        
        eventoCell.evento_nombre.text = meet.nombre;
        eventoCell.javascripter.text =  [NSString stringWithFormat:@"%d", meet.personas];
        eventoCell.estado.text = @"proximamente";
        eventoCell.fecha.text = [MADUtil construirFecha:meet.tiempo];

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



-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    
    
    
    

    
                               
    if (buttonIndex == 0) {
        NSLog(@" actionSheet.tag --> %d",actionSheet.tag);
        
        MADMeetup *meet = [self.backend.listado_eventos objectAtIndex:actionSheet.tag];
        [self.calendario crearRecordatorio:meet];
        
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"MadridJS"
                                                         message:self.calendario.mensaje
                                                        delegate:self cancelButtonTitle:@"Aceptar"
                                               otherButtonTitles:nil, nil];
        [alerta show];
                                   
    }
}



- (IBAction)calendario:(id)sender {
    
    
    NSLog(@"tag-> %ld",(long)((UIView *)sender).tag);
    MADMeetup *meet = [self.backend.listado_eventos objectAtIndex:((UIView *)sender).tag];
    NSString *titulo = [NSString stringWithFormat:@"La fecha del evento es %@ ¿crear recordatorio?", [meet.tiempo description]];
    
    
    
    
    UIActionSheet *aInforme = [[UIActionSheet alloc]initWithTitle:titulo
                                                         delegate:self
                                                cancelButtonTitle:@"No Añadir gracias."                                           destructiveButtonTitle:Nil
                                                otherButtonTitles:@"Añadir a mi agenda.",nil];
    

    aInforme.tag = ((UIView *)sender).tag;
    
    [aInforme showInView:self.view];

    
}




- (IBAction)mostrarMapa:(id)sender {
    
    [self performSegueWithIdentifier:@"mapa" sender:sender];
}

- (IBAction)mostrarInformacion:(id)sender {
}
@end
