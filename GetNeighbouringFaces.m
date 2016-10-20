function neighbourFaces = GetNeighbouringFaces(face, neighourArray, faceindexforvertex)
    neighbourFaces = [];

    for i = 0:2
        neighbourFaces = [neighbourFaces; neighourArray{face(mod(i,3)+1), face(mod(i+1,3)+1)}];
        % faceindexValueset = values(faceindexforvertex,num2cell(face(i)));        
        % neighbourFaces = [neighbourFaces; cell2mat(faceindexValueset)];
    end
end