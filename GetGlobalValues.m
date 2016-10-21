function value = GetGlobalValues(field)
    if(strcmpi(field,'faceNormals'))
        global faceNormals;
        value = faceNormals;
    elseif (strcmpi(field,'vertexNormals'))
        global vertexNormals;
        value = vertexNormals;
    elseif(strcmpi(field,'clusterGroupSize'))
        global clusterGroupSize;
        value = clusterGroupSize;
    end
end