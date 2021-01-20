# cpu-vs-gpu

CPU and GPU profiles comparison.

### Requirements

* Ubuntu 20
* NVIDIA video card
* NVIDIA driver >= 460
* CUDA 10
* GCC 8
* Valgrind

### How to run

1. Install NVIDIA driver and CUDA

```bash
sudo apt-get install cuda-10-0 cuda-toolkit-10-0
```

or try

https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=2004&target_type=deblocal

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda-repo-ubuntu2004-11-2-local_11.2.0-460.27.04-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-2-local_11.2.0-460.27.04-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-2-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda cuda-toolkit-11-2
```


2. Install another tools

   ```bash
   bash ./setup.sh 
   ```

3. Run build and benchmark

   ```bash
   make
   ```

### Comparison table

#### calculation sample

| Samples count (N) | GPU (GeForce MX250 2048Mb) | CPU (i7-10850H CPU @ 2.70GHz) |
|-------------------|-----------------|-----------------|
| 256               | 0 min 0.004 sec | 0 min 0.77 sec  |
| 4096              | 0 min 0.009 sec | 0 min 12.54 sec |
| 65536             | 0 min 0.119 sec | 3 min 18.71 sec |
| 262144            | 0 min 0.431 sec | 7 min 14.17 sec |

#### vector-add

| Samples count (N) | GPU (GeForce MX250 2048Mb) | CPU (i7-10850H CPU @ 2.70GHz) |
|-------------------|--------------------|------------------|
| 256               | 0 min 0.000008 sec | 0 min 0.002 sec  |
| 4096              | 0 min 0.000859 sec | 0 min 0.04 sec   |
| 65536             | 0 min 0.237 sec    | 0 min 9.50 sec   |
| 262144            | 0 min 3.66 sec     | 2 min 31.10 sec  |

### Useful links

* https://cuda-tutorial.readthedocs.io/en/latest/
* https://eax.me/c-cpp-profiling/
