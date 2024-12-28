package terminal

import "core:fmt"

ResetAll :: 0

// escape fstring for ANSI colors
F_ANSI :: "\x1b[%dm%s\x1b[%dm"

// for 256 color
F_256 :: "\x1b[%d;5;%dm%s\x1b[%dm"
FG_256 :: 38
BG_256 :: 48

// RGB
F_RGB :: "\x1b[%d;2;%d;%d;%dm%s\x1b[%dm"
FG_RGB :: 38
BG_RGB :: 48

ColorANSI :: enum {
    Black         = 30,
    Red           = 31,
    Green         = 32,
    Yellow        = 33,
    Blue          = 34,
    Magenta       = 35,
    Cyan          = 36,
    White         = 37,
    Default       = 39,
    BrightBlack   = 90,
    BrightRed     = 91,
    BrightGreen   = 92,
    BrightYellow  = 93,
    BirhgtBlue    = 94,
    BrightMagenta = 95,
    BrightCyan    = 96,
    BrightWhite   = 97,
}

Color256 :: distinct u8

ColorRGB :: [3]int

Color :: union #no_nil {
    ColorANSI,
    Color256,
    ColorRGB,
}

Reset :: int(ColorANSI.Default)

fg :: proc {
    fg_ansi,
    fg_256,
    fg_rgb,
}

fg_ansi :: proc(s: string, c: ColorANSI, allocator := context.allocator) -> string {
    return fmt.aprintf(F_ANSI, c, s, Reset, allocator = allocator)
}

fg_256 :: proc(s: string, c: Color256, allocator := context.allocator) -> string {
    return fmt.aprintf(F_256, FG_256, c, s, Reset, allocator = allocator)
}

fg_rgb :: proc(s: string, c: ColorRGB, allocator := context.allocator) -> string {
    return fmt.aprintf(F_RGB, FG_RGB, c.r, c.g, c.b, s, Reset, allocator = allocator)
}

bg :: proc {
    bg_ansi,
    bg_256,
    bg_rgb,
}

bg_ansi :: proc(s: string, c: ColorANSI, allocator := context.allocator) -> string {
    return fmt.aprintf(F_ANSI, int(c) + 10, s, Reset, allocator = allocator)
}

bg_256 :: proc(s: string, c: Color256, allocator := context.allocator) -> string {
    return fmt.aprintf(F_256, BG_256, c, s, Reset, allocator = allocator)
}

bg_rgb :: proc(s: string, c: ColorRGB, allocator := context.allocator) -> string {
    return fmt.aprintf(F_RGB, BG_RGB, c.r, c.g, c.b, s, Reset, allocator = allocator)
}
