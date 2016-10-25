function neighbourFaces = GetNeighbouringFaces(face, edgeList)
    neighbourFaces = cell(6,1);

    count = 1;
    for i = 0:2
        neighbourFaces{count} = edgeList{face(mod(i,3)+1), face(mod(i+1,3)+1)};
        count = count+1;
        neighbourFaces{count} = edgeList{face(mod(i+1,3)+1), face(mod(i,3)+1)};
        count = count+1;
    end
    
    neighbourFaces = neighbourFaces(~cellfun('isempty',neighbourFaces));
    neighbourFaces = cell2mat(neighbourFaces);
end