package main

import "core:testing"
import "core:fmt"

Point :: struct { x, y: int }

main :: proc() {
    input := string(#load("03.txt"))

    out1 := part_one(input);
    fmt.println("2025 - Day 3:1", out1)

    out2 := part_two(input);
    fmt.println("2025 - Day 3:2", out2)
}

part_one :: proc(input: string) -> int {
    m: map[Point]struct{}
    defer delete(m)

    position := Point { x = 0, y = 0 }
    m[position] = {}

    for c in input {

        switch c {
        case '^': position.y += 1
        case 'v': position.y -= 1
        case '>': position.x += 1
        case '<': position.x -= 1
        case:
        }

        m[position] = {}
    }

    return len(m)
}

part_two :: proc(input: string) -> int {
    m: map[Point]struct{}
    defer delete(m)

    santa := Point { x = 0, y = 0 }
    m[santa] = {}

    robo := Point { x = 0, y = 0 }
    m[robo] = {} // pointless but just in case robo start in a different house

    for c, index in input {

        position : ^Point

        if index % 2 == 0 {
            position = &santa
        } else {
            position = &robo
        }

        switch c {
        case '^': position.y += 1
        case 'v': position.y -= 1
        case '>': position.x += 1
        case '<': position.x -= 1
        case:
        }

        m[position^] = {}
    }

    return len(m)
}

@(test)
test_one :: proc(t: ^testing.T) {
    output := part_one(">")
    testing.expect_value(t, output, 2)

    output = part_one("^>v<")
    testing.expect_value(t, output, 4)

    output = part_one("^v^v^v^v^v")
    testing.expect_value(t, output, 2)
}

@(test)
test_two :: proc(t: ^testing.T) {
    output := part_two("^v")
    testing.expect_value(t, output, 3)

    output = part_two("^>v<")
    testing.expect_value(t, output, 3)

    output = part_two("^v^v^v^v^v")
    testing.expect_value(t, output, 11)
}