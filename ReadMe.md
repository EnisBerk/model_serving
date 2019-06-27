
# Compatibility
* The OnnxParser shipped with TensorRT 5.1.x supports ONNX IR (Intermediate Representation) version 0.0.3, opset version 9
* Release 19.05 supports CUDA compute capability 6.0 and higher. So **NO K80**.

# Steps to reproduce:
```bash
## get example models
git clone https://github.com/NVIDIA/tensorrt-inference-server.git && \
cd tensorrt-inference-server/ && \
git checkout r19.05 && \
cd docs/examples && \
./fetch_models.sh && \
cd ../../..

## get serving docker
docker pull nvcr.io/nvidia/tensorrtserver:19.05-py3

## build server_client image and push or pull it
# cd tensorrt-inference-server
# docker build -t tensorrtserver_client -f Dockerfile.client .
# docker images
# docker tag c76b36819b1f enisberk/tensorrtserver_client:19.05
# docker push  enisberk/tensorrtserver_client:19.05
docker pull enisberk/tensorrtserver_client:19.05



## run serving
docker run --rm --runtime=nvidia --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 -p8000:8000 -p8001:8001 -p8002:8002 -v/home/enis/tensorrt-inference-server/docs/examples/model_repository/:/models nvcr.io/nvidia/tensorrtserver:19.05-py3 trtserver  --model-store=/models &
#
# get status
curl localhost:8000/api/status

docker run -it --rm --net=host tensorrtserver_client:19.05

python src/clients/python/image_client.py  -m resnet50_netdef -s INCEPTION images/mug.jpg
#client code
https://github.com/NVIDIA/tensorrt-inference-server/blob/master/src/clients/python/image_client.py

```

ls /home/enis/tensorrt-inference-server/docs/examples/model_repository/

### Resources
* [TensorRT support matrix (not serving)](https://docs.nvidia.com/deeplearning/sdk/tensorrt-support-matrix/index.html)
* [TensorRT API supported types](https://docs.nvidia.com/deeplearning/sdk/tensorrt-api/python_api/infer/FoundationalTypes/pyFoundationalTypes.html)
* [TensorRT github page](https://github.com/nvidia/TensorRT)
* [TensorRT dev guide](https://docs.nvidia.com/deeplearning/sdk/tensorrt-developer-guide)
* [TensorRT serving blog post](https://devblogs.nvidia.com/nvidia-serves-deep-learning-inference/)
* [TensorRT in tensorflow code](https://github.com/tensorflow/models/blob/master/research/tensorrt/tensorrt.py)
* [image_client for tensor_rt](https://github.com/NVIDIA/tensorrt-inference-server/blob/master/src/clients/python/image_client.py)
