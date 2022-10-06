%%
clc
clear 
close all
%%
%Parametros
n1=-10; n2=20; R=1;  N=2e3;  No=1;   d1=0.5;    d2=0.5;  alpha=4; P=1e5; error=20;                                                              
g1=(d1^(-alpha));   g2=(d2^(-alpha));
%%
%sem buffer 
[OUTA,OUTB]=funtion_Sem_buffer1(n1,n2,P);
ptdb=n1:1:n2;
semilogy(ptdb,OUTA,'r')
%semilogy(ptdb,OUTB,'r--')
grid
hold on
%%
%Com dois buffer
[OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay1(n1,n2,P+error);
semilogy(ptdb,OUTA1,'b');
%semilogy(ptdb,OUTB1,'b--');
%%
%Com buffer unico
[OUTA2,OUTB2]=Funtion_Com_duplo_Buffer_no_relay1(n1,n2,P+error);
semilogy(ptdb,OUTA2,'k');
%semilogy(ptdb,OUTB2,'k--');
%%
Com buffer mo relay/fonte
[OUTA3, OUTB3]=Funtion_Com_Buffer_no_relay_Fonte1(n1,n2,P+error);
semilogy(ptdb,OUTA3,'m');
%semilogy(ptdb,OUTB3,'m--');
%%
%Com buffer mo relay/fonte
[OUTA4, OUTB4]=Funtion_Com_duplo_Buffer_no_relay_Fonte1(n1,n2,P+error);
semilogy(ptdb,OUTA4,'c');
%semilogy(ptdb,OUTB4,'c--');
