package ansi_term

import "core:os"

enter_alt_buffer :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[1049h")
    return
}

exit_alt_buffer :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[1049l")
    return
}

screen_save :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[?47h")
    return
}

screen_restore :: proc() -> (err: os.Error) {
    _, err = os.write_string(os.stdout, "\x1b[?47l")
    return
}
