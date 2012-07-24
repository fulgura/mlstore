/*
 * AppController.j
 * NewApplication
 *
 * Created by You on November 16, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>


var SliderToolbarItemIdentifier = "SliderToolbarItemIdentifier",
    AddToolbarItemIdentifier = "AddToolbarItemIdentifier",
    SaleToolbarItemIdentifier = "SaleToolbarItemIdentifier",
    NAVIGATION_AREA_WIDTH = 200.0;

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];


    var navigationArea = [[CPView alloc] initWithFrame:CGRectMake(0.0, 0.0, NAVIGATION_AREA_WIDTH, CGRectGetHeight([contentView bounds]) - NAVIGATION_AREA_WIDTH)];

    [navigationArea setBackgroundColor:[CPColor colorWithHexString:@"DDE4E4"]];

    // This view will grow in height, but stay fixed width attached to the left side of the screen.
    [navigationArea setAutoresizingMask:CPViewHeightSizable | CPViewMaxXMargin];

    [contentView addSubview:navigationArea];

    var metaDataArea = [[CPView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY([navigationArea frame]), NAVIGATION_AREA_WIDTH, NAVIGATION_AREA_WIDTH)];

    var rgbColor = [CPColor colorWithHexString:@"CCCCCC"];
    var color = [rgbColor colorWithAlphaComponent:0.9]
    [metaDataArea setBackgroundColor: color];

    // This view will stay the same size in both directions, and fixed to the lower left corner.
    [metaDataArea setAutoresizingMask:CPViewMinYMargin | CPViewMaxXMargin];

    [contentView addSubview:metaDataArea];

    var contentArea = [[CPView alloc] initWithFrame:CGRectMake(NAVIGATION_AREA_WIDTH, 0.0, CGRectGetWidth([contentView bounds]) - NAVIGATION_AREA_WIDTH, CGRectGetHeight([contentView bounds]))];

    [contentArea setBackgroundColor:[CPColor whiteColor]];

    // This view will grow in both height an width.
    [contentArea setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];

    [contentView addSubview:contentArea];


    [theWindow orderFront:self];

    var toolbar = [[CPToolbar alloc] initWithIdentifier:"Photos"];
    [toolbar setDelegate:self];
    [toolbar setVisible:YES];
    [theWindow setToolbar:toolbar];


    //[CPMenu setMenuBarVisible:YES];


    var request = [CPURLRequest requestWithURL:"https://api.mercadolibre.com/countries"];
    var connection = [CPURLConnection connectionWithRequest:request delegate:self];

}


// Return an array of toolbar item identifier (all the toolbar items that may be present in the toolbar)
- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{
   return [CPToolbarFlexibleSpaceItemIdentifier, SliderToolbarItemIdentifier, AddToolbarItemIdentifier, SaleToolbarItemIdentifier];
}

// Return an array of toolbar item identifier (the default toolbar items that are present in the toolbar)
- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{
   return [AddToolbarItemIdentifier, SaleToolbarItemIdentifier, CPToolbarFlexibleSpaceItemIdentifier, SliderToolbarItemIdentifier];
}

- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)anItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag
{
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:anItemIdentifier];

    if (anItemIdentifier == SliderToolbarItemIdentifier)
    {
    }
    else if (anItemIdentifier == SaleToolbarItemIdentifier)
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Sale-256-blue.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Sale-256.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(sale:)];
        [toolbarItem setLabel:"Sale"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }

    return toolbarItem;
}


- (void)connection:(CPURLConnection) connection didReceiveData:(CPString)data
{
    //This method is called when a connection receives a response. in a
    //multi-part request, this method will (eventually) be called multiple times,
    //once for each part in the response.
    CPLog.info(data);
}

- (void)connection:(CPURLConnection)connection didFailWithError:(CPString)error
{
    //This method is called if the request fails for any reason.
    CPLog.info(error);
}

@end



