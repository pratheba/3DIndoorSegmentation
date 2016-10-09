function [] = startProcess(vertex, faces)
        [faceVertices, indexfaces] = getFacesForEachVertex(vertex, faces);
        [triangulatedVertex, vertexnormals, facenormals] = computeVertexAndFaceNormalAndDisplay(vertex, faces);
        adjacencyMatrix = triangulation2adjacency(faces,vertex);	
        adjacencyList = adjacencyMatrix2List(adjacencyMatrix);
    
        numVertices = length(adjacencyList');
        isVisited = zeros(1, numVertices);
        clusterNumber = 0;
        colorInformation = zeros(length(faces),3);
      
        faceindexesforblack = [];
        figure();

        for i = 1: numVertices
           
            if(~isVisited(i))
                clusterNumber = clusterNumber+1;
            
                clusterVertices = i;
                uVector = vertexnormals(i,:)';
                [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexnormals, i, isVisited, clusterVertices, uVector);
          
                [numberOfClusterVertices, finalClusterVertices, isVisited] = CheckForValidityoftheComponent(clusterVertices, isVisited, adjacencyList, vertexnormals);
                valueSet = values(faceVertices,num2cell(finalClusterVertices));
                clustergroupfaces=[];

                for v=1:length(valueSet)
                    count = 0;
                    for index=1:length(valueSet{v})
                        for j=1:3
                            if(ismember(valueSet{v}(index,j),finalClusterVertices))
                                count = count +1;
                            end
                        end
                    clustergroupfaces = [clustergroupfaces; valueSet{v}];
                    if( count < 2)
%                         clustergroupfaces = [clustergroupfaces; valueSet{v}];
%                     else
                         
                         faceindexValueset = values(indexfaces,num2cell(valueSet{v}(index,j)));
                         for v1 =1:length(faceindexValueset)
                            faceindexesforblack = [faceindexesforblack; faceindexValueset{v1}];
                         end
                         
%                         for f=1:length(faceindexValueset)
%                             colorInformation(faceindexValueset(f)) = {0 0 0};
%                         end
%                         disp(valueSet{v});
                          %isVisible(valueSet{v}(index,j)) = 0;
                    end
                    count = 0;
                    end
                end

                c = rand(1,3);
                if(length(clustergroupfaces) > 0)
                tri = triangulation(clustergroupfaces, vertex);
                end
                clustergroupfaces=[];
                faceindexValueset = values(indexfaces,num2cell(finalClusterVertices));
                for v=1:length(faceindexValueset)
                    clustergroupfaces = [clustergroupfaces; faceindexValueset{v}];
  %                  disp(facenormals(clustergroupfaces(:),:));
                end
                for k=1:length(clustergroupfaces)
                    colorInformation(clustergroupfaces(k),:) = ceil(255*c(:));
                end
                for k=1:length(faceindexesforblack)
                    colorInformation(faceindexesforblack(k),:) = [0 0 0];
                end

                h = trisurf(tri, 'FaceColor', c);
                axis equal;
                hold on;
            end
        end
        hold off;
        write_ply(vertex,faces,colorInformation, 'test.ply');
end