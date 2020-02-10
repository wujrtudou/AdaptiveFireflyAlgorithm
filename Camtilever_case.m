clc,clear

d=5; % Simple bounds/limits for d-dimensional problems

num_search=15; %number of search agents

num_iteration=800; %number of iteration

for j=1:100

alpha=0.2; %alpha

betamin=1; %betamin

gamma=1; %gamma

Ub=100*ones(1,d);

Lb=0.01*ones(1,d);

para=[num_search num_iteration alpha betamin gamma];

u0=Lb+(Ub-Lb).*rand(1,d);

[ns,Lightn]=init_ffa(num_search,d,Lb,Ub,u0); 
        
fa_result(j,:)=ffa_mincon(str2func(['Camtilever']),u0,Lb,Ub,para,ns,Lightn);
    
lffa_result(j,:)=lf_ffa_mincon(str2func(['Camtilever']),u0,Lb,Ub,para,ns,Lightn);
    
lsfa_result(j,:)=ls_ffa_mincon(str2func(['Camtilever']),u0,Lb,Ub,para,ns,Lightn);

adfa_result(j,:)=adaptive_ffa_mincon(str2func(['Camtilever']),u0, Lb, Ub, para,ns,Lightn);

end
%%figure
figure(1)
plot(mean(fa_result),'b')
hold on
plot(mean(lffa_result),'m')
hold on
plot(mean(lsfa_result),'k')
hold on
plot(mean(adfa_result),'r')
%% Indice summmary
Fa=[mean(fa_result(:,799)),min(fa_result(:,799)),std(fa_result(:,799))];
LFFa=[mean(lffa_result(:,799)),min(lffa_result(:,799)),std(lffa_result(:,799))];
LSFa=[mean(lsfa_result(:,799)),min(lsfa_result(:,799)),std(lsfa_result(:,799))];
ADFa=[mean(adfa_result(:,799)),min(adfa_result(:,799)),std(adfa_result(:,799))];
Final_Results=[Fa; LFFa; LSFa; ADFa]
