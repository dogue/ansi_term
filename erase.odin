package ansi_term

import "core:os"

erase_screen_from_cursor_to_end :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[0J")
    return
}

erase_screen_from_cursor_to_beginning :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[1J")
    return
}

erase_screen :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[2J")
    return
}

erase_line_from_cursor_to_end :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[0K")
    return
}

erase_line_from_start_to_cursor :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[1K")
    return
}

erase_line :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[2K")
    return
}
