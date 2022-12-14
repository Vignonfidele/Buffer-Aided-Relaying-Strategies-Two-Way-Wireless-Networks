%%
clc
clear 
close all
%%
%Parametros
n1=-10; n2=20;  P=1.5e6; error=20;                                                              
%%
%sem buffer 
[OUTA,OUTB]=funtion_Sem_buffer1_otima(n1,n2,P);
ptdb=n1:1:n2;
semilogy(ptdb,OUTA,'b','MarkerSize',5, 'LineWidth',1.25)
grid
hold on
%%
%Com dois buffer
[OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay1_otima(n1,n2,P+error);
semilogy(ptdb,OUTA1,'r','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer unico
[OUTA2,OUTB2]=Funtion_Com_duplo_Buffer_no_relay1_otima(n1,n2,P+error);
semilogy(ptdb,OUTA2,'g','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer mo relay/fonte
[OUTA3, OUTB3]=Funtion_Com_Buffer_no_relay_Fonte1_otima(n1,n2,P+error);
semilogy(ptdb,OUTA3,'m','MarkerSize',5, 'LineWidth',1.25);
%
%Com buffer mo relay/fonte
[OUTA4, OUTB4]=Funtion_Com_duplo_Buffer_no_relay_Fonte1_otima(n1,n2,P+error);
semilogy(ptdb,OUTA4,'c','MarkerSize',5, 'LineWidth',1.25);

axis([-10 20 0.001 1 ]);
xlabel('Potência de transmissão [dB]')
ylabel('Probabilidade de Outage')
legend('Sem retransmissor','Buffer retransmissor','Buffer único retransmissor','Buffer retransmissor/fonte','Buffer único retransmissor/fonte')


axes('position', [0.25 0.25 0.5 0.5 ]);
box on 
position= ptdb>=-4 & ptdb<=-3;
%semilogy(ptdb(position),OUTA(position),'b','MarkerSize',5, 'LineWidth',1.25) 

semilogy(ptdb(position),OUTA1(position),'r','MarkerSize',5, 'LineWidth',1.25)
grid
hold on
semilogy(ptdb(position),OUTA2(position),'g','MarkerSize',5, 'LineWidth',1.25)
semilogy(ptdb(position),OUTA3(position),'m','MarkerSize',5, 'LineWidth',1.25)
semilogy(ptdb(position),OUTA4(position),'c','MarkerSize',5, 'LineWidth',1.25)
axis tight



