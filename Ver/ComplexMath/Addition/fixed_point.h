#pragma once
#include <cnl/fixed_point.h>

// Create a fixed point type which has 10 integer bits and 6 fractional bits
typedef cnl::fixed_point<cnl::uint16, -6> fixpoint_16;
// Create a fixed point type which has 5 integer bits and 3 fractional bits
typedef cnl::fixed_point<cnl::uint16, -3> fixpoint_8;

// Short conversion functions to switch primitive integer types back to fixed point
fixpoint_8 int_to_fixed8(unsigned char);
fixpoint_16 int_to_fixed16(short signed int);
