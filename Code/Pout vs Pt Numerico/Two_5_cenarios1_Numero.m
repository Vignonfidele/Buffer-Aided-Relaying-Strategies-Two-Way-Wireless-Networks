%%
clc
clear 
close all
%%
%Parametros
n1=-10; n2=20; P=1.5e6; error=20; R=1; No=1; d1=0.5; d2=0.5; alpha=4;
POUT=[]; POUT1=[]; POUT2=[]; 
%%
for ptdb=n1:1:n2
pt=10.^(ptdb/10);
a=2^(3*R)-1;
beta=pt/No;
lambda1=d1^(-alpha);
lambda2=d2^(-alpha);
Pout=(1-exp(-(a/(lambda1*beta))))+(exp(-(a/(lambda1*beta))))*((1-exp(-(a/(lambda2*beta)))));
POUT=[POUT Pout];
end 
%%
for ptdb=n1:1:n2
pt=10.^(ptdb/10);
a=2^(3*R)-1;
beta=pt/No;
lambda1=d1^(-alpha);
lambda2=d2^(-alpha);
Pout=(1/8)*(8*(1-exp(-(a/(lambda1*beta))))+(exp(-(a/(lambda1*beta))))*((1-exp(-(a/(lambda2*beta))))));
POUT1=[POUT1 Pout];
end 
%%
for ptdb=n1:1:n2
pt=10.^(ptdb/10);
a=2^(3*R)-1;
beta=pt/No;
lambda1=d1^(-alpha);
lambda2=d2^(-alpha);
Pout=(1/7)*(7*(1-exp(-(a/(lambda1*beta))))+(exp(-(a/(lambda1*beta))))*((1-exp(-(a/(lambda2*beta))))^7));
POUT2=[POUT2 Pout];
end 

%%
%sem buffer 
[OUTA,OUTB]=funtion_Sem_buffer1(n1,n2,P);
ptdb=n1:1:n2;
semilogy(ptdb,OUTA,'b','MarkerSize',5, 'LineWidth',1.25)
grid
hold on
%%
%Com dois buffer
[OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay1(n1,n2,P+error);
semilogy(ptdb,OUTA1,'r','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer unico
[OUTA2,OUTB2]=Funtion_Com_duplo_Buffer_no_relay1(n1,n2,P+error);
semilogy(ptdb,OUTA2,'g','MarkerSize',5, 'LineWidth',1.25);
%%
semilogy(ptdb,POUT,'ko','MarkerSize',5, 'LineWidth',1.25)
semilogy(ptdb,POUT1,'ko','MarkerSize',5, 'LineWidth',1.25)
semilogy(ptdb,POUT2,'ko','MarkerSize',5, 'LineWidth',1.25)
%%
xticks([-10 -5 0 5 10 15 20]); yticks([10^-2 10^-1 10^0])
yticklabels({'10^-^2','10^-^1','10^0'}); axis([1 3.3 0.02 1 ],'manual');
axis([-10 20 0.01 1 ]);
xlabel('Potência de transmissão [dB]')
ylabel('Probabilidade de Outage')
legend('Sem retransmissor','Buffer retransmissor','Buffer único retransmissor', 'Numérico')
axes('position', [0.25 0.25 0.5 0.5 ]);
box on 
position= ptdb>=-4 & ptdb<=-3;
semilogy(ptdb(position),OUTA1(position),'r','MarkerSize',5, 'LineWidth',1.25)
grid
hold on
semilogy(ptdb(position),OUTA2(position),'g','MarkerSize',5, 'LineWidth',1.25)
semilogy(ptdb(position),POUT1(position),'ko','MarkerSize',5, 'LineWidth',1.25)
semilogy(ptdb(position),POUT2(position),'ko','MarkerSize',5, 'LineWidth',1.25)
axis tight



