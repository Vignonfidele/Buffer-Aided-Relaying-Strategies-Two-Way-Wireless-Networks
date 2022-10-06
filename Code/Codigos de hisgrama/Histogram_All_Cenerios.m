%%

%%
%Parametros
n1=-10; n2=40; R=1;  N=1000;  No=1;   d1=0.5;    d2=0.5;  alpha=4;                                                              
g1=(d1^(-alpha));   g2=(d2^(-alpha)); 
load('realizacaoAr.mat','realizacaoAr') 
load('realizacaoBr.mat','realizacaoBr');
OUTA=[]; OUTB=[]; OUTA1=[]; OUTB1=[]; OUTA3=[]; OUTB3=[]; OUTA2=[]; OUTB2=[]; 
P=100000:100000:1000000;
%%
%Sem buffer
% figure(1)
% n=1;
% for ptdb=-10:10:40
% [OUTA,OUTB]=funtion_Sem_buffer(ptdb); 
% P=100000:100000:1000000;
% subplot(3,2,n); bar(P,OUTA,0.4)
% xlabel('Transmitted packets')
% ylabel('Lost packets')  
% hold on
% n=n+1;  
% title('Two Way without Buffer')
% end
% %%
% %Com dois buffer
% for Max=[ 3 ]
% i=2;
% figure(i)
% n=1;
% for ptdb=-10:10:40 
% [OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay(ptdb,Max);
% P=100000:100000:1000000;
% if Max==1
%     P=P-1e4;
% elseif Max==2
%     P=P;
% elseif Max==3
%     P=P+2*1e4;
% elseif Max==10
%     P=P+3*1e4;
% end    
% subplot(3,2,n); bar(P,OUTA1,0.4) 
% xlabel('Transmitted packets')
% ylabel('Lost packets')  
% hold on
% n=n+1; 
% title('Two-Way with Two Buffer relay')
% end 
% end 
% 
% %legend(sprintfc('Max= %d dB',1))
% %%
% %Com buffer unico
% for Max=[ 6 ]
% i=3;
% figure(i)
% n=1;
% for ptdb=-10:10:40 
% [OUTA2,OUTB2]=Funtion_Com_duplo_Buffer_no_relay(ptdb,Max);
% P=100000:100000:1000000;
% if Max==2
%     P=P-1e4;
% elseif Max==4
%     P=P;
% elseif Max==6
%     P=P+2*1e4;
% elseif Max==20
%     P=P+3*1e4;
% end  
% subplot(3,2,n); bar(P,OUTA2,0.4)
% xlabel('Transmitted packets')
% ylabel('Lost packets')  
% hold on
% n=n+1; 
% %legend(sprintfc('Px= %d dB',ptdb)) 
% title( 'Two-Way with Only Buffer relay')
% end
% end
% %%
% %Com buffer no relay/fonte
% for Max=[ 3 ]
% i=4;
% figure(i)
% n=1;
% for ptdb=-10:10:40 
% [OUTA3, OUTB3]=Funtion_Com_Buffer_no_relay_Fonte(ptdb,Max);
% P=100000:100000:1000000;
% if Max==1
%     P=P-1e4;
% elseif Max==2
%     P=P;
% elseif Max==3
%     P=P+2*1e4;
% elseif Max==10
%     P=P+3*1e4;
% end  
% subplot(3,2,n); bar(P,OUTA3,0.4)
% xlabel('Transmitted packets')
% ylabel('Lost packets')  
% hold on
% n=n+1; 
% %legend(sprintfc('Px= %d dB',ptdb)) 
% title( 'Two-Way with Buffer relay/source')
% end
% end
% %%
% %Com buffer no duplo_relay/fonte
% for Max=[ 3 ]
%     MaxS=Max;
%     MaxR=2*Max;
% i=5;
% figure(i)
% n=1;
% for ptdb=-10:10:40 
% [OUTA4, OUTB4]=Funtion_Com_duplo_Buffer_no_relay_Fonte(ptdb,MaxS,MaxR);
% P=100000:100000:1000000;
% if Max==1
%     P=P-1e4;
% elseif Max==2
%     P=P;
% elseif Max==3
%     P=P+2*1e4;
% elseif Max==10
%     P=P+3*1e4;
% end  
% subplot(3,2,n); bar(P,OUTA4,0.4)
% xlabel('Transmitted packets')
% ylabel('Lost packets')  
% hold on
% n=n+1; 
% %legend(sprintfc('Px= %d dB',ptdb)) 
% title( 'Two-Way with Buffer Only relay/source')
% end
% end


%%
%os 04 senarios  con tamano de buffer =3

Max=3;
MaxS=Max;
MaxR=2*Max;
i=6;
figure(i)
n=1;
for ptdb=-10:10:20  
P=700000:100000:1000000;
subplot(2,2,n); 
[OUTA1,~]=Funtion_Com_dois_Buffer_no_relay(ptdb,Max);
[OUTA2,~]=Funtion_Com_duplo_Buffer_no_relay(ptdb,6);
[OUTA3,~]=Funtion_Com_Buffer_no_relay_Fonte(ptdb,Max);
[OUTA4,~]=Funtion_Com_duplo_Buffer_no_relay_Fonte(ptdb,MaxS,MaxR);
Y=100*[OUTA1.',OUTA2.',OUTA3.', OUTA4.'];
bar(P,Y);
hold on
xlabel('Pacotes transmitidos')
ylabel('Taxa de perda de pacotes (%)')  
grid
n=n+1;
end




