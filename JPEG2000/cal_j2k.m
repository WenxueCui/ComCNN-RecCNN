
function psnr=cal_j2k(image_name, rate)
I=double(imread(image_name));

% file_name=strcat(num2str(pre_num),'_rate_',num2str(rate),'.pgm');
% imwrite(uint8(I1,file_name);
imwrite(uint8(I),'lenaLRgaussian.pgm');
enc_cmdl = sprintf('kdu_compress.exe -i lenaLRgaussian.pgm -o new.j2k -rate %1.3f',rate);
    [re,rs] = dos(enc_cmdl);
    dec_cmdl = sprintf('kdu_expand.exe -i new.j2k -o %s','lena_g1.j20.dec025.pgm');
    [re,rs] = dos(dec_cmdl);
    il = double(imread('lena_g1.j20.dec025.pgm'));
    imwrite(uint8(il),'05.jp2');
    psnr=csnr( il ,I,0,0);

