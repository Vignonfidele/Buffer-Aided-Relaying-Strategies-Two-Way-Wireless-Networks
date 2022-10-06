function [OUTA,OUTB]=funtion_Sem_buffer(ptdb)
    OutageA=0; OutageB=0;
    OUTA=[]; OUTB=[]; 
    No=1; R=1;
for P=100000:100000:1000000
    N=2e6;
    d1=0.5; d2=0.5; alpha=4;    
    g1=(d1^(-alpha));   g2=(d2^(-alpha)); 
    realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
    realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]);
    
    %load('realizacaoAr.mat','realizacaoAr') 
    %load('realizacaoBr.mat','realizacaoBr');  
    pt=10.^(ptdb/10);
    SNRAr=(realizacaoAr.^2*pt)./(No);  SNRBr=(realizacaoBr.^2*pt)./(No);    %(Relacion sinal ruido)                                                            
    ImAr=(1/3)*log2(1+SNRAr);  ImBr=(1/3)*log2(1+SNRBr);                    %(Informacion mutua)
                                                                                           %(Numero de paquete a ser simulado)
    PacksA=zeros(1,P); PacksB=zeros(1,P);                                                %(inicializando todos los paquetes en un estado 0)
    for i=1:P                                                   
        [PacksA(i),PacksB(i)]=Modelo_Sem_Buffer(R,ImAr(i),ImBr(i));
    end
    LineAnalisisA=P ;
    LineAnalisisB=P ;
    PacksA3=find(PacksA(1,1:LineAnalisisA)==3);
    PacksB3=find(PacksB(1,1:LineAnalisisB)==3);
    OutageA=numel(PacksA3);
    OUTA=[OUTA OutageA];
    OutageB=numel(PacksB3);
    OUTB=[OUTB OutageB];
end
end