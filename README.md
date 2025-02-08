# Jetson TX2 Containers

The Jetson TX2 is out-dated in many ways, but still better then running AI models on CPU. Maybe there are some containers we can hack from scratch to run some current cases on CUDA 10.2.


|Image|OS|Python|Description|
|-|-|-|-|
|devbar/tx2-pytorch|Ubuntu 20.04|Python 3.8|CUDA 10.2

## Quickstart
Bootstrap TX2 with NVIDIA sdk-manager. If you don't have a Ubuntu 18.04 to flash from, think about using the [flash-from-docker approach](https://notes.rdu.im/hardware/jetson/flash-jetson-with-docker/).

```
sudo ./build.sh
sudo ./run.sh
```
Make a quick test, if cuda is working.
```
sudo docker exec -it tx2-pytorch /bin/bash
python3
> import torch
> torch.cuda.is_available()
True
```