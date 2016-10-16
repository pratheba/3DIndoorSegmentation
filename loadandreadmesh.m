
function []= loadandreadmesh(filename)
    [vertex, faces] = read_mesh(filename);
    startProcess(vertex, faces);
end