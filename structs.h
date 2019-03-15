#include <cuda.h>

#define FIXED_K 12
#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) <= (y)) ? (x) : (y))

typedef struct parameters_index{
    unsigned long z_value;
    unsigned long kmer_size;
	unsigned long items_read;
	unsigned long global_item_size;
	unsigned long kmers_per_work_item;
    unsigned long offset;
} Parameters_index;

typedef struct hash_item{
    //unsigned char bitmask[8];
    unsigned long repeat;
    unsigned long key;
    unsigned long pos_in_x;
    unsigned long pos_in_y;
} Hash_item;