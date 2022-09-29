function[OUTA3, OUTB3]=Funtion_Com_Buffer_no_relay_Fonte(ptdb,Max)
for Max=Max 
OUTA3=[]; OUTB3=[];
OutageA=0; OutageB=0;
    R=1;  No=1;
    N=2e6;
    d1=0.5; d2=0.5; alpha=4;    
    g1=(d1^(-alpha));   g2=(d2^(-alpha)); 
    realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
    realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]);
    pt=10.^(ptdb/10);
    SNRAr=(realizacaoAr.^2*pt)./(No);  SNRBr=(realizacaoBr.^2*pt)./(No);                                                             
    ImAr=(1/3)*log2(1+SNRAr);    ImBr=(1/3)*log2(1+SNRBr);
    Error=100;
for P=700000:100000:1000000
    P=P+Error;
    PacksA=zeros(1,P); PacksB=zeros(1,P);
    A=0; B=0; AR=0; BR=0; 
    ContA=0; ContB=0; ContAR=0; ContBR=0; %Espacio para almacenar "el numero i" del paquete que fue almacenado en uno de los buffer (ContA del buffer A, ContB del Buffer B, ContAR del buffer AR y ContBR del buffer Br )
    fA=0; fB=0; i=0; t=0; 
    while fA<=P && fB<=P
        i=i+1; t=t+1;
       % A-->R Ok and B-->R Not Ok
        if (ImAr(1,t)>=R && ImBr(1,t)<R)
            %Este Bloque realiza la siguiente tarea: 
            %1) el buffer B esta lleno, el enlace BR no esta disponible por lo que, el paquete "i" que sale de B -->A toma el valor de 3 (descartado), fB se inclementa en 1 y  es actulazado con un valor de "3" en packsB, 
            %2) el Buffer AR no esta lleno, si no hay elemento almacenado en el buffer A pues el paquete "i" que sale de A--->B se almacena en la primera posicion disponible en  AR, 
            %3) Sino si al menos hay un elemento en buffer A (Logicamente este elemento tiene que ser atendido primero), el paquete primero paquete en ContA sale y se almacena en  AR, Se actuliza ContAR,  
            %4) el paque "i" de este frame  (A-->B)almacena en A, actualizando el valor de ContA  
            %5) El Buffer BR es liberado segun la cantida de paquete que tenga y el sub-Frame diponible para realizar esta tarea(3 tarea por frame)
            if B==Max
                PacksB(i)=3;  fB=fB+1;
            elseif B<Max
                PacksB(i)=1; ContB(B+1)=i; B=B+1; 
            end
            if AR<Max
                if A==0 
                    PacksA(i)=2; ContAR(AR+1)=i; AR=AR+1;  ContAR(ContAR==0)=[];
                    if (BR>0 && BR<3)
                       PacksB(ContBR(1,1:BR))=4;  fB=fB+BR; ContBR=0; BR=BR-BR;
                    elseif BR>=3
                        PacksB(ContBR(1,1:2))=4; fB=fB+2; ContBR(1,1:2)=0; ContBR(ContBR==0)=[]; BR=BR-2; 
                    end  
                elseif A==1
                    if AR==Max-1  
                        PacksA(ContA(1))=2;  ContAR(AR+1)=ContA(1); AR=AR+1; ContA(1)=0; ContA(ContA==0)=[];  ContAR(ContAR==0)=[];
                        PacksA(i)=1; ContA(A)=i;
                        if (BR>0 && BR<3)
                            PacksB(ContBR(1,1:BR))=4;  fB=fB+BR; ContBR=0; BR=BR-BR; ContBR(ContA==0)=[];  
                        elseif BR>=3
                            PacksB(ContBR(1,1:2))=4; fB=fB+2; ContBR(1,1:2)=0; ContBR(ContBR==0)=[]; BR=BR-2; 
                        end
                    elseif AR<=Max-2 
                        PacksA(ContA(1))=2;  ContAR(AR+1)=ContA(1); AR=AR+1; ContA(1)=0; ContAR(ContAR==0)=[];
                        PacksA(i)=2; ContAR(AR+1)=i; AR=AR+1; A=A-1;
                        if BR>0
                           PacksB(ContBR(1))=4;  fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; BR=BR-1;
                        end
                    end
                elseif A==2
                    if AR==Max-1 
                        PacksA(ContA(1))=2;  ContAR(AR+1)=ContA(1); AR=AR+1; ContA(1)=0; ContA(ContA==0)=[]; ContAR(ContAR==0)=[];
                        PacksA(i)=1; ContA(A)=i;
                        if (BR>0 && BR<3)
                              PacksB(ContBR(1,1:BR))=4;  fB=fB+BR; ContBR=0; BR=BR-BR;
                        elseif BR>=3
                              PacksB(ContBR(1,1:2))=4; fB=fB+2;  ContBR(1,1:2)=0 ;ContBR(ContBR==0)=[]; BR=BR-2;
                        end
                    elseif AR==Max-2 
                        PacksA(ContA(1,1:2))=2;  ContAR=[ContAR ContA(1,1:2)]; AR=AR+2; ContA(1,1:2)=0; ContA(ContA==0)=[]; ContAR(ContAR==0)=[];
                        PacksA(i)=1; ContA(A-1)=i; A=A-1;
                        if BR>0
                             PacksB(ContBR(1))=4;  fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; BR=BR-1;
                        end
                    elseif AR<=Max-3
                        if BR==0 
                          PacksA(ContA(1,1:2))=2;  ContAR=[ContAR ContA(1,1:2)]; AR=AR+2; ContA(1,1:2)=0; ContA(ContA==0)=[]; ContAR(ContAR==0)=[];
                          PacksA(i)=2; ContAR(AR+1)=i; AR=AR+1;  A=A-2;
                        elseif BR==Max 
                          PacksA(ContA(1))=2; ContAR=[ContAR ContA(1)]; AR=AR+1; ContA(1)=0; ContA(ContA==0)=[];ContAR(ContAR==0)=[];
                          PacksA(i)=1; ContA(A)=i;
                          PacksB(ContBR(1,1:2))=4; fB=fB+2;  ContBR(1,1:2)=0; ContBR(ContBR==0)=[]; BR=BR-2;
                        else 
                          PacksA(ContA(1,1:2))=2;  ContAR=[ContAR ContA(1,1:2)]; AR=AR+2; ContA(1,1:2)=0; ContA(ContA==0)=[]; ContAR(ContAR==0)=[];
                          PacksA(i)=1; ContA(A-1)=i; A=A-1; 
                          PacksB(ContBR(1))=4;  fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; BR=BR-1;
                        end
                    end
                elseif A>=3
                    if AR==Max-1 
                        PacksA(ContA(1))=2;  ContAR=[ContAR ContA(1)]; AR=AR+1; ContA(1)=0; ContA(ContA==0)=[];  ContAR(ContAR==0)=[];
                        PacksA(i)=1; ContA(A)=i;
                        if (BR>0 && BR<3)
                              PacksB(ContBR(1,1:BR))=4;  fB=fB+BR; ContBR=0; BR=BR-BR;
                        elseif BR>=3
                              PacksB(ContBR(1,1:2))=4; fB=fB+2;  ContBR(1,1:2)=0; ContBR(ContBR==0)=[]; BR=BR-2;
                        end
                    elseif AR==Max-2 
                        PacksA(ContA(1,1:2))=2;  ContAR=[ContAR ContA(1,1:2)]; AR=AR+2; ContA(1,1:2)=0; ContA(ContA==0)=[];  ContAR(ContAR==0)=[];
                        PacksA(i)=1; ContA(A-1)=i; A=A-1;
                        if BR>0
                           PacksB(ContBR(1))=4;  fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; BR=BR-1;
                        end
                    elseif AR<=Max-3
                        if BR==0 
                          PacksA(ContA(1,1:3))=2;  ContAR=[ContAR ContA(1,1:3)] ; AR=AR+3; ContA(1,1:3)=0; ContA(ContA==0)=[]; ContAR(ContAR==0)=[];
                          PacksA(i)=1; ContA(A-2)=i; A=A-2;
                        else 
                          PacksA(ContA(1,1:2))=2;  ContAR=[ContAR ContA(1,1:2)]; AR=AR+2; ContA(1,1:2)=0; ContA(ContA==0)=[]; ContAR(ContAR==0)=[];
                          PacksA(i)=1; ContA(A-1)=i; A=A-1; 
                          PacksB(ContBR(1))=4;  fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; BR=BR-1;
                        end
                    end
                end 
            %Este Bloque realiza la siguiente tarea: 
            %1) el buffer B esta lleno, el enlace BR no esta disponible por lo que, el paquete "i" que sale de B -->A toma el valor de 3 (descartado), fB se inclementa en 1 y  es actulazado con un valor de "3" en packsB,
            %2) el Buffer AR  esta lleno, por lo que la decision es %almacenar en A el paquete i ou descartarlo 
            %3) Si A no esta lleno, se almacena el paquete "i" con el valor 1, Actualixo ContA, y A inclementa de 1. 
            %4) Si A esta lleno, el paquete i sale del sistema con un valor  %igual a 3. 
            %5) El Buffer BR es liberado segun la cantida de paquete que
            %tenga ) 
            elseif AR==Max
                if BR>0
                   PacksB(ContBR(1,1:min(BR,3)))=4;  fB=fB+min(BR,3); ContBR(1,1:min(BR,3))=0;  BR=BR-min(BR,3);  ContBR(ContBR==0)=[];
                end
                if A<Max
                    PacksA(i)=1; ContA(A+1)=i; A=A+1; 
                elseif A==Max    
                    PacksA(i)=3;  fA=fA+1; 
                end
            end
            % A-->R Not Ok B-->R  Ok
        elseif (ImAr(1,t)<R && ImBr(1,t)>=R)
            %Este bloque realizar exactamente la misma tarea pero de forma
            %simetrica al bloque de A-->R Ok B-->R Not Ok
            if A==Max
                PacksA(i)=3;  fA=fA+1;
            elseif A<Max
                PacksA(i)=1; ContA(A+1)=i; A=A+1; 
            end
            if BR<Max 
                 if B==0 
                    PacksB(i)=2; ContBR(BR+1)=i; BR=BR+1;  ContBR(ContBR==0)=[];
                    if (AR>0 && AR<3)
                       PacksA(ContAR(1,1:AR))=4;  fA=fA+AR; ContAR=0; AR=AR-AR;
                    elseif AR>=3
                        PacksA(ContAR(1,1:2))=4; fA=fA+2; ContAR(1,1:2)=0; ContAR(ContAR==0)=[];  AR=AR-2;
                    end  
                elseif B==1
                    if BR==Max-1  
                        PacksB(ContB(1))=2;  ContBR=[ContBR ContB(1)] ; BR=BR+1; ContB(1)=0; ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                        PacksB(i)=1; ContB(B)=i;
                        if (AR>0 && AR<3)
                            PacksA(ContAR(1,1:AR))=4;  fA=fA+AR; ContAR=0; AR=AR-AR;
                        elseif AR>=3
                            PacksA(ContAR(1,1:2))=4; fA=fA+2; ContAR(1,1:2)=0; ContAR(ContAR==0)=[];  AR=AR-2;
                        end
                    elseif BR<=Max-2 
                        PacksB(ContB(1))=2;  ContBR=[ContBR ContB(1)]; BR=BR+1; ContB(1)=0; ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                        PacksB(i)=2; ContBR(BR+1)=i; BR=BR+1; B=B-1;
                        if AR>0
                            PacksA(ContAR(1))=4;  fA=fA+1;   ContAR(1)=0; ContAR(ContAR==0)=[];  AR=AR-1;
                        end
                    end
                elseif B==2
                    if BR==Max-1 
                        PacksB(ContB(1))=2;  ContBR=[ContBR ContB(1)] ; BR=BR+1; ContB(1)=0;ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                        PacksB(i)=1; ContB(B)=i; 
                        if (AR>0 && AR<3)
                              PacksA(ContAR(1,1:AR))=4;  fA=fA+AR; ContAR=0; AR=AR-AR;
                        elseif AR>=3
                              PacksA(ContAR(1,1:2))=4; fA=fA+2; ContAR(1,1:2)=0; ContAR(ContAR==0)=[];  AR=AR-2;
                        end
                    elseif BR==Max-2 
                        PacksB(ContB(1,1:2))=2;  ContBR=[ContBR ContB(1,1:2)]; BR=BR+2; ContB(1,1:2)=0; ContB(ContB==0)=[];  ContBR(ContBR==0)=[];
                        PacksB(i)=1; ContB(B-1)=i; B=B-1;
                        if AR>0
                            PacksA(ContAR(1))=4;  fA=fA+1;   ContAR(1)=0; ContAR(ContAR==0)=[];  AR=AR-1;
                        end
                    elseif BR<=Max-3
                        if AR==0 
                          PacksB(ContB(1,1:2))=2;  ContBR=[ContBR ContB(1,1:2)]; BR=BR+2; ContB(1,1:2)=0; ContB(ContB==0)=[]; ContBR(ContBR==0)=[]; 
                          PacksB(i)=2; ContBR(BR+1)=i; BR=BR+1;  B=B-2;  
                        elseif AR==Max 
                          PacksB(ContB(1))=2;  ContBR=[ContBR ContB(1)] ; BR=BR+1; ContB(1)=0; ContB(ContB==0)=[];  ContBR(ContBR==0)=[];
                          PacksB(i)=1; ContB(B)=i;
                          PacksA(ContAR(1,1:2))=4; fA=fA+2; ContAR(1,1:2)=0; ContAR(ContAR==0)=[];  AR=AR-2;
                        else  
                          PacksB(ContB(1,1:2))=2;  ContBR=[ContBR ContB(1,1:2)]; BR=BR+2; ContB(1,1:2)=0; ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                          PacksB(i)=1; ContB(B-1)=i; B=B-1; 
                          PacksA(ContAR(1))=4;  fA=fA+1;   ContAR(1)=0; ContAR(ContAR==0)=[];  AR=AR-1;
                        end
                    end
                elseif B>=3
                    if BR==Max-1 
                        PacksB(ContB(1))=2;  ContBR=[ContBR ContB(1)] ; BR=BR+1; ContB(1)=0;ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                        PacksB(i)=1; ContB(B)=i;
                        if (AR>0 && AR<3)
                              PacksA(ContAR(1,1:AR))=4;  fA=fA+AR; ContAR=0; AR=AR-AR;
                        elseif AR>=3
                              PacksA(ContAR(1,1:2))=4; fA=fA+2; ContAR(1,1:2)=0; ContAR(ContAR==0)=[];  AR=AR-2;
                        end
                    elseif BR==Max-2 
                        PacksB(ContB(1,1:2))=2;  ContBR=[ContBR ContB(1,1:2)]; BR=BR+2; ContB(1,1:2)=0; ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                        PacksB(i)=1; ContB(B-1)=i; B=B-1;
                        if AR>0
                            PacksA(ContAR(1))=4;  fA=fA+1;   ContAR(1)=0; ContAR(ContAR==0)=[];  AR=AR-1;
                        end
                    elseif BR<=Max-3
                        if AR==0 
                          PacksB(ContB(1,1:3))=2;  ContBR=[ContBR ContB(1,1:3)]; BR=BR+3; ContB(1,1:3)=0; ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                          PacksB(i)=1; ContB(B-2)=i; B=B-2;
                        else 
                         PacksB(ContB(1,1:2))=2;  ContBR=[ContBR ContB(1,1:2)]; BR=BR+2; ContB(1,1:2)=0; ContB(ContB==0)=[]; ContBR(ContBR==0)=[];
                         PacksB(i)=1; ContB(B-1)=i; B=B-1; 
                         PacksA(ContAR(1))=4;  fA=fA+1;   ContAR(1)=0; ContAR(ContAR==0)=[];  AR=AR-1;
                        end
                    end
                 end        
            elseif BR==Max
                if AR>0
                    PacksA(ContAR(1,1:min(3,AR)))=4;   fA=fA+(min(3,AR)); ContAR(1,1:(min(3,AR)))=0; AR=AR-(min(3,AR)); ContAR(ContAR==0)=[];
                end
                if B<Max  
                    PacksB(i)=1; ContB(B+1)=i; B=B+1;
                elseif B==Max 
                    PacksB(i)=3;   fB=fB+1;
                end 
            end
            
            %Los dos enlaces no estan disponibles
        elseif  (ImAr(1,t)<R && ImBr(1,t)<R) 
           % Aqui se realiza diferente: Basicamnete las siguentes:
           % 1) Se hay espacio en en los bufer se almacena el paquete "i" con el valor 1
           % 2) Sino hay espacio, el paquete "i" es descartado, cogiendo un
           % valor 3 en PackssA/PacksB. 
            if A<Max && B<Max
                PacksA(i)=1; ContA(A+1)=i; A=A+1; 
                PacksB(i)=1; ContB(B+1)=i; B=B+1; 
            elseif A==Max && B<Max
                PacksA(i)=3;   fA=fA+1;
                PacksB(i)=1; ContB(B+1)=i; B=B+1; 
            elseif A<Max && B==Max
                PacksA(i)=1; ContA(A+1)=i; A=A+1; 
                PacksB(i)=3;   fB=fB+1;
            elseif A==Max && B==Max 
                PacksA(i)=3;   fA=fA+1;
                PacksB(i)=3;   fB=fB+1;
            end
            
        else
            %En este bloque examino la posibilidad de tener los buffer AR y BR vazio. En este caso la transmission de un nuevo/antiguo paquete depente del estado de los buffer A e B 
            %1) Si A y B estan vazio entonces el paquete "i" tanto de A-->B como de B--> A llega a su destino y toma el valor 4. fA/fB se incrementa en 1 pues los paquete salen del sistema. 
            %2) Si uno de los los dos buffer extremo tiene informacion y el outro no, doy prioridad de envio al paquete en espera, y  el paquete "i" nuevo que llega lo almaceno en el transmisor con un valor 1 que a su vez esperara el proximo frame para ser transmitido o no. 
            %3) Cuando los dos buffer tienen paquetes, entonces doy prioridad de envio los paquetes en espera, y  los paquete "i" nuevo que llega a los Tx lo almaceno en el transmisor (A/B) con un valor 1 que a su vez esperara el proximo frame para ser transmitido o no.
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
                %Las misma logica se implementa aqui, siempre dando prioridad al paquete mas antiguo. 
            elseif AR~=0 && BR==0  
                if A==0 && B==0
                    PacksB(i)=4; fB=fB+1;  
                    PacksA(ContAR(1))=4;  fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[]; 
                    PacksA(i)=2; ContAR(AR)=i; 
                elseif A~=0 && B==0
                    PacksA(ContAR(1))=4;  fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[]; 
                    PacksA(ContA(1))=2; ContAR(AR)=ContA(1); ContA(1)=0; ContA(ContA==0)=[];  
                    PacksA(i)=1; ContA(A)=i; 
                    PacksB(i)=4;  fB=fB+1; 
                elseif A==0 && B~=0
                    PacksA(ContAR(1))=4;  fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[];
                    PacksA(i)=2; ContAR(AR)=i;  
                    PacksB(ContB(1))=4;   fB=fB+1; ContB(1)=0; ContB(ContB==0)=[]; 
                    PacksB(i)=1; ContB(B)=i;  
                elseif A~=0 && B~=0
                    PacksA(ContAR(1))=4;   fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[];
                    PacksA(ContA(1))=2; ContAR(AR)=ContA(1); ContA(1)=0; ContA(ContA==0)=[]; 
                    PacksA(i)=1; ContA(A)=i; 
                    PacksB(ContB(1))=4;    fB=fB+1; ContB(1)=0; ContB(ContB==0)=[]; 
                    PacksB(i)=1; ContB(B)=i;  
                end
            elseif AR==0 && BR~=0
                if A==0 && B==0
                    PacksA(i)=4;  fA=fA+1;
                    PacksB(ContBR(1))=4;   fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[];
                    PacksB(i)=2; ContBR(BR)=i; 
                elseif A~=0 && B==0
                    PacksB(ContBR(1))=4;   fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; 
                    PacksB(i)=2; ContBR(BR)=i; 
                    PacksA(ContA(1))=4;   fA=fA+1; ContA(1)=0; ContA(ContA==0)=[]; 
                    PacksA(i)=1; ContA(A)=i;  
                elseif A==0 && B~=0
                    PacksB(ContBR(1))=4;  fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; 
                    PacksB(ContB(1))=2;  ContBR(BR)=ContB(1); ContB(1)=0; ContB(ContB==0)=[]; 
                    PacksB(i)=1; ContB(B)=i; 
                    PacksA(i)=4;  fA=fA+1;
                elseif A~=0 && B~=0
                    PacksA(ContA(1))=4;  fA=fA+1; ContA(1)=0; ContA(ContA==0)=[]; 
                    PacksA(i)=1; ContA(A)=i;  
                    PacksB(ContBR(1))=4;   fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[];
                    PacksB(ContB(1))=2;  ContBR(BR)=ContB(1); ContB(1)=0; ContB(ContB==0)=[];  
                    PacksB(i)=1; ContB(B)=i; 
                end
            elseif AR~=0 && BR~=0 
                if A==0 && B==0
                    PacksA(ContAR(1))=4;  fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[];
                    PacksA(i)=2; ContAR(AR)=i; 
                    PacksB(ContBR(1))=4;   fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[];
                    PacksB(i)=2; ContBR(BR)=i; 
                elseif A~=0 && B==0
                    PacksA(ContAR(1))=4;   fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[];
                    PacksA(ContA(1))=2; ContAR(AR)=ContA(1); ContA(1)=0; ContA(ContA==0)=[]; 
                    PacksA(i)=1; ContA(A)=i;  
                    PacksB(ContBR(1))=4;  fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[];
                    PacksB(i)=2; ContBR(BR)=i; 
                elseif A==0 && B~=0
                    PacksA(ContAR(1))=4;  fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[];
                    PacksA(i)=2; ContAR(AR)=i; 
                    PacksB(ContBR(1))=4;   fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[]; 
                    PacksB(ContB(1))=2;  ContBR(BR)=ContB(1); ContB(1)=0; ContB(ContB==0)=[]; 
                    PacksB(i)=1; ContB(B)=i; 
                elseif A~=0 && B~=0
                    PacksA(ContAR(1))=4; fA=fA+1; ContAR(1)=0; ContAR(ContAR==0)=[];
                    PacksA(ContA(1))=2; ContAR(AR)=ContA(1); ContA(1)=0; ContA(ContA==0)=[]; 
                    PacksA(i)=1; ContA(A)=i;  
                    PacksB(ContBR(1))=4;   fB=fB+1; ContBR(1)=0; ContBR(ContBR==0)=[];
                    PacksB(ContB(1))=2;  ContBR(BR)=ContB(1); ContB(1)=0; ContB(ContB==0)=[]; 
                    PacksB(i)=1; ContB(B)=i; 
                end 
            end
             
        end
    end 
    
    LineAnalisisA=P-Error ;
    LineAnalisisB=P-Error;
    PacksA3=find(PacksA(1,1:LineAnalisisA)==3);
    PacksB3=find(PacksB(1,1:LineAnalisisB)==3);
    OutageA=numel(PacksA3)/LineAnalisisA;
    OUTA3=[OUTA3 OutageA];
    OutageB=numel(PacksB3)/LineAnalisisB;
    OUTB3=[OUTB3 OutageB];
    
end
end

