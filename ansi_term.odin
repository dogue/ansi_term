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

