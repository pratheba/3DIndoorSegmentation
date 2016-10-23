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
    elseif(strcmpi(field,'minDistance'))
        global minDistance;
        minDistance = value;
    end
end