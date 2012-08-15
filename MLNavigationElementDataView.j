@import <AppKit/CPView.j>


@implementation MLNavigationElementDataView : CPView
{
    id  object;
    CPTextField titleLabel @accessors;
    CPImageView iconImage @accessors;
}

- (void)setObjectValue:(id)anObject
{
	var subviews = [self subviews];
    for (var i=0; i < subviews.length; i++) {
        [subviews[i] removeFromSuperview];
    };

	object = anObject;

	console.log(anObject);

    var label = [[CPTextField alloc] initWithFrame:[self bounds]];
    [label setAlignment:CPLeftTextAlignment];
    [label setTextColor:[CPColor grayColor]];
	[label setFont:[CPFont boldSystemFontOfSize:14.0]];
    [self addSubview:label];

    [label setStringValue:[anObject label]];
    [label sizeToFit];

    // Declare dirty, request redraw
    [self setNeedsDisplay: YES];
}
@end
