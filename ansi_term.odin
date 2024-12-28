package ansi_term

import "core:os"

enter_alt_buffer :: proc() -> os.Error {
    _, err := os.write_string(os.stdout, "\x1b[1049h")
    return err
}

exit_alt_buffer :: proc() -> os.Error {
    _, err := os.write_string(os.stdout, "\x1b[1049l")
    return err
}
