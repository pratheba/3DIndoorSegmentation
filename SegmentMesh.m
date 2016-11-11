function [] = SegmentMesh
    %filename='colored-reductionmesh-3.ply';
    %filename='nowall-reduced.ply';
    %filename='nowall-reduced.ply';
    %filename='nowall-reduced-30-1038faces.ply'
    %filename='nowall.ply'
    %filename='brianoffice-reduced.ply'
    addpath('toolbox_graph');
    %addpath('gaimc');
    
    %filenames= {'brianoffice-reduced-3.ply'; 'brianoffice-reduced-2.ply'; 'brianoffice-reduced-1.ply'};
    filenames = {'nowall.ply'};
    SetGlobalClusterGroupSize(40);
    SetGlobalValues('minDistance',2);
    for i = 1:length(filenames)
        loadandreadmesh(filenames{i});
    end
end