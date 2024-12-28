package terminal

import "core:fmt"

Style :: struct {
    set:   int,
    reset: int,
}

Bold :: Style{1, 22}
Dim :: Style{2, 22}
Italic :: Style{3, 23}
Underline :: Style{4, 24}
Blink :: Style{5, 25}
Inverse :: Style{7, 27}
Hidden :: Style{8, 28}
Strikethrough :: Style{9, 29}

style :: proc(s: string, g: Style, allocator := context.allocator) -> string {
    return fmt.aprintf("\x1b[%dm%s\x1b[%dm", g.set, s, g.reset, allocator = allocator)
}

bold :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Bold, allocator)
}

dim :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Dim, allocator)
}

italic :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Italic, allocator)
}

underline :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Underline, allocator)
}

blink :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Blink, allocator)
}

invert :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Inverse, allocator)
}

hide :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Hidden, allocator)
}

strike :: proc(s: string, allocator := context.allocator) -> string {
    return style(s, Strikethrough, allocator)
}
