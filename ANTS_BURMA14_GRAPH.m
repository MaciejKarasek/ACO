clear; clc;
%
NumCit=14; a=0.7; b=0.7; 
NumAnt=NumCit;     
rho=0.5; Q=1;
NumIter=8;
%---------------------------------------------------------------
z=10^10; 
%                             PROBLEM - BURMA 14
w=[16.47 96.10;    %CITY X Y COORDINATES
 16.47 94.44;
 20.09 92.52;
 22.39 93.37;
 25.23 97.24;
 22.00 96.05;
 20.47 97.02;
 17.20 96.29;
 16.30 97.38;
 14.05 98.12;
 16.53 97.38;
 21.52 95.59;
 19.41 97.13;
 20.09 94.55];
%
for i=1:NumCit 
        for j=1:NumCit
          if i==j
           d(i,j)=z;
           else
           d(i,j)=sqrt((w(i,1)-w(j,1))^2.0+(w(i,2)-w(j,2))^2.0);
         end
        end
    end
%    
    for i=1:NumCit 
        for j=1:NumCit
            tau(i,j)=1;    % PHEROMONE DOSE ON CONNECTIONS BETWEEN CITIES
            if i==j; tau(i,j)=0; end
            eta(i,j)=1/d(i,j);  % VISIBILITY - RECIPROCAL OF DISTANCE BETWEEN CITIES
          
        end
    end
       
%    
for iter=1:NumIter     
fprintf('START OF ITER %i  ========================================================= \n',iter);
%
for iant=1:NumAnt   % LOOKING FOR BEST PATH BY EVERY ANT
%    
temp=tau;    
temp(:,iant)=0;
Path(iant,1)=iant;  % START. EVERY ANT STARTS FROM A DIFFRENT CITY
ind=iant;

%
for icity=2:NumCit   
%
sum=0;
for j=1:NumCit
  sum=sum+(temp(ind,j)^a)*(eta(ind,j)^b);  
end
%
for k=1:NumCit
 p(k)=(temp(ind,k)^a)*(eta(ind,k)^b)/sum;   
end
[pmax,ind]=max(p);
%
Path(iant,icity)=ind; 
temp(:,ind)=0;    
end
%
Path(iant,NumCit+1)=iant;
sump=0;
for ip=1:NumCit
    sump=sump+d(Path(iant,ip),Path(iant,ip+1));
end
DistPath(iant)=sump;
fprintf('PATH  %i  %i  %i  %i  %i  %i  %i  %i  %i  %i  %i  %i  %i  %i  %i   DIST=%f \n',Path(iant,:),DistPath(iant));
%
end
%
fprintf('END OF ITER %i  ========================================================= \n',iter);
%
[MinPath,min_ant]=min(DistPath);  

for i=1:NumCit+1                  % DRAWING BEST PATH
  u(:,i)=w(Path(min_ant,i),:);
end
   clf;
   hold on;
   plot(w(:,1),w(:,2),'r.','Markersize',10);
   xlabel('x');
   ylabel('y');
   nazwa = sprintf('DIST=%f', MinPath)
   title(nazwa);
   grid on;
   uu=flip(rot90(u));
   plot(uu(:,1),uu(:,2),'k-','Markersize',5);
   pause(0.1);
   hold off;
%
%                                          PHEROMONE UPDATE
Dtau=zeros(NumCit,NumCit);
for ip=1:NumCit
    Dtau(Path(min_ant,ip),Path(min_ant,ip+1))=Q/MinPath;
        Dtau(Path(min_ant,ip+1),Path(min_ant,ip))=Dtau(Path(min_ant,ip),Path(min_ant,ip+1));   
end

    for i=1:NumCit 
        for j=1:NumCit
            tau(i,j)=(1-rho)*tau(i,j)+Dtau(i,j);    
            if i==j; tau(i,j)=0; end
        end
    end  
end        
  
fprintf('\n\nMIN DIST=%f\n',MinPath);
