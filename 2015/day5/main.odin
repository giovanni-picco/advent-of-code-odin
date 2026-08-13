package main

import "core:fmt"
import "core:strings"
import "core:testing"

main :: proc() {
	input := string(#load("05.txt"))

	out1 := part_one(input)
	fmt.println("2025 - Day 5:1", out1)

	out2 := part_two(input)
	fmt.println("2025 - Day 5:2", out2)
}

part_one :: proc(input: string) -> int {
	lines := strings.split_lines(input)
	defer delete(lines)

	nice_str := make([dynamic]string)
	defer delete(nice_str)

	for_line: for line in lines {

		bad_combo := [?]string{"ab", "cd", "pq", "xy"}
		for combo in bad_combo {
			if strings.contains(line, combo) do continue for_line
		}

		repeted_char: bool
		vowels_count := 0
		last_char: rune
		for c in line {
			is_vowels := strings.contains_rune("aeiou", c)
			if (is_vowels) {
				vowels_count += 1
			}

			if (c == last_char) {
				repeted_char = true
			}

			last_char = c
		}

		if (vowels_count >= 3 && repeted_char) {
			append(&nice_str, line)
		}

	}

	return len(nice_str)
}

part_two :: proc(input: string) -> int {
	lines := strings.split_lines(input)
	defer delete(lines)
	
    nice_str := make([dynamic]string)
	defer delete(nice_str)

    for line in lines {
		two_char_before: rune
		one_char_before: rune
	
        repeted_pair := false
		repeted_with_between := false
		
        pair_map: map[string]int
		defer delete_pair_map(&pair_map)
		
        for c, index in line {
			if index == 0 {
				one_char_before = c
				continue
			}
		
            if two_char_before == c {
				repeted_with_between = true
			}
			
            pair := fmt.aprintf("%c%c", one_char_before, c)
			
            start := index - 1
			
            if mval, present := pair_map[pair]; present {
				if start - mval > 1 {
					repeted_pair = true
				}
				delete(pair)
			} else {
				pair_map[pair] = start
			}

			two_char_before = one_char_before
			one_char_before = c
		}

		if repeted_pair && repeted_with_between {
			append(&nice_str, line)
		}
	}
	return len(nice_str)
}

delete_pair_map :: proc(m: ^map[string]int) {
	for key in m {
		delete(key)
	}
	delete(m^)
}

@(test)
test_one :: proc(t: ^testing.T) {
	output := part_one("ugknbfddgicrmopn")
	testing.expect_value(t, output, 1)

	output = part_one("aaa")
	testing.expect_value(t, output, 1)

	output = part_one("jchzalrnumimnmhp")
	testing.expect_value(t, output, 0)

	output = part_one("haegwjzuvuyypxyu")
	testing.expect_value(t, output, 0)

	output = part_one("dvszwmarrgswjxmb")
	testing.expect_value(t, output, 0)
}

@(test)
test_two :: proc(t: ^testing.T) {
	output := part_two("qjhvhtzxzqqjkmpb")
	testing.expect_value(t, output, 1)

	output = part_two("xxyxx")
	testing.expect_value(t, output, 1)

	output = part_two("uurcxstgmygtbstg")
	testing.expect_value(t, output, 0)

	output = part_two("ieodomkazucvgmuy")
	testing.expect_value(t, output, 0)
}

