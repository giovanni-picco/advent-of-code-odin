package main

import "core:testing"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() {
	input := string(#load("02.txt"))

	out1 := part_one(input);
	fmt.println("2025 - Day 2:1", out1)
	
	out2 := part_two(input);
	fmt.println("2025 - Day 2:2", out2)
}

part_one :: proc(input: string) -> (output: int) {
	lines := strings.split_lines(input)
	defer delete(lines)

	for line in lines {
		if line == "" do continue

		args := strings.split(line, "x")
		defer delete(args)

		l, _ := strconv.parse_int(args[0])
		w, _ := strconv.parse_int(args[1])
		h, _ := strconv.parse_int(args[2])

		l_w := l * w;
		w_h := w * h;
		h_l := h * l;

		output += (l_w + w_h + h_l) * 2 + min(l_w, w_h, h_l)
	}
	return
}

part_two :: proc(input: string) -> (output: int) {
	lines := strings.split_lines(input)
	defer delete(lines)

	for line in lines {
		if line == "" do continue

		args := strings.split(line, "x")
		defer delete(args)

		l, _ := strconv.parse_int(args[0])
		w, _ := strconv.parse_int(args[1])
		h, _ := strconv.parse_int(args[2])

		d := []int { l, w, h }
		slice.sort(d)

		output += (d[0] + d[1]) * 2 + l*w*h
	}
	return
}

@(test)
test_one :: proc(t: ^testing.T) {
	output := part_one("2x3x4")
	testing.expect_value(t, output, 58)
}

@(test)
test_two :: proc(t: ^testing.T) {
	output := part_two("2x3x4")
	testing.expect_value(t, output, 34)
}