mkdir /tmp/models
cp config.properties /tmp/models/config.properties
cp config.properties /home/model-server/tmp/config.properties
mxnet-model-server --start --models squeezenet=https://s3.amazonaws.com/model-server/model_archive_1.0/squeezenet_v1.1.mar
