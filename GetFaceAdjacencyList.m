function AdjacencyListForFaces = GetFaceAdjacencyList(faces,vertices, faceindexforvertex)

    numFaces = length(faces);
    AdjacencyListForFaces = cell(numFaces,1);
    
    numOfVertices = length(vertices);
    edgeList = cell(numOfVertices);
    
    for r = 1:numFaces
        for c = 0:2  
            edgeList{faces(r,mod(c,3)+1),faces(r,mod(c+1,3)+1)} = [edgeList{faces(r,mod(c,3)+1),faces(r,mod(c+1,3)+1)}; r];
            edgeList{faces(r,mod(c+1,3)+1),faces(r,mod(c,3)+1)} = [edgeList{faces(r,mod(c+1,3)+1),faces(r,mod(c,3)+1)}; r];
        end
    end
     
    for i = 1:numFaces
        neighbourFaces = GetNeighbouringFaces(faces(i,:),edgeList);
        neighbourFaces = neighbourFaces(neighbourFaces~=i);
        neighbourFaces = unique(neighbourFaces);
        AdjacencyListForFaces{i} = neighbourFaces;
    end

    %AdjacencyListForFaces = AdjacencyListForFaces(~cellfun('isempty',AdjacencyListForFaces));  
end