clc
clear all 
close all 
alpha=4;
N=2e6;
d1=0.4; d2=0.6;                                                               
g1=(d1^(-alpha));   g2=(d2^(-alpha));
realizacaoAr=sqrt(g1)*randraw('nakagami', 1, [1 N]);  
realizacaoBr=sqrt(g2)*randraw('nakagami', 1, [1 N]);