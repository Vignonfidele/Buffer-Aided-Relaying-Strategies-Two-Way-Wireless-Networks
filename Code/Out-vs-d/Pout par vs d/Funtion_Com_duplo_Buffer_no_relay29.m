function[OUTC2]=Funtion_Com_duplo_Buffer_no_relay29(n1,n2,n3,ptdb,P,Max,N) 
    OUTA2=[]; OUTB2=[]; OUTC2=[];
    pt=10.^(ptdb/10);
    No=1; R=1; alpha=4;
    Max=2*Max;
for d=n1:n3:n2  
    d1=d; d2=1-d1;                                                               
    g1=(d1^(-alpha));   g2=(d2^(-alpha));
    realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
    realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]);
    SNRAr=(realizacaoAr.^2*pt)./(No); SNRBr=(realizacaoBr.^2*pt)./(No);                                      %(Relacion sinal ruido)                                                       
    ImAr=(1/3)*log2(1+SNRAr);  ImBr=(1/3)*log2(1+SNRBr);                                                     %(Informacion mutua)
    Error=20;                                                                                        %(Numero de paquete a ser simulado + un margen de error )
    PacksA=zeros(1,P);PacksB=zeros(1,P);                                                           %(inicializando todos los paquetes en un estado 0)
    ContRab=0;                                                                                               %Bufferunico do relay                                                                         
    Rab=0; AR=0; BR=0;                                                                                       %Rab=Contador dos elementos no buffer, AR=Contador dos elementos de  A-->B, BR= Contador dos elementos de B-->A                                                  
    ContAR=0; ContBR=0;                                                                                      %ContAR= Posicion que ocupa los elementos A-->B em el buffer del relay, ContBR= Posicion que ocupa los elementos B-->A em el buffer del relay.                                                                              
    fA=0; fB=0; i=0; t=0; 
while (fA<=P && fB<=P)                                                                                       %(Mientras que el Numero total de paquete transmitido con "suceso" o "NO" de A-->B y de B-->A no llegue a la catidad total de paquete a ser analizado; no paro la simulacion)
        i=i+1; t=t+1;                                                                                        %(incremento de 1 a i e t para inicializar con el primero elemento del vector Paquete e del vector de la informacion mutua.
            if (ImAr(1,t)>=R && ImBr(1,t)<R) 
               PacksB(i)=3;   fB=fB+1;  
               if BR==0 
                   if AR==Max 
                       PacksA(i)=3; fA=fA+1;
                   elseif AR<Max
                       PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=Rab+1; Rab=Rab+1; AR=AR+1; 
                   end
               elseif BR==1 
                       PacksB(ContRab(ContBR(1)))=4; fB=fB+1; ContRab(ContBR(1))=0;ContRab(ContRab==0)=[];ContBR=0; 
                       ContAR=1:(Rab-1); BR=BR-1; PacksA(i)=2; ContRab(Rab)=i; ContAR(AR+1)=Rab; AR=AR+1;         
               elseif BR>=2
                       PacksB(ContRab(ContBR(1)))=4; fB=fB+1;  
                       PacksB(ContRab(ContBR(2)))=4; fB=fB+1;  
                       Lbel=1:Rab; Lbel(ContBR(1))=0; Lbel(ContBR(2))=0; Lbel((Lbel==0))=[];  
                       ContRab(ContBR(1))=0;ContRab(ContBR(2))=0; ContBR(1)=0; ContBR(2)=0;  
                       ContRab(ContRab==0)=[]; ContBR(ContBR==0)=[]; 
                       [~,ContBR]=ismember(ContBR,Lbel); [~,ContAR]=ismember(ContAR,Lbel); Lbel=0;  
                       PacksA(i)=2; ContRab(Rab-1)=i;  ContAR(AR+1)=Rab-1 ;Rab=Rab-1; AR=AR+1; BR=BR-2;
               end    
           elseif (ImAr(1,t)<R && ImBr(1,t)>=R)
               PacksA(i)=3;   fA=fA+1;  
               if AR==0 
                   if BR==Max 
                       PacksB(i)=3; fB=fB+1;
                   elseif BR<Max
                       PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=Rab+1; Rab=Rab+1; BR=BR+1; 
                   end
               elseif AR==1 
                       PacksA(ContRab(ContAR(1)))=4; fA=fA+1; ContRab(ContAR(1))=0; 
                       ContRab(ContRab==0)=[];  ContAR=0; ContBR=1:(Rab-1); AR=AR-1;
                       PacksB(i)=2; ContRab(Rab)=i; ContBR(BR+1)=Rab; BR=BR+1;
               elseif AR>=2
                       PacksA(ContRab(ContAR(1)))=4; fA=fA+1;  
                       PacksA(ContRab(ContAR(2)))=4; fA=fA+1;
                       Lbel=1:Rab; Lbel(ContAR(1))=0; Lbel(ContAR(2))=0; Lbel(Lbel==0)=[]; 
                       ContRab(ContAR(1))=0; ContRab(ContAR(2))=0; ContAR(1)=0; ContAR(2)=0; 
                       ContRab(ContRab==0)=[]; ContAR(ContAR==0)=[];
                       [~,ContAR]=ismember(ContAR,Lbel); [~,ContBR]=ismember(ContBR,Lbel); Lbel=0;  
                       PacksB(i)=2; ContRab(Rab-1)=i; ContBR(BR+1)=Rab-1 ; Rab=Rab-1; BR=BR+1; AR=AR-2;
               end
           elseif  (ImAr(1,t)<R && ImBr(1,t)<R) 
               PacksA(i)=3;  fA=fA+1;                                                                                           % Si lo dos enlace no estando disponible, en este frame el paquete (A-->B) sale del sistema con un valor igual a 3. (Paquete descartado). 
               PacksB(i)=3;  fB=fB+1;  
            else
               if AR==0 && BR==0
                  PacksA(i)=4; fA=fA+1;
                  PacksB(i)=4; fB=fB+1;
               elseif AR==Max
                  PacksB(i)=4; fB=fB+1;
                  PacksA(i)=3; fA=fA+1;
                  PacksA(ContRab(1))=4; fA=fA+1;  PacksA(ContRab(2))=4; fA=fA+1; 
                  ContRab(1)=0;  ContRab(2)=0; ContRab(ContRab==0)=[]; ContAR(1)=0; ContAR(2)=0; 
                  ContAR(ContAR==0)=[]; ContAR=ContAR-2; AR=AR-2; Rab=Rab-2; 
              elseif BR==Max
                  PacksA(i)=4; fA=fA+1;
                  PacksB(i)=3; fB=fB+1;
                  PacksB(ContRab(1))=4; fB=fB+1;  PacksB(ContRab(2))=4; fB=fB+1; 
                  ContRab(1)=0;  ContRab(2)=0; ContRab(ContRab==0)=[]; ContBR(1)=0; ContBR(2)=0;
                  ContBR(ContBR==0)=[];  ContBR=ContBR-2; BR=BR-2; Rab=Rab-2; 
              elseif AR==0 && BR~=0
                  PacksA(i)=4; fA=fA+1;
                  PacksB(ContRab(1))=4; fB=fB+1; ContRab(1)=0; ContRab(ContRab==0)=[] ;
                  ContBR(1)=0;  ContBR(ContBR==0)=[]; ContBR =ContBR-1 ;
                  PacksB(i)=2; ContRab(Rab)=i; ContBR(Rab)=Rab;
              elseif AR~=0 && BR==0
                  PacksB(i)=4; fB=fB+1;
                  PacksA(ContRab(1))=4; fA=fA+1; ContRab(1)=0; ContRab(ContRab==0)=[] ;
                  ContAR(1)=0;  ContAR(ContAR==0)=[]; ContAR =ContAR-1;
                  PacksA(i)=2; ContRab(Rab)=i; ContAR(Rab)=Rab;
              elseif AR~=0 && BR~=0 
                  PacksA(ContRab(ContAR(1)))=4; fA=fA+1;
                  PacksB(ContRab(ContBR(1)))=4; fB=fB+1; 
                  Lbel=1:Rab; Lbel(ContAR(1))=0; Lbel(ContBR(1))=0; Lbel(Lbel==0)=[]; 
                  ContRab(ContAR(1))=0; ContRab(ContBR(1))=0; ContAR(1)=0; ContBR(1)=0;  
                  ContRab(ContRab==0)=[]; ContAR(ContAR==0)=[];ContBR(ContBR==0)=[];
                  [~,ContAR]=ismember(ContAR,Lbel); [~,ContBR]=ismember(ContBR,Lbel);  Lbel=0; 
                  PacksA(i)=2; ContRab(Rab-1)=i ; ContAR(AR)=Rab-1;
                  PacksB(i)=2;ContRab(Rab)=i ; ContBR(BR)=Rab;
              end      
           end
end
    LineAnalisisA=P-Error ;
    LineAnalisisB=P-Error;
    PacksA3=find(PacksA(1,1:LineAnalisisA)==3);
    PacksB3=find(PacksB(1,1:LineAnalisisB)==3);
    OutageA=numel(PacksA3)/LineAnalisisA;
    OUTA2=[OUTA2 OutageA];
    OutageB=numel(PacksB3)/LineAnalisisB;
    OUTB2=[OUTB2 OutageB];
    AA=numel(PacksA3);
    BB=numel(PacksB3);
    OutageC=(AA+BB)/(LineAnalisisB+LineAnalisisA);
    OUTC2=[OUTC2 OutageC];
end
end
