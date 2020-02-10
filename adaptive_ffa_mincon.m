% Start FA
function result=adaptive_ffa_mincon(fhandle,u0, Lb, Ub, para,ns,Lightn)
n=para(1);  MaxGeneration=para(2);
alpha=para(3); betamin=para(4); gamma=para(5);

% Calcualte dimension
d=length(u0);

% Initial values of an array
zn=ones(n,1)*10^100;
% ------------------------------------------------
% generating the initial locations of n fireflies
%[ns,Lightn]=init_ffa(n,d,Lb,Ub,u0);

% Iterations or pseudo time marching
%for k=1:MaxGeneration     %%%%% start iterations
count=1;
fbest=Inf;
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

if count==1
    
    rate=0.5;
else
    
    I_a=floor(log10(abs(fbest(count-1))));
    
    I_b=floor(log10(abs(fbest(count))));
    
if I_a==I_b
    
   theta=floor(log10(abs(fbest(count)-fix(fbest(count)))));
    
   a=fbest(count-1)-(10^theta)*floor(fbest(count-1)/(10^(theta+1)));
   
   b=fbest(count)-(10^theta)*floor(fbest(count)/(10^(theta+1)));
    
else
    
    a=fbest(count-1);
    
    b=fbest(count);
    
end    

rate=1/(1+exp(-a/b));

end

% Move all fireflies to the better locations
[ns]=adaptive_ffa_move(n,d,ns,Lightn,nso,Lighto,alpha,betamin,gamma,Lb,Ub,rate);

count=count+1;

end   %%%%% end of iterations

    result=fbest;

end

