function AdjacencyListForFaces = GetFaceAdjacencyList(faces,vertices, faceindexforvertex)

    numFaces = length(faces);
    AdjacencyListForFaces = cell(numFaces);
    
    numOfVertices = length(vertices);
    neighourArray = cell(numOfVertices);
     
     for r = 1:numFaces
         for c = 0:2  
             neighourArray{faces(r,mod(c,3)+1),faces(r,mod(c+1,3)+1)} = [neighourArray{faces(r,mod(c,3)+1),faces(r,mod(c+1,3)+1)}; r];
             neighourArray{faces(r,mod(c+1,3)+1),faces(r,mod(c,3)+1)} = [neighourArray{faces(r,mod(c+1,3)+1),faces(r,mod(c,3)+1)}; r];       
         end
     end
     
    for i = 1:numFaces

        neighbourFaces = GetNeighbouringFaces(faces(i,:),neighourArray, faceindexforvertex);
        neighbourFaces = neighbourFaces(find(neighbourFaces~=i));
        neighbourFaces = unique(neighbourFaces, 'rows');
        AdjacencyListForFaces{i} = neighbourFaces;
    end

    AdjacencyListForFaces = AdjacencyListForFaces(~cellfun('isempty',AdjacencyListForFaces));  
end