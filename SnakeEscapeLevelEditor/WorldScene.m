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
        background = [CCLayer node];
        [self addChild:background];
        backgroundImageName = @"busch1.png";
		bg = [CCSprite spriteWithFile:backgroundImageName];
        CGSize size = [(CCDirectorMac*)[CCDirector sharedDirector] winSize];
        bg.position = ccp(size.width/2,size.height/2);
        [background addChild:bg];
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
-(void)changeBackGroundTo:(int)buschNummer
{
    backgroundImageName = [NSString stringWithFormat:@"busch%d.png",buschNummer];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:backgroundImageName];
    [bg setTexture:tex];
}
-(void)addStein
{
    CCSprite* stein = [CCSprite spriteWithFile:@"stein1.png"];
    stein.position = ccp(100,100);
    stein.tag = 17;
    int steinnr = 1;
    stein.userData = [NSNumber numberWithInt:steinnr];
    [background addChild:stein];
    [AstSprites addObject:stein];
    [self AstLabelsgenerieren];
}
-(void)addBaum
{
    CCSprite* baum = [CCSprite spriteWithFile:@"baum1.png"];
    baum.position = ccp(100,100);
    baum.tag = 15;
    baum.userData = @"baum1";
    [background addChild:baum];
    [AstSprites addObject:baum];
    [self AstLabelsgenerieren];
}
-(void)addBaumkrone
{
    CCSprite* baum = [CCSprite spriteWithFile:@"baumkrone_1.png"];
    baum.position = ccp(480,200);
    baum.tag = 16;
    baum.userData = @"baumkrone_1";
    [background addChild:baum];
    [AstSprites addObject:baum];
    [self AstLabelsgenerieren];
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
-(void)addBaumharz
{
    CCSprite* ast = [CCSprite spriteWithFile:@"harz.png"];
    ast.position = ccp(100,100);
    ast.tag = 9;
    [self addChild:ast];
    [AstSprites addObject:ast];
    [self AstLabelsgenerieren];
}
-(void)addRutschigerAst
{
    CCSprite* ast = [CCSprite spriteWithFile:@"rutschigerAst.png"];
    ast.position = ccp(100,100);
    ast.tag = 7;
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
-(void)addAstKatapult
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AstKatapult.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AstKatapult.png"];
    [self addChild:spriteSheet];
    CCSprite* ast = [CCSprite spriteWithSpriteFrameName:@"astkatapult1"];
    [self addChild:ast];
    ast.position = ccp(100,100);
    ast.tag = 8;
    [AstSprites addObject:ast];
    [self AstLabelsgenerieren];

}
-(void)addAffe
{    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"affe.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"affe.png"];
    [self addChild:spriteSheet];
    CCSprite* affe = [CCSprite spriteWithSpriteFrameName:@"affe0"];
    [self addChild:affe];
    affe.tag = 10;
    
    affe.position = ccp(100,100);
    [AstSprites addObject:affe];
    [self AstLabelsgenerieren];
    
}
-(void)addSpinne
{

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"spinne.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"spinne.png"];
    [self addChild:spriteSheet];
    CCSprite* spinne = [CCSprite spriteWithSpriteFrameName:@"spinne0"];
    [self addChild:spinne];
    spinne.tag = 11;
    
    spinne.position = ccp(100,100);
    [AstSprites addObject:spinne];
    [self AstLabelsgenerieren];

    
}
-(void)addVogel
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"vogel.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"vogel.png"];
    [self addChild:spriteSheet];
    CCSprite* vogel = [CCSprite spriteWithSpriteFrameName:@"vogel0"];
    [self addChild:vogel];
    vogel.tag = 12;
    
    vogel.position = ccp(250,280);
    [AstSprites addObject:vogel];
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
-(void)addFeuer
{
    CCSprite* feuer = [CCSprite spriteWithFile:@"feuer.png"];
    feuer.position = ccp(100,100);
    feuer.tag = 13;
    [self addChild:feuer];
    [AstSprites addObject:feuer];
    [self AstLabelsgenerieren];
}
-(void)addWasserfall
{
    CCSprite* wasserfall = [CCSprite spriteWithFile:@"wasserfall.png"];
    wasserfall.position = ccp(100,100);
    wasserfall.tag = 14;
    [self addChild:wasserfall];
    [AstSprites addObject:wasserfall];
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
        }
            
    }
    [self.delegate currentSpriteChanged];

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
        if(ast.tag < 9 && ast.tag != 0) // PORTALENTRY,Baumharz,Tier usw. ausschliessen
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
    [implementationFile appendString:[NSString stringWithFormat:@"\treturn [[%@ alloc]initWithBackGroundImageFile:@\"%@\" AndLevelWidth:%@];\n",levelName,backgroundImageName,levelBreite]];
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
    int itemCounter = 0;
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
            [implementationFile appendString:[NSString stringWithFormat:@"\tAstHindernis* ast%d = [[AstHindernis alloc]initWithWorld:world];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];        
            AstCounter++;

        }
        if(ast.tag == 7) // Rutschiger Ast
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tRutschiger_Ast* ast%d = [[Rutschiger_Ast alloc]init];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];        
            AstCounter++;
            
        }
        if(ast.tag == 8) // AstKatapult
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tAstKatapult* ast%d = [[AstKatapult alloc]init];\n",AstCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.position = ccp(%f, %f);\n",AstCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tast%d.rotation = %f;\n\n",AstCounter,ast.rotation]];        
            AstCounter++;
            
        }
        if(ast.tag == 9) // Baumharz
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tBaumharz* harz%d = [[Baumharz alloc]initWithWorld:world];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tharz%d.position = ccp(%f, %f);\n",itemCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tharz%d.rotation = %f;\n",itemCounter,ast.rotation]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addChild:harz%d];\n\n",itemCounter]];   
            itemCounter++;
        }
        
        if(ast.tag == 10) // Affe
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tAffe* affe%d = [[Affe alloc]initWithWorld:world AndDelegate:self];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\taffe%d.position = ccp(%f, %f);\n",itemCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addToFrameUpdate:affe%d,nil];\n",itemCounter]];        
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addChild:affe%d];\n\n",itemCounter]];  
            itemCounter++;
        }
        
        if(ast.tag == 11) // Spinne
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tSpinne* spinne%d = [[Spinne alloc]initWithWorld:world];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[spinne%d setAnkerPosition:ccp(%f, 480.0)];\n",itemCounter,ast.position.x]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tspinne%d.joint->SetLimits(-200/PTM_RATIO, -100.0/PTM_RATIO);\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addToFrameUpdate:spinne%d,nil];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addChild:spinne%d];\n\n",itemCounter]];  
            itemCounter++;
        }
        
        if(ast.tag == 12) // Vogel
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tVogel* vogel%d = [[Vogel alloc]init];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tvogel%d.position = ccp(%f,%f);\n",itemCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tvogel%d.maxLeft = 40;\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tvogel%d.maxRight = 450;\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tvogel%d.speed = 150;\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tvogel%d.abwurfPosition = 260;\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tvogel%d.delegate = self;\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addToFrameUpdate:vogel%d,nil];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addChild:vogel%d];\n\n",itemCounter]];  
            itemCounter++;
        }
        
        if(ast.tag == 13) // Feuer
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tFeuer* feuer%d = [[Feuer alloc]initWithWorld:world];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tfeuer%d.position = ccp(%f, %f);\n",itemCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addChild:feuer%d];\n\n",itemCounter]];        
            itemCounter++;
        }
        if(ast.tag == 14) // Wasserfall
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tWasserfall* wasserfall%d = [[Wasserfall alloc]initWithWorld:world];\n",itemCounter]];
            [implementationFile appendString:[NSString stringWithFormat:@"\twasserfall%d.position = ccp(%f, 320);\n",itemCounter,ast.position.x]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addChild:wasserfall%d];\n\n",itemCounter]];        
            itemCounter++;
        }
        if(ast.tag == 15) // Baum
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tCCSprite* baum%d = [CCSprite spriteWithSpriteFrame:@\"%@\"];\n",itemCounter,(NSString*)ast.userData]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tbaum%d.position = ccp(%f, %f);\n",itemCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tbaum%d.scale = %f;\n",itemCounter,ast.scale]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tbaum%d.rotation = %f;\n",itemCounter,ast.rotation]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[backgroundLayer addChild:baum%d];\n\n",itemCounter]];        
            itemCounter++;
        }
      
        if(ast.tag == 16) // Baumkrone
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tCCSprite* baumkrone%d = [CCSprite spriteWithFile:@\"%@\"];\n",itemCounter,(NSString*)ast.userData]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tbaumkrone%d.position = ccp(%f, %f);\n",itemCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tbaumkrone%d.scale = %f;\n",itemCounter,ast.scale]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tbaumkrone%d.rotation = %f;\n",itemCounter,ast.rotation]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[backgroundLayer addChild:baumkrone%d];\n\n",itemCounter]];        
            itemCounter++;
        }

        if(ast.tag == 17) // Stein
        {
            [implementationFile appendString:[NSString stringWithFormat:@"\tStein* stein%d = [[Stein alloc]initWithWorld:world AndStein:%d];\n",itemCounter,[(NSNumber*)ast.userData intValue]]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tstein%d.position = ccp(%f, %f);\n",itemCounter,ast.position.x,ast.position.y]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tstein%d.scale = %f;\n",itemCounter,ast.scale]];
            [implementationFile appendString:[NSString stringWithFormat:@"\tstein%d.rotation = %f;\n",itemCounter,ast.rotation]];
            [implementationFile appendString:[NSString stringWithFormat:@"\t[self addChild:stein%d];\n\n",itemCounter]];        
            itemCounter++;
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
    for(int i=1;i<AstCounter;i++)
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
    
    NSURL* implementationURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.mm",[savePanel URL]]];
    NSURL* headerURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.h",[savePanel URL]]];

    [implementationFile writeToURL:implementationURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [headerFile writeToURL:headerURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end











