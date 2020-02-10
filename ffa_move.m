function [ns]=ffa_move(n,d,ns,Lightn,nso,Lighto,alpha,betamin,gamma,Lb,Ub)
% Updating fireflies
for i=1:n
% The attractiveness parameter beta=exp(-gamma*r)
   for j=1:n
      r=sqrt(sum((ns(i,:)-ns(j,:)).^2));
      % Update moves
      if Lightn(i)>Lighto(j) % Brighter and more attractive
         beta0=1; beta=(beta0-betamin)*exp(-gamma*r.^2)+betamin;
         tmpf=alpha.*(rand(1,d)-0.5);
         ns(i,:)=ns(i,:).*(1-beta)+nso(j,:).*beta+tmpf;
      else
          continue
      end
   end % end for j

end % end for i
% Check if the updated solutions/locations are within limits
[ns]=findlimits(n,ns,Lb,Ub);
end