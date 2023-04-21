/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappx     = 12;        /* gap pixel between windows */
static const unsigned int gappih    = 12;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 12;       /* vert inner gap between windows */
static const unsigned int gappoh    = 12;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 12;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int extrabar           = 0;        /* 0 means no extra bar */
static const char statussep         = ';';      /* separator between statuses */
static const int horizpadbar        = 20;        /* horizontal padding for statusbar */
static const int vertpadbar         = 20;        /* vertical padding for statusbar */
static const char *fonts[]          = { "FiraCode Nerd Font:size=11" };
static const char dmenufont[]       = "FiraCode Nerd Font:size=11";
static const char col_gray1[]       = "#1a1b26";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#a9b1d6";
static const char col_gray4[]       = "#4e5173";
static const char col_cyan[]        = "#7aa2f7";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	// { "Gimp",     NULL,       NULL,       0,            1,           -1 },
	// { "Firefox",      NULL,       NULL,       1 << 8,       0,           -1 },
	{ "float-term",   NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "󰝘",      tile },    /* first entry is default */
	{ "",      monocle },
	{ "",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "/bin/sh", "-c", "~/.de/scripts/dmenu/all", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *lower_volume[]  = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-2000", NULL };
static const char *raise_volume[]  = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+2000", NULL };
static const char *toggle_volume[]  = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };
static const char *next_led[]  = { "asusctl", "led-mode", "-n", NULL };
static const char *kbd_lower_light[]  = { "asusctl", "-p", NULL };
static const char *kbd_raise_light[]  = { "asusctl", "-n", NULL };
static const char *mpc_prev[]  = { "mpc", "prev", NULL };
static const char *mpc_next[]  = { "mpc", "next", NULL };
static const char *mpc_toggle[]  = { "mpc", "toggle", NULL };
static const char *lower_light[]  = { "/bin/sh", "-c", "~/.de/scripts/backlight dec", NULL };
static const char *raise_light[]  = { "/bin/sh", "-c", "~/.de/scripts/backlight inc", NULL };
static const char *rf_toggle[]  = { "rfkill", "toggle", "all", NULL };
static const char *take_screenshot[] = { "maim", "-s", "~/Desktop/$(date +%s).png", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_space,                  spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return,                 spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_b,                      toggleextrabar, {0} },
  { 0,                            XF86XK_AudioLowerVolume,   spawn,          {.v = lower_volume } },
  { 0,                            XF86XK_AudioRaiseVolume,   spawn,          {.v = raise_volume } },
  { 0,                            XF86XK_AudioMute,          spawn,          {.v = toggle_volume } },
  { 0,                            XF86XK_Launch1,            spawn,          {.v = next_led } },
  { 0,                            XF86XK_KbdBrightnessDown,  spawn,          {.v = kbd_lower_light } },
  { 0,                            XF86XK_KbdBrightnessUp,    spawn,          {.v = kbd_raise_light } },
  { 0,                            XF86XK_MonBrightnessDown,  spawn,          {.v = lower_light } },
  { 0,                            XF86XK_MonBrightnessUp,    spawn,          {.v = raise_light } },
  { 0,                            XF86XK_AudioPrev,          spawn,          {.v = mpc_prev } },
  { 0,                            XF86XK_AudioNext,          spawn,          {.v = mpc_next } },
  { 0,                            XF86XK_AudioPlay,          spawn,          {.v = mpc_toggle } },
  { 0,                            XF86XK_RFKill,             spawn,          {.v = rf_toggle } },
  { 0,                            XK_Print,                  spawn,          {.v = take_screenshot } },
	{ MODKEY,                       XK_b,                      togglebar,      {0} },
	{ MODKEY,                       XK_Right,                  focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Left,                   focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Left,                   setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_Right,                  setmfact,       {.f = +0.05} },
	// { MODKEY,                       XK_i,                      incnmaster,     {.i = +1 } },
	// { MODKEY,                       XK_d,                      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_Return,                 zoom,           {0} },
	{ MODKEY,                       XK_Tab,                    view,           {0} },
	{ MODKEY,                       XK_q,                      killclient,     {0} },
	{ MODKEY,                       XK_t,                      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,                      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_f,                      setlayout,      {.v = &layouts[2]} },
	// { MODKEY,                       XK_space                ,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,                  togglefloating, {0} },
	{ MODKEY,                       XK_0,                      view,           {.ui = ~0 } },
	// { MODKEY|ShiftMask,             XK_0,                      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,                  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,                 focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,                  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,                 tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_Escape,  quit,          {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	// { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	// { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	// { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	// { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	// { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

