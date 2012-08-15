@import <AppKit/CPWindow.j>
@import "MLUserInfo.j"


@implementation MLUserInfoView : CPWindow
{
	MLUserInfo userInfo;
	CPArray items;
}

- (id)initWithUserInfo:(MLUserInfo)aUserInfo
{
    self = [self initWithContentRect:CGRectMake(50.0, 50.0, 600.0, 400.0)
                           styleMask: CPClosableWindowMask |
                                     CPResizableWindowMask];

    if (self)
    {
    	var contentView = [self contentView],
            bounds = [contentView bounds];

        userInfo = aUserInfo;

        [self setTitle:"User Info"];


	    var box = [[CPBox alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth([contentView bounds]) - 20 , CGRectGetHeight([contentView bounds]) - 20)];

	    [box setBorderType:CPLineBorder];
	    [box setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];

	    var toolbar = [CPToolbar new];
        [toolbar setDisplayMode:CPToolbarDisplayModeIconAndLabel];

        items = [@"general"];

        [items addObject:CPToolbarFlexibleSpaceItemIdentifier];
        [items addObject:@"seller_reputation"];
        [items addObject:@"buyer_reputation"];
        [items addObject:@"status"];
        [items addObject:@"credit"];

        [toolbar setDelegate:self];
        [self setToolbar:toolbar];
        [contentView addSubview:box];

        [self showDetails:nil];

    }

    return self;
}

- (void)showDetails:(id)sender
{
	console.log(self);
}
- (void)showSellerReputation:(id)sender
{
}
- (void)showBuyerReputation:(id)sender
{
}
- (void)showStatus:(id)sender
{
}
- (void)showCredit:(id)sender
{
}
@end


@implementation MLUserInfoView (UserInfoToolbarDelegate)

- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)toolbar
{
    return items;
}

- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)toolbar
{
    return items;
}

- (CPToolbarItem)toolbar:(CPToolbar)toolbar itemForItemIdentifier:(CPString)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:itemIdentifier];

 	if (itemIdentifier == "general")
 	{
 		[self customizeToolbarItem:toolbarItem label:"Details" image:"details.png" selector:@selector(showDetails:) target:self];
 	}
 	else if (itemIdentifier == "seller_reputation")
 	{
 		[self customizeToolbarItem:toolbarItem label:"Seller Reputation" image:"seller_reputation.png" selector:@selector(showSellerReputation:) target:self];
 	}
 	else if (itemIdentifier == "buyer_reputation")
 	{
 		[self customizeToolbarItem:toolbarItem label:"Buyer reputation" image:"buyer_reputation.png" selector:@selector(showBuyerReputation:) target:self];
 	}
 	else if (itemIdentifier == "status")
 	{
 		[self customizeToolbarItem:toolbarItem label:"Status" image:"status.png" selector:@selector(showStatus:) target:self];
 	}
 	else if (itemIdentifier == "credit")
 	{
 		[self customizeToolbarItem:toolbarItem label:"Credit" image:"credit.png" selector:@selector(showCredit:) target:self];
 	}

    return toolbarItem;
}

-(void)customizeToolbarItem:(CPToolbarItem)aToolbarItem label:(CPString)aLabel image:(CPString)anImageName selector:(SEL)aSelector target:(id)aTarget
{
    var mainBundle = [CPBundle mainBundle];
    var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:anImageName] size:CPSizeMake(256, 256)];
    var highlighted = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:anImageName] size:CPSizeMake(256, 256)];

    [aToolbarItem setImage:image];
    [aToolbarItem setAlternateImage:highlighted];

    [aToolbarItem setTarget:aTarget];
    [aToolbarItem setAction:aSelector];
    [aToolbarItem setLabel:aLabel];

    [aToolbarItem setMinSize:CGSizeMake(32, 32)];
    [aToolbarItem setMaxSize:CGSizeMake(32, 32)];
}
@end
