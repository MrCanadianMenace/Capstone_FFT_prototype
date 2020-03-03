#include <stdlib.h>
#include "Vcomplex_add.h"
#include "verilated.h"

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

    printf("Output: %d + %di\n", out_real, out_imag);
    test_unit->final();

    exit(EXIT_SUCCESS);
}
