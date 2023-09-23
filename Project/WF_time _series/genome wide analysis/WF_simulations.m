function [xx_2d_neg,xx_2d_pos,ss,time_points,type,s_neg,s_pos]=WF_simulations(N,mu,sn,sp,fr,L,T,dt,ns)% Parameters
%WFsims function does simulation to create frequency array of genome,time
%array and type string.


% Initialize allele frequency array
x = zeros(T+1, L);

%create a smaple array to store type based on 2Ns and s
type = string(zeros(1,L));

% Set initial allele frequencies randomly between 0-1 for positive
% selection part
shape = 2 * N * mu;
rate = 2 * N * abs(sn);
%negative selection initial frequencies are under gamma distribution with
%shape= 2 * N * mu,and rate= 2 * N * sn
x(1,1:fr*L) = gamrnd(shape,1/rate,[1,fr*L]);

%make sure frequencies under 1
while max(x(1,:)) > 1
    x(1,1:fr*L) = gamrnd(shape,1/rate,[1,fr*L]);
end


for i = (L*fr)+1 : L 
x(1,i) = rand(1);

end

%set selection coefficient for positive and negative selection under
%exponential distribution
n_neg = fr * L;
n_pos = L - n_neg;

s_neg =  -exprnd(sn,n_neg,1);
s_pos =   exprnd(sp,n_pos,1);
ss=[s_neg',s_pos']';
ss=reshape(ss,length(s_neg)+length(s_pos),1);




%determine whether it belons to 'neutral' or 'selection'
for i =1 : L
    if 2*N*abs(ss(i)) <= 1
        type(i) = 'Neutral';

    else 
        type(i) = 'Selection';

    end
end
tabulate(type)
%histogram(x(1,1:fr*L))

% Loop over generations
for k = 1:T
    for i = 1:fr*L
    % Calculate selection terms
    sel_neg =  s_neg(i) * x(k,i) .* (1 - x(k,i));     % negative selection

    % Calculate mutation terms
    mut_fwd = mu * (1 - x(k,i)); % forward mutation
    mut_bwd = mu * x(k,i);       % backward mutation
    
    % Calculate frequency in next generation due to selection and mutation
    x(k+1,i) = x(k,i) + sel_neg + mut_fwd - mut_bwd;
    
    % Apply genetic drift
    x(k+1,i) = binornd(N, x(k+1,i)) / N;
    end
end

for k=1:T
    for j = (fr*L)+1 : L
        % Calculate selection terms
    sel_pos =  s_pos(j-n_neg) * x(k,j) .* (1 - x(k,j));     % positive selection
    
    % Calculate mutation terms
    mut_fwd = mu * (1 - x(k,j)); % forward mutation
    mut_bwd = mu * x(k,j);       % backward mutation
    
    % Calculate frequency in next generation due to selection and mutation
    x(k+1,j) = x(k,j) + sel_pos + mut_fwd - mut_bwd;
    
    % Apply genetic drift
    x(k+1,j) = binornd(N, x(k+1,j)) / N;
    end
end


% Plot allele frequency time-series for one randomly selected site
%plot(0:T, x(:,randi(L)))
%xlabel('Generation')
%ylabel('Allele frequency')


%plot for both positive and negative selection conditions
%{
subplot(1,2,1)
plot(x(:,1:8000))
title({"Allele frequency change over 100 generations"; "under negative selection (Initial frequency conforms for gamma distribution)"});
xlabel('T (Generation)')
ylabel('Allele frequency')
subplot(1,2,2)
plot(x(:,8001:10000))
title({"Allele frequency change over 100 generations"; "under positive selection (Initial frequency are set randomly between 0-1)"})
xlabel('T (Generation)')
ylabel('Allele frequency')
%}

%calculate 3D f array that GenomeAnalysisAll... needs for input - choose
%sampling time DT = 10 tt = t(0:DT:end) let xx = x(0:DT:end) then save f t
%output.mat
tt=(1:T+1);
time_points=tt(1:dt:end);
%sample through every dt generations,than do binomial sampling for 100
%samples through samplex
x_neg=x(:,1:fr*L);
x_pos=x(:,fr*L+1:end);
samplex_neg=x_neg(1:dt:end,:);
samplex_pos=x_pos(1:dt:end,:);
%allele_types = {'Selection', 'Neutral'};


%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%3D array part%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the f and fsampled arrays
num_sites = size(samplex, 2);
num_alleles = numel(allele_types);
num_timepoints = numel(time_points);
f1 = zeros(num_sites, num_alleles, num_timepoints);
f = zeros(num_sites, num_alleles, num_timepoints);

% Iterate over the sampled frequency array
for i = 1:num_sites
    for k = 1:num_timepoints
        % Sample the binomial distribution for allele 1
        f1(i, 1, k) = samplex(k, i);
        f(i, 1, k) = binornd(ns, f1(i, 1, k)) / ns;
        
        % Calculate allele 2 frequency
        f1(i, 2, k) = 1 - f1(i, 1, k);
        f(i, 2, k) = 1 - f(i, 1, k);
    end
end


% fsampled array dimensions: (number of genomic sites) x (number of nucleotides) x (number of times points)
size(f)
save('3darray.mat','f')
%}


%%%%%%2D array%%%
%%%%%%%%%%%%%%%%%
% Initialize the f and fsampled arrays
num_sites_neg = size(samplex_neg, 2);
num_sites_pos = size(samplex_pos, 2);
num_timepoints = numel(time_points);
x2d_neg = zeros(num_sites_neg, num_timepoints);
x2d_pos = zeros(num_sites_pos, num_timepoints);
xx_neg = zeros(num_sites_neg, num_timepoints);
xx_pos = zeros(num_sites_pos, num_timepoints);

% Iterate over the sampled frequency array
for i = 1:num_sites_neg
    for k = 1:num_timepoints
        % Sample the binomial distribution for allele 1
        x2d_neg(i, k) = samplex_neg(k, i);
        xx_neg(i, k) = binornd(ns, x2d_neg(i, k)) / ns;
    end
end

for i = 1:num_sites_pos
    for k = 1:num_timepoints
        % Sample the binomial distribution for allele 1
        x2d_pos(i, k) = samplex_pos(k, i);
        xx_pos(i, k) = binornd(ns, x2d_pos(i, k)) / ns;
    end
end
% Reshape the f and fsampled arrays to 2D
%x_2d = reshape(x2d, num_sites, num_timepoints);
xx_2d_neg = reshape(xx_neg, num_sites_neg, num_timepoints);
xx_2d_pos = reshape(xx_pos, num_sites_pos, num_timepoints);

end