function [OUTA,OUTB]=funtion_Sem_buffer1_otima(n1,n2,P)
    OutageA=0; OutageB=0;
    OUTA=[]; OUTB=[];
for ptdb=n1:n2 
    N=2e6;
    No=1; R=1;
    d=0.416;
    d1=d; d2=1-d; alpha=4;    
    g1=(d1^(-alpha));   g2=(d2^(-alpha)); 
    realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
    realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]);
    pt=10.^(ptdb/10);
    SNRAr=(realizacaoAr.^2*pt)./(No);  SNRBr=(realizacaoBr.^2*pt)./(No);    %(Relacion sinal ruido)                                                            
    ImAr=(1/3)*log2(1+SNRAr);  ImBr=(1/3)*log2(1+SNRBr);                    %(Informacion mutua)
    PacksA=zeros(1,P); PacksB=zeros(1,P);                                   %(inicializando todos los paquetes en un estado 0)
    for i=1:1:P                                                             %(Aqui decido utilizar el ciclo 'for' porque los paquetes no se almacenan en un buffer. (cuando el paquete es transmitido, o llega al destino o es descartado))
        [PacksA(i),PacksB(i)]=Modelo_Sem_Buffer(R,ImAr(i),ImBr(i));
    end 
    OutageA=1-numel(find(PacksA==4))/P;
    OUTA=[OUTA OutageA];
    OutageB=1-numel(find(PacksB==4))/P;
    OUTB=[OUTB OutageB];
end