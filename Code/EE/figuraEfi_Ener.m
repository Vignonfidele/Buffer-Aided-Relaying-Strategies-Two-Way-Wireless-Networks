%%
clc
clear  
close all
%%
%Parametros
n1=0.1; n2=0.9; n3=0.05; P=1e6; error=20; ptdb=10;  N=1.1*P; Max=[2,3,4,6];
%%
%sem buffer 
i=1;
[OUTC_2]=funtion_Sem_buffer_EF(n1,n2,n3,ptdb,P,N) ;
d=n1:n3:n2; 
subplot(2,2,1); plot(d,OUTC_2,'b','MarkerSize',6, 'LineWidth',2)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
%yticks([0.40 0. 0.4 0.6 0.8 0.9])
%yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 40 65 ]);
xlabel('(a)')
ylabel('Energy Efficiency [%]')

%%
%Com dois buffer
subplot(2,2,1); [OUTC1_2]=Funtion_Com_dois_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,2,N);
d=n1:n3:n2;
plot(d,OUTC1_2,'r--','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer unico
subplot(2,2,1); [OUTC2_2]=Funtion_Com_duplo_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,2,N) ;
plot(d,OUTC2_2,'g-.','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer mo relay/fonte
subplot(2,2,1); [OUTC3_2]=Funtion_Com_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,2,N);
plot(d,OUTC3_2,'m','MarkerSize',6, 'LineWidth',2); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,1); plot(d(numeco),OUTC3_2(numeco),'mv','MarkerSize',6, 'LineWidth',2);

%%
%Com buffer mo relay/fonte
subplot(2,2,1); [OUTC4_2]=Funtion_Com_duplo_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,2,N);
plot(d, OUTC4_2,'c', 'MarkerSize',6, 'LineWidth',2); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,1); plot(d(numeco), OUTC4_2(numeco), 'cs','MarkerSize',6, 'LineWidth',2);

%%
i=2;
[OUTC_3]=funtion_Sem_buffer_EF(n1,n2,n3,ptdb,P,N) ;
d=n1:n3:n2; 
subplot(2,2,2); plot(d,OUTC_3,'b','MarkerSize',6, 'LineWidth',2)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
%yticks([2*10^-2 10^-1 4*10^-1])
%yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 40 65 ]);
xlabel('(b)')
%ylabel('Energy Efficiency.')

%%
%Com dois buffer
[OUTC1_3]=Funtion_Com_dois_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,3,N);
d=n1:n3:n2;
subplot(2,2,2); plot(d,OUTC1_3,'r--','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer unico
[OUTC2_3]=Funtion_Com_duplo_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,3,N) ;
subplot(2,2,2); plot(d,OUTC2_3,'g-.','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer mo relay/fonte
[OUTC3_3]=Funtion_Com_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,3,N);
subplot(2,2,2); plot(d,OUTC3_3,'m','MarkerSize',6, 'LineWidth',2); 

numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,2); plot(d(numeco),OUTC3_3(numeco),'mv','MarkerSize',6, 'LineWidth',2);
%%
%Com buffer mo relay/fonte
[OUTC4_3]=Funtion_Com_duplo_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,3,N);
subplot(2,2,2); plot(d,OUTC4_3,'c','MarkerSize',6, 'LineWidth',2); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,2); plot(d(numeco),OUTC4_3(numeco),'cs','MarkerSize',6, 'LineWidth',2);

%%
i=3;
[OUTC_3]=funtion_Sem_buffer_EF(n1,n2,n3,ptdb,P,N) ;
d=n1:n3:n2; 
subplot(2,2,3); plot(d,OUTC_3,'b','MarkerSize',6, 'LineWidth',2)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
%yticks([2*10^-2 10^-1 4*10^-1])
%yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 40 65 ]);
xlabel('Distance d_{S_{1}R}')
ylabel('Energy Efficiency [%]')
%%
%Com dois buffer
[OUTC1_3]=Funtion_Com_dois_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,4,N);
d=n1:n3:n2;
subplot(2,2,3); plot(d,OUTC1_3,'r--','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer unico
[OUTC2]=Funtion_Com_duplo_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,4,N) ;
subplot(2,2,3); plot(d,OUTC2,'g-.','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer no relay/fonte
[OUTC3_3]=Funtion_Com_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,4,N);
subplot(2,2,3); plot(d,OUTC3_3,'m','MarkerSize',6, 'LineWidth',2); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,3); plot(d(numeco),OUTC3_3(numeco),'mv','MarkerSize',6, 'LineWidth',2);
%%
%Com buffer no double relay/fonte
[OUTC4_3]=Funtion_Com_duplo_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,4,N);
subplot(2,2,3); plot(d,OUTC4_3,'c','MarkerSize',6, 'LineWidth',2); 

numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,3); plot(d(numeco),OUTC4_3(numeco),'cs','MarkerSize',6, 'LineWidth',2);

i=4;
[OUTC_4]=funtion_Sem_buffer_EF(n1,n2,n3,ptdb,P,N) ;
d=n1:n3:n2; 
subplot(2,2,4); Primero=plot(d,OUTC_4,'b','MarkerSize',6, 'LineWidth',2);
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
%yticks([2*10^-2 10^-1 4*10^-1])
%yticklabels({'2x10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 40 65 ]);
xlabel('Distance d_{S_{1}R}')
%ylabel('Spectral efficiency')
%%
%Com dois buffer
[OUTC1_4]=Funtion_Com_dois_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,6,N);
d=n1:n3:n2;
subplot(2,2,4); Secundo=plot(d,OUTC1_4,'r--','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer unico
[OUTC2_4]=Funtion_Com_duplo_Buffer_no_relay_EF(n1,n2,n3,ptdb,P,6,N) ;
subplot(2,2,4); tercero=plot(d,OUTC2_4,'g-.','MarkerSize',6, 'LineWidth',2); 
%%
%Com buffer mo relay/fonte
[OUTC3_4]=Funtion_Com_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,6,N);
subplot(2,2,4); plot(d,OUTC3_4,'m','MarkerSize',6, 'LineWidth',2); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,4); plot(d(numeco),OUTC3_4(numeco),'mv','MarkerSize',6, 'LineWidth',2);
%%
%Com buffer mo relay/fonte
[OUTC4_4]=Funtion_Com_duplo_Buffer_no_relay_Fonte_EF(n1,n2,n3,ptdb,P+error,6,N);
subplot(2,2,4); plot(d,OUTC4_4,'c','MarkerSize',6, 'LineWidth',2); 
numeco= ismembertol(d,0.1) | ismembertol(d,0.2) | ismembertol(d,0.3) | ismembertol(d,0.4) | ismembertol(d,0.5) | ismembertol(d,0.6) | ismembertol(d,0.7) | ismembertol(d,0.8) | ismembertol(d,0.9);
subplot(2,2,4); plot(d(numeco),OUTC4_4(numeco),'cs','MarkerSize',6, 'LineWidth',2);

x1=0.01:0.001:0.01; y1=x1.^2;
x2=0.01:0.001:0.01; y2=x2.^3;
subplot(2,2,3); quarto=plot(x1,y1,'m-v','MarkerSize',6, 'LineWidth',2); subplot(2,2,3); Quinto=plot(x2,y2,'c-s','MarkerSize',6, 'LineWidth',2);
legend( [Primero; Secundo; tercero; quarto; Quinto],'Without Buffer', 'Buffer Relay', 'Single-Buffer Relay','Buffer Relay/Source', 'Single-Buffer Relay/Buffer Source')


