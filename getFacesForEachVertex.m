function [faceVertices, indexfacevertex] = getFacesForEachVertex(vertices, faces)
    
	faceVertices = containers.Map('KeyType','int32','ValueType','any');
    indexfacevertex = containers.Map('KeyType', 'int32', 'ValueType','any');
	[row col] = size(faces);
    
	for i=1:row
		for j=1:3
            if(isKey(faceVertices,faces(i, j)))
                faceVertices(faces(i,j)) = [faceVertices(faces(i,j)); faces(i,:)]; 
                %disp(faceVertices(faces(i,j)));
            else
                faceVertices(faces(i,j)) = faces(i,:);    
            end
                
            if(isKey(indexfacevertex,faces(i,j)))
                indexfacevertex(faces(i,j)) = [indexfacevertex(faces(i,j)); i];
            else
                indexfacevertex(faces(i,j)) = i;
            end
        end
    end

end