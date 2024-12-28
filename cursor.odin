package ansi_term

import "core:fmt"
import "core:os"
import vmem "core:mem/virtual"

// move the cursor to col, row
cursor_move_to :: proc(x, y: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%d;%df", y, x, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

// move the cursor up by n rows
cursor_up_by :: proc(n: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%dA", n, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

// move the cursor down by n rows
cursor_down_by :: proc(n: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%dB", n, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

// move the cursor right by n cols
cursor_right_by :: proc(n: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%dC", n, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

// move the cursor left by n cols
cursor_left_by :: proc(n: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%dD", n, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

// move the cursor to the start of the line, n rows down
cursor_return_down_by :: proc(n: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%dE", n, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

// move the cursor to the start of the line, n rows up
cursor_return_up_by :: proc(n: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%dF", n, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

cursor_to_col :: proc(n: int) -> (err: os.Error) {
    arena: vmem.Arena
    alloc := vmem.arena_allocator(&arena)

    code := fmt.aprintf("\x1b[%dG", n, allocator = alloc)
    _, err = os.write_string(os.stdout, code)
    return
}

cursor_save :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[s")
    return
}

cursor_restore :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[u")
    return
}

cursor_hide :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[?25l")
    return
}

cursor_show :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[?25h")
    return
}
