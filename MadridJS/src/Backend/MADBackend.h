//
//  MADBackend.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADMeetup.h"
#import "Constantes.h"

@class MADBackend;

/*
@protocol BackendDelegate <NSObject>

@optional
-(void)recuperarListaEventos:(NSArray *)listaEventos;

@end
*/

@interface MADBackend : NSObject <NSCoding>


@property NSString *token;
@property NSString *refresh_token;
@property (nonatomic) int token_expira_segundos;
@property NSMutableArray *listado_eventos;
@property NSDate *fechaExpiracion;


//@property (nonatomic, weak) id <BackendDelegate> delegate;


-(void)getUltimosEventos:(int)numero_of_eventos;
-(void)getEventosPasados:(int)numero_of_eventos;
-(id)initWithToken:(NSString *)tokenId;
-(void)parsearData:(NSData *)data;
-(void)revisarTokenAndRefrescar;
- (id)initWithCodigo:(NSString *)codigo;


//-(void)guardarToken;
+(MADBackend *)iniciarDesdeFichero;

@end
