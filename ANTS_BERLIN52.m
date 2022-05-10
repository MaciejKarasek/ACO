clear; clc;
%
NumCit=52; a=1; b=5; 
NumAnt=NumCit;   
rho=0.75; Q=1;
NumIter=16;
%---------------------------------------------------------------
z=10^10; 
%                             PROBLEM - BERLIN 52
w=[565.0 575.0;
 25.0 185.0
 345.0 750.0
 945.0 685.0
 845.0 655.0
 880.0 660.0
 25.0 230.0
 525.0 1000.0
 580.0 1175.0
 650.0 1130.0
 1605.0 620.0 
 1220.0 580.0
 1465.0 200.0
 1530.0 5.0
 845.0 680.0
 725.0 370.0
 145.0 665.0
 415.0 635.0
 510.0 875.0  
 560.0 365.0
 300.0 465.0
 520.0 585.0
 480.0 415.0
 835.0 625.0
 975.0 580.0
 1215.0 245.0
 1320.0 315.0
 1250.0 400.0
 660.0 180.0
 410.0 250.0
 420.0 555.0
 575.0 665.0
 1150.0 1160.0
 700.0 580.0
 685.0 595.0
 685.0 610.0
 770.0 610.0
 795.0 645.0
 720.0 635.0
 760.0 650.0
 475.0 960.0
 95.0 260.0
 875.0 920.0
 700.0 500.0
 555.0 815.0
 830.0 485.0
 1170.0 65.0
 830.0 610.0
 605.0 625.0
 595.0 360.0
 1340.0 725.0
 1740.0 245.0];
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
            tau(i,j)=1;    
            if i==j; tau(i,j)=0; end
            eta(i,j)=1/d(i,j);  
          
        end
    end
%    
for iter=1:NumIter    
fprintf('START OF ITER %i  ========================================================= \n',iter);
%
for iant=1:NumAnt  
% 
temp=tau;    
temp(:,iant)=0;
Path(iant,1)=iant;  
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
%
end
%
Path(iant,NumCit+1)=iant;
sump=0;
for ip=1:NumCit
    sump=sump+d(Path(iant,ip),Path(iant,ip+1));
end
DistPath(iant)=sump;
fprintf('%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i \n',Path(iant,:));
fprintf('DIST=%f \n',DistPath(iant));
%
end
%
fprintf('END OF ITER %i  ========================================================= \n',iter);
%
[MinPath,min_ant]=min(DistPath);  

for i=1:NumCit+1                
  u(:,i)=w(Path(min_ant,i),:);
end
   clf;
   hold on;
   plot(w(:,1),w(:,2),'r.','Markersize',10);
   xlabel('wspolrzedna x');
   ylabel('wspolrzedna y');
   nazwa = sprintf('ITER %i MinDist=%f', iter,MinPath);
   title(nazwa);
   grid on;
   uu=flip(rot90(u));
   plot(uu(:,1),uu(:,2),'k-','Markersize',5);
   pause(0.1);
   hold off;

                                     
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