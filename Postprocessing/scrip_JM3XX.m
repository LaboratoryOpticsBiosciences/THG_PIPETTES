close all;
scan_min=0e-6;
scan_range = 12e-6;
scan_step = 5e-7;
param = scan_min:scan_step:scan_range;
position=[scan_min:scan_step:scan_range].';


basefolder='E:\LUMERICAL\_data\JOSEPHINE\_pipettes\';
name00='JM317';
name90='JM318';

cd(basefolder);
[pangle,res00]=plot_interface_functionxyz([basefolder,name00],[name00,'_d6-10_TDEWAT_TDEWAT_POLAR_00_width_'],1)
res000=nonzeros(res00);
cd ..
saveas(gcf,[name00,'.png'])

cd(basefolder);
[pangle,res90]=plot_interface_functionxyz([basefolder,name90],[name90,'_d6-10_TDEWAT_TDEWAT_POLAR_90_width_'],2)
res090=nonzeros(res90);
cd ..
saveas(gcf,[name90,'.png'])
%symetrisation of the results to get a nicer graoh
%position=[-scan_range:scan_step:scan_range].';
%res00=[res000(end:-1:1);res000];
%res90=[res090(end:-1:1);res090];
position=param.';
res00=res000;
res90=res090;

%res00=res000;
%res90=res090;

figure(4);
plot(position,res00,'g',position,res90,'r');
saveas(gcf,[name00,'-',name90,'.png'])
modulation=1-min(res00,res90)./max(res00,res90);
modulationexp=movmean(modulation,3)
mod_tot=1-min(sum(res00),sum(res90))/max(sum(res00),sum(res090))
figure(5);
plot(position,modulation,'b',position,modulationexp,'r');
str= ['Average modulation = ',num2str(mod_tot,3)];
text(0,mod_tot,str);
[m,coord]=max(max(res00,res90));
P0=sum(res00(coord-1:coord+1));
P90=sum(res90(coord-1:coord+1));
mod_PTHG=1-min(P0,P90)/max(P0,P90);
str= ['Modulation at peak = ',num2str(mod_PTHG,3)]
text(0,mod_PTHG,str);
saveas(gcf,[name00,'-',name90,'_mod.png'])
res=[position,res00,res90,modulation];
save([name00,'-',name90],'res');