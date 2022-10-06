function[OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay1(n1,n2,P)
    OutageA=0; OutageB=0;
    OUTA1=[]; OUTB1=[]; 
for ptdb=n1:n2 
    N=2e6;
    No=1; R=1; Max=3;
    d1=0.5; d2=0.5; alpha=4;    
    g1=(d1^(-alpha));   g2=(d2^(-alpha)); 
    realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
    realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]); 
    pt=10.^(ptdb/10);
    SNRAr=(realizacaoAr.^2*pt)./(No); SNRBr=(realizacaoBr.^2*pt)./(No);      %(Relacion sinal ruido)                                                       
    ImAr=(1/3)*log2(1+SNRAr);  ImBr=(1/3)*log2(1+SNRBr);                     %(Informacion mutua)
    Error=20;                                                     %(Numero de paquete a ser simulado + un margen de error )
    PacksA=zeros(1,P);PacksB=zeros(1,P);                                     %(inicializando todos los paquetes en un estado 0)
    AR=0; BR=0;                                                     %(AR=Contador de numero de elemento en el bufer de A--->B, BR=Contador de numero de elemento en el bufer de B--->A, Max= Tamanho maximo de los buffer)                                                   
    ContA=0; ContB=0;                                                       %(Espacio para almacenar "el numero i" del paquete que fue almacenado en uno de los buffer) (Por ejemplo en un determinado situacion el paquete numero 110 fue almacenado en la posicion ContA(1) esperando nuevas sensoriamento de los caneles ) 
    fA=0;fB=0; i=0; t=0; 
while (fA<=P && fB<=P)                                                                                            %(Mientras que el Numero total de paquete transmitido con "suceso" o "NO" de A-->B y de B-->A no llegue a la catidad total de paquete a ser analizado; no paro la simulacion)
        i=i+1; t=t+1;                                                                                               %(incremento de 1 a i e t para inicializar con el primero elemento del vector Paquete e del vector de la informacion mutua.
           if (ImAr(1,t)>=R && ImBr(1,t)<R)                                                                         %A-->R OK and B---> Not Ok  
                if AR<Max                                                                                           %Si el buffer AR no esta lleno 
                    PacksB(i)=3;   fB=fB+1;                                                                         % B-->R no esta disponible, B no tiene bufer para almacenar, El paquete "bi" sale del sistema con un valor 3, es actulazado con un valor de "3" en packsB,, e incremento fB de 1 
                    PacksA(i)=2; ContA(AR+1)=i; AR=AR+1;                                                            % A-->R  esta disponible, coloco el valor de i en la posicion AR+1 en el vector ContA (Por ejemplo si i= 100 y el buffer AR esta vacio, coloco el  paquete numero 100 en la primera posicion de vector ContA) ) 
                    if BR==1
                       PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; BR=BR-1;                                          %(Hay un elemento en BR, el numero de este paquete fue almacenado en la primera posicion de ContB, Este numero se extrae, asigno el valor 4,  inclemento fB, zero ContB, decremento BR de 1, )
                    elseif BR>=2                                                                                    %Aqui tambien realizo la misma tarea que cuando habia BR==1,  pero transmito dos elemento de BR ya que tengo esta oportunidad. 
                       PacksB(ContB(1,1:2))=4; fB=fB+2; ContB(1,1:2)=0; ContB(ContB==0)=[]; BR=BR-2;      
                    end
                elseif AR==Max                                                                                      % el Buffer AR esta lleno
                    PacksA(i)=3;  fA=fA+1;                                                                          % El paquete "Ai" sale del sistema con un valor 3, es almacenado en Aa con la posicion "i", e incremento fA de 1)
                    PacksB(i)=3;  fB=fB+1;
                    if BR>0
                       PacksB(ContB(1,1:3))=4; fB=fB+3; ContB(1,1:3)=0;  ContB(ContB==0)=[]; BR=BR-3;                                           %(Hay un elemento en BR, el numero de este paquete fue almacenado en la primera posicion de ContB, Este numero se extrae, asigno el valor 4, inclemento fB, zero ContB, decremento BR de 1, )
                    end
                end
                 %A-->R Not OK and B--->  Ok 
            elseif (ImAr(1,t)<R && ImBr(1,t)>=R)                                                                    %Sistema simetro, aqui executo las misma tareas que fueron, %excecutada en el A-->R OK and B---> Not Ok.
               if BR<Max 
                    PacksA(i)=3;  fA=fA+1;
                    PacksB(i)=2; ContB(BR+1)=i; BR=BR+1; 
                    if AR==1
                       PacksA(ContA(1))=4;  fA=fA+1; ContA=0; AR=AR-1;
                    elseif AR>=2
                        PacksA(ContA(1,1:2))=4; fA=fA+2; ContA(1,1:2)=0; ContA(ContA==0)=[]; AR=AR-2;
                    end   
               elseif BR==Max
                    PacksA(i)=3;  fA=fA+1;
                    PacksB(i)=3;  fB=fB+1;
                     if AR>0
                        PacksA(ContA(1,1:3))=4; fA=fA+3; ContA(1,1:3)=0; ContA(ContA==0)=[]; AR=AR-3;  
                     end 
               end 
            elseif  (ImAr(1,t)<R && ImBr(1,t)<R)                                                                                 %A-->R Not OK and B--->  Not Ok
                PacksA(i)=3;  fA=fA+1;                                                                                           % Si lo dos enlace no estando disponible, en este frame el paquete (A-->B) sale del sistema con un valor igual a 3. (Paquete descartado). 
                PacksB(i)=3;  fB=fB+1;                                                                                           % Lo mismo ocurre en el otro sentido. 
               
            else                                                                                                                  %A-->R OK and B--->Ok
                if AR==0 && BR==0                                                                                                % Si los dos buffer estan vacios,
                   PacksA(i)=4;   fA=fA+1;                                                                                       % entonces el paquete numero "i" de A-->B llega a su destino, y su estado es 4. 
                   PacksB(i)=4;   fB=fB+1;                                                                                       % Lo mismo ocurre en el otro sentido.          
                elseif AR~=0 && BR==0                                                                                            % Si al menos hay un elemento en el buffer AR e nada en el buffer BR,
                    PacksB(i)=4;   fB=fB+1;                                                                                      % El paquete "i" que sale de B-->A coge el valor 4, pues no hay elemento en fila (BR==0). 
                    PacksA(ContA(1))=4; fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];
                    PacksA(i)=2; ContA(AR)=i;                                                                                                           %aqui es para reorganizar el vector ContA(Poniendo "i" en la primero posicion vazia ya  que el fue almacenado) 
                elseif AR==0 && BR~=0                                                        
                    PacksA(i)=4; fA=fA+1; 
                    PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; ContB(ContB==0)=[];
                    PacksB(i)=2; ContB(BR)=i;
                elseif AR~=0 && BR~=0                                                                                            % En el caso de que los dos relay tengan informaciones, la estategia correcta es envia primero los mensage de los Buffer, luego almacenar en los buffer el mensaje "i" que va de A-->B y el de B-->A
                    PacksA(ContA(1))=4; fA=fA+1; ContA(1)=0; ContA(ContA==0)=[];
                    PacksB(ContB(1))=4; fB=fB+1; ContB(1)=0; ContB(ContB==0)=[];
                    PacksA(i)=2; ContA(AR)=i;                                                                                     %aqui es para reorganizar el vector ContA(Poniendo "i" %en la primero posicion vazia ya  que el fue almacenado) 
                    PacksB(i)=2; ContB(BR)=i; 
                     
                end
           end
end
    OutageA=1-numel(find(PacksA(1,1:(P-Error))==4))/(P-Error); 
    OUTA1=[OUTA1 OutageA];
    OutageB=1-numel(find(PacksB(1,1:(P-Error))==4))/(P-Error);
    OUTB1=[OUTB1 OutageB];
end