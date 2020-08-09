# ComCNN
The ComCNN code of paper "An End-to-End Compression Framework Based on Convolutional Neural Networks". TCSVT2017

## Framework of ComCNN

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/comcnn.jpg)

## Requirements

* Windows10
* Matlab R2015b
* MatconvNet 1.0-beta23 (https://www.vlfeat.org/matconvnet/)
* CUDA 8.0 (CPU is OK)

## How to Run

### Training

After training stage of RecCNN model, the newly produced RecCNN model is obtained and copied into `ComCNN/RecCNN_model`.

* Generating the training data of ComCNN model by running `data/GenerateData_model_64_25_Res_Bnorm_Adam.m`.
* Training the ComCNN model, during which the newly produced RecCNN model is used, and copying the produced ComCNN model into `RecCNN\data\model`.


### Testing ComCNN and RecCNN

Through the training stage, the newly produced model of ComCNN and RecCNN are obtained.

* Executing the test code of ComCNN `ComCNN/Demo_Test_Qp_30.m` to produce the compact representation of input image.
* Executing the test code of RecCNN `RecCNN/Demo_Test_QP_30.m` to output the final result of reconstructed image.

## The Visual Effect of Compact Representations

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/com.jpg)

## Additional instructions

* For training data, you can choose any dataset by yourself.
* The code is implemented in terms of JPEG encoder with Qp=30, you can set the configration as you wish (Different image compresser and different image quality).
* If you have any problem about this repo, please email wenxuecui@stu.hit.edu.cn

## Acknowledgments

This code is built based on the repo https://github.com/cszn/DnCNN

