function test_bug1775

% TEST test_bug1775
% TEST ft_sourceparcellate ft_checkdata ft_datatype_source ft_datatype_volume ft_datatype_parcellation ft_datatype_segmentation

%% create a set of sensors

[pnt, tri] = icosahedron162;

pnt = pnt .* 10; % convert to cm
sel = find(pnt(:,3)>0);

grad.pnt = pnt(sel,:) .* 1.2;
grad.ori = pnt(sel,:);
grad.tra = eye(length(sel));
for i=1:length(sel)
  grad.ori(i,:) = grad.ori(i,:) ./ norm(grad.ori(i,:));
  grad.label{i} = sprintf('magnetometer%d', i);
end
grad.unit = 'cm';
grad.type = 'magnetometer';

grad = ft_datatype_sens(grad);

%% create a volume conductor

vol = [];
vol.r     = 10;
vol.o     = [0 0 0];
vol.unit  = 'cm';

vol = ft_datatype_headmodel(vol);

%% create some precomputed leadfields

cfg = [];
<<<<<<< HEAD
cfg.grad            = grad;
cfg.vol             = vol;
cfg.grid.resolution = 1;
cfg.channel         = 'all';
=======
cfg.grad = grad;
cfg.vol = vol;
cfg.grid.resolution = 1;
cfg.channel = 'all';
>>>>>>> a13ab85c7c3c7dc51acd25cffda5c04c94d97ec0
grid = ft_prepare_leadfield(cfg);

%% create an anatomical parcellation
parcellation = [];
<<<<<<< HEAD
parcellation.pos        = grid.pos;
parcellation.unit       = grid.unit;
parcellation.type       = zeros(size(grid.pos,1),1);
parcellation.typelabel  = {};
=======
parcellation.pos = grid.pos;
parcellation.unit = grid.unit;
parcellation.type      = zeros(size(grid.pos,1),1);
parcellation.typelabel = {};
>>>>>>> a13ab85c7c3c7dc51acd25cffda5c04c94d97ec0
height = [3 4 5 6 7 8 9];
for i=1:length(height)
  sel = parcellation.pos(:,3)==height(i);
  parcellation.type(sel) = i;
  parcellation.typelabel{i} = sprintf('%d%s', height(i), parcellation.unit);
end
parcellation.cfg = 'manual'; % to check whether the provenance is correct

%% create simulated data
cfg = [];
<<<<<<< HEAD
cfg.grad    = grad;
cfg.vol     = vol;
=======
cfg.grad = grad;
cfg.vol = vol;
>>>>>>> a13ab85c7c3c7dc51acd25cffda5c04c94d97ec0
cfg.dip.pos = [0 0 4];
data = ft_dipolesimulation(cfg);

cfg = [];
cfg.covariance = 'yes';
timelock = ft_timelockanalysis(cfg, data);

cfg = [];
<<<<<<< HEAD
cfg.method  = 'mtmfft';
cfg.taper   = 'hanning';
freq1 = ft_freqanalysis(cfg, data);

cfg = [];
cfg.method  = 'wavelet';
cfg.toi     = data.time{1};
freq2 = ft_freqanalysis(cfg, data);

cfg = [];
cfg.grad    = grad;
cfg.vol     = vol;
cfg.grid    = grid;
cfg.method  = 'lcmv';
source1 = ft_sourceanalysis(cfg, timelock);

cfg = [];
cfg.grad    = grad;
cfg.vol     = vol;
cfg.grid    = grid;
cfg.method  = 'mne';
cfg.lambda  = 0;
source2 = ft_sourceanalysis(cfg, timelock);

%% make some parcellations
cfg = [];
gridp    = ft_sourceparcellate(cfg, grid, parcellation);
source1p = ft_sourceparcellate(cfg, source1, parcellation);
source2p = ft_sourceparcellate(cfg, source2, parcellation);

%% construct a more complex source structure
source3 = [];
source3.pos       = source2.pos;
source3.freq      = 1:5;
source3.coh       = randn(size(source2.pos,1), size(source2.pos,1), 5);
source3.cohdimord = 'pos_pos_freq';

cfg = [];
source3p = ft_sourceparcellate(cfg, source3, parcellation);

%%
source4 = [];
source4.pos       = source2.pos;
source4.freq      = 1:5;
source4.time      = 1:3;
source4.coh       = randn(size(source2.pos,1), size(source2.pos,1), 5, 3);
source4.cohdimord = 'pos_pos_freq_time';
=======
cfg.method = 'mtmfft';
cfg.taper = 'hanning';
freq1 = ft_freqanalysis(cfg, data);

cfg = [];
cfg.method = 'wavelet';
cfg.toi = data.time{1};
freq2 = ft_freqanalysis(cfg, data);

cfg = [];
cfg.grad = grad;
cfg.vol = vol;
cfg.grid = grid;
cfg.method = 'lcmv';
source1 = ft_sourceanalysis(cfg, timelock);

cfg = [];
cfg.grad = grad;
cfg.vol = vol;
cfg.grid = grid;
cfg.method = 'mne';
cfg.lambda = 0;
source2 = ft_sourceanalysis(cfg, timelock);

cfg = [];
source4p = ft_sourceparcellate(cfg, source4, parcellation);

%%
source5 = [];
source5.pos       = source2.pos;
source5.inside    = source2.inside;
source5.outside   = source2.outside;
source5.freq      = 1:2;
source5.coh       = cell(size(source2.pos,1), size(source2.pos,1));
for i=source2.inside(:)'
  for j=source2.inside(:)'
    source5.coh{i,j} = randn(3, 2);
  end
end
source5.cohdimord = '{pos_pos}_ori_freq';

<<<<<<< HEAD
cfg = [];
cfg.method = 'mean';
source5p = ft_sourceparcellate(cfg, source5, parcellation);
cfg.method = 'min';
source5p = ft_sourceparcellate(cfg, source5, parcellation);
cfg.method = 'max';
source5p = ft_sourceparcellate(cfg, source5, parcellation);

%%
source6 = [];
source6.pos       = source2.pos;
source6.inside    = source2.inside;
source6.outside   = source2.outside;
source6.time      = 1:20;
source6.mom       = randn(size(source2.pos,1),20);
source6.momdimord = 'pos_time';
=======
%% make some parcellations
cfg = [];
gridp    = ft_sourceparcellate(cfg, grid, parcellation);
source1p = ft_sourceparcellate(cfg, source1, parcellation);
source2p = ft_sourceparcellate(cfg, source2, parcellation);
>>>>>>> a13ab85c7c3c7dc51acd25cffda5c04c94d97ec0

cfg = [];
cfg.method = 'mean';
source6p = ft_sourceparcellate(cfg, source6, parcellation);
cfg.method = 'min';
source6p = ft_sourceparcellate(cfg, source6, parcellation);
cfg.method = 'max';
source6p = ft_sourceparcellate(cfg, source6, parcellation);
cfg.method = 'eig';
source6p = ft_sourceparcellate(cfg, source6, parcellation);

