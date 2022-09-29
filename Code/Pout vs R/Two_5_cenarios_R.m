%%
clc
clear 
close all
%%
%Parametros
n1=1; n2=3.5; n3=0.1;  P=1e6; error=20; N=2e6;  ptdb=10; Max=3  ;
%%
%sem buffer 
[OUTA,OUTB]=funtion_Sem_buffer3(n1,n2,n3,ptdb,N,P);
R=n1:n3:n2;
semilogy(R,OUTA,'b','MarkerSize',5, 'LineWidth',1.25)
grid
hold on
%%
%Com dois buffer
[OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay3(n1,n2,n3,ptdb,N,P+error,Max);
semilogy(R,OUTA1,'r','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer unico
[OUTA2,OUTB2]=Funtion_Com_duplo_Buffer_no_relay3(n1,n2,n3,ptdb,N,P,Max);
semilogy(R,OUTA2,'g','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer mo relay/fonte
[OUTA3,OUTB3]=Funtion_Com_Buffer_no_relay_Fonte3(n1,n2,n3,ptdb,N,P,Max);
semilogy(R,OUTA3,'m','MarkerSize',5, 'LineWidth',1.25);
 %%
 %Com buffer mo relay/fonte
[OUTA4, OUTB4]=Funtion_Com_duplo_Buffer_no_relay_Fonte3(n1,n2,n3,ptdb,N,P,Max);
semilogy(R,OUTA4,'c','MarkerSize',5, 'LineWidth',1.25);
axis([1 3.3 0.02 1 ]);
xlabel('Taxa de transmissão r[bps/Hz]')
ylabel('Probabilidade de Outage')

legend('Sem retransmissor','Buffer retransmissor','Buffer único retransmissor','Buffer retransmissor/fonte','Buffer único retransmissor/fonte')


axes('position', [0.25 0.25 0.5 0.5 ]);
box on 
position= R>=2.5 & R<=3;
%semilogy(R(position),OUTA(position),'b','MarkerSize',5, 'LineWidth',1.25) 

semilogy(R(position),OUTA1(position),'r','MarkerSize',5, 'LineWidth',1.25) 
grid
hold on
semilogy(R(position),OUTA2(position),'g','MarkerSize',5, 'LineWidth',1.25)
semilogy(R(position),OUTA3(position),'m','MarkerSize',5, 'LineWidth',1.25)
semilogy(R(position),OUTA4(position),'c','MarkerSize',5, 'LineWidth',1.25)
axis tight

