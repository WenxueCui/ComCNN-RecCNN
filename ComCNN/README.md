# ComCNN
The ComCNN code of paper "An End-to-End Compression Framework Based on Convolutional Neural Networks". TCSVT

## Framework

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/comcnn.jpg)

## Requirements

* Windows10
* Matlab R2015b
* MatconvNet 1.0-beta23 (https://www.vlfeat.org/matconvnet/)
* CUDA 8.0 (CPU is OK)

## How to Run

### Training

We have provided the pretrained model of RecCNN and ComCNN in the folder `ComCNN/RecCNN_model` and `RecCNN\data\model`.

* Generating the training data of RecCNN model (The pretrained ComCNN is used).
* Training the RecCNN model, and copying the produced RecCNN model into `ComCNN/RecCNN_model`
* Generating the training data of ComCNN model (the newly produced RecCNN model is used).
* Training the ComCNN model, and copying the produced ComCNN model into `RecCNN\data\model`.
* Repeat the above four steps for several times until stabilization of the model.


### Testing

Through the training stage, the newly produced model of ComCNN and RecCNN are obtained.

* Executing the test code of ComCNN `ComCNN/Demo_Test_Qp_30.m` to produce the compact representation of input image.
* Executing the test code of RecCNN `RecCNN/Demo_Test_QP_30.m` to output the final result of reconstructed image.


## Additional instructions

* For training data, you can choose any dataset by yourself.
* The code is implemented in terms of JPEG encoder with Qp=30, you can set the configration as you wish (Different image compresser and different image quality).
* If you have any problem about this repo, please email wenxuecui@stu.hit.edu.cn

## Acknowledgments

This code is built based on the repo https://github.com/cszn/DnCNN

