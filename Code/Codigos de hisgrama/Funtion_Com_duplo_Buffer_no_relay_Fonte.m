function[OUTA4, OUTB4]=Funtion_Com_duplo_Buffer_no_relay_Fonte(ptdb,MaxS,MaxR) 
OUTA4=[]; OUTB4=[];
R=1;  No=1;
pt=10.^(ptdb/10);
N=2e6;
d1=0.5; d2=0.5; alpha=4;    
g1=(d1^(-alpha));   g2=(d2^(-alpha)); 
realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]);
SNRAr=(realizacaoAr.^2*pt)./(No); SNRBr=(realizacaoBr.^2*pt)./(No);                                              %(Relacion sinal ruido)                                                       
ImAr=(1/3)*log2(1+SNRAr);  ImBr=(1/3)*log2(1+SNRBr);                                                             %(Informacion mutua)
Error=100;        
for P=700000:100000:1000000                                                                                                 %(Numero de paquete a ser simulado + un margen de error )
P=P+Error;
PacksA=zeros(1,P);PacksB=zeros(1,P);                                                                                  %(inicializando todos los paquetes en un estado 0)
ContRab=0;                                                                                                     %Bufferunico do relay                                                                         
Rab=0; AR=0; BR=0; A=0; B=0;                                                                                             %Rab=Contador dos elementos no buffer, AR=Contador dos elementos de  A-->B, BR= Contador dos elementos de B-->A                                                  
ContAR=0; ContBR=0; ContA=0;ContB=0;
fA=0;fB=0; i=0; t=0;
while (fA<=P && fB<=P)                                                                                            %(Mientras que el Numero total de paquete transmitido con "suceso" o "NO" de A-->B y de B-->A no llegue a la catidad total de paquete a ser analizado; no paro la simulacion)
        i=i+1; t=t+1;                                                                                               %(incremento de 1 a i e t para inicializar con el primero elemento del vector Paquete e del vector de la informacion mutua.
           if (ImAr(1,t)>=R && ImBr(1,t)<R)
              if B==MaxS
                PacksB(i)=3;  fB=fB+1;
              elseif B<MaxS
                PacksB(i)=1; ContB(B+1)=i; B=B+1; 
              end
              %if Rab==MaxS-1 
              if BR==0
                  if  Rab==MaxR
                      if A<MaxS 
                          PacksA(i)=1; ContA(A+1)=i; A=A+1;
                      elseif A==MaxS
                          PacksA(i)=3; fA=fA+1;
                      end
                  elseif Rab==MaxR-1
                      if A==0
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1; 
                      elseif A>=1
                          PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); ContAR(AR+1)=AR+1; AR=AR+1; ContA(1)=0;
                          Rab=Rab+1; ContA(ContA==0)=[]; 
                          PacksA(i)=1; ContA(A)=i; 
                      end    
                  elseif Rab==MaxR-2
                      if A==0
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1;
                      elseif A==1 
                           PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); ContAR(AR+1)=AR+1; AR=AR+1; ContA(1)=0; Rab=Rab+1;
                           ContA(ContA==0)=[];  A=A-1;
                           PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1;
                      elseif A>=2
                          PacksA(ContA(1,1:2))=2; ContRab=[ContRab ContA(1,1:2)]; ContAR=[ContAR  AR+1  AR+2]; AR=AR+2; ContA(1,1:2)=0; Rab=Rab+2;
                          ContA(ContA==0)=[];   ContAR(ContAR==0)=[]; ContRab(ContRab==0)=[]; A=A-2;
                          PacksA(i)=1; ContA(A+1)=i; A=A+1;
                      end
                  elseif Rab<=MaxR-3
                      if A==0
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1; 
                      elseif A==1
                          PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); ContAR(AR+1)=AR+1; AR=AR+1; ContA(1)=0; Rab=Rab+1;
                          ContA(ContA==0)=[]; A=A-1;
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1; 
                      elseif A==2
                          PacksA(ContA(1,1:2))=2; ContRab=[ContRab ContA(1,1:2)]; ContAR=[ContAR  AR+1  AR+2]; AR=AR+2; ContA(1,1:2)=0; Rab=Rab+2;
                          ContA(ContA==0)=[];  ContAR(ContAR==0)=[];  ContRab(ContRab==0)=[];A=A-2;
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1; 
                      elseif A>=3
                          PacksA(ContA(1,1:3))=2; ContRab=[ContRab ContA(1,1:3)]; ContAR=[ContAR  AR+1  AR+2 AR+3]; AR=AR+3; ContA(1,1:3)=0; Rab=Rab+3;
                          ContA(ContA==0)=[];   ContAR(ContAR==0)=[]; ContRab(ContRab==0)=[]; A=A-3;
                          PacksA(i)=1; ContA(A+1)=i; A=A+1;
                      end
                  end
              elseif BR==1
                  PacksB(ContRab(ContBR(1)))=4; fB=fB+1; ContRab(ContBR(1))=0; ContRab(ContRab==0)=[]; BR=BR-1; Rab=Rab-1; ContBR(1)=0; ContBR(ContBR==0)=[]; ContAR=1:AR;
                  if Rab==MaxR-1
                      if A==0
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1; 
                      elseif A>=1
                          PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); ContAR(AR+1)=AR+1; AR=AR+1; ContA(1)=0;
                          Rab=Rab+1; ContA(ContA==0)=[]; 
                          PacksA(i)=1; ContA(A)=i; 
                      end
                  elseif Rab<=MaxR-2
                      if A==0
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1;
                      elseif A==1 
                           PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); ContAR(AR+1)=AR+1; AR=AR+1; ContA(1)=0; Rab=Rab+1;
                           ContA(ContA==0)=[];  A=A-1;
                           PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1;
                      elseif A>=2
                          PacksA(ContA(1,1:2))=2; ContRab=[ContRab ContA(1,1:2)]; ContAR=[ContAR  AR+1  AR+2]; AR=AR+2; ContA(1,1:2)=0; Rab=Rab+2;
                          ContA(ContA==0)=[];   ContAR(ContAR==0)=[]; ContRab(ContRab==0)=[]; A=A-2;
                          PacksA(i)=1; ContA(A+1)=i; A=A+1;
                      end
                  end
              elseif BR>=2
                  PacksB(ContRab(ContBR(1,1:2)))=4; fB=fB+2; Lbel=1:Rab; Lbel(ContBR(1))=0; Lbel(ContBR(2))=0; Lbel((Lbel==0))=[]; 
                  ContRab(ContBR(1))=0;ContRab(ContBR(2))=0; ContBR(1)=0; ContBR(2)=0;   
                  ContRab(ContRab==0)=[];  ContBR(ContBR==0)=[];  [~,ContBR]=ismember(ContBR,Lbel); [~,ContAR]=ismember(ContAR,Lbel); Lbel=0;
                  BR=BR-2; Rab=Rab-2;
                      if A==0
                          PacksA(i)=2; ContRab(Rab+1)=i; ContAR(AR+1)=AR+1; AR=AR+1; Rab=Rab+1; 
                      elseif A>=1
                          PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); ContAR(AR+1)=Rab+1; AR=AR+1; ContA(1)=0;
                          Rab=Rab+1; ContA(ContA==0)=[]; 
                          PacksA(i)=1; ContA(A)=i; 
                      end
              end
              
 
           elseif (ImAr(1,t)<R && ImBr(1,t)>=R)
               if A==MaxS
                PacksA(i)=3;  fA=fA+1;
              elseif A<MaxS
                PacksA(i)=1; ContA(A+1)=i; A=A+1; 
               end 
              if AR==0
                  if  Rab==MaxR
                      if B<MaxS 
                          PacksB(i)=1; ContB(B+1)=i; B=B+1;
                      elseif B==MaxS
                          PacksB(i)=3; fB=fB+1;
                      end
                  elseif Rab==MaxR-1
                      if B==0
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1; 
                      elseif B>=1
                          PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); ContBR(BR+1)=BR+1; BR=BR+1; ContB(1)=0;
                          Rab=Rab+1; ContB(ContB==0)=[]; 
                          PacksB(i)=1; ContB(B)=i; 
                      end    
                  elseif Rab==MaxR-2
                      if B==0
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1; 
                      elseif B==1 
                           PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); ContBR(BR+1)=BR+1; BR=BR+1; ContB(1)=0; Rab=Rab+1;
                           ContB(ContB==0)=[];  B=B-1;
                           PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1;
                      elseif B>=2
                          PacksB(ContB(1,1:2))=2; ContRab=[ContRab ContB(1,1:2)]; ContBR=[ContBR  BR+1  BR+2]; BR=BR+2; ContB(1,1:2)=0; Rab=Rab+2;
                          ContB(ContB==0)=[]; ContBR(ContBR==0)=[];  ContRab(ContRab==0)=[]; B=B-2;
                          PacksB(i)=1; ContB(B+1)=i; B=B+1;
                      end
                  elseif Rab<=MaxR-3
                      if B==0
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1;
                      elseif B==1
                          PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); ContBR(BR+1)=BR+1; BR=BR+1; ContB(1)=0; Rab=Rab+1;
                          ContB(ContB==0)=[];  B=B-1;
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1;
                      elseif B==2
                          PacksB(ContB(1,1:2))=2; ContRab=[ContRab ContB(1,1:2)]; ContBR=[ContBR  BR+1  BR+2]; BR=BR+2; ContB(1,1:2)=0; Rab=Rab+2;
                          ContB(ContB==0)=[];  ContBR(ContBR==0)=[];  ContRab(ContRab==0)=[]; B=B-2;
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1; 
                      elseif B>=3
                          PacksB(ContB(1,1:3))=2; ContRab=[ContRab ContB(1,1:3)]; ContBR=[ContBR  BR+1  BR+2 BR+3]; BR=BR+3; ContB(1,1:3)=0; Rab=Rab+3;
                          ContB(ContB==0)=[];  ContBR(ContBR==0)=[];  ContRab(ContRab==0)=[]; B=B-3;
                          PacksB(i)=1; ContB(B+1)=i; B=B+1;
                      end
                  end
              elseif AR==1 
                  PacksA(ContRab(ContAR(1)))=4; fA=fA+1; ContRab(ContAR(1))=0; ContRab(ContRab==0)=[]; AR=AR-1; Rab=Rab-1; ContAR(1)=0; ContAR(ContAR==0)=[]; ContBR=1:BR;
                  if Rab==MaxR-1
                      if B==0
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1; 
                      elseif B>=1
                          PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); ContBR(BR+1)=BR+1; BR=BR+1; ContB(1)=0;
                          Rab=Rab+1; ContB(ContB==0)=[]; 
                          PacksB(i)=1; ContB(B)=i; 
                      end
                  elseif Rab<=MaxR-2
                      if B==0
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1;
                      elseif B==1 
                           PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); ContBR(BR+1)=BR+1; BR=BR+1; ContB(1)=0; Rab=Rab+1;
                           ContB(ContB==0)=[];    B=B-1;
                           PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1;
                      elseif B>=2
                          PacksB(ContB(1,1:2))=2; ContRab=[ContRab ContB(1,1:2)]; ContBR=[ContBR  BR+1  BR+2]; BR=BR+2; ContB(1,1:2)=0; Rab=Rab+2;
                          ContB(ContB==0)=[];  ContBR(ContBR==0)=[]; ContRab(ContRab==0)=[]; B=B-2;
                          PacksB(i)=1; ContB(B+1)=i; B=B+1;
                      end
                  end
              elseif AR>=2
                  PacksA(ContRab(ContAR(1,1:2)))=4; fA=fA+2; Lbel=1:Rab; Lbel(ContAR(1))=0; Lbel(ContAR(2))=0; Lbel((Lbel==0))=[]; 
                  ContRab(ContAR(1))=0;ContRab(ContAR(2))=0; ContAR(1)=0; ContAR(2)=0;   
                  ContRab(ContRab==0)=[];  ContAR(ContAR==0)=[];  [~,ContAR]=ismember(ContAR,Lbel); [~,ContBR]=ismember(ContBR,Lbel); Lbel=0;
                  AR=AR-2; Rab=Rab-2;
                      if B==0
                          PacksB(i)=2; ContRab(Rab+1)=i; ContBR(BR+1)=BR+1; BR=BR+1; Rab=Rab+1;
                      elseif B>=1
                          PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); ContBR(BR+1)=Rab+1; BR=BR+1; ContB(1)=0;
                          Rab=Rab+1; ContB(ContB==0)=[]; 
                          PacksB(i)=1; ContB(B)=i;
                      end
              end
           elseif (ImAr(1,t)<R && ImBr(1,t)<R)
               if A<MaxS 
                   PacksA(i)=1; ContA(A+1)=i; A=A+1; 
               elseif A==MaxS  
                   PacksA(i)=3;   fA=fA+1;
               end
               if B<MaxS
                   PacksB(i)=1; ContB(B+1)=i; B=B+1; 
               elseif  B==MaxS
                   PacksB(i)=3;   fB=fB+1;
               end 
               
           elseif (ImAr(1,t)>=R && ImBr(1,t)>=R)
              if AR==0 && BR==0
                  if A==0 && B==0
                    PacksA(i)=4;   fA=fA+1;
                    PacksB(i)=4;  fB=fB+1;
                  elseif A~=0 && B==0
                    PacksA(ContA(1))=4; fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];  
                    PacksA(i)=1; ContA(A)=i; 
                    PacksB(i)=4;    fB=fB+1;
                  elseif A==0 && B~=0
                    PacksA(i)=4;   fA=fA+1;
                    PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; ContB(ContB==0)=[];  
                    PacksB(i)=1; ContB(B)=i; 
                  elseif A~=0 && B~=0
                    PacksA(ContA(1))=4;   fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];  
                    PacksA(i)=1; ContA(A)=i; 
                    PacksB(ContB(1))=4;    fB=fB+1; ContB(1)=0; ContB(ContB==0)=[]; 
                    PacksB(i)=1;  ContB(B)=i; 
                  end
              elseif AR==MaxR
                if A~=MaxS && B==0
                    PacksB(i)=4; fB=fB+1;
                    PacksA(ContRab(ContAR(1,1:2)))=4;  fA=fA+2; ContRab(ContAR(1,1:2))=0; ContAR(1,1:2)=0; ContAR(ContAR==0)=[]; 
                    ContRab(ContRab==0)=[]; ContAR=ContAR-2; AR=AR-2; Rab=Rab-2;
                    PacksA(i)=1; ContA(A+1)=i; A=A+1;
                elseif A~=MaxS && B~=0
                    PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; ContB(ContB==0)=[];  
                    PacksB(i)=1; ContB(B)=i;
                    PacksA(ContRab(ContAR(1,1:2)))=4;  fA=fA+2; ContRab(ContAR(1,1:2))=0; ContAR(1,1:2)=0; ContAR(ContAR==0)=[]; 
                    ContRab(ContRab==0)=[]; ContAR=ContAR-2; AR=AR-2; Rab=Rab-2; 
                    PacksA(i)=1; ContA(A+1)=i; A=A+1; 
                elseif A==MaxS && B==0
                    PacksB(i)=4; fB=fB+1;
                    PacksA(ContRab(ContAR(1,1:2)))=4;  fA=fA+2;  ContRab(ContAR(1,1:2))=0; ContAR(1,1:2)=0; ContAR(ContAR==0)=[];
                    ContRab(ContRab==0)=[]; ContAR=ContAR-2; AR=AR-2; Rab=Rab-2;
                    PacksA(i)=3; fA=fA+1;
                elseif A==MaxS && B~=0
                    PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; ContB(ContB==0)=[];  
                    PacksB(i)=1; ContB(B)=i;
                    PacksA(ContRab(ContAR(1,1:2)))=4;  fA=fA+2; ContRab(ContAR(1,1:2))=0; ContAR(1,1:2)=0; ContAR(ContAR==0)=[];
                    ContRab(ContRab==0)=[]; ContAR=ContAR-2; AR=AR-2; Rab=Rab-2; 
                    PacksA(i)=3; fA=fA+1;
                end
              elseif BR==MaxR
                if B~=MaxS && A==0
                    PacksA(i)=4; fA=fA+1;
                    PacksB(ContRab(ContBR(1,1:2)))=4;  fB=fB+2;  ContRab(ContBR(1,1:2))=0; ContBR(1,1:2)=0; ContBR(ContBR==0)=[];
                    ContRab(ContRab==0)=[]; ContBR=ContBR-2; BR=BR-2; Rab=Rab-2;
                    PacksB(i)=1; ContB(B+1)=i; B=B+1;
                elseif B~=MaxS && A~=0
                    PacksA(ContA(1))=4; fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];  
                    PacksA(i)=1; ContA(A)=i;
                    PacksB(ContRab(ContBR(1,1:2)))=4;  fB=fB+2; ContRab(ContBR(1,1:2))=0; ContBR(1,1:2)=0; ContBR(ContBR==0)=[];
                    ContRab(ContRab==0)=[]; ContBR=ContBR-2; BR=BR-2; Rab=Rab-2; 
                    PacksB(i)=1; ContB(B+1)=i; B=B+1; 
                elseif A==MaxS && B==0
                    PacksA(i)=4; fA=fA+1;
                    PacksB(ContRab(ContBR(1,1:2)))=4;  fB=fB+2;  ContRab(ContBR(1,1:2))=0;  ContBR(1,1:2)=0; ContBR(ContBR==0)=[];
                    ContRab(ContRab==0)=[]; ContBR=ContBR-2; BR=BR-2; Rab=Rab-2;
                    PacksB(i)=3; fB=fB+1;
                elseif A==MaxS && B~=0
                    PacksA(ContA(1))=4; fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];  
                    PacksA(i)=1; ContA(A)=i;
                    PacksB(ContRab(ContBR(1,1:2)))=4;  fB=fB+2; ContRab(ContBR(1,1:2))=0; ContBR(1,1:2)=0; ContBR(ContBR==0)=[]; 
                    ContRab(ContRab==0)=[]; ContBR=ContBR-2; BR=BR-2; Rab=Rab-2;
                    PacksB(i)=3; fB=fB+1;
                end
              elseif AR==0 && BR~=0 && BR~=MaxR
                  if B==0 && A==0
                     PacksA(i)=4; fA=fA+1;
                     PacksB(ContRab(ContBR(1)))=4;  fB=fB+1; ContRab(ContBR(1))=0;  ContBR(1)=0; ContBR(ContBR==0)=[]; 
                     ContRab(ContRab==0)=[]; ContBR=ContBR-1; BR=BR-1; Rab=Rab-1;
                     PacksB(i)=2; ContRab(Rab+1)=i; Rab=Rab+1; ContBR=[ContBR BR+1]; ContBR(ContBR==0)=[]; 
                  elseif  B==0 && A~=0
                      PacksA(ContA(1))=4; fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];  
                      PacksA(i)=1; ContA(A)=i;
                      PacksB(ContRab(ContBR(1)))=4;  fB=fB+1; ContRab(ContBR(1))=0;  ContBR(1)=0; ContBR(ContBR==0)=[];
                      ContRab(ContRab==0)=[]; ContBR=ContBR-1; BR=BR-1; Rab=Rab-1;
                      PacksB(i)=2; ContRab(Rab+1)=i; Rab=Rab+1; ContBR=[ContBR BR+1]; ContBR(ContBR==0)=[]; BR=BR+1;
                  elseif  B~=0 && A==0 
                      PacksA(i)=4; fA=fA+1;
                      PacksB(ContRab(ContBR(1)))=4;  fB=fB+1; ContRab(ContBR(1))=0;  ContBR(1)=0; ContBR(ContBR==0)=[]; 
                      ContRab(ContRab==0)=[]; ContBR=ContBR-1; BR=BR-1; Rab=Rab-1;
                      PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); Rab=Rab+1; ContBR=[ContBR BR+1]; ContBR(ContBR==0)=[]; 
                      ContB(1)=0; ContB(ContB==0)=[];
                      PacksB(i)=1; ContB(B)=i; 
                  elseif  B~=0 && A~=0 
                      PacksA(ContA(1))=4; fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];  
                      PacksA(i)=1; ContA(A)=i;
                      PacksB(ContRab(ContBR(1)))=4;  fB=fB+1; ContRab(ContBR(1))=0;  ContBR(1)=0; ContBR(ContBR==0)=[]; 
                      ContRab(ContRab==0)=[]; ContBR=ContBR-1; BR=BR-1; Rab=Rab-1;
                      PacksB(ContB(1))=2; ContRab(Rab+1)=ContB(1); Rab=Rab+1; ContBR=[ContBR BR+1]; ContBR(ContBR==0)=[]; 
                      ContB(1)=0; ContB(ContB==0)=[];  BR=BR+1;
                      PacksB(i)=1; ContB(B)=i;
                  end
              elseif AR~=0 && AR~=MaxR && BR==0 
                  if A==0 && B==0
                     PacksB(i)=4; fB=fB+1;
                     PacksA(ContRab(ContAR(1)))=4;  fA=fA+1; ContRab(ContAR(1))=0;  ContAR(1)=0; ContAR(ContAR==0)=[]; 
                     ContRab(ContRab==0)=[]; ContAR=ContAR-1; AR=AR-1; Rab=Rab-1;
                     PacksA(i)=2; ContRab(Rab+1)=i; Rab=Rab+1; ContAR=[ContAR AR+1]; ContAR(ContAR==0)=[]; 
                  elseif  A==0 && B~=0
                      PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; ContB(ContB==0)=[];  
                      PacksB(i)=1; ContB(B)=i;
                      PacksA(ContRab(ContAR(1)))=4;   ContRab(ContAR(1))=0; ContAR(1)=0; fA=fA+1;  ContAR(ContAR==0)=[];
                      ContRab(ContRab==0)=[]; ContAR=1:(AR-1); AR=AR-1; Rab=Rab-1;
                      PacksA(i)=2; ContRab(Rab+1)=i; Rab=Rab+1; ContAR=[ContAR AR+1]; ContAR(ContAR==0)=[]; AR=AR+1;
                  elseif  A~=0 && B==0 
                      PacksB(i)=4; fB=fB+1;
                      PacksA(ContRab(ContAR(1)))=4;  fA=fA+1; ContRab(ContAR(1))=0; ContAR(1)=0; ContAR(ContAR==0)=[]; 
                      ContRab(ContRab==0)=[]; ContAR=ContAR-1; AR=AR-1; Rab=Rab-1;
                      PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); Rab=Rab+1; ContAR=[ContAR AR+1]; ContAR(ContAR==0)=[]; 
                      ContA(1)=0; ContA(ContA==0)=[];
                      PacksA(i)=1; ContA(A+1)=i; A=A+1;
                  elseif  A~=0 && B~=0 
                      PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; ContB(ContB==0)=[];  
                      PacksB(i)=1; ContB(B)=i;
                      PacksA(ContRab(ContAR(1)))=4;  fA=fA+1;  ContRab(ContAR(1))=0; ContAR(1)=0; ContAR(ContAR==0)=[];
                      ContRab(ContRab==0)=[]; ContAR=ContAR-1; AR=AR-1; Rab=Rab-1;
                      PacksA(ContA(1))=2; ContRab(Rab+1)=ContA(1); Rab=Rab+1; ContAR=[ContAR AR+1]; ContAR(ContAR==0)=[]; 
                      ContA(1)=0; ContA(ContA==0)=[]; AR=AR+1;
                      PacksA(i)=1; ContA(A)=i;
                  end
              elseif AR~=0 && BR~=0
                      PacksB(ContRab(ContBR(1)))=4;  PacksA(ContRab(ContAR(1)))=4;  fA=fA+1; fB=fB+1;
                      Lbel=1:Rab; Lbel(ContAR(1))=0; Lbel(ContBR(1))=0; Lbel(Lbel==0)=[]; 
                      ContRab(ContAR(1))=0; ContRab(ContBR(1))=0; ContAR(1)=0; ContBR(1)=0;  
                      ContRab(ContRab==0)=[]; ContAR(ContAR==0)=[];ContBR(ContBR==0)=[]; 
                      [~,ContAR]=ismember(ContAR,Lbel); [~,ContBR]=ismember(ContBR,Lbel);  Lbel=0; 
                  if A==0 && B==0 
                      PacksA(i)=2; ContRab(Rab-1)=i ; ContAR(AR)=Rab-1;
                      PacksB(i)=2; ContRab(Rab)=i ; ContBR(BR)=Rab;
                  elseif  A==0 && B~=0
                      PacksA(i)=2; ContRab(Rab-1)=i ; ContAR(AR)=Rab-1;
                      PacksB(ContB(1))=2; ContRab(Rab)=ContB(1); ContB(1)=0 ; ContB(ContB==0)=[]; ContBR=[ContBR Rab];
                      ContBR(ContBR==0)=[];
                      PacksB(i)=1; ContB(B)=i;
                  elseif  A~=0 && B==0
                      PacksB(i)=2;ContRab(Rab-1)=i ; ContBR(BR)=Rab-1;
                      PacksA(ContA(1))=2; ContRab(Rab)=ContA(1); ContA(1)=0; ContA(ContA==0)=[]; 
                      ContAR=[ContAR Rab];  ContAR(ContAR==0)=[];
                      PacksA(i)=1; ContA(A)=i; 
                  elseif  A~=0 && B~=0
                      PacksB(ContB(1))=2; ContRab(Rab-1)=ContB(1); ContB(1)=0 ; ContB(ContB==0)=[]; ContBR=[ContBR Rab-1];
                      ContBR(ContBR==0)=[];
                      PacksB(i)=1; ContB(B)=i;
                      PacksA(ContA(1))=2; ContRab(Rab)=ContA(1); ContA(1)=0; ContA(ContA==0)=[]; 
                      ContAR=[ContAR Rab];  ContAR(ContAR==0)=[];
                      PacksA(i)=1; ContA(A)=i;
                  end
              
              end
           end
end
    LineAnalisisA=P-Error ;
    LineAnalisisB=P-Error;
    PacksA3=find(PacksA(1,1:LineAnalisisA)==3);
    PacksB3=find(PacksB(1,1:LineAnalisisB)==3);
    OutageA=numel(PacksA3)/LineAnalisisA;
    OUTA4=[OUTA4 OutageA];
    OutageB=numel(PacksB3)/LineAnalisisB;
    OUTB4=[OUTB4 OutageB];
end
end
 
