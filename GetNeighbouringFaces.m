function neighbourFaces = GetNeighbouringFaces(face, faceindexforvertex)
    neighbourFaces = [];
    for i = 1:3
        faceindexValueset = values(faceindexforvertex,num2cell(face(i)));        
        neighbourFaces = [neighbourFaces; cell2mat(faceindexValueset)];
    end
end