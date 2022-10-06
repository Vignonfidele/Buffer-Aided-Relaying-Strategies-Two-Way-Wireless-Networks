%%
clc
clear all 
close all
%%
%Parametros
n1=0.1; n2=0.9; n3=0.2; P=1e3; error=20; ptdb=10; Max1=2; Max2=3; Max3=4; Max4=6; N=2e3; 
%%
%sem buffer 
[OUTC]=funtion_Sem_buffer29(n1,n2,n3,ptdb,P,N);
d=n1:n3:n2; 
subplot(2,2,1); semilogy(d,OUTC,'b','MarkerSize',5, 'LineWidth',1.25)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
yticks([2*10^-2 10^-1 4*10^-1])
yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.02 0.5 ]);
xlabel('Distância')
ylabel('Probabilidade de Outage do pare')

%%
%Com dois buffer
subplot(2,2,1); [OUTC1]=Funtion_Com_dois_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,2,N);
d=n1:n3:n2;
semilogy(d,OUTC1,'r--','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer unico
subplot(2,2,1); [OUTC2]=Funtion_Com_duplo_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,2,N);
semilogy(d,OUTC2,'g-.','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer mo relay/fonte
subplot(2,2,1); [OUTC3]=Funtion_Com_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,2,N);
semilogy(d,OUTC3,'m','MarkerSize',5, 'LineWidth',1.25); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,1); semilogy(d(numeco),OUTC3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);

%%
%Com buffer mo relay/fonte
subplot(2,2,1); [OUTC4]=Funtion_Com_duplo_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,2,N);
semilogy(d,OUTC4,'c'); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,1); semilogy(d(numeco),OUTC4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25);

%%
[OUTC]=funtion_Sem_buffer29(n1,n2,n3,ptdb,P,N);
d=n1:n3:n2; 
subplot(2,2,2); semilogy(d,OUTC,'b','MarkerSize',5, 'LineWidth',1.25)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
yticks([2*10^-2 10^-1 4*10^-1])
yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.02 0.5 ]);
xlabel('Distância')
ylabel('Probabilidade de Outage do pare')

%%
%Com dois buffer
[OUTC1]=Funtion_Com_dois_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,3,N);
d=n1:n3:n2;
subplot(2,2,2); semilogy(d,OUTC1,'r--','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer unico
[OUTC2]=Funtion_Com_duplo_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,3,N);
subplot(2,2,2); semilogy(d,OUTC2,'g-.','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer mo relay/fonte
[OUTC3]=Funtion_Com_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,3,N);
subplot(2,2,2); semilogy(d,OUTC3,'m','MarkerSize',5, 'LineWidth',1.25); 

numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,2); semilogy(d(numeco),OUTC3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer mo relay/fonte
[OUTC4]=Funtion_Com_duplo_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,3,N);
subplot(2,2,2); semilogy(d,OUTC4,'c','MarkerSize',5, 'LineWidth',1.25); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,2); semilogy(d(numeco),OUTC4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25);

%%
[OUTC]=funtion_Sem_buffer29(n1,n2,n3,ptdb,P,N);
d=n1:n3:n2; 
subplot(2,2,3); semilogy(d,OUTC,'b','MarkerSize',5, 'LineWidth',1.25)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
yticks([2*10^-2 10^-1 4*10^-1])
yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.02 0.5 ]);
xlabel('Distância')
ylabel('Probabilidade de Outage do pare')
%%
%Com dois buffer
[OUTC1]=Funtion_Com_dois_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,4,N);
d=n1:n3:n2;
subplot(2,2,3); semilogy(d,OUTC1,'r--','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer unico
[OUTC2]=Funtion_Com_duplo_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,4,N);
subplot(2,2,3); semilogy(d,OUTC2,'g-.','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer no relay/fonte
[OUTC3]=Funtion_Com_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,4,N);
subplot(2,2,3); semilogy(d,OUTC3,'m','MarkerSize',5, 'LineWidth',1.25); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,3); semilogy(d(numeco),OUTC3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer no double relay/fonte
[OUTC4]=Funtion_Com_duplo_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,4,N);
subplot(2,2,3); semilogy(d,OUTC4,'c','MarkerSize',5, 'LineWidth',1.25); 

numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,3); semilogy(d(numeco),OUTC4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25);
 
[OUTC]=funtion_Sem_buffer29(n1,n2,n3,ptdb,P,N);
d=n1:n3:n2; 
subplot(2,2,4); Primero=semilogy(d,OUTC,'b','MarkerSize',5, 'LineWidth',1.25);
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
yticks([2*10^-2 10^-1 4*10^-1])
yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.02 0.5 ]);
xlabel('Distância')
ylabel('Probabilidade de Outage do pare')
%%
%Com dois buffer
[OUTC1]=Funtion_Com_dois_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,6,N);
d=n1:n3:n2;
subplot(2,2,4); Secundo=semilogy(d,OUTC1,'r--','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer unico
[OUTC2]=Funtion_Com_duplo_Buffer_no_relay29(n1,n2,n3,ptdb,P+error,6,N);
subplot(2,2,4); tercero=semilogy(d,OUTC2,'g-.','MarkerSize',5, 'LineWidth',1.25); 
%%
%Com buffer mo relay/fonte
[OUTC3]=Funtion_Com_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,6,N);
subplot(2,2,4); semilogy(d,OUTC3,'m','MarkerSize',5, 'LineWidth',1.25); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,4); semilogy(d(numeco),OUTC3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer mo relay/fonte
[OUTC4]=Funtion_Com_duplo_Buffer_no_relay_Fonte29(n1,n2,n3,ptdb,P+error,6,N);
subplot(2,2,4); semilogy(d,OUTC4,'c','MarkerSize',5, 'LineWidth',1.25); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,4); semilogy(d(numeco),OUTC4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25);

x1=0.01:0.001:0.01; y1=x1.^2;
x2=0.01:0.001:0.01; y2=x2.^3;
subplot(2,2,3); quarto=plot(x1,y1,'m-v','MarkerSize',5, 'LineWidth',1.25); subplot(2,2,3); Quinto=plot(x2,y2,'c-s','MarkerSize',5, 'LineWidth',1.25);
legend( [Primero; Secundo; tercero; quarto; Quinto],'Sem retransmissor', 'Buffer retransmissor', 'Buffer único retransmissor','Buffer retransmissor/fonte', 'Buffer único retransmissor/fonte')


