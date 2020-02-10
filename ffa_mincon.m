function result=ffa_mincon(fhandle,u0, Lb, Ub, para,ns,Lightn)

n=para(1); % n=number of fireflies

MaxGeneration=para(2); % MaxGeneration=number of pseudo time steps

alpha=para(3); % alpha: Randomness 0--1 (highly random)

betamin=para(4); % betamn: minimum value of beta

gamma=para(5); % gamma: Absorption coefficient


d=length(u0);% Calcualte dimension



% Initial values of an array
zn=ones(n,1)*10^100;

% generating the initial locations of n fireflies
%[ns,Lightn]=init_ffa(n,d,Lb,Ub,u0);

count=1;

fbest=Inf;
% Iterations or pseudo time marching

while (count<MaxGeneration) 
    
% This line of reducing alpha is optional
 alpha=alpha_new(alpha,MaxGeneration);
 
% Evaluate new solutions (for all n fireflies)
for i=1:n
    
   zn(i)=fhandle(ns(i,:));
   
   Lightn(i)=zn(i);
   
end
% Ranking fireflies by their light intensity/objectives
[Lightn,Index]=sort(zn);

ns_tmp=ns;

for i=1:n
    
 ns(i,:)=ns_tmp(Index(i),:);
 
end

%% Find the current best
nso=ns; Lighto=Lightn;

Lightbest=Lightn(1);

% For output only
fbest(count)=Lightbest;

% Move all fireflies to the better locations
[ns]=ffa_move(n,d,ns,Lightn,nso,Lighto,alpha,betamin,gamma,Lb,Ub);

count=count+1;

end   %%%%% end of iterations

    result=fbest;


end

