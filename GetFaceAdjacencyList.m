function AdjacencyListForFaces = GetFaceAdjacencyList(faces,faceindexforvertex)

    numFaces = length(faces);
    AdjacencyListForFaces = cell(numFaces);
    for i = 1:length(faces)
        neighbourFaces = GetNeighbouringFaces(faces(i,:),faceindexforvertex);
        neighbourFaces = neighbourFaces(find(neighbourFaces~=i));
        neighbourFaces = unique(neighbourFaces, 'rows');
        AdjacencyListForFaces{i} = neighbourFaces;
    end
end