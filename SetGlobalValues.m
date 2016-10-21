function [] = SetGlobalValues(field, value)
    if(strcmpi(field,'faceNormals'))
        global faceNormals;
        faceNormals = value;
    elseif (strcmpi(field,'vertexNormals'))
        global vertexNormals;
        vertexNormals = value;
    elseif(strcmpi(field,'clusterGroupSize'))
        global clusterGroupSize;
        clusterGroupSize = value;
    end
end