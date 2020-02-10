function [ns]=ls_ffa_move(n,d,ns,Lightn,nso,Lighto,alpha,betamin,gamma,Lb,Ub)
b=1;
% Updating fireflies
for i=1:n
% The attractiveness parameter beta=exp(-gamma*r)
   for j=1:n
      r=sqrt(sum((ns(i,:)-ns(j,:)).^2));
      % Update moves
   if Lightn(i)>Lighto(j) % Brighter and more attractive
      if rand(1)>0.5
         beta0=1; beta=(beta0-betamin)*exp(-gamma*r.^2)+betamin;
         tmpf=alpha.*sign((rand(1,d)-0.5)).*Levy(d);
         ns(i,:)=ns(i,:).*(1-beta)+nso(j,:).*beta+tmpf;
      else
          l=-1+2*rand(1);
          beta0=1; beta=(beta0-betamin)*exp(-gamma*r.^2)+betamin;
         ns(i,:)=ns(i,:)+(-ns(i,:)+nso(j,:)).*(beta*exp(l*b)*cos(2*pi*l));
      end
   end % end for j
   end % end for i
% Check if the updated solutions/locations are within limits
end
[ns]=findlimits(n,ns,Lb,Ub);