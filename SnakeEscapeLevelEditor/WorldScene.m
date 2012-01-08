//
//  HelloWorldLayer.m
//  SnakeEscapeLevelEditor
//
//  Created by Lennart Hansen on 28.12.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "WorldScene.h"
#import "MathHelper.h"

// HelloWorldLayer implementation
@implementation WorldScene
@synthesize currentSprite,AstSprites,levelName,levelPack,levelZeit,nextLevelName,levelBreite,delegate,selectedRahmen;

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) 
    {
		CCSprite* bg = [CCSprite spriteWithFile:@"busch1.png"];
        CGSize size = [(CCDirectorMac*)[CCDirector sharedDirector] winSize];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg];
        HilfslinienSprites = [[NSMutableArray alloc]init];
        
        
        CCSprite* strich = [CCSprite spriteWithFile:@"strich.png"];
        strich.position =   ccp(480, 160);
        [self addChild:strich];
        
        CCSprite* strich2 = [CCSprite spriteWithFile:@"strich.png"];
        strich2.position =   ccp(480, 80);
        strich2.rotation = 90;
        [self addChild:strich2];

        CCSprite* strich3 = [CCSprite spriteWithFile:@"strich.png"];
        strich3.position =   ccp(480, 240);
        strich3.rotation = 90;
        [self addChild:strich3];
        
        CCSprite* strich4 = [CCSprite spriteWithFile:@"strich.png"];
        strich4.position =   ccp(80, 160);
        [self addChild:strich4];
        
        CCSprite* strich5 = [CCSprite spriteWithFile:@"strich.png"];
        strich5.position =   ccp(880, 160);
        [self addChild:strich5];
        
        CCSprite* strich6 = [CCSprite spriteWithFile:@"strich.png"];
        strich6.position =   ccp(400, 160);
        [self addChild:strich6];
        
        CCSprite* strich7 = [CCSprite spriteWithFile:@"strich.png"];
        strich7.position =   ccp(560, 160);
        [self addChild:strich7];
        
        HilfslinienSprites = [NSArray arrayWithObjects:strich,strich2,strich3,strich4,strich5,strich6,strich7, nil];
        [HilfslinienSprites retain];
        astLabels = [[NSMutableArray alloc]init];

        
    }
	return self;
}

-(void)addAstNormal;
{
    CCSprite* ast = [CCSprite spriteWithFile:@"AstNormalInaktiv.png"];
    ast.position = ccp(100,100);
    ast.tag = 2;
    [self addChild:ast];
    [AstSprites addObject:ast];
    [self AstLabelsgenerieren];
}
-(void)toggleHilfslinien
{
    for(CCSprite* linie in HilfslinienSprites)
    {
        if(linie.opacity == 0x00)
            linie.opacity = 0xFF;
        else
            linie.opacity = 0x00;
    }
}
-(void)addVerkohlterAst
{
    CCSprite* ast = [CCSprite spriteWithFile:@"VerkohlterAst.png"];
    ast.position = ccp(100,100);
    ast.tag = 3;
    [self addChild:ast];
    [AstSprites addObject:ast];
    [self AstLabelsgenerieren];

}
-(void)addStacheligerAst
{
    CCSprite* ast = [CCSprite spriteWithFile:@"StachelAst.png"];
    ast.position = ccp(100,100);
    ast.tag = 4;
    [self addChild:ast];
    [AstSprites addObject:ast];
    [self AstLabelsgenerieren];

}
-(void)addPortalExit
{
    CCSprite* ast = [CCSprite spriteWithFile:@"portal.png"];
    ast.position = ccp(150,280);
    ast.tag = 1;
    [self addChild:ast];
    [AstSprites addObject:ast];
    [self AstLabelsgenerieren];

}
-(void)addPortalEntry
{
    CCSprite* ast = [CCSprite spriteWithFile:@"portal-off.png"];
    ast.position = ccp(100,280);
    ast.tag = 0;
    [self addChild:ast];
    [AstSprites addObject:ast];
    currentSprite = ast;
    selectedRahmen = [CCSprite spriteWithFile:@"selected.png"];
    [self addChild:selectedRahmen];
    selectedRahmen.position = ast.position;
    [self AstLabelsgenerieren];

}
-(void)addAstHindernis
{
    CCSprite* ast = [CCSprite spriteWithFile:@"astHindernis.png"];
    ast.position = ccp(100,100);
    ast.tag = 5;
    [self addChild:ast];
    [AstSprites addObject:ast];
    [self AstLabelsgenerieren];

}
-(void)addAstSchalter
{
    CCSprite* ast = [CCSprite spriteWithFile:@"AstSchalter.png" rect:CGRectMake(1, 1, 50, 95)];
    ast.position = ccp(100,100);
    ast.tag = 6;
    [self addChild:ast];
    [AstSprites addObject:ast];

    NSValue *positionOffset = [NSValue valueWithPoint:NSMakePoint(0, 0)];
    NSNumber* rotationOffset = [NSNumber numberWithFloat:0.0];
    NSString* target = @"ast1";
    NSMutableArray* targetInfo = [[NSMutableArray alloc]initWithObjects:positionOffset,rotationOffset,target, nil];
    ast.userData = targetInfo;
    [self AstLabelsgenerieren];

}

-(BOOL)ccMouseDown:(NSEvent *)event
{
    CGPoint clickedAt;
    clickedAt = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
    currentSprite = nil;
    selectedRahmen.position = ccp(-1000,-2000);
    for(CCSprite* ast in AstSprites)
    {
        if([MathHelper IsCGPoint:clickedAt InRadius:30 OfPoint:ast.position])
        {
            currentSprite = ast;
            if(ast)
                selectedRahmen.position = ast.position;
            [self.delegate currentSpriteChanged];
        }
            
    }
    
    return YES;
}

-(BOOL)ccMouseUp:(NSEvent *)event
{
    [self AstLabelsgenerieren];

    return YES;

}

-(BOOL)ccMouseDragged:(NSEvent *)event
{
    CGPoint clickedAt;
    clickedAt = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
    currentSprite.position = clickedAt;
    if(currentSprite)
        selectedRahmen.position = currentSprite.position;
    [self AstLabelsgenerieren];
    return YES;
}

-(void)onEnter
{
    [[CCEventDispatcher sharedDispatcher]addMouseDelegate:self priority:0];
    [super onEnter];
    AstSprites = [[NSMutableArray alloc]init];
    [self addPortalEntry];
    [self addPortalExit];
    [self AstLabelsgenerieren];
}
-(void)onExit
{
    [super onExit];
}
-(void)AstLabelsgenerieren
{
    for(CCLabelTTF* label in astLabels)
    {        
        [self removeChild:label cleanup:YES];
    }
    
    
    int AstCounter = 1;
    for (CCSprite* ast in AstSprites)
    {
        if(ast.tag != 0 && ast.tag !=6) // PORTALENTRY ausschliessen
        {
            CCLabelTTF* astLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"ast%d",AstCounter] fontName:@"Helvetica" fontSize:12];
            [self addChild:astLabel];
            astLabel.position = ccp(ast.position.x,ast.position.y+20);
            [astLabels addObject:astLabel];
            AstCounter++;
        }
    }
    for (CCSprite* ast in AstSprites)
    {
        if(ast.tag == 6) // PORTALENTRY ausschliessen
        {
            CCLabelTTF* astLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"ast%d",AstCounter] fontName:@"Helvetica" fontSize:12];
            [self addChild:astLabel];
            astLabel.position = ccp(ast.position.x,ast.position.y+20);
            [astLabels addObject:astLabel];
            AstCounter++;
        }
    }

}
-(void)generieren
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NSTextDidEndEditingNotification object:nil];
    
    
    NSMutableString* implementationFile = [NSMutableString string];
    [implementationFile appendString:@"// \n"];
    [implementationFile appendString:[NSString stringWithFormat:@"//  %@.m\n",levelName]];
    [implementationFile appendString:@"//  Snake Escape\n//\n//  Created by Pix-Factory.\n//  Copyright 2011 Pix-Factory. All rights reserved.\n//\n\n"];
    [implementationFile appendFormat:@"#import \"%@.h\"\n",levelName];
    [implementationFile appendString:@"#import \"Credits.h\"\n"];
    [implementationFile appendFormat:@"#import \"%@.h\"\n\n",nextLevelName];    
    [implementationFile appendString:[NSString stringWithFormat:@"@implementation %@\n",levelName]];
    [implementationFile appendString:@"+(CCScene*)scene\n{\n"];
    [implementationFile appendString:[NSString stringWithFormat:@"\treturn [[%@ alloc]initWithBackGroundImageFile:@\"%@.png\" AndLevelWidth:%@];\n",levelName,levelName,levelBreite]];
    [implementationFile appendString:@"}\n"];
    [implementationFile appendString:@"+(NSArray *)getNeededHighScores\n{\n"];
    [implementationFile appendString:@"\tNSNumber* oneStar = [NSNumber numberWithInt:5000];\n"];
    [implementationFile appendString:@"\tNSNumber* twoStar = [NSNumber numberWithInt:10000];\n"];
    [implementationFile appendString:@"\tNSNumber* threeStar = [NSNumber numberWithInt:13000];\n"];
    [implementationFile appendString:@"\treturn [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];\n}\n"];
    [implementationFile appendString:@"-(void)LevelSetup\n{\n"];
    [implementationFile appendString:[NSString stringWithFormat:@"\tlevelPack = %@;\n",levelPack]];
    [implementationFile appendString:[NSString stringWithFormat:@"\tself.levelTimeout = %@;\n",levelZeit]];

    int AstCounter = 0 ;
    for(CCSprite* ast in AstSprites)
    {
        
        if(ast.tag == 0) // PORTALENTRY 
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\t[schlangeLayer setSchlangePosition:ccp(%f, %f)];\n\n",ast.position.x,ast.position.y]];
            AstCounter++;
        }
        
        if(ast.tag == 1) // PORTALEXIT 
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tPortalExit* ast%d = [[PortalExit alloc]init];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];        
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];    
            AstCounter++;

        }

        if(ast.tag == 2) // Normaler Ast 
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tAstNormal* ast%d = [[AstNormal alloc]init];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];        
            AstCounter++;

        }
        if(ast.tag == 3) // Verkohlter Ast
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tVerkohlterAst* ast%d = [[VerkohlterAst alloc]init];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];        
            AstCounter++;

        }
        if(ast.tag == 4) // Stachel Ast
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tStachelAst* ast%d = [[StachelAst alloc]init];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];        
            AstCounter++;

        }
        if(ast.tag == 5) // AstHindernis
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tAstHindernis* ast%d = [[AstHindernis alloc]init];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];        
            AstCounter++;

        }
        
    }
    
    for(CCSprite* ast in AstSprites)
    {
        if(ast.tag == 6)
        {
        
            NSValue* positionOffset = [(NSArray*)ast.userData objectAtIndex:0];
            NSNumber* rotationOffset = [(NSArray*)ast.userData objectAtIndex:1];
            NSString* target = [(NSArray*)ast.userData objectAtIndex:2];

            
            [implementationFile appendFormat:@"\tAstSchalter* ast%d = [[AstSchalter alloc]initWithTarget:%@ AndRotation:%f AndPosition:ccp(%f,%f)];\n",AstCounter,target,rotationOffset.floatValue,positionOffset.pointValue.x,positionOffset.pointValue.y];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];  
            AstCounter++;
        }
    }
    [implementationFile appendString:@"\t[astLayer addAeste:"];
    for(int i=1;i<AstSprites.count;i++)
    {
        [implementationFile appendString:[NSString stringWithFormat:@"ast%d,",i]];
    }
    [implementationFile appendString:@"nil];\n\n"];
    [implementationFile appendString:@"}\n"];

    [implementationFile appendString:@"-(void)nextLevel\n{\n"];
    [implementationFile appendString:[NSString stringWithFormat:@"\t[[CCDirector sharedDirector]replaceScene:[%@ scene]];\n}\n@end",nextLevelName]];
    

    NSMutableString* headerFile = [NSMutableString string];
    [headerFile appendFormat:@"//\n//  %@.h\n//  Snake Escape\n//\n//  Created by Pix-Factory\n//  Copyright 2011 Pix-Factory. All rights reserved.\n//\n\n",levelName];
    [headerFile appendFormat:@"#import <Foundation/Foundation.h>\n#import \"cocos2d.h\"\n#import \"BaseLevel.h\"\n\n"];
    [headerFile appendFormat:@"@interface %@ : BaseLevel\n{\n\n}\n\n@end\n",levelName];
    
    
    NSSavePanel* savePanel =  [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:[NSString stringWithFormat:@"%@",levelName]];
    [savePanel runModal];
    
    NSURL* implementationURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.m",[savePanel URL]]];
    NSURL* headerURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.h",[savePanel URL]]];

    [implementationFile writeToURL:implementationURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [headerFile writeToURL:headerURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end











