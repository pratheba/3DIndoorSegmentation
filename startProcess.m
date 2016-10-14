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
                         %faceindexesforblack = [faceindexesforblack ; faceindexValueset];
                         blackFaces = [blackFaces; faces(faceindexValueset,:)];
                        %colorInformation(faceindexValueset,:)= AssignValue(colorInformation(faceindexValueset,:), [0 0 0]);
                         %colorInformation(faceindexValueset,:) = [0 0 0];
                    else
                         %faceindexesforblack = [faceindexesforblack ; faceindexValueset];
                         %blackFaces = [blackFaces; faces(faceindexValueset,:)];
                         %colorInformation(faceindexValueset,:) = ceil(255*c(:));
                        %colorInformation(faceindexValueset,:)= AssignValue(colorInformation(faceindexValueset,:), ceil(255*c(:)));
                    end
                    count = 0;
                    end
                end

                
                %if(length(clustergroupfaces) > 0)
                tri = triangulation(clustergroupfaces, vertex);
                %end
                
                %clustergroupfaces=[];
                %faceindexValueset = values(indexfaces,num2cell(finalClusterVertices));
                %faceindexValueset = cell2mat(faceindexValueset);
                %clustergroupfaces = faceindexValueset;
                %colorInformation(faceindexValueset) = ceil(255*c(:));
                %for v=1:length(faceindexValueset)
                    %clustergroupfaces = [clustergroupfaces; faceindexValueset{v}];
                    %colorInformation(faceindexValueset{v},:) = ceil(255*c(:));
  %                  disp(facenormals(clustergroupfaces(:),:));
                %end
%                 for k=1:length(clustergroupfaces)
%                     colorInformation(clustergroupfaces(k),:) = ceil(255*c(:));
%                 end
                %colorInformation(faceindexesforblack) = [0 0 0]
%                 for k=1:length(faceindexesforblack)
%                     colorInformation(faceindexesforblack(k),:) = [0 0 0];
%                     blackFaces = [blackFaces; faces(faceindexesforblack(k),:)];
%                 end

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