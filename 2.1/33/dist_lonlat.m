
%% �������㣨��γ�ȣ�֮��Ĵ�Բ���루��λ��km��
function [ Distance_num ] = dist_lonlat( Lat_Orig, Long_Orig,Lat_Dest,Long_Dest)

 NM2KM = 1.852;
 temParam = sin(Lat_Orig/180*pi)*sin(Lat_Dest/180*pi) + cos(Lat_Orig/180*pi)*cos(Lat_Dest/180*pi)*cos((Long_Orig-Long_Dest)/180*pi);
 Distance_num = acos(temParam)/pi*180*60*NM2KM;

end

