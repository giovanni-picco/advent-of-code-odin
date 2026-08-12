package main

import "core:testing"
import "core:fmt"

main :: proc() {

	input := string(#load("01.txt"))
	out1 := part_one(input);
	fmt.println("2025 - Day 1:1", out1)
	
	out2 := part_two(input);
	fmt.println("2025 - Day 1:2", out2)
	
}

part_one :: proc(input: string) -> int {
	floor := 0
	for c in input {
		switch c {
		case '(': floor += 1
		case ')': floor -= 1
		case:
		}
	}
	return floor
}

part_two :: proc(input: string) -> int {
	
	floor := 0
	for c, index in input {
		switch c {
		case '(': floor += 1
		case ')': floor -= 1
		case:
		}
		if floor == -1 do return index+1
	}
	return len(input)
}

@(test)
test_one :: proc(t: ^testing.T) {
	out1 := part_one("(()(()(")
	testing.expect_value(t, out1, 3)
}

@(test)
test_two :: proc(t: ^testing.T) {
	out2 := part_two(")(((((((")
	testing.expect_value(t, out2, 1)
}