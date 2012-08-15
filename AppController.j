/*
 * AppController.j
 * NewApplication
 *
 * Created by You on November 16, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

@import <Raphuccino/Raphuccino.j>
@import "MLSiteController.j"
@import "MLCategoryBrowser.j"
@import "MLPreferencesView.j"
@import "MLAPIController.j"

var SliderToolbarItemIdentifier = "SliderToolbarItemIdentifier",
    AddToolbarItemIdentifier = "AddToolbarItemIdentifier",
    ViewMLItemIdentifier = "ViewMLItemIdentifier",
    MLPreferencesItemIdentifier = "MLPreferencesItemIdentifier",
    CategoryBrowserItemIdentifier = "CategoryBrowserItemIdentifier",
    SaleToolbarItemIdentifier = "SaleToolbarItemIdentifier",
    UserInfoToolbarItemIdentifier = "UserInfoToolbarItemIdentifier",
    NAVIGATION_AREA_WIDTH = 200.0;

@implementation AppController : CPObject
{
    CPWindow    theWindow;
    MLAPIController apiController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{

    apiController = [[MLAPIController alloc] init];

    theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];

    var contentView = [theWindow contentView];

    var navigationArea = [[CPView alloc] initWithFrame:CGRectMake(0.0, 0.0, NAVIGATION_AREA_WIDTH, CGRectGetHeight([contentView bounds]) - NAVIGATION_AREA_WIDTH)];

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

    [[MLSiteController alloc] init];

    var toolbar = [[CPToolbar alloc] initWithIdentifier:"Photos"];
    [toolbar setDelegate:self];
    [toolbar setVisible:YES];
    [theWindow setToolbar:toolbar];

//    var request = [CPURLRequest requestWithURL: "https://api.mercadolibre.com/sites/MLA/search?q=ipod"];
//    var data = [CPURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    var str = [data description];
//    console.log(data);

    //[CPMenu setMenuBarVisible:YES];
}

// Return an array of toolbar item identifier (all the toolbar items that may be present in the toolbar)
- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{
   console.log("toolbarAllowedItemIdentifiers");
   return [UserInfoToolbarItemIdentifier, CPToolbarFlexibleSpaceItemIdentifier, ViewMLItemIdentifier, CategoryBrowserItemIdentifier, SliderToolbarItemIdentifier, AddToolbarItemIdentifier, MLPreferencesItemIdentifier, SaleToolbarItemIdentifier];
}

// Return an array of toolbar item identifier (the default toolbar items that are present in the toolbar)
- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{
    console.log("toolbarDefaultItemIdentifiers");
   return [UserInfoToolbarItemIdentifier, AddToolbarItemIdentifier, ViewMLItemIdentifier, CategoryBrowserItemIdentifier, SaleToolbarItemIdentifier, CPToolbarFlexibleSpaceItemIdentifier, MLPreferencesItemIdentifier, SliderToolbarItemIdentifier];
}

- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)anItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag
{
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:anItemIdentifier];

    if (anItemIdentifier == SliderToolbarItemIdentifier)
    {
        // The toolbar is using a custom view (of class CPSearchField)
        var searchField = [[CPSearchField alloc] initWithFrame:CGRectMake(0, 10, 200, 30)];
        [searchField setEditable:YES];
        [searchField setPlaceholderString:@"search and hit enter"];
        [searchField setBordered:YES];
        [searchField setBezeled:YES];
        [searchField setFont:[CPFont systemFontOfSize:12.0]];
        [searchField setTarget:self];
        [searchField setAction:@selector(searchChanged:)];
        [searchField setSendsWholeSearchString:YES];
        [searchField setSendsSearchStringImmediately:NO];

        [toolbarItem setView:searchField];
        [toolbarItem setLabel:"Search"];
        [toolbarItem setMinSize:CGSizeMake(180, 32)];
        [toolbarItem setMaxSize:CGSizeMake(180, 32)];
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
        [toolbarItem setLabel:"Sale!!"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if(anItemIdentifier == ViewMLItemIdentifier)
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"mercadolibre.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"mercadolibre.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(viewML:)];
        [toolbarItem setLabel:"Visit ML"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if (anItemIdentifier == CategoryBrowserItemIdentifier)
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"categories-browser.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"categories-browser.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(browserItemCategories:)];
        [toolbarItem setLabel:"Browse categories"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if (anItemIdentifier == MLPreferencesItemIdentifier)
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"preferences.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"preferences.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(editPreferences:)];
        [toolbarItem setLabel:"Preferences"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }
    else if (anItemIdentifier == UserInfoToolbarItemIdentifier)
    {
        var mainBundle = [CPBundle mainBundle];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"user.png"] size:CPSizeMake(256, 256)];
        var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"user.png"] size:CPSizeMake(256, 256)];

        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:highlighted];

        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(showUserInfo:)];
        [toolbarItem setLabel:"User Info"];

        [toolbarItem setMinSize:CGSizeMake(32, 32)];
        [toolbarItem setMaxSize:CGSizeMake(32, 32)];
    }

    return toolbarItem;
}

- (void)searchChanged:(id)senderObject
{
    CPLog.info([senderObject stringValue]);

    var request = [CPURLRequest requestWithURL:"https://api.mercadolibre.com/sites/MLA/search?q=" + encodeURIComponent([senderObject stringValue])],
        connection = [CPURLConnection connectionWithRequest:request delegate:self];
}

/**
 * Shows a Mercadolibre webpage in a Dialog
 *
 *
 */
- (void)viewML:(id)sender
{
    var HUDPanel = [[CPPanel alloc]
        initWithContentRect:CGRectMake(100, 30, 1000, 600)
        styleMask:CPHUDBackgroundWindowMask | CPResizableWindowMask | CPClosableWindowMask];

    var panelContentView = [HUDPanel contentView];

    [HUDPanel setTitle:"MercadoLibre"];
    //[HUDPanel setBackgroundColor:[CPColor colorWithHexString:@"DDE4E4"]];
    [HUDPanel setFloatingPanel:YES];

    var webview = [[CPWebView alloc] initWithFrame:CGRectMake(0, 0, 1000, 600)];
    [webview setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];
    [webview setMainFrameURL:"http://www.mercadolibre.com.ar/"];

    [panelContentView addSubview:webview];

    [HUDPanel orderFront:self];
}

/**
 * Show a browser over categories
 *
 *
 */
- (void)browserItemCategories:(id)sender
{
    [[[MLCategoryBrowser alloc] init] orderFront:nil];
}

/**
 * Show a preferences panel
 *
 *
 */
- (void)editPreferences:(id)sender
{
    [[[MLPreferencesView alloc] init] orderFront:nil];
}
/**
 * Show a user info panel
 *
 *
 */
- (void)showUserInfo:(id)sender
{
    [apiController userInfo:function(userInfo)
    {
        console.log(userInfo);
    }];

}

/**
 * Show a preferences panel
 *
 *
 */
- (void)sale:(id)sender
{
        var content = {
            "title":"Anteojos Ray Ban Wayfare",
            "category_id":"MLA5529",
            "price":10,
            "currency_id":"ARS",
            "available_quantity":1,
            "buying_mode":"buy_it_now",
            "listing_type_id":"bronze",
            "condition":"new",
            "description":"{Model: RB2140. Size: 50mm. Name: WAYFARER. Color: Gloss Black. Includes Ray-Ban Carrying Case and Cleaning Cloth. New in Box",
            "pictures":[
                {"source":"http://upload.wikimedia.org/wikipedia/commons/f/fd/Ray_Ban_Original_Wayfarer.jpg"},
                {"source":"http://en.wikipedia.org/wiki/File:Teashades.gif"}
            ]
        };

        var request = new CFHTTPRequest();
        request.open(@"POST", "https://api.mercadolibre.com/items?access_token=APP_USR-9760-080911-0dd2e49ca0d728f6bde023c3480ed7b7-30429282", true);
        //request.setRequestHeader(@"Content-Type",@"application/json");

        request.oncomplete = function()
        {
            console.log("Answer: ", request);
        };

        request.onerror = function()
        {
            console.log("ERROR: ", request);
        };

        request.send("");
}


- (void)connection:(CPURLConnection) connection didReceiveData:(CPString)data
{

    console.log("Answer:", data);
}

- (void)connection:(CPURLConnection)connection didFailWithError:(CPString)error
{
    //Ideally, we would do something smarter here.
    alert(error);
}

@end



