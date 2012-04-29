#import "GComponent.h"

@interface GLabel : GComponent {
	NSString	*_label;
	UILabel		*lbl_label;
}
@property(nonatomic, strong)			NSString *label;
@property(readonly, nonatomic, strong)	UILabel *lbl_label;
@property(nonatomic)					UITextAlignment textAlignment;

-(void)sizeToFit;

@end