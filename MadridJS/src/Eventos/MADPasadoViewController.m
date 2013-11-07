//
//  MADPasadoViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 04/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADPasadoViewController.h"

@implementation MADPasadoViewController

-(void)viewDidLoad{

    //self.reader.layer.cornerRadius = 7;
    
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    NSMutableString *buffer = [[NSMutableString alloc]initWithString: _texto];
    
    for (int x = 0; x<2; x++) {
        [buffer appendString:@"<br></br>"];
    }
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[buffer dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    UIFont *fuente =  [UIFont fontWithName:@"Trebuchet MS" size:15.0f];
    self.textformatted.font = fuente;
    self.textformatted.attributedText = attributedString;

}


@end
