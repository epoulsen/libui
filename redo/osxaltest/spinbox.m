// 31 july 2015
#import "osxaltest.h"

// leave a whole lot of space around the alignment rect, just to be safe
@interface tSpinboxContainer : NSView
@end

@implementation tSpinboxContainer

- (NSEdgeInsets)alignmentRectInsets
{
	return NSEdgeInsetsMake(50, 50, 50, 50);
}

@end

@implementation tSpinbox {
	tSpinboxContainer *c;
	NSTextField *t;
	NSStepper *s;
	id<tControl> parent;
}

- (id)init
{
	self = [super init];
	if (self) {
		self->c = [[tSpinboxContainer alloc] initWithFrame:NSZeroRect];

		self->t = [[NSTextField alloc] initWithFrame:NSZeroRect];
		[self->t setSelectable:YES];
		[self->t setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]]];
		[self->t setBordered:NO];
		[self->t setBezelStyle:NSTextFieldSquareBezel];
		[self->t setBezeled:YES];
		[[self->t cell] setLineBreakMode:NSLineBreakByClipping];
		[[self->t cell] setScrollable:YES];
		[self->t setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self->c addSubview:self->t];

		self->s = [[NSStepper alloc] initWithFrame:NSZeroRect];
		[self->s setIncrement:1];
		[self->s setValueWraps:NO];
		[self->s setAutorepeat:YES];
		[self->s setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self->c addSubview:self->s];

		self->parent = nil;
	}
	return self;
}

- (void)tSetParent:(id<tControl>)p addToView:(NSView *)v
{
	self->parent = p;
	[v addSubview:self->c];
}

- (void)tFillAutoLayoutHorz:(NSMutableArray *)horz
	vert:(NSMutableArray *)vert
	extra:(NSMutableArray *)extra
	extraVert:(NSMutableArray *)extraVert
	views:(NSMutableDictionary *)views
	first:(uintmax_t *)n
{
	NSString *key;

	key = tAutoLayoutKey(*n);
	(*n)++;
	[horz addObject:[NSString stringWithFormat:@"[%@]", key]];
	[vert addObject:[NSString stringWithFormat:@"[%@]", key]];
	[views setObject:self->c forKey:key];
}

- (void)tRelayout
{
	if (self->parent != nil)
		[self->parent tRelayout];
}

@end
