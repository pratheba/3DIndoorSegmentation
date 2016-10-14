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
        blackFaces = [];
        for i = 1: numVertices

                if(~isVisited(i))
                clusterNumber = clusterNumber+1;
            
                clusterVertices = i;
                uVector = vertexnormals(i,:)';
                [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexnormals, i, isVisited, clusterVertices, uVector);
          
                [numberOfClusterVertices, finalClusterVertices, isVisited] = CheckForValidityoftheComponent(clusterVertices, isVisited, adjacencyList, vertexnormals);
                valueSet = values(faceVertices,num2cell(finalClusterVertices));
                clustergroupfaces=[];

                c = rand(1,3);
                for v=1:length(valueSet)
                    count = 0;
                    for index=1:length(valueSet{v})
                        for j=1:3
                            if(ismember(valueSet{v}(index,j),finalClusterVertices))
                                count = count +1;
                            end
                        end
                    clustergroupfaces = [clustergroupfaces; valueSet{v}];
                    faceindexValueset = values(indexfaces,num2cell(valueSet{v}(index,j)));
                    faceindexValueset = cell2mat(faceindexValueset);
                    if( count < 2)
                        blackFaces = [blackFaces; faces(faceindexValueset,:)];
                    end
                    count = 0;
                    end
                end

                tri = triangulation(clustergroupfaces, vertex); 
                h = trisurf(tri, 'FaceColor', c);
                axis equal;
                hold on;
            end
        end
        hold off;
        
        blackFaces = unique(blackFaces,'rows');
        backcolorfaces = zeros(length(blackFaces),3);
        write_ply(vertex,blackFaces,backcolorfaces, 'test.ply');
end