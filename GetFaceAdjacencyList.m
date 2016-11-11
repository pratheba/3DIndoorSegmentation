function AdjacencyListForFaces = GetFaceAdjacencyList(faces,vertices, faceindexforvertex)

    numFaces = length(faces);
    AdjacencyListForFaces = cell(numFaces,1);
    
    numOfVertices = length(vertices);
    edgeList = containers.Map();
    %edgeList = cell(numOfVertices);
    
    for r = 1:numFaces
        for c = 0:2  
            KeyEdge1 = [num2str(faces(r,mod(c,3)+1)) '/' num2str(faces(r,mod(c+1,3)+1))];
            KeyEdge2 = [num2str(faces(r,mod(c+1,3)+1)) '/' num2str(faces(r,mod(c,3)+1))];
            
            if(isKey(edgeList,KeyEdge1))
                edgeList(KeyEdge1) = [edgeList(KeyEdge1); r];  
             else
                 edgeList(KeyEdge1) = r;
            end

            if(isKey(edgeList,KeyEdge2))
                edgeList(KeyEdge2) = [edgeList(KeyEdge2); r];  
             else
                 edgeList(KeyEdge2) = r;
            end
%              edgeList{faces(r,mod(c+1,3)+1),faces(r,mod(c,3)+1)} = [edgeList{faces(r,mod(c+1,3)+1),faces(r,mod(c,3)+1)}; r];
%              edgeList{faces(r,mod(c,3)+1),faces(r,mod(c+1,3)+1)} = [edgeList{faces(r,mod(c,3)+1),faces(r,mod(c+1,3)+1)}; r];
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