function tmp_fun_cal_combine(fileFullPath, oxindex, pixelpcm, range_left, range_right, drop_vol, startIndex, endIndex)
[image_path,dFrameTime] = tmp_fun_cal_xt(fileFullPath, oxindex, pixelpcm, range_left, range_right, startIndex, endIndex);
% [image_path,dFrameTime] = tmp_fun_cal_xt_by_xt_pix(fileFullPath, oxindex, pixelpcm, range_left, range_right, startIndex, endIndex);

fun_cal_ax1(image_path,dFrameTime);
fun_cal_mp(1,image_path,drop_vol);
fun_cal_ax2(image_path);
fun_cal_mp(2,image_path,drop_vol);
