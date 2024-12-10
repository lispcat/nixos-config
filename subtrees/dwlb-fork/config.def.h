#define HEX_COLOR(hex)				\
	{ .red   = ((hex >> 24) & 0xff) * 257,	\
	  .green = ((hex >> 16) & 0xff) * 257,	\
	  .blue  = ((hex >> 8) & 0xff) * 257,	\
	  .alpha = (hex & 0xff) * 257 }

// use ipc functionality
static bool ipc = false;
// initially hide all bars
static bool hidden = false;
// initially draw all bars at the bottom
static bool bottom = true;
// hide vacant tags
static bool hide_vacant = true;
// vertical pixel padding above and below text
static uint32_t vertical_padding = 3; // was 3
// allow in-line color commands in status text
static bool status_commands = true;
// center title text
static bool center_title = false;
// use title space as status text element
static bool custom_title = false;
// blend title bg with middle_bg
static bool blend_title_and_middle_bg = true;
// scale
static uint32_t buffer_scale = 1;
// font
static char *fontstr = "TamzenForPowerline:pixelsize=18";
/* static char *fontstr = "Spleen:pixelsize=17"; */
/* static char *fontstr = "Liberation Mono:size=10"; */
/* static char *fontstr = "Terminus:style=bold,pixelsize=17"; */
// tag names
static char *tags_names[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

// set 16-bit colors for bar
// use either pixman_color_t struct or HEX_COLOR macro for 8-bit colors
#define white1 0xeeeeeeff  // #eeeeee\ff
#define pink1 0xd698beff  // #f2b1d9\ff
#define dark1 0x222222ff  // #222222\ff
#define black 0x000000ff  // #000000\ff
#define grey1 0x444444ff  // #444444\ff
#define titlebg 0x333333ff  // #333333\ff

// tags sel
static pixman_color_t active_fg_color = HEX_COLOR(dark1);		// #222222\ff / dark
static pixman_color_t active_bg_color = HEX_COLOR(pink1);		// #f2b1d9\ff / pink
// tags occ
static pixman_color_t occupied_fg_color = HEX_COLOR(pink1);		// #f2b1d9\ff / pink
static pixman_color_t occupied_bg_color = HEX_COLOR(dark1);		// #222222\ff / dark
// tags not
static pixman_color_t inactive_fg_color = HEX_COLOR(pink1);		// #f2b1d9\ff
static pixman_color_t inactive_bg_color = HEX_COLOR(dark1);		// #222222\ff / dark
// tags urgent
static pixman_color_t urgent_fg_color = HEX_COLOR(dark1);		// #222222\ff / dark
static pixman_color_t urgent_bg_color = HEX_COLOR(0xff0000ff);		// #ff0000\ff
// title
static pixman_color_t title_fg_color = HEX_COLOR(pink1);		// #f2b1d9\ff / pink
static pixman_color_t title_bg_color = HEX_COLOR(dark1);		// #222222\ff / dark
// middle
static pixman_color_t middle_bg_color = HEX_COLOR(0x009999ff);		// #009999\ff / 
static pixman_color_t middle_bg_color_selected = HEX_COLOR(dark1);	// #222222\ff / dark
