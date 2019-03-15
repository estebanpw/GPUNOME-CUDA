#include "kernels.cuh"


__global__ void kernel_index(Hash_item * hash_table, Parameters_index * params, const char * sequence) {
	// Get the index of the current element to be processed
	unsigned long global_id = blockDim.x;
	//ulong local_id = get_local_id(0);
	unsigned long kmers_in_work_item = params->kmers_per_work_item;
	unsigned long kmer_size = params->kmer_size;
	unsigned long z_value = params->z_value;
	unsigned long t_work_items = params->global_item_size;
	unsigned long offset = params->offset;
	unsigned long j, k;

	// Until reaching end of sequence
	for(j=0; j<kmers_in_work_item; j++){
		
		// Coalescent
        unsigned long pos = global_id + (j * t_work_items);
        
        
        unsigned long hash12 = 0, hash_full = 0;
		unsigned char checker = 0, multiplier = 0, val;
		
		for(k=0; k<FIXED_K; k++){
			val = (unsigned char) sequence[pos+k];
			multiplier = (val & (unsigned char) 6) >> 1;
			checker = checker | (val & (unsigned char) 8); // Verified
			hash12 += (((unsigned long) 1) << (2*k)) * (unsigned long) multiplier;
        }

        
        
        hash_full = hash12;
        
		for(k=FIXED_K; k<kmer_size; k+=z_value){
			val = (unsigned char) sequence[pos+k];
			multiplier = (val & (unsigned char) 6) >> 1;
			checker = checker | (val & (unsigned char) 8); // Verified
			hash_full += (((unsigned long) 1) << (2*k)) * (unsigned long) multiplier;
        }
        
        
		if(checker == (unsigned char) 0){ // Verified
			hash_table[0].key = hash_full;
			//hash_table[hash12].key = hash_full;
			//hash_table[hash12].pos_in_x = pos + offset;
			//atom_inc(&hash_table[hash12].repeat);
        }	
        
	}
}