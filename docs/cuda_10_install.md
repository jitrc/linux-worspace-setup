Cuda 10,cudnn,TensorRT
======================
 * https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
 * https://developer.nvidia.com/cuda-toolkit
 * https://www.tensorflow.org/install/gpu
 * https://docs.nvidia.com/deeplearning/sdk/tensorrt-install-guide/index.html
 * https://developer.nvidia.com/cudnn


Install Cuda 10
---------------
```bash

#wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1604_10.1.168-1_amd64.deb
#sudo dpkg -i cuda-repo-ubuntu*.deb
#sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu${VERSION/./}/x86_64/7fa2af80.pub


VERSION=$(lsb_release -rs)
ubuntu${VERSION/./}
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${VERSION/./}/x86_64/cuda-ubuntu1604.pin
sudo mv cuda-ubuntu1604.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu${VERSION/./}/x86_64/7fa2af80.pub
#sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu${VERSION/./}/x86_64/ /"
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${VERSION/./}/x86_64 /" |  sudo tee /etc/apt/sources.list.d/cuda.list  > /dev/null

sudo apt-get update
sudo apt-get -y install cuda
#sudo apt-get install --no-install-recommends cuda-10-0 


```

ENV in ~/.bashrc
-----------------
```bash
echo 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}' >>~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >>~/.bashrc
```


Install Cudnn
--------------
```bash

#wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu${VERSION/./}/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
#sudo dpkg -i nvidia-machine-learning-repo-*.deb


echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu${VERSION/./}/x86_64 /"  |  sudo tee  /etc/apt/sources.list.d/nvidia-ml.list> /dev/null

sudo apt-get update
apt-cache show libcudnn7 | grep Version
sudo apt-get install --no-install-recommends \
libcudnn7=7.6.0.64-1+cuda10.0 \
libcudnn7-dev=7.6.0.64-1+cuda10.0
sudo apt-mark hold libcudnn7 libcudnn7-dev 

```

Install TensorRT (Requires that libcudnn7 is installed above)
-----------------
```bash
apt-cache show libnvinfer5 |grep Version
sudo apt-get install nvinfer-runtime-trt-repo-ubuntu1604-5.0.2-ga-cuda10.0 
sudo apt-get install -y --no-install-recommends \
libnvinfer5=5.1.5-1+cuda10.0  \
libnvinfer-dev=5.1.5-1+cuda10.0
sudo apt-mark hold libnvinfer5 libnvinfer-dev
```

Test
----
```bash
Restart or source ~/.bashrc
nvidia-smi
nvcc -V

#/usr/local/cuda-10.0/bin/cuda-install-samples-10.0.sh ~
cuda-install-samples-10.0.sh ~

cd ~/NVIDIA_CUDA-10.0_Samples/1_Utilities/deviceQuery
make
./deviceQuery
```
