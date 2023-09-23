function plot_type_auc
%load struct to srore all results under different conditions
dataStruct1 = struct('Nmus', {},'u_Nmus', {});
dataStruct2 = struct('mus', {},'u_mus', {});
dataStruct3 = struct('Ns', {},'u_Ns', {});
dataStruct4 = struct('s', {},'u_s', {});
dt_list     = [5,10,20,50];


%loop for inputing data
%Nmus
%unsampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/optimiseNmus/');
dataStruct1(i).u_Nmus = load([load_path,'unsampled_results',num2str(i),'/output',num2str(i),'_unsampled.mat']);

end

%sampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/optimiseNmus/');
dataStruct1(i).Nmus = load([load_path,'results',num2str(i),'/output',num2str(i),'.mat']);

end

%mus
%unsampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/fixN/');
dataStruct2(i).u_mus = load([load_path,'unsampled_results',num2str(i),'/output',num2str(i),'_unsampled.mat']);

end

%sampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/fixN/');
dataStruct2(i).mus = load([load_path,'results',num2str(i),'/output',num2str(i),'.mat']);

end

%Ns
%unsampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/fixmu/');
dataStruct3(i).u_Ns = load([load_path,'unsampled_results',num2str(i),'/output',num2str(i),'_unsampled.mat']);

end

%sampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/fixmu/');
dataStruct3(i).Ns = load([load_path,'results',num2str(i),'/output',num2str(i),'.mat']);

end

%s
%unsampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/fixNmu/');
dataStruct4(i).u_s = load([load_path,'unsampled_results',num2str(i),'/output',num2str(i),'_unsampled.mat']);

end

%sampled
for i=1:8
load_path=('/home/cw422/Documents/project/results/fixNmu/');
dataStruct4(i).s = load([load_path,'results',num2str(i),'/output',num2str(i),'.mat']);

end

alpha=0.05;

%loop for calculating AUC values and storing them
%Nmus
%unsampled Nmus
for j=1:8
    type = dataStruct1(j).u_Nmus.type;

    typenumeric=zeros(1,10000);

    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct1(j).utypenumeric = typenumeric;
    [X, Y, ~, AUC]              = perfcurve(typenumeric, dataStruct1(j).u_Nmus.d0, 1);
    dataStruct1(j).uAUC         = AUC;
    %tabulate(typenumeric)
end
%sampled
for j=1:8
    type = dataStruct1(j).Nmus.type;
    typenumeric=zeros(1,10000);

    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct1(j).typenumeric  = typenumeric;
    [X, Y, ~, AUC]              = perfcurve(typenumeric, dataStruct1(j).Nmus.d0, 1);
    dataStruct1(j).AUC         = AUC;
    %tabulate(typenumeric)
    
end

%mus
%unsampled
for j=1:8
    type = dataStruct2(j).u_mus.type;

    typenumeric=zeros(1,10000);
    
    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct2(j).utypenumeric = typenumeric;
    [X, Y, ~, AUC]              = perfcurve(typenumeric, dataStruct2(j).u_mus.d0, 1);
    dataStruct2(j).uAUC         = AUC;
    %tabulate(typenumeric)
end
%sampled
for j=1:8
    type = dataStruct2(j).mus.type;

    typenumeric=zeros(1,10000);

    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct2(j).typenumeric = typenumeric;
    [X, Y, ~, AUC]             = perfcurve(typenumeric, dataStruct2(j).mus.d0, 1);
    dataStruct2(j).AUC         = AUC;
    %tabulate(typenumeric)
    
end

%Ns
%unsampled Nmus
for j=1:8
    type = dataStruct3(j).u_Ns.type;

    typenumeric=zeros(1,10000);
    
    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct3(j).utypenumeric = typenumeric;
    [X, Y, ~, AUC]              = perfcurve(typenumeric, dataStruct3(j).u_Ns.d0, 1);
    dataStruct3(j).uAUC         = AUC;
    %tabulate(typenumeric)
end
%sampled
for j=1:8
    type = dataStruct3(j).Ns.type;

    typenumeric=zeros(1,10000);

    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct3(j).typenumeric = typenumeric;
    [X, Y, ~, AUC]             = perfcurve(typenumeric, dataStruct3(j).Ns.d0, 1);
    dataStruct3(j).AUC         = AUC;
    %tabulate(typenumeric)
    
end

%s
%unsampled 
for j=1:8
    type = dataStruct4(j).u_s.type;

    typenumeric=zeros(1,10000);
    
    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct4(j).utypenumeric = typenumeric;
    [X, Y, ~, AUC]              = perfcurve(typenumeric, dataStruct4(j).u_s.d0, 1);
    dataStruct4(j).uAUC         = AUC;
    %tabulate(typenumeric)
end
%sampled
for j=1:8
    type = dataStruct4(j).s.type;

    typenumeric=zeros(1,10000);

    for l =1 : 10000
        if type(l) == 'Neutral'
            typenumeric(l) = 0;
        else 
            typenumeric(l) = 1;

        end 

    end
    dataStruct4(j).typenumeric = typenumeric;
    [X, Y, ~, AUC]             = perfcurve(typenumeric, dataStruct4(j).s.d0, 1);
    dataStruct4(j).AUC         = AUC;
    %tabulate(typenumeric)
    
end

%plot
%T=1000
aucValues1000Nmus   = [dataStruct1(1:4).AUC]
aucValues1000Nmusu  = [dataStruct1(1:4).uAUC]
aucValues1000mus    = [dataStruct2(1:4).AUC]
aucValues1000musu   = [dataStruct2(1:4).uAUC]
aucValues1000Ns     = [dataStruct3(1:4).AUC]
aucValues1000Nsu    = [dataStruct3(1:4).uAUC]
aucValues1000s      = [dataStruct4(1:4).AUC]
aucValues1000su     = [dataStruct4(1:4).uAUC]

%T=10000
aucValues10000Nmus   = [dataStruct1(5:8).AUC];
aucValues10000Nmusu  = [dataStruct1(5:8).uAUC];
aucValues10000mus    = [dataStruct2(5:8).AUC];
aucValues10000musu   = [dataStruct2(5:8).uAUC];
aucValues10000Ns     = [dataStruct3(5:8).AUC];
aucValues10000Nsu    = [dataStruct3(5:8).uAUC];
aucValues10000s      = [dataStruct4(5:8).AUC];
aucValues10000su     = [dataStruct4(5:8).uAUC];


titlestr = ('$AUC\ difference\ $');
sgtitle(titlestr,'Interpreter','latex')

subplot(1,2,1);
line9=plot(dt_list,aucValues1000Nmus,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color = [36/255, 169/255, 225/255];
set(line9,'Marker','o', 'MarkerFaceColor', marker_color, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;

line11=plot(dt_list,aucValues1000mus,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color2 = [225/255, 213/255, 36/255];
set(line11,'Marker','o', 'MarkerFaceColor', marker_color2, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;

line13=plot(dt_list,aucValues1000Ns,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color3 = [106/255, 225/255, 36/255];
set(line13,'Marker','o', 'MarkerFaceColor', marker_color3, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;


line15=plot(dt_list,aucValues1000s,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color4 = [225/255, 36/255, 76/255];
set(line15,'Marker','o', 'MarkerFaceColor', marker_color4, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;


line10=plot(dt_list,aucValues1000Nmusu,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color = [36/255, 169/255, 225/255];
set(line10,'Marker','o', 'MarkerFaceColor', marker_color, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;



line12=plot(dt_list,aucValues1000musu,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color2 = [225/255, 213/255, 36/255];
set(line12,'Marker','o', 'MarkerFaceColor', marker_color2, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;



line14=plot(dt_list,aucValues1000Nsu,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color3 = [106/255, 225/255, 36/255];
set(line14,'Marker','o', 'MarkerFaceColor', marker_color3, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;


line16=plot(dt_list,aucValues1000su,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color4 = [225/255, 36/255, 76/255];
set(line16,'Marker','o', 'MarkerFaceColor', marker_color4, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;

ylim([0,1])
xlim([0,60])
xticks([ 5, 10, 20, 50]);
xticklabels({'5', '10', '20', '50'});
title('$T= 1000 $','Interpreter','latex')
ylabel('$ AUC $','Interpreter','latex','FontSize', 20)
xlabel('$\Delta t$','Interpreter','latex','FontSize', 20)


subplot(1,2,2);
line1=plot(dt_list,aucValues10000Nmus,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color = [36/255, 169/255, 225/255];
set(line1,'Marker','o', 'MarkerFaceColor', marker_color, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;

line3=plot(dt_list,aucValues10000mus,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color2 = [225/255, 213/255, 36/255];
set(line3,'Marker','o', 'MarkerFaceColor', marker_color2, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;

line5=plot(dt_list,aucValues10000Ns,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color3 = [106/255, 225/255, 36/255];
set(line5,'Marker','o', 'MarkerFaceColor', marker_color3, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;


line7=plot(dt_list,aucValues10000s,'LineStyle','--','Color',[96, 96, 96] / 255);
marker_color4 = [225/255, 36/255, 76/255];
set(line7,'Marker','o', 'MarkerFaceColor', marker_color4, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;


line2=plot(dt_list,aucValues10000Nmusu,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color = [36/255, 169/255, 225/255];
set(line2,'Marker','o', 'MarkerFaceColor', marker_color, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;



line4=plot(dt_list,aucValues10000musu,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color2 = [225/255, 213/255, 36/255];
set(line4,'Marker','o', 'MarkerFaceColor', marker_color2, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;



line6=plot(dt_list,aucValues10000Nsu,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color3 = [106/255, 225/255, 36/255];
set(line6,'Marker','o', 'MarkerFaceColor', marker_color3, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;



line8=plot(dt_list,aucValues10000su,'Color',[96, 96, 96] / 255,'LineStyle','-');
marker_color4 = [225/255, 36/255, 76/255];
set(line8,'Marker','o', 'MarkerFaceColor', marker_color4, 'MarkerEdgeColor', 'black', 'MarkerSize', 8);
hold on;


ylim([0,1])
xlim([0,60])
xticks([ 5, 10, 20, 50]);
xticklabels({'50', '100', '200', '500'});
title('$T= 10000 $','Interpreter','latex')
ylabel('$ AUC $','Interpreter','latex','FontSize', 20)
xlabel('$\Delta t$','Interpreter','latex','FontSize', 20)
hLegend = legend({'optimise $N\ \mu\ s$ with sampling','fix $N$ with sampling', ...
                  'fix $\mu$ with sampling','fix $N\ \mu$ with sampling', ...
                  'optimise $N\ \mu\ s$ without sampling','fix $N$ without sampling', ...
                  'fix $\mu$ without sampling','fix $N\ \mu$ without sampling'}, ...
                 'Location', 'best', 'AutoUpdate', 'on','NumColumns', 4);
set(hLegend, 'Position', [0.5, 0.01, 0.1, 0.03], 'Orientation', 'horizontal');


end
