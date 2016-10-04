
function []= loadandreadmesh()
	filename='colored-reductionmesh-3.ply';
    addpath('toolbox_graph');
    addpath('gaimc');
	[vertex, faces] = read_mesh(filename);

	startProcess(vertex, faces);
end