/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }
/* appearance */
static const int tabletmaptosurface        = 0;  /* map tablet input to surface(1) or monitor(0) */
static const int sloppyfocus               = 0;  /* focus follows mouse */
static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const unsigned int borderpx         = 1;  /* border pixel of windows */
static const float rootcolor[]             = COLOR(0x222222ff);  // #222222\ff
static const float bordercolor[]           = COLOR(0x444444ff);  // #444444\ff
/* static const float focuscolor[]            = COLOR(0x005577ff);  // #005577\ff */
static const float focuscolor[]            = COLOR(0xf2b1d9ff);  // #f2b1d9\ff
static const float urgentcolor[]           = COLOR(0xff0000ff);  // #ff0000\ff
/* This conforms to the xdg-protocol. Set the alpha to zero to restore the old behavior */
static const float fullscreen_bg[]         = {0.1f, 0.1f, 0.1f, 1.0f}; /* You can also use glsl colors */
/* keyboard layout change notification for status bar */
static const char  kblayout_file[] = "/tmp/dwl-keymap";
static const char *kblayout_cmd[]  = {"pkill", "-RTMIN+5", "slstatus", NULL};

enum {
	MENU,
	PROGRAMS,
};
const char *modes_labels[] = {
	"menu",
	"programs",
};

enum {
    VIEW_L = -1,
    VIEW_R = 1,
    SHIFT_L = -2,
    SHIFT_R = 2,
} RotateTags;

/* tagging - TAGCOUNT must be no greater than 31 */
#define TAGCOUNT (9)

/* logging */
static int log_level = WLR_ERROR;

/* passthrough */
static int passthrough = 0;

/* Autostart */
static const char *const autostart[] = {
	"/bin/sh", "-c", "sleep 0.5; ~/.bin/slstatus-dwlb-start.sh", NULL,
	"/bin/sh", "-c", "wbg $HOME/Pictures/Random-images/glt-landscape2.png", NULL,
	"/bin/sh", "-c", "wlsunset -S 10:00 -s 19:00 -t 3000 -T 6500", NULL,
	"/bin/sh", "-c", "swayidle -w timeout 900", NULL,
	"/bin/sh", "-c", "mako --border-radius=2 --font='Deva Vu Sans 10' --max-visible=5 \
--outer-margin=5 --margin=3 --background='#1c1f26' --border-color='#89AAEB' --border-size=1 \
--default-timeout=7000", NULL,
        NULL /* terminate */
};

/* NOTE: ALWAYS keep a rule declared even if you don't use rules (e.g leave at least one example) */
static const Rule rules[] = {
	/* app_id             title       tags mask     isfloating   monitor */
	/* examples: */
	{ "Gimp_EXAMPLE",     NULL,       0,            1,           -1 }, /* Start on currently visible tags floating, not tiled */
	{ "firefox_EXAMPLE",  NULL,       1 << 8,       0,           -1 }, /* Start on ONLY tag "9" */
};

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "[M]",      monocle },
	{ "[D]",      deck },
	{ "><>",      NULL },    /* no layout function means floating behavior */
};

/* monitors */
/* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
 * WARNING: negative values other than (-1, -1) cause problems with Xwayland clients
 * https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
*/
/* NOTE: ALWAYS add a fallback rule, even if you are completely sure it won't be used */
static const MonitorRule monrules[] = {
	/* name       mfact  nmaster scale layout       rotate/reflect                x    y */
	/* example of a HiDPI laptop monitor:
	{ "eDP-1",    0.5f,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
	*/
	/* defaults */
	{ NULL,       0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
	/* can specify fields: rules, model, layout, variant, options */
	/* example:
	.options = "ctrl:nocaps",
	*/
	.layout  = "us,us,us",
	.variant = ",dvp,colemak_dh",
	.options = "ctrl:nocaps",
};
/* set this value to correspond with the above */
static const int xkb_num_layouts = 3;
static const int xkb_init_layout = 1; // dvp (2nd)

/* numlock and capslock */
static const int numlock = 1;
static const int capslock = 0;

static const int repeat_rate = 80;
static const int repeat_delay = 200;

/* Trackpad */
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 0;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
*/
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;

/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_LOGO

/* Alias modkeys */
#define ALT WLR_MODIFIER_ALT
#define CTRL WLR_MODIFIER_CTRL
#define SHIFT WLR_MODIFIER_SHIFT

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
	{ MODKEY|CTRL,               KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|SHIFT,              SKEY,           tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|CTRL|SHIFT,         SKEY,           toggletag,       {.ui = 1 << TAG} }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[] = { "alacritty", NULL };
static const char *menucmd[] = { "bemenu-run", NULL };
static const char *emacsclient[] = { "emacsclient", "-c", "-a", "", NULL };
// xf86 cmds
static const char *volmute[] = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };
static const char *volup[]    = { "volume-adjust.sh", "+10%", NULL };
static const char *volup2[]   = { "volume-adjust.sh", "+5%", NULL };
static const char *voldown[]  = { "volume-adjust.sh", "-10%", NULL };
static const char *voldown2[] = { "volume-adjust.sh", "-5%", NULL };
static const char *lightup[]    = { "brightnessctl", "set", "10%+", NULL};
static const char *lightup2[]   = { "brightnessctl", "set", "5%+", NULL};
static const char *lightdown[]  = { "brightnessctl", "set", "10%-", NULL};
static const char *lightdown2[] = { "brightnessctl", "set", "5%-", NULL};
static const char *playpause[] = { "playerctl", "play-pause", NULL};
static const char *hibernate[] = { "loginctl", "hibernate", NULL};
static const char *screenshot_sel[] = {
	"/bin/sh", "-c",
	"grimshot --notify save area $HOME/screenshots/$(date -Iseconds).png", NULL
};
static const char *screenshot_out[] = {
	"/bin/sh", "-c",
	"grimshot --notify save output $HOME/screenshots/$(date -Iseconds).png", NULL
};
static const char *screenshot_sel_copy[] = {
	"/bin/sh", "-c",
	"grimshot --notify copy area", NULL
};

#include "shiftview.c"

static const Key keys[] = {
	/* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
	/* modifier                  key                 function        argument */
	/* spawning */
	{ MODKEY,                    XKB_KEY_l,          spawn,          {.v = menucmd} },
	{ MODKEY,                    XKB_KEY_b,          spawn,          {.v = termcmd} },
	{ MODKEY,                    XKB_KEY_m,          spawn,          {.v = emacsclient} },

	/* stack */
	{ MODKEY,                    XKB_KEY_n,          focusstack,     {.i = +1} },
	{ MODKEY,                    XKB_KEY_t,          focusstack,     {.i = -1} },
	{ MODKEY|ALT,                XKB_KEY_n,          movestack,      {.i = +1} },
	{ MODKEY|ALT,                XKB_KEY_t,          movestack,      {.i = -1} },

	/* master area */
	{ MODKEY|CTRL,               XKB_KEY_h,          incnmaster,     {.i = +1} },
	{ MODKEY|CTRL,               XKB_KEY_s,          incnmaster,     {.i = -1} },

	/* window adjustment */
	{ MODKEY,                    XKB_KEY_c,          setmfact,       {.f = -0.05f} },
	{ MODKEY,                    XKB_KEY_r,          setmfact,       {.f = +0.05f} },

	/* window manage */
	{ MODKEY,                    XKB_KEY_Return,     zoom,           {0} },
	{ MODKEY,                    XKB_KEY_Tab,        view,           {0} },
	{ MODKEY|ALT,                XKB_KEY_h,          rotatetags,     {.i = VIEW_L} },
	{ MODKEY|ALT,                XKB_KEY_s,          rotatetags,     {.i = VIEW_R} },
	{ MODKEY|SHIFT,              XKB_KEY_H,          rotatetags,     {.i = SHIFT_L} },
	{ MODKEY|SHIFT,              XKB_KEY_S,          rotatetags,     {.i = SHIFT_R} },
	{ MODKEY,                    XKB_KEY_h,          shiftview,      { .i = -1 } },
	{ MODKEY,                    XKB_KEY_s,          shiftview,      { .i = 1 } },
	{ MODKEY|ALT,                XKB_KEY_d,          killclient,     {0} },

	/* layouts */
	{ MODKEY|CTRL,               XKB_KEY_t,          setlayout,      {.v = &layouts[0]} },
	{ MODKEY|CTRL,               XKB_KEY_m,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY|CTRL,               XKB_KEY_d,          setlayout,      {.v = &layouts[2]} },
	{ MODKEY|CTRL,               XKB_KEY_f,          setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                    XKB_KEY_space,      setlayout,      {0} },

	/* window state */
	{ MODKEY|SHIFT,              XKB_KEY_space,      togglefloating, {0} },
	{ MODKEY,                    XKB_KEY_f,          togglefullscreen, {0} },

	/* tag */
	{ MODKEY,                    XKB_KEY_bracketright,view,          {.ui = ~0} },
	{ MODKEY|SHIFT,              XKB_KEY_6,          tag,            {.ui = ~0} },

	/* monitor */
	{ MODKEY|CTRL|SHIFT,         XKB_KEY_h,          focusmon,       {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY|CTRL|SHIFT,         XKB_KEY_s,          focusmon,       {.i = WLR_DIRECTION_RIGHT} },
	{ MODKEY|CTRL|SHIFT,         XKB_KEY_t,          tagmon,         {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY|CTRL|SHIFT,         XKB_KEY_n,          tagmon,         {.i = WLR_DIRECTION_RIGHT} },

	/* tags */
	TAGKEYS(	XKB_KEY_ampersand,	XKB_KEY_percent,	0), // & %
	TAGKEYS(	XKB_KEY_bracketleft,	XKB_KEY_7,		1), // [ 7
	TAGKEYS(	XKB_KEY_braceleft,	XKB_KEY_5,		2), // { 5
	TAGKEYS(	XKB_KEY_braceright,	XKB_KEY_3,		3), // } 3
	TAGKEYS(	XKB_KEY_parenleft,	XKB_KEY_1,		4), // ( 1
	TAGKEYS(	XKB_KEY_equal,		XKB_KEY_9,		5), // = 9
	TAGKEYS(	XKB_KEY_asterisk,	XKB_KEY_0,		6), // * 0
	TAGKEYS(	XKB_KEY_parenright,	XKB_KEY_2,		7), // ) 2
	TAGKEYS(	XKB_KEY_plus,		XKB_KEY_4,		8), // + 4

	/* XF86 keys */
	{ 0,		XKB_KEY_XF86AudioMute,		spawn,	{.v = volmute    } },
	{ 0,		XKB_KEY_XF86AudioRaiseVolume,	spawn,	{.v = volup      } },
	{ SHIFT,	XKB_KEY_XF86AudioRaiseVolume,	spawn,	{.v = volup2     } },
	{ 0,		XKB_KEY_XF86AudioLowerVolume,	spawn,	{.v = voldown    } },
	{ SHIFT,	XKB_KEY_XF86AudioLowerVolume,	spawn,	{.v = voldown2   } },
	{ 0,		XKB_KEY_XF86MonBrightnessUp,	spawn,	{.v = lightup    } },
	{ SHIFT,	XKB_KEY_XF86MonBrightnessUp,	spawn,	{.v = lightup2   } },
	{ 0,		XKB_KEY_XF86MonBrightnessDown,	spawn,	{.v = lightdown  } },
	{ SHIFT,	XKB_KEY_XF86MonBrightnessDown,	spawn,	{.v = lightdown2 } },
	{ 0,		XKB_KEY_XF86AudioPlay,		spawn,	{.v = playpause  } },
	{ 0,		XKB_KEY_Print,		spawn,	{.v = screenshot_sel } },
	{ SHIFT,	XKB_KEY_Print,		spawn,	{.v = screenshot_out } },
	{ MODKEY|SHIFT,	XKB_KEY_Print,		spawn,	{.v = screenshot_sel_copy } },
	{ MODKEY,	XKB_KEY_F12,		spawn,	{.v = hibernate } },

	/* misc */
	{ MODKEY|SHIFT,              XKB_KEY_Q,          quit,           {0} },

	{ MODKEY,                    XKB_KEY_F11,        togglepassthrough, {0} },

	{ MODKEY,                    XKB_KEY_g,          entermode,      {.i = MENU} },

	{ MODKEY,                    XKB_KEY_Home,       switchxkbrule,  {1} },
	{ MODKEY,                    XKB_KEY_End,        switchxkbrule,  {2} },
	{ MODKEY,                    XKB_KEY_Prior,      switchxkbrule,  {0} },
	{ MODKEY,                    XKB_KEY_Next,       switchxkbrule,  {-1} },

	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
	{ CTRL|ALT, XKB_KEY_Terminate_Server, quit, {0} },
	/* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
	 * do not remove them.
	 */
#define CHVT(n) { CTRL|ALT, XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

static const Modekey modekeys[] = {
	/* mode	modifier key		function argument */
	{ MENU,	{ 0, XKB_KEY_comma,	spawn,     SHCMD("playerctl previous")}},
	{ MENU, { 0, XKB_KEY_comma,	entermode, {.i = NORMAL} }},
	{ MENU,	{ 0, XKB_KEY_period,	spawn,     SHCMD("playerctl next")}},
	{ MENU, { 0, XKB_KEY_period,	entermode, {.i = NORMAL} }},
	{ MENU,	{ 0, XKB_KEY_s,		spawn,     SHCMD("text-to-speech-clipboard.sh")}},
	{ MENU, { 0, XKB_KEY_s,		entermode, {.i = NORMAL} }},
	{ MENU, { 0, XKB_KEY_a,      entermode, {.i = PROGRAMS} }},
	{ MENU, { 0, XKB_KEY_Escape, entermode, {.i = NORMAL}}},

	{ PROGRAMS, { 0, XKB_KEY_f, spawn,     SHCMD("firefox")}},
	{ PROGRAMS, { 0, XKB_KEY_f, entermode, {.i = NORMAL} }},
	{ PROGRAMS, { 0, XKB_KEY_l, spawn, SHCMD("flatpak run io.gitlab.librewolf-community")}},
	{ PROGRAMS, { 0, XKB_KEY_l, entermode, {.i = NORMAL} }},
	{ PROGRAMS, { 0, XKB_KEY_p, spawn,     SHCMD("firejail keepassxc")}},
	{ PROGRAMS, { 0, XKB_KEY_p, entermode, {.i = NORMAL} }},
	{ PROGRAMS, { 0, XKB_KEY_d, spawn,     SHCMD("vesktop")}},
	{ PROGRAMS, { 0, XKB_KEY_d, entermode, {.i = NORMAL} }},
	{ PROGRAMS, { 0, XKB_KEY_s, spawn,     SHCMD("flatpak run com.spotify.Client")}},
	{ PROGRAMS, { 0, XKB_KEY_s, entermode, {.i = NORMAL} }},
	{ PROGRAMS, { 0, XKB_KEY_c, spawn,     SHCMD("steam")}},
	{ PROGRAMS, { 0, XKB_KEY_c, entermode, {.i = NORMAL} }},
	{ PROGRAMS, { 0, XKB_KEY_r, spawn,     SHCMD("pw-jack renoise --scripting-dev")}},
	{ PROGRAMS, { 0, XKB_KEY_r, entermode, {.i = NORMAL} }},
	{ PROGRAMS, { 0, XKB_KEY_Escape, entermode, {.i = NORMAL}}},
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },
	{ MODKEY, BTN_MIDDLE, togglefloating, {0} },
	{ MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
};
