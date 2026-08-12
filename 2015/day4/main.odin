package main

import "core:testing"
import "core:fmt"
import "core:strings"
import hash "core:crypto/hash"
import "core:encoding/hex"

main :: proc() {
    input := string(#load("04.txt"))

    out1 := part_one(input);
    fmt.println("2025 - Day 4:1", out1)

    out2 := part_two(input);
    fmt.println("2025 - Day 4:2", out2)
}

part_one :: proc(input: string) -> int {
    for i := 1;; i += 1 {
        before := fmt.aprintf("%s%d", input, i)
        defer delete(before)

        hashed := hash.hash_string(.Insecure_MD5, before)
        defer delete(hashed)

        value := hex.encode(hashed)
        defer delete(value)

        if(strings.has_prefix(string(value), "00000")) do return i
    }
    return 0
}

part_two :: proc(input: string) -> int {
    for i := 1;; i += 1 {
        before := fmt.aprintf("%s%d", input, i)
        defer delete(before)

        hashed := hash.hash_string(.Insecure_MD5, before)
        defer delete(hashed)

        value := hex.encode(hashed)
        defer delete(value)

        if(strings.has_prefix(string(value), "000000")) do return i
    }
    return 0
}

@(test)
test_one :: proc(t: ^testing.T) {
    output := part_one("abcdef")
    testing.expect_value(t, output, 609043)

    output = part_one("pqrstuv")
    testing.expect_value(t, output, 1048970)
}

@(test)
test_two :: proc(t: ^testing.T) {

}