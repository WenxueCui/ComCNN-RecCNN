# ComCNN-RecCNN
The code of paper "An End-to-End Compression Framework Based on Convolutional Neural Networks". TCSVT

## Framework

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/framework.jpg)

## Requirements

* Windows10
* Matlab R2015b
* MatconvNet 1.0-beta23 (https://www.vlfeat.org/matconvnet/)
* CUDA 8.0 (CPU is OK)

## How to Run

### Training

* Copying the function in `+dagnn` folder to your `Matconvnet` location `<MatconvNet>\matlab\+dagnn`
* Preparing the training data. (T91 and BSDS200 are included in our repo)
* Train the LapCSNet, run the code `train_LapCSN(0.1, 2, 0);`

```
The first param is CS subrate
The second param is the number of conv layers in each pyramid level
The third param is gpu setting. (0 is CPU, 1 is GPU)
```

### Testing

* Preparing the testing data. (Set5 and Set14 are included in our repo)
* Test the LapCSNet, run the code `test_LapCSN_main(100, 200)`

```
The first param is start epoch for testing model
The second param is end epoch for testing model 
```


## Experimental Results

* ### Subjective results

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/results.jpg)

* ### Objective results

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/table1.jpg)

![image](https://github.com/WenxueCui/ComCNN-RecCNN/raw/master/images/table2.jpg)

## Additional instructions

* For training data, you can choose any dataset by yourself.
* When subrate<=0.25, the laplacian structure can be used.
* If you have any problem, please email wenxuecui@stu.hit.edu.cn

## Acknowledgments

This code is built based on the repo https://github.com/phoenix104104/LapSRN
