#include <stdlib.h>
#include <iostream>

#include "Vcomplex_add.h"
#include "verilated.h"

#include <cnl/fixed_point.h>

// Create a fixed point type which has 10 integer bits and 6 fractional bits
typedef cnl::fixed_point<cnl::uint16, -6> fixpoint_16;
// Create a fixed point type which has 5 integer bits and 3 fractional bits
typedef cnl::fixed_point<cnl::uint16, -3> fixpoint_8;

// Short conversion functions to switch primitive integer types back to fixed point
fixpoint_8 int_to_fixed8(short signed char);
fixpoint_16 int_to_fixed16(short signed int);

int main(int argc, char **argv) {

    const int REAL_ONES = 255 << 8;
    const int IMAG_ONES = 255;

    // Initialize Verliators variables
    Verilated::commandArgs(argc, argv);

    // Create an instance of our module under test
    Vcomplex_add *test_unit = new Vcomplex_add;

    // Apply a few test cases
    //while(!Verilated::gotFinish()) {
    int A = 4 << 8;
    A = A | 33;
    int B = 2 << 8;
    B = B | 36;

    test_unit->i_A = A;
    test_unit->i_B = B;
    test_unit->eval();

    int out = test_unit->o_sum;
    int out_real = (out & REAL_ONES) >> 8;
    int out_imag = out & IMAG_ONES;

    //printf("Output: %d + %di\n", out_real, out_imag);

    /* Fixed point test case  */
    fixpoint_8 fix_A = fixpoint_8 {7.125};
    fixpoint_8 fix_B = fixpoint_8 {8.25};
    fixpoint_16 fix_O;

    test_unit->i_A = to_rep(fix_A);
    test_unit->i_B = to_rep(fix_B);
    test_unit->eval();

    out = test_unit->o_sum;
    //out_imag = out & IMAG_ONES;
    // Convert back to fixed-point
    fix_O = fixpoint_16{out >> 6};
    fixpoint_16 fix_O_fract = (fixpoint_16{out & 0x3F}) >> 6;
    fix_O += fix_O_fract;

    std::cout << "Output: " << to_rep(fix_A) << " * " << to_rep(fix_B) << " = " << fix_O  << "(" << to_rep(fix_O) << ")" << std::endl;
    std::cout << "Should be: " << fix_A * fix_B << std::endl;

    /* Fixed point test case 2 */
    fix_A = fixpoint_8 {0.5};
    fix_B = fixpoint_8 {0.5};

    test_unit->i_A = to_rep(fix_A);
    test_unit->i_B = to_rep(fix_B);
    test_unit->eval();

    out = test_unit->o_sum;
    //out_imag = out & IMAG_ONES;
    // Convert back to fixed-point
    fix_O = fixpoint_8 {out};
    fix_O = fix_O >> 6;

    std::cout << "Output: " << to_rep(fix_A) << " * " << to_rep(fix_B) << " = " << fix_O  << "(" << to_rep(fix_O) << ")" << std::endl;
    std::cout << "Should be: " << fix_A * fix_B << std::endl;

    // DONE
    test_unit->final();

    exit(EXIT_SUCCESS);
}

fixpoint_8 int_to_fixed8(short signed char) {

    fixpoint_8 converted_integer = fixpoint_8{out >> 3};
    fixpoint_8 converted_fraction = (fixpoint_8{out & 0x3F}) >> 3;
    return converted_integer + converted_fraction;
}

fixpoint_16 int_to_fixed16(short signed int) {

    fixpoint_16 converted_integer = fixpoint_16{out >> 6};
    fixpoint_16 converted_fraction = (fixpoint_16{out & 0x3F}) >> 6;
    return converted_integer + converted_fraction;
}
