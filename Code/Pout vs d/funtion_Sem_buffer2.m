function [OUTA,OUTB]=funtion_Sem_buffer2(n1,n2,n3,ptdb,P,N) 
    OUTA=[]; OUTB=[];
    pt=10.^(ptdb/10);
    No=1; R=1; alpha=4;
for d=n1:n3:n2  
    OutageA=0; OutageB=0;
    d1=d; d2=1-d;                                                               
    g1=(d1^(-alpha));   g2=(d2^(-alpha));
    realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
    realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]);  
    SNRAr=(realizacaoAr.^2*pt)./(No);  SNRBr=(realizacaoBr.^2*pt)./(No);    %(Relacion sinal ruido)                                                            
    ImAr=(1/3)*log2(1+SNRAr);  ImBr=(1/3)*log2(1+SNRBr);                    %(Informacion mutua)
    PacksA=zeros(1,P); PacksB=zeros(1,P);                                   %(inicializando todos los paquetes en un estado 0)
    for i=1:1:P                                                             %(Aqui decido utilizar el ciclo 'for' porque los paquetes no se almacenan en un buffer. (cuando el paquete es transmitido, o llega al destino o es descartado))
        [PacksA(i),PacksB(i)]=Modelo_Sem_Buffer(R,ImAr(i),ImBr(i));
    end 
    OutageA=numel(find(PacksA==3))/P;
    OUTA=[OUTA OutageA];
    OutageB=numel(find(PacksB==3))/P;
    OUTB=[OUTB OutageB];
end