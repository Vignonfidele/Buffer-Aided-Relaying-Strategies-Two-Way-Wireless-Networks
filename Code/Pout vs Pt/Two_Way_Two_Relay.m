clc
clear all 
close all 
alpha=4;
N=2e6; No=1; R=1;
d_Ar1=0.5; d_Ar2=0.5; d_Br1=0.5; d_Br2=0.5;                                                          
g_Ar1=(d_Ar1^(-alpha)); g_Ar2=(d_Ar2^(-alpha)); g_Br1=(d_Br1^(-alpha));   g_Br2=(d_Br2^(-alpha));
realizacaoAr1=sqrt(g_Ar1)*randraw('nakagami', 1, [1 N]); 
realizacaoAr2=sqrt(g_Ar2)*randraw('nakagami', 1, [1 N]); 
realizacaoBr1=sqrt(g_Br1)*randraw('nakagami', 1, [1 N]);  
realizacaoBr2=sqrt(g_Br2)*randraw('nakagami', 1, [1 N]);
OUTA=[]; OUTB=[]; OUTA1=[]; OUTB1=[];

%%
for ptdb=-10:20
    pt=10.^(ptdb/10);
SNRAr1=(realizacaoAr1.^2*pt)./(No);  SNRBr1=(realizacaoBr1.^2*pt)./(No);    %(Relacion sinal ruido)                                                            
SNRAr2=(realizacaoAr2.^2*pt)./(No);  SNRBr2=(realizacaoBr2.^2*pt)./(No);
ImAr1=(1/3)*log2(1+SNRAr1);  ImBr1=(1/3)*log2(1+SNRBr1);                    %(Informacion mutua)
ImAr2=(1/3)*log2(1+SNRAr2);  ImBr2=(1/3)*log2(1+SNRBr2);
P=1e6;
PacksA=zeros(1,P); PacksB=zeros(1,P);                                   %(inicializando todos los paquetes en un estado 0)
    for i=1:1:P                                                             %(Aqui decido utilizar el ciclo 'for' porque los paquetes no se almacenan en un buffer. (cuando el paquete es transmitido, o llega al destino o es descartado))
        [PacksA(i),PacksB(i)]=Modelo_Sem_Buffer(R,ImAr1(i),ImAr2(i),ImBr1(i),ImBr2(i));
    end 
    OutageA=numel(find(PacksA==3))/P;
    OUTA=[OUTA OutageA];
    OutageB=numel(find(PacksB==3))/P;
    OUTB=[OUTB OutageB];
end

ptdb=-10:20;
semilogy(ptdb,OUTA)
grid
