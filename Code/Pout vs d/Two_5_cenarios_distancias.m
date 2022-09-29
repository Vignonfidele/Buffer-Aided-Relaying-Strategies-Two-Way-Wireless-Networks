%%
clc
clear all 
close all
%%
%Parametros
n1=0.1; n2=0.9; n3=0.01;  P=1e6; error=20;  ptdb=10; Max1=3; N=2e6; Max2=6;
%%
%sem buffer 
[OUTA,OUTB]=funtion_Sem_buffer2(n1,n2,n3,ptdb,P,N);
d=n1:n3:n2;
subplot(2,2,1); semilogy(d,OUTA,'b','MarkerSize',5, 'LineWidth',1.25)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9]);
yticks([7*10^-3 10^-2 10^-1 4*10^-1]); yticklabels({'7x10^-^3','10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.007 0.6 ]);
xlabel('Distância'); ylabel('Probabilidade de Outage de S_1 para S_2')

subplot(2,2,2); semilogy(d,OUTB,'b','MarkerSize',5, 'LineWidth',1.25)
hold on 
grid 
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
yticks([7*10^-3 10^-2 10^-1 4*10^-1]); yticklabels({'7x10^-^3','10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.007 0.6 ]);
xlabel('Distância')
ylabel('Probabilidade de Outage de S_2 para S_1')


%%
%Com dois buffer
[OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay2(n1,n2,n3,ptdb,P+error,Max1,N);
d=n1:n3:n2;
subplot(2,2,1); semilogy(d,OUTA1,'r--','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,2); semilogy(d,OUTB1,'r--','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer unico
[OUTA2,OUTB2]=Funtion_Com_duplo_Buffer_no_relay2(n1,n2,n3,ptdb,P+error,Max1,N);
subplot(2,2,1); semilogy(d,OUTA2,'g-.','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,2); semilogy(d,OUTB2,'g-.','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer mo relay/fonte
[OUTA3, OUTB3]=Funtion_Com_Buffer_no_relay_Fonte2(n1,n2,n3,ptdb,P+error,Max1,N);
subplot(2,2,1); semilogy(d,OUTA3,'m','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,2); semilogy(d,OUTB3,'m','MarkerSize',5, 'LineWidth',1.25);

numeco= ismembertol(d,0.1) | ismembertol(d,0.15)| ismembertol(d,0.2) | ismembertol(d,0.25)|ismembertol(d,0.3) | ismembertol(d,0.35)| ismembertol(d,0.4) | ismembertol(d,0.45)| ismembertol(d,0.5) | ismembertol(d,0.55)| ismembertol(d,0.6) | ismembertol(d,0.65)| ismembertol(d,0.7) | ismembertol(d,0.75)| ismembertol(d,0.8) | ismembertol(d,0.85)| ismembertol(d,0.9) |ismembertol(d,0.95);
subplot(2,2,1); semilogy(d(numeco),OUTA3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,2); semilogy(d(numeco),OUTB3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);

%%
%Com buffer mo relay/fonte
[OUTA4, OUTB4]=Funtion_Com_duplo_Buffer_no_relay_Fonte2(n1,n2,n3,ptdb,P+error,Max1,N);
subplot(2,2,1); semilogy(d,OUTA4,'c','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,2); semilogy(d,OUTB4,'c','MarkerSize',5, 'LineWidth',1.25);

numeco= ismembertol(d,0.1) | ismembertol(d,0.15)| ismembertol(d,0.2) | ismembertol(d,0.25)|ismembertol(d,0.3) | ismembertol(d,0.35)| ismembertol(d,0.4) | ismembertol(d,0.45)| ismembertol(d,0.5) | ismembertol(d,0.55)| ismembertol(d,0.6) | ismembertol(d,0.65)| ismembertol(d,0.7) | ismembertol(d,0.75)| ismembertol(d,0.8) | ismembertol(d,0.85)| ismembertol(d,0.9) |ismembertol(d,0.95);
subplot(2,2,1); semilogy(d(numeco),OUTA4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,2); semilogy(d(numeco),OUTB4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25);

%%
[OUTA,OUTB]=funtion_Sem_buffer2(n1,n2,n3,ptdb,P,N);
subplot(2,2,3)
semilogy(d,OUTA,'b','MarkerSize',5, 'LineWidth',1.25)
hold on
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
yticks([3*10^-3 10^-2 10^-1 4*10^-1])
yticklabels({'3x10^-^3','10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.003 0.6 ]);
xlabel('Distância')
ylabel('Probabilidade de Outage de S_1 para S_2')
subplot(2,2,4); Primero=semilogy(d,OUTB,'b','MarkerSize',5, 'LineWidth',1.25);
grid
xticks([0.1 0.2 0.4 0.6 0.8 0.9])
yticks([3*10^-3 10^-2 10^-1 4*10^-1])
yticklabels({'3x10^-^3','10^-^2', '10^-^1', '4x10^-^1'})
axis([0.1 0.9 0.003 0.6 ]);
xlabel('Distância')
ylabel('Probabilidade de Outage de S_2 para S_1')
hold on
%%
%Com dois buffer
[OUTA1,OUTB1]=Funtion_Com_dois_Buffer_no_relay2(n1,n2,n3,ptdb,P+error,Max2,N);
d=n1:n3:n2;
subplot(2,2,3); Secundo=semilogy(d,OUTA1,'r--','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,4); semilogy(d,OUTB1,'r--','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer unico
[OUTA2,OUTB2]=Funtion_Com_duplo_Buffer_no_relay2(n1,n2,n3,ptdb,P+error,Max2,N);
subplot(2,2,3); tercero=semilogy(d,OUTA2,'g-.','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,4); semilogy(d,OUTB2,'g-.','MarkerSize',5, 'LineWidth',1.25);
%%
%Com buffer mo relay/fonte
[OUTA3, OUTB3]=Funtion_Com_Buffer_no_relay_Fonte2(n1,n2,n3,ptdb,P+error,Max2,N);
subplot(2,2,3); semilogy(d,OUTA3,'m','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,4); semilogy(d,OUTB3,'m','MarkerSize',5, 'LineWidth',1.25);
numeco= ismembertol(d,0.1) | ismembertol(d,0.15)| ismembertol(d,0.2) | ismembertol(d,0.25)|ismembertol(d,0.3) | ismembertol(d,0.35)| ismembertol(d,0.4) | ismembertol(d,0.45)| ismembertol(d,0.5) | ismembertol(d,0.55)| ismembertol(d,0.6) | ismembertol(d,0.65)| ismembertol(d,0.7) | ismembertol(d,0.75)| ismembertol(d,0.8) | ismembertol(d,0.85)| ismembertol(d,0.9) |ismembertol(d,0.95);
subplot(2,2,3); semilogy(d(numeco),OUTA3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);
subplot(2,2,4); semilogy(d(numeco),OUTB3(numeco),'mv','MarkerSize',5, 'LineWidth',1.25);

% 
%%
%Com buffer mo relay/fonte
[OUTA4, OUTB4]=Funtion_Com_duplo_Buffer_no_relay_Fonte2(n1,n2,n3,ptdb,P+error,Max2,N);
subplot(2,2,3); semilogy(d,OUTA4,'c','MarkerSize',5, 'LineWidth',1.25); subplot(2,2,4); semilogy(d,OUTB4,'c','MarkerSize',5, 'LineWidth',1.25);
numeco= ismembertol(d,0.1) | ismembertol(d,0.15)| ismembertol(d,0.2) | ismembertol(d,0.25)|ismembertol(d,0.3) | ismembertol(d,0.35)| ismembertol(d,0.4) | ismembertol(d,0.45)| ismembertol(d,0.5) | ismembertol(d,0.55)| ismembertol(d,0.6) | ismembertol(d,0.65)| ismembertol(d,0.7) | ismembertol(d,0.75)| ismembertol(d,0.8) | ismembertol(d,0.85)| ismembertol(d,0.9) |ismembertol(d,0.95);
subplot(2,2,3); semilogy(d(numeco),OUTA4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25); subplot(2,2,4); semilogy(d(numeco),OUTB4(numeco),'cs','MarkerSize',5, 'LineWidth',1.25);
x1=0.01:0.001:0.01; y1=x1.^2;
x2=0.01:0.001:0.01; y2=x2.^3;
subplot(2,2,3); quarto=plot(x1,y1,'m-v','MarkerSize',5, 'LineWidth',1.25); subplot(2,2,3); Quinto=plot(x2,y2,'c-s','MarkerSize',5, 'LineWidth',1.25);
legend( [Primero; Secundo; tercero; quarto; Quinto],'Sem retransmissor', 'Buffer retransmissor', 'Buffer único retransmissor','Buffer retransmissor/fonte', 'Buffer único retransmissor/fonte')


% 
%%
% % [h1, icons1] = legend([AB, AC], {'Buffer retransmissor/fonte', 'unused'});
% % 
% % %p2_text = icons(1);
% % p3_text1 = icons1(2);
% % p2_line1 = icons1(3);
% % %p2_marker = icons(4);
% % p3_line1 = icons1(5);
% % p3_marker1 = icons1(6);
% % p2_line1.Color = Quarto.Color;
% % p2_line1.LineStyle = Quarto.LineStyle;    %it is missing the solid line of p1
% % p3_text1.Visible = 'off';             %turn off what you do not need
% % p3_line1.Visible = 'off';
% 
% 
% 
% % [h2, icons] = legend([BA, BB], {'Buffer único retransmissor/fonte', 'unused'});
% % %p2_text = icons(1);
% % p3_text = icons(2);
% % p2_line = icons(3);
% % %p2_marker = icons(4);
% % p3_line = icons(5);
% % p3_marker = icons(6);
% % p2_line.Color = Quinto.Color;
% % p2_line.LineStyle = Quinto.LineStyle;    %it is missing the solid line of p1
% % p3_text.Visible = 'off';             %turn off what you do not need
% % p3_line.Visible = 'off';
% % %p3_marker.XData = p2_marker.XData + 0.02;  %move the small white circle
% % %p3_marker.YData = p2_marker.YData + 0.02;
% % % %legend('Sem retransmissor','Buffer retransmissor','Buffer único retransmissor','Buffer retransmissor/fonte','Buffer único retransmissor/fonte')
% % % 
