
# ONNX inference
  * [ONNX runtime](https://github.com/microsoft/onnxruntime) only makes inference no serving
  * It has support for tensorRT [src](https://azure.microsoft.com/en-us/blog/onnx-runtime-integration-with-nvidia-tensorrt-in-preview/)
```bash
#
docker_image= "mcr.microsoft.com/azureml/onnxruntime:v0.4.0-tensorrt19.03"
```

# ONNX serving
<!-- docker pull awsdeeplearningteam/mxnet-model-server:latest-gpu -->

```bash
#
gradient jobs create \
--name inference \
--machineType K80 \
--container awsdeeplearningteam/mxnet-model-server:latest-gpu \
--ports 8080:8080,8081:8081 \
--command 'bash serv_onnx.sh' \
 --workspace './'
```
