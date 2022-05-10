%=================================================
% ACO - TRAVELING SALESMAN PROBLEM 
%=================================================
clear; clc;
%
NumCit=5; a=0.7; b=0.7;
NumAnt=NumCit;     
rho=0.5; Q=1;
NumIter=5;
%---------------------------------------------------------------
z=10^10; 
%
   d=[z, 3, 6,2, 3;...   % DISTANCES TABLE BETWEEN CITIES
        3, z, 5, 2, 3;...   %  d_ij  DISTANCE BETWEEN CITY I TO CITY J
        6, 5, z, 6, 4;...   % d_ii  TENING TO INFINITY (z=10^10)
        2, 2, 6, z, 6;...
        3, 3, 4, 6, z];
%    
    for i=1:NumCit 
        for j=1:NumCit
            tau(i,j)=1;    % PHEROMONE DOSE ASSOCIATED TO EVERY CITY CONNECTION
            if i==j; tau(i,j)=0; end
            eta(i,j)=1/d(i,j);  % VISIBILITY - RECIPROCAL OF DISTANCE BETWEEN CITIES
        end
    end
fprintf('INITIAL PHEROMONE \n');        
fprintf(' %f   %f   %f   %f   %f  \n',tau(:,:));        
%    
%===============================================================
for iter=1:NumIter     % THE BEGINNING OF THE ITERATION LOOP
%===============================================================   
fprintf('START OF ITER %i  ========================================================= \n',iter);
%
for iant=1:NumAnt   % LOOKING FOR BEST PATH BY EVERY ANT
%    
temp=tau;     % TEMPORARY BOARD. FOR VISITED CITY, COLUMN temp IS SET TO 0
temp(:,iant)=0;
Path(iant,1)=iant;  % START. EVERY ANT STARTS FROM A DIFFRENT CITY
ind=iant;
fprintf('ANT %i  ---------------------------------------------------------------------- \n',iant);
%
for icity=2:NumCit   % CHOICE OF NEXT CITY TO VISIT
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
fprintf('%f   %f   %f   %f   %f   --->  %i \n',p(:),ind);
Path(iant,icity)=ind; 
temp(:,ind)=0;    % FOR THE VISITED CITY, THE RELEVANT COLUMN temp IS SET TO 0
%
end
%
Path(iant,NumCit+1)=iant;
sump=0;
for ip=1:NumCit
    sump=sump+d(Path(iant,ip),Path(iant,ip+1));
end
DistPath(iant)=sump;
fprintf('PATH   %i   %i   %i   %i   %i   %i     DIST=%f \n',Path(iant,:),DistPath(iant));
%
end
%
fprintf('END OF ITER %i  ========================================================= \n',iter);
%
[MinPath,min_ant]=min(DistPath);  % THE SHORTEST ROUTE, ANT, WHICH CHOSEN THIS ROUTE
%
%                                          PHEROMONE UPDATE
Dtau=zeros(NumCit,NumCit);
for ip=1:NumCit
    Dtau(Path(min_ant,ip),Path(min_ant,ip+1))=Q/MinPath;
        Dtau(Path(min_ant,ip+1),Path(min_ant,ip))=Dtau(Path(min_ant,ip),Path(min_ant,ip+1));   % SYMMETRY
end

    for i=1:NumCit 
        for j=1:NumCit
            tau(i,j)=(1-rho)*tau(i,j)+Dtau(i,j);    
            if i==j; tau(i,j)=0; end
        end
    end
fprintf('UPDATED PHEROMONE \n');        
fprintf(' %f   %f   %f   %f   %f  \n',tau(:,:));    
%
%===============================================================   
end        % END OF THE ITERATION LOOP
%===============================================================   
fprintf('MinPath=%f\n',MinPath);    