function [] = SegmentMesh
    filename='colored-reductionmesh-3.ply';
    %filename='demos/Block.ply';
    addpath('toolbox_graph');
    addpath('gaimc');
    
    SetGlobalClusterGroupSize(20);
    loadandreadmesh(filename);
end