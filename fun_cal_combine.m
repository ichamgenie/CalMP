function fun_cal_combine(fileFullPath, oxindex, pixelpcm, range_left, range_right, drop_vol)
[image_path,dFrameTime] = fun_cal_xt(fileFullPath, oxindex, pixelpcm, range_left, range_right);
fun_cal_ax1(image_path,dFrameTime);
fun_cal_mp(1,image_path,drop_vol);
fun_cal_ax2(image_path);
fun_cal_mp(2,image_path,drop_vol);
