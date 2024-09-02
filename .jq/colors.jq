module {
  "name": "colors",
  "description": "jq module to colorize output",
  "homepage": "https://github.com/pschmitt/colors.jq",
  "license": "GPL3",
  "author": "Philipp Schmitt",
  "repository": {
    "type": "git",
    "url": "https://github.com/pschmitt/colors.jq"
  }
};

# Helper
def esc(seq): "\u001b[" + seq + "m";

# Color and style definitions
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
def reset:
{
  "all":           esc("0"), # alias
  "reset":         esc("0"),
  "bold":          esc("21"),
  "dim":           esc("22"),
  "underline":     esc("24"),
  "blink":         esc("25"),
  "reverse":       esc("27"),
  "hidden":        esc("28"),
  "strikethrough": esc("29")
};

def color:
{
  "black":        esc("30"),
  "red":          esc("31"),
  "green":        esc("32"),
  "yellow":       esc("33"),
  "blue":         esc("34"),
  "magenta":      esc("35"),
  "cyan":         esc("36"),
  "lightgray":    esc("37"),
  "default":      esc("39"),
  "darkgray":     esc("90"),
  "lightred":     esc("91"),
  "lightgreen":   esc("92"),
  "lightyellow":  esc("93"),
  "lightblue":    esc("94"),
  "lightmagenta": esc("95"),
  "lightcyan":    esc("96"),
  "white":        esc("97"),
};

def bgcolor:
{
  "black":        esc("40"),
  "red":          esc("41"),
  "green":        esc("42"),
  "yellow":       esc("43"),
  "blue":         esc("44"),
  "magenta":      esc("45"),
  "cyan":         esc("46"),
  "lightgray":    esc("47"),
  "darkgray":     esc("100"),
  "lightred":     esc("101"),
  "lightgreen":   esc("102"),
  "lightyellow":  esc("103"),
  "lightblue":    esc("104"),
  "lightmagenta": esc("105"),
  "lightcyan":    esc("106"),
  "white":        esc("107"),
};

def style:
{
  "reset":         esc("0"), # alias
  "bold":          esc("1"),
  "dim":           esc("2"),
  "italic":        esc("3"),
  "underline":     esc("4"),
  "blink":         esc("5"),
  "reverse":       esc("7"),
  "hidden":        esc("8"),
  "strikethrough": esc("9")
};

# Helper
def colorize(s): (s | tostring) + reset.all;

# Actual functions
# Colors
def black(s):        colorize(color.black        + (s | tostring));
def red(s):          colorize(color.red          + (s | tostring));
def green(s):        colorize(color.green        + (s | tostring));
def yellow(s):       colorize(color.yellow       + (s | tostring));
def blue(s):         colorize(color.blue         + (s | tostring));
def magenta(s):      colorize(color.magenta      + (s | tostring));
def cyan(s):         colorize(color.cyan         + (s | tostring));
def lightgray(s):    colorize(color.lightgray    + (s | tostring));
def darkgray(s):     colorize(color.darkgray     + (s | tostring));
def lightred(s):     colorize(color.lightred     + (s | tostring));
def lightgreen(s):   colorize(color.lightgreen   + (s | tostring));
def lightyellow(s):  colorize(color.lightyellow  + (s | tostring));
def lightblue(s):    colorize(color.lightblue    + (s | tostring));
def lightmagenta(s): colorize(color.lightmagenta + (s | tostring));
def lightcyan(s):    colorize(color.lightcyan    + (s | tostring));
def white(s):        colorize(color.white        + (s | tostring));

# BG Colors
def bgblack(s):        colorize(bgcolor.black        + (s | tostring));
def bgred(s):          colorize(bgcolor.red          + (s | tostring));
def bggreen(s):        colorize(bgcolor.green        + (s | tostring));
def bgyellow(s):       colorize(bgcolor.yellow       + (s | tostring));
def bgblue(s):         colorize(bgcolor.blue         + (s | tostring));
def bgmagenta(s):      colorize(bgcolor.magenta      + (s | tostring));
def bgcyan(s):         colorize(bgcolor.cyan         + (s | tostring));
def bglightgray(s):    colorize(bgcolor.lightgray    + (s | tostring));
def bgdarkgray(s):     colorize(bgcolor.darkgray     + (s | tostring));
def bglightred(s):     colorize(bgcolor.lightred     + (s | tostring));
def bglightgreen(s):   colorize(bgcolor.lightgreen   + (s | tostring));
def bglightyellow(s):  colorize(bgcolor.lightyellow  + (s | tostring));
def bglightblue(s):    colorize(bgcolor.lightblue    + (s | tostring));
def bglightmagenta(s): colorize(bgcolor.lightmagenta + (s | tostring));
def bglightcyan(s):    colorize(bgcolor.lightcyan    + (s | tostring));
def bgwhite(s):        colorize(bgcolor.white        + (s | tostring));

# Styles
def reset(s):         colorize(reset.all           + (s | tostring));
def bold(s):          colorize(style.bold          + (s | tostring));
def dim(s):           colorize(style.dim           + (s | tostring));
def italic(s):        colorize(style.italic        + (s | tostring));
def underline(s):     colorize(style.underline     + (s | tostring));
def blink(s):         colorize(style.blink         + (s | tostring));
def reverse(s):       colorize(style.reverse       + (s | tostring));
def hidden(s):        colorize(style.hidden        + (s | tostring));
def strikethrough(s): colorize(style.strikethrough + (s | tostring));
