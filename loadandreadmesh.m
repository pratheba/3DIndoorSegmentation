
function []= loadandreadmesh()
	filename='colored-reductionmesh-3.ply';
    addpath('toolbox_graph');
    addpath('gaimc');
    addpath('polygon2voxel');
    addpath('voxel');
    addpath('Mesh_voxelisation')
    addpath('Voxel_Plotter');
    addpath('ExportVoxelData/ExportVoxelData');
    addpath('ExportVoxelData/ExportVoxelData/bin');
	[vertex, faces] = read_mesh(filename);
   % TR = triangulation(faces,vertex);

   

%     field1 = 'faces';
%     value1 = {faces};
%     field2 = 'vertices';
%     value2 = {vertex};
%     s = struct(field1,value1, field2, value2);
    
    %[volume] = VOXELISE(100, 100, 100, s);
    %VoxelPlotter(volume,1);

   
     structure = patch('Faces',faces,'Vertices',vertex);
    %disp(size(structure.Vertices));
     meshtovoxel = polygon2voxel(structure, [100 100 100], 'auto','true');
    % VoxelPlotter(meshtovoxel,1);
     ExportVoxelData(meshtovoxel);
    % stem3(volume);
    
    %Show the voxelised result:
% figure;
% subplot(1,3,1);
% imagesc(squeeze(sum(volume,1)));
% colormap(gray(256));
% xlabel('Z-direction');
% ylabel('Y-direction');
% axis equal tight
% 
% subplot(1,3,2);
% imagesc(squeeze(sum(volume,2)));
% colormap(gray(256));
% xlabel('Z-direction');
% ylabel('X-direction');
% axis equal tight
% 
% subplot(1,3,3);
% imagesc(squeeze(sum(volume,3)));
% colormap(gray(256));
% xlabel('Y-direction');
% ylabel('X-direction');
% axis equal tight


%	startProcess(vertex, faces);
end