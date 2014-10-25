
%% Counting vehicles in image
totalCarCount_a = FRI_D3_G15_Soumya_2();
totalCarCount_b = FRI_D3_G15_Soumya_3();
totalCarCount_c = FRI_D3_G15_Soumya_4();

TotalCars = totalCarCount_a + totalCarCount_b + totalCarCount_c;

carcolor_a = FRI_D3_G15_Soumya_15('FRI_D3_G15_Soumya_5.jpg');
carcolor_b = FRI_D3_G15_Soumya_15('FRI_D3_G15_Soumya_6.jpg');
carcolor_c = FRI_D3_G15_Soumya_15('FRI_D3_G15_Soumya_7.jpg');

%T := table(Image1(a) = totalCarCount, Image2(b) = totalCarCount_b, Image3(c) = totalCarCount_c, Total=TotalCars);

f = figure('Position',[200 200 400 150]);
dat = [totalCarCount_a, totalCarCount_b, totalCarCount_c, TotalCars];
cnames = {'Image1(a)','Image2(b)','Image3(c)', 'TotalVehicles'};
rnames = {'totalCount'};

t = uitable('Parent',f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames,'Position',[20 20 360 100]);
