function [] = SegmentMesh
    %filename='colored-reductionmesh-3.ply';
    %filename='nowall-reduced.ply';
    %filename='nowall-reduced.ply';
    filename='nowall-reduced-30-1038faces.ply'
    addpath('toolbox_graph');
    addpath('gaimc');
    
    SetGlobalClusterGroupSize(40);
    SetGlobalValues('minDistance',2);
    loadandreadmesh(filename);
end