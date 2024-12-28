package raw

import "core:os"
import "core:strings"
import "core:strconv"

ParseIntErr :: struct{
    src: string,
}

Error :: union {
    ParseIntErr,
    os.Error,
}

// returns the current row and column position of the cursor
// an error during read/write will return the underlying os.Error
// a failure during integer parsing will return ParseIntErr and set row/col to -1
get_cursor_pos :: proc(allocator := context.allocator) -> (row: int, col: int, err: Error) {
    // report cursor position
    os.write_string(os.stdout, "\x1b[6n") or_return

    // The buffer size of 16 bytes is arbitrary. The character sequence returned by the terminal
    // is 4 bytes + 1 for each digit of the row and column values. This means that a terminal
    // of size 999x999 would return \x1b[999;999R, or 10 bytes.
    buf: [16]u8
    n := os.read(os.stdin, buf[:]) or_return

    // ignore escape, prefix, and suffix
    s := string(buf[2:n - 1])
    pos := strings.split(s, ";", allocator)

    ok: bool
    row, ok = strconv.parse_int(pos[0]);
    if !ok {
        err = ParseIntErr{ src = strings.clone(s) }
        return
    }

    col, ok = strconv.parse_int(pos[1])
    if !ok {
        err = ParseIntErr{ src = strings.clone(s) }
        return
    }

    return
}

get_term_size :: proc(allocator := context.allocator) -> (rows: int, cols: int, err: Error) {
    // save current cursor
    os.write_string(os.stdout, "\x1b[s") or_return

    // move the cursor outside of any reasonable terminal size, forcing it to the bottom right
    os.write_string(os.stdout, "\x1b[999;999f") or_return

    rows, cols = get_cursor_pos(allocator) or_return

    // restore cursor position
    os.write_string(os.stdout, "\x1b[u") or_return
    return
}

enter_alt_buffer :: proc() -> Error {
    os.write_string(os.stdout, "\x1b[?1049h") or_return
    return nil
}

exit_alt_buffer :: proc() -> Error {
    os.write_string(os.stdout, "\x1b[?1049l") or_return
    return nil
}
