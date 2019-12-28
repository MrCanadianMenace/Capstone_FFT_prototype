#include <iostream>
#include <math.h>
#include <complex>
#include <chrono>

typedef std::complex<double> dcomp;
typedef std::complex<int> int_comp;
const dcomp j(0.0, 1.0);

dcomp twiddle(double power, double base); 
void radix2_shuffle(dcomp** input_vector, const int sig_length, const int num_steps);
void butterfly_sum(dcomp** input_vector, const int sig_length, const int num_steps);
void print_vector(dcomp* test_list, int length);

int main(int argc, char** argv) {

	// The length of a signal determines how many 'steps' are
	// necessary in the FFT implementation
	const int sig_length = atoi(argv[1]);
	const int num_steps = log2(sig_length);

	dcomp* test_list = new dcomp[sig_length]; 

	for (int count = 1; count <= 5; count++) {

		
		for (int i = 0; i < sig_length; i++) {
			test_list[i] = sin(i);
		}

		// Start Timer
		auto fft_start = std::chrono::high_resolution_clock::now();

		radix2_shuffle(&test_list, sig_length, num_steps);

		butterfly_sum(&test_list, sig_length, num_steps);

		// Finish Timer
		auto fft_stop = std::chrono::high_resolution_clock::now();
		auto duration = std::chrono::duration_cast<std::chrono::microseconds>(fft_stop - fft_start);
	
		std::cout << "Run# " << count  << "  Signal Length: " << sig_length << "  Execution Time: " << duration.count() << " microseconds" << std::endl;
	}

	delete [] test_list;

	return 0;
}

dcomp twiddle(double power, double base) {

	return exp(-2.0 * j * M_PI * power / base);
}

void radix2_shuffle(dcomp** input_vector, const int sig_length, const int num_steps) {

	dcomp* current_layer = *input_vector;
	dcomp* next_layer = new dcomp[sig_length];

	// Loop through each divide and conquer step of the FFT algorithm
	for (int layer = 0; layer < num_steps - 1; layer++) {
		
		// These three parameters will help determine how to loop through the current layer
		int num_partitions = pow(2.0, double(layer));
		int partition_length = sig_length / num_partitions;
		int shuffle_midpoint = partition_length / 2;

		// Each step in the layer involves dividing all currently existing partitions in half.
		// We then treat each partition as an individual array to split it into two new arrays
		// and shift all values corresponding to the FFT symmetry
		for (int partition = 0; partition < num_partitions; partition++) {

			// Each partition is the same in length so looping through each one will be 
			// the same.  To adjust for differences in position use the partition number
			// and partition length to calculate the displaced i
			for (int i = 0; i < shuffle_midpoint; i++) {

				int displaced_i = i + partition * partition_length;

				next_layer[displaced_i] = current_layer[2*i + partition * partition_length];
				next_layer[displaced_i + shuffle_midpoint] = current_layer[2*i + 1 + partition * partition_length];
			}
		}

		// Assign the current iteration of the shuffle to the input
		dcomp* tmp_ptr = current_layer;
		current_layer = next_layer;
		next_layer = tmp_ptr;
	}

	*input_vector = current_layer; 

	delete [] next_layer;
}


void butterfly_sum(dcomp** input_vector, const int sig_length, const int num_steps) {

	dcomp* current_layer = *input_vector;
	dcomp* sum_vector = new dcomp[sig_length];

	// Loop through each divide and conquer step of the FFT algorithm
	for (int layer = 0; layer < num_steps; layer++) {
		
		// These three parameters will help determine how to loop through the current layer
		int layer_order = num_steps - 1 - layer;
		int num_partitions = pow(2.0, double(layer_order));
		int partition_length = sig_length / num_partitions;
		int shuffle_midpoint = partition_length / 2;

		for (int partition = 0; partition < num_partitions; partition++) {

			// Each partition is the same in length so looping through each one will be 
			// the same.  To adjust for differences in position use the partition number
			// and partition length to calculate the displaced i
			for (int i = 0; i < shuffle_midpoint; i++) {

				int displaced_i = i + partition * partition_length;

				sum_vector[displaced_i] = current_layer[displaced_i] + current_layer[displaced_i + shuffle_midpoint] * twiddle(displaced_i, pow(2.0, layer + 1));
				sum_vector[displaced_i + shuffle_midpoint] = current_layer[displaced_i] + current_layer[displaced_i + shuffle_midpoint] * twiddle(displaced_i + shuffle_midpoint, pow(2.0, layer + 1));
			}
		}

		// Assign the sum from the current iteration to the current layer
		dcomp* tmp_ptr = current_layer;
		current_layer = sum_vector;
		sum_vector = tmp_ptr;
	}
	
	*input_vector = current_layer;

	delete [] sum_vector;
}

void print_vector(dcomp* test_list, int length) {

	for (int i = 0; i < length; i++) {
		dcomp unrounded_complex = test_list[i];
		printf("|\t(%.3f, %.3f)\t|\n", std::real(unrounded_complex), std::imag(unrounded_complex));
	}
	std::cout << std::endl;
}
