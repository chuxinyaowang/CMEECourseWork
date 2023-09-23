function plot_genome_wide_analysis(fr,L,N,sn,sp,mu,Nopt,sopt,muopt,d0,s_neg,s_pos,type,dt,T)


titlestr = ['$True\ values: N = ', num2str(N), '; s>0: \langle s_{pos} \rangle = ', num2str(sp), ...
    '; s<0: \langle s_{neg} \rangle = ', num2str(sn), '; \mu = ', num2str(mu), ...
    '; T = ', num2str(T), '; \Delta t = ', num2str(dt), '$'];

% Create data matrices for boxplot
rel_sneg=(sopt(1:fr*L) - s_neg')/sn;
log_sneg=log10(abs(sopt(1:fr*L)))-log10(abs(s_neg'));
rel_spos=(sopt(fr*L+1:end) - s_pos')/sp;
log_spos=log10(abs(sopt(fr*L+1:end)))-log10(abs(s_pos'));
data_neg = [(Nopt(1:fr*L) - N)/N; log10((Nopt(1:fr*L)) - log10(N)); (muopt(1:fr*L) - mu)/mu; log10(muopt(1:fr*L))-log10(mu); rel_sneg; log_sneg];
data_pos = [(Nopt(fr*L+1:end) - N)/N; log10(Nopt(fr*L+1:end))-log10(N); (muopt(fr*L+1:end) - mu)/mu; log10(muopt(fr*L+1:end))-log10(mu); rel_spos; log_spos];

% Create labels for x-axis
%labels = {'N','log10(N)','mu','s','log10(s)'};

% Create boxplot for negative selection
figure;
subplot(1, 2, 1);
boxchart(data_neg(1,:)')
hold on
scatter((1+randn(size(data_neg(1,:)'))/20),data_neg(1,:)','filled','SizeData',5);
title('$Relative\ N\ differences\ for\ Negative\ Selection$','Interpreter','latex', 'FontSize', 16);
ylabel('$Relative Difference\ \frac{N^*-N_i}{N_i}$','Interpreter','latex','FontSize', 20);

subplot(1, 2, 2);
boxchart(data_pos(1,:)');
hold on
scatter((1+randn(size(data_pos(1,:)'))/20),data_pos(1,:)','filled','SizeData',5)
title('$Relative\ N\ differences\ for\ Positive\ Selection$','Interpreter','latex', 'FontSize', 16);
ylabel('$Relative Difference\ \frac{N^*-N_i}{N_i}$','Interpreter','latex', 'FontSize', 20);
sgtitle(titlestr,'Interpreter','latex')
%path='/home/cw422/Documents/project/results4/relNDifferences.png';
%saveas(gcf, path)

figure;
subplot(1, 2, 1);
boxchart(data_neg(2,:)');
hold on
scatter((1+randn(size(data_neg(2,:)'))/20),data_neg(2,:)','filled','SizeData',5)
title('$\log_{10}(N)\ differences\ for\ Negative\ Selection$', 'Interpreter','latex','FontSize', 16);
ylabel('$Difference\ in\ \log_{10}(N^*)-\log_{10}(N_i)$','Interpreter','latex', 'FontSize', 20);

subplot(1, 2, 2);
boxchart(data_pos(2,:)');
hold on
scatter((1+randn(size(data_pos(2,:)'))/20),data_pos(2,:)','filled','SizeData',5)
title('$\log_{10}(N)\ differences\ for\ Positive\ Selection$', 'Interpreter','latex','FontSize', 16);
ylabel('$Difference\ in\ \log_{10}(N^*)-\log_{10}(N_i)$','Interpreter','latex', 'FontSize', 20);
sgtitle(titlestr,'Interpreter','latex')
%path='/home/cw422/Documents/project/results4/log10NDifferences.png';
%saveas(gcf, path)

figure;
subplot(1, 2, 1);
boxchart(data_neg(3,:)');
hold on
scatter((1+randn(size(data_neg(3,:)'))/20),data_neg(3,:)','filled','SizeData',5)
title('$Relative\ \mu\ differences\ for\ Negative\ Selection$', 'Interpreter','latex','FontSize', 16);
ylabel('$Relative\ Difference\ \frac{\mu^*-\mu_i}{\mu_i}$', 'Interpreter','latex','FontSize', 20);

subplot(1, 2, 2);
boxchart(data_pos(3,:)');
hold on
scatter((1+randn(size(data_pos(3,:)'))/20),data_pos(3,:)','filled','SizeData',5)
title('$Relative\ \mu\ differences\ for\ Positivetive\ Selection$', 'Interpreter','latex','FontSize', 16);
ylabel('$Relative\ Difference\ \frac{\mu^*-\mu_i}{\mu_i}$','Interpreter','latex', 'FontSize', 20);
sgtitle(titlestr,'Interpreter','latex')
%path='/home/cw422/Documents/project/results4/relmuDifferences.png';
%saveas(gcf, path)

figure;
subplot(1, 2, 1);
boxchart(data_neg(4,:)');
hold on
scatter((1+randn(size(data_neg(4,:)'))/20),data_neg(4,:)','filled','SizeData',5)
title('$\log_{10}(\mu)\ differences\ for\ Negative\ Selection$', 'Interpreter','latex','FontSize', 16);
ylabel('$Difference\ in\ \log_{10}(\mu^*)-\log_{10}(\mu_i)$', 'Interpreter','latex','FontSize', 20);

subplot(1, 2, 2);
boxchart(data_pos(4,:)');
hold on
scatter((1+randn(size(data_pos(4,:)'))/20),data_pos(4,:)','filled','SizeData',5)
title('$\log_{10}(\mu)\ differences\ for\ Positive\ Selection$','Interpreter','latex', 'FontSize', 16);
ylabel('$Difference\ in\ \log_{10}(\mu^*)-\log_{10}(\mu_i)$','Interpreter','latex', 'FontSize', 20);
sgtitle(titlestr,'Interpreter','latex')
%path='/home/cw422/Documents/project/results4/relsDifferences.png';
%saveas(gcf, path)

figure;
subplot(1, 2, 1);
boxchart(data_neg(5,:)');
hold on
scatter((1+randn(size(data_neg(5,:)'))/20),data_neg(5,:)','filled','SizeData',5)
title('$Relative\ s\ differences\ for\ Negative\ Selection$','Interpreter','latex', 'FontSize', 16);
ylabel('$Relative\ Difference\ \frac{\langle s_{neg} \rangle-s_i}{s_i}$', 'Interpreter','latex','FontSize', 20);
ylim([-7000,1000])

subplot(1, 2, 2);
boxchart(data_pos(5,:)');
hold on
scatter((1+randn(size(data_pos(5,:)'))/20),data_pos(5,:)','filled','SizeData',5)
title('$Relative\ s\ differences\ for\ Positive\ Selection$', 'Interpreter','latex','FontSize', 16);
ylabel('$Relative\ Difference\ \frac{\langle s_{pos} \rangle-s_i}{s_i}$','Interpreter','latex', 'FontSize', 20);
ylim([-10,10])
sgtitle(titlestr,'Interpreter','latex')

figure;
subplot(1, 2, 1);
boxchart(data_neg(6,:)');
hold on
scatter((1+randn(size(data_neg(6,:)'))/20),data_neg(6,:)','filled','SizeData',5)
title('$\log_{10}(s)\ differences\ for\ Negative\ Selection$', 'Interpreter','latex','FontSize', 16);
ylabel('$Difference\ in\ \log_{10}(\langle s_{neg} \rangle)-\log_{10}(s_i)$','Interpreter','latex', 'FontSize', 20);

subplot(1, 2, 2);
boxchart(data_pos(6,:)');
hold on
scatter((1+randn(size(data_pos(6,:)'))/20),data_pos(5,:)','filled','SizeData',5)
title('$\log_{10}(s)\ differences\ for\ Positive\ Selection$','Interpreter','latex', 'FontSize', 16);
ylabel('$Difference\ in\ \log_{10}(\langle s_{pos} \rangle)-\log_{10}(s_i)$','Interpreter','latex', 'FontSize', 20);
ylim([-10,10])
sgtitle(titlestr,'Interpreter','latex')
%path='/home/cw422/Documents/project/results4/log10sDifferences.png';
%saveas(gcf, path)



%ROC plotcpart

for i =1 : L
    if type(i) == 'Neutral'
        typenumeric(i) = 0.0;

    else 
        typenumeric(i) = 1.0;

    end
end


% Compute the ROC curve
figure;
[X, Y, ~, AUC] = perfcurve(typenumeric, d0, 1);
plot(X, Y)
xlabel('$False\ Positive\ Rate$','Interpreter','latex')
ylabel('$True\ Positive\ Rate$','Interpreter','latex')
title(['$ROC\ Curve\ (AUC = ', num2str(AUC), ')$'],'Interpreter','latex','position',[0.45,1.05])
sgtitle(titlestr,'Interpreter','latex')
grid on
%path='/home/cw422/Documents/project/results4/ROCplot.png';

end