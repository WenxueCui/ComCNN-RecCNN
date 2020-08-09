# RecCNN
The RecCNN code of paper "An End-to-End Compression Framework Based on Convolutional Neural Networks". TCSVT

## Framework of RecCNN

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/reccnn.jpg)

## Requirements

* Windows10
* Matlab R2015b
* MatconvNet 1.0-beta23 (https://www.vlfeat.org/matconvnet/)
* CUDA 8.0 (CPU is OK)

## How to Run

### Training RecCNN

We have provided the pretrained model of RecCNN in the folder `ComCNN/RecCNN_model`.

* Generating the training data of RecCNN model (The pretrained ComCNN is used) by running `data/GenerateData_model_64_25_Res_Bnorm_Adam.m`.
* Training the RecCNN model by running `Demo_Train_model_QP_30.m`, and copying the produced RecCNN model into `ComCNN/RecCNN_model`

### Testing ComCNN and RecCNN

Through the training stage, the newly produced model of RecCNN is obtained.

* Executing the test code of ComCNN `ComCNN/Demo_Test_Qp_30.m` to produce the compact representation of input image.
* Executing the test code of RecCNN `RecCNN/Demo_Test_QP_30.m` to output the final result of reconstructed image.


## Additional instructions

* For training data, you can choose any dataset by yourself.
* The code is implemented in terms of JPEG encoder with Qp=30, you can set the configration as you wish (Different image compresser and different image quality).
* If you have any problem about this repo, please email wenxuecui@stu.hit.edu.cn

## Acknowledgments

This code is built based on the repo https://github.com/cszn/DnCNN

