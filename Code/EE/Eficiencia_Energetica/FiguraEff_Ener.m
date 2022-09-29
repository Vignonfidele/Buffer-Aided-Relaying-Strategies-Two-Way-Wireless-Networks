
%%
clc
clear  
close all
%%
%Parametros
n1=0.1; n2=0.9; n3=0.1; P=1e4; error=20; ptdb=10;  N=1.1 *P; Max=[3,3,4,6];
%%
%sem buffer 
[OUTC]=funtion_Sem_buffer_EF(n1,n2,n3,ptdb,P,N) ;
[OUTC1]=Funtion_Com_dois_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,Max(i),N);
[OUTC2]=Funtion_Com_duplo_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,Max(i),N) ;
[OUTC3]=Funtion_Com_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,Max(i),N);
[OUTC4]=Funtion_Com_duplo_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,Max(i),N);
 
d=n1:n3:n2; 
%subplot(2,2,1);
semilogy(d,OUTC,'b','MarkerSize',5, 'LineWidth',1.25)
hold on
grid
semilogy(d,OUTC1,'r--','MarkerSize',5, 'LineWidth',1.25)
semilogy(d,OUTC2,'g-.','MarkerSize',5, 'LineWidth',1.25); 
semilogy(d,OUTC3,'m','MarkerSize',5, 'LineWidth',1.25); 
semilogy(d,OUTC4,'c');
%xticks([0.1 0.2 0.4 0.6 0.8 0.9])
%yticks([2*10^-2 10^-1 4*10^-1])
%yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
%axis([0.1 0.9 0.02 0.5 ]);
xlabel('Distance')
ylabel('Spectral efficiency')
