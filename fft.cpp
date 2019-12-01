#include <iostream>
#include <math.h>
#include <complex>

typedef std::complex<double> dcomp;
const dcomp j(0.0, 1.0);

dcomp twiddle(double power, double base); 
void radix2_shuffle(dcomp** input_vector, const int sig_length, const int num_steps);
void butterfly_sum(dcomp** input_vector, const int sig_length, const int num_steps);
void print_vector(dcomp* test_list, int length);

int main(int argc, char** argv) {

	// The length of a signal determines how many 'steps' are
	// necessary in the FFT implementation
	const int sig_length = 2;
	const int num_steps = log2(sig_length);

	// Create a dynamic array to contain each step of the FFT
	dcomp** layers = new dcomp* [num_steps+1];

	std::cout << "Number of steps required = " << num_steps << std::endl;

	std::cout << "Filling twiddle vector" << std::endl;
	dcomp twiddle_vec[4] = {0};
	for (int i = 1; i < 4; i++) {
		twiddle_vec[i] = twiddle(1.0, double(i));

		std::cout << "|\t" << twiddle_vec[i] << "\t|" << std::endl;
	}

	dcomp* test_list = new dcomp[sig_length] {0, 1}; //, 2, 3, 4}; //, 5, 6, 7}; //, 8, 9, 10, 11, 12, 13, 14, 15};

	std::cout << "Printing unshuffled vector:" << std::endl;
	print_vector(test_list, sig_length);

	radix2_shuffle(&test_list, sig_length, num_steps);

	std::cout << "Printing shuffled vector:" << std::endl;
	print_vector(test_list, sig_length);

	butterfly_sum(&test_list, sig_length, num_steps);

	delete [] layers;

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

		// std::cout << "Layer [" << layer << "], # Partitions [" << num_partitions << "], Part Length [" << partition_length << "], Shuffle Midpoint [" << shuffle_midpoint << "]" << std::endl;

		// Each step in the layer involves dividing all currently existing partitions in half.
		// We then treat each partition as an individual array to split it into two new arrays
		// and shift all values corresponding to the FFT symmetry
		for (int partition = 0; partition < num_partitions; partition++) {

			// std::cout << "Partition " << partition << std::endl;

			// Each partition is the same in length so looping through each one will be 
			// the same.  To adjust for differences in position use the partition number
			// and partition length to calculate the displaced i
			for (int i = 0; i < shuffle_midpoint; i++) {

				int displaced_i = i + partition * partition_length;

				/*
				std::cout << "Moving A(" << 2 * i + partition * partition_length << ") = " << current_layer[2*i + partition * partition_length]  << "-> B(" << displaced_i << ")" << std::endl;
				std::cout << "Moving A(" << 2 * i + 1 + partition * partition_length << ") = " << current_layer[2*i + 1 + partition * partition_length]  << "-> B(" << displaced_i + shuffle_midpoint << ")" << std::endl;
				*/

				next_layer[displaced_i] = current_layer[2*i + partition * partition_length];
				next_layer[displaced_i + shuffle_midpoint] = current_layer[2*i + 1 + partition * partition_length];
			}
		}

		/*
		std::cout << "Shuffle Layer " << layer << std::endl;
		print_vector(next_layer, sig_length);
		*/

		// Assign the current iteration of the shuffle to the input
		dcomp* tmp_ptr = current_layer;
		current_layer = next_layer;
		next_layer = tmp_ptr;
	}

	*input_vector = current_layer; 

	/*
	std::cout << "Output Vector" << std::endl;
	print_vector(*input_vector, sig_length);
	
	std::cout << "Current Layer Vector" << std::endl;
	print_vector(current_layer, sig_length);

	std::cout << "Next Layer Vector" << std::endl;
	print_vector(next_layer, sig_length);
	*/

	delete [] next_layer;
}


void butterfly_sum(dcomp** input_vector, const int sig_length, const int num_steps) {

	dcomp* shuffled_vector = *input_vector;
	dcomp* sum_vector = new dcomp[sig_length];

	// Loop through each divide and conquer step of the FFT algorithm
	for (int layer = num_steps - 1; layer >= 0; layer--) {
		
		// These three parameters will help determine how to loop through the current layer
		int num_partitions = pow(2.0, double(layer));
		int partition_length = sig_length / num_partitions;
		int shuffle_midpoint = partition_length / 2;

		std::cout << "Layer [" << layer << "], # Partitions [" << num_partitions << "], Part Length [" << partition_length << "], Shuffle Midpoint [" << shuffle_midpoint << "]" << std::endl;

		// Each step in the layer involves dividing all currently existing partitions in half.
		// We then treat each partition as an individual array to split it into two new arrays
		// and shift all values corresponding to the FFT symmetry
		for (int partition = 0; partition < num_partitions; partition++) {

			std::cout << "Partition " << partition << std::endl;

			// Each partition is the same in length so looping through each one will be 
			// the same.  To adjust for differences in position use the partition number
			// and partition length to calculate the displaced i
			for (int i = 0; i < shuffle_midpoint; i++) {

				int displaced_i = i + partition * partition_length;

				std::cout << "Adding A(" << 2 * i + partition * partition_length << ") = " << shuffled_vector[2*i + partition * partition_length]  << "+ B(" << displaced_i << ")" << std::endl;
				std::cout << "Adding A(" << 2 * i + 1 + partition * partition_length << ") = " << shuffled_vector[2*i + 1 + partition * partition_length]  << "+ B(" << displaced_i + shuffle_midpoint << ")" << std::endl;

				//sum_vector[displaced_i] = shuffled_vector[2*i + partition * partition_length];
				//sum_vector[displaced_i + shuffle_midpoint] = shuffled_vector[2*i + 1 + partition * partition_length];
			}
		}

		std::cout << "Shuffle Layer " << layer << std::endl;
		print_vector(sum_vector, sig_length);

		// Assign the current iteration of the shuffle to the input
		/*
		dcomp* tmp_ptr = shuffled_vector;
		shuffled_vector = sum_vector;
		sum_vector = tmp_ptr;
		*/
	}
	
	/*
	std::cout << "Input vector" << std::endl;
	print_vector(shuffled_vector, sig_length);

	std::cout << "Sum vector" << std::endl;
	print_vector(sum_vector, sig_length);
	*/

	delete [] sum_vector;
}

void print_vector(dcomp* test_list, int length) {

	for (int i = 0; i < length; i++) {
		std::cout << "|\t" << test_list[i] << "\t|" << std::endl;
	}
	std::cout << std::endl;
}
