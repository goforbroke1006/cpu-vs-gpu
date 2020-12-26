# cpu-vs-gpu

Based on answer https://stackoverflow.com/a/7664280 by [Patrick87](https://stackoverflow.com/users/847269/patrick87)

### Requirements

* Ubuntu 20
* NVIDIA video card
* NVIDIA driver >= 460
* CUDA 10
* GCC 8

### How to run

1. Install NVIDIA driver and CUDA
2. Install another tools

   ```bash
   bash ./setup.sh 
   ```

3. Run build and benchmark

   ```bash
   make
   ```

### Comparison table

| Samples count (N) | GPU (GeForce MX250 2048Mb) | CPU (i7-10850H CPU @ 2.70GHz) |
|-------------------|-----|-----|
| 1024              | 0 min 0.19 sec | 0 min 3.58 sec  |
| 1024 * 32         | 0 min 0.27 sec | 1 min 48.64 sec |
| 1024 * 128        | 0 min 0.40 sec | 7 min 14.17 sec |

### Useful links

* https://cuda-tutorial.readthedocs.io/en/latest/tutorials/tutorial01/
