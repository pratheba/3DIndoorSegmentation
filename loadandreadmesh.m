
function []= loadandreadmesh(filename)
    [vertex, faces] = read_mesh(filename);
    outputFileName = strcat('outputMesh/',filename,'-result.ply');
    startProcess(vertex, faces,outputFileName);
end