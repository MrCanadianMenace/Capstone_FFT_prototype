#include <stdlib.h>
#include <iostream>

#include "Vcomplex_add.h"
#include "verilated.h"

#include <cnl/fixed_point.h>

// Create a fixed point type which has 10 integer bits and 6 fractional bits
typedef cnl::fixed_point<cnl::uint16, -6> fixpoint_16;
// Create a fixed point type which has 5 integer bits and 3 fractional bits
typedef cnl::fixed_point<cnl::uint16, -3> fixpoint_8;

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
    auto fix_A = fixpoint_8 {5.125};
    auto fix_B = fixpoint_8 {3.25};
    auto fix_O = fixpoint_8 {0};

    test_unit->i_A = to_rep(fix_A);
    test_unit->i_B = to_rep(fix_B);
    test_unit->eval();

    out = test_unit->o_sum;
    out_imag = out & IMAG_ONES;
    // Convert back to fixed-point
    fix_O = fixpoint_8(out_imag);
    fix_O = fix_O >> 3;

    std::cout << "Output: " << fix_O << std::endl;
    std::cout << "Should be: " << fix_A + fix_B << std::endl;
    test_unit->final();

    exit(EXIT_SUCCESS);
}
