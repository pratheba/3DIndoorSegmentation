function faceIndexForEachVertex = GetFacesForEachVertex(faces)
    faceIndexForEachVertex = containers.Map('KeyType', 'int32', 'ValueType','any');
    [row col] = size(faces);
        
     for r=1:row
        for c=1:3
            if(isKey(faceIndexForEachVertex,faces(r,c)))
                faceIndexForEachVertex(faces(r,c)) = [faceIndexForEachVertex(faces(r,c)); r];
            else
                faceIndexForEachVertex(faces(r,c)) = r;
            end
        end
    end
end

% function [faceVertices, indexfacevertex] = getFacesForEachVertex(vertices, faces)
    
%     faceVertices = containers.Map('KeyType','int32','ValueType','any');
%     indexfacevertex = containers.Map('KeyType', 'int32', 'ValueType','any');
%     [row col] = size(faces);
    
%     for r=1:row
% 	for c=1:3
%                 if(isKey(faceVertices,faces(r, c))) % Is the Vertex - faces(r,c) currenty part of faceVertex
%                     faceVertices(faces(r,c)) = [faceVertices(faces(r,c)); faces(r,:)]; 
%                 else
%                     faceVertices(faces(r,c)) = faces(r,:);    
%                 end
                
%                 if(isKey(indexfacevertex,faces(r,c)))
%                     indexfacevertex(faces(r,c)) = [indexfacevertex(faces(r,c)); r];
%                 else
%                     indexfacevertex(faces(r,c)) = r;
%             end
%         end
%     end

% end