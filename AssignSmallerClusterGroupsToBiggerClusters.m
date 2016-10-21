function [clusters, colorInformationValue] = AssignSmallerClusterGroupsToBiggerClusters(clusters, smallGroupSizeCluster, mapFaceToCluster,adjacencyListForFaces,colorInformationValue)
    numOfSmallClusters = length(smallGroupSizeCluster);
    faceNormals = GetGlobalValues('faceNormals');

    clusterNumberForNeighbouringFaces = [];
    finalFaceNormal = [];
    finalClusterNumber = [];

    for i = 1: numOfSmallClusters % Foe each small Cluster
        currCluster = clusters{smallGroupSizeCluster(i)};
        for j = 1: length(currCluster) % For each face in a single cluster
                currface = currCluster(j);
               % disp(currface);
                neighbourFaces = adjacencyListForFaces{currface}; % Get the neighbouring faces
                neighbourFaceNormalAverage = cell(length(neighbourFaces));
                neighbourFaceClusterNumber = cell(length(neighbourFaces));

                for k = 1:length(neighbourFaces) % From the neighbouring faces

%                 if(neighbourFaceClusterNumber ~= smallGroupSizeCluster(i))
%                     clusterNumberForNeighbouringFaces = [clusterNumberForNeighbouringFaces; neighbourFaceClusterNumber];
%                 end
                
                    if(mapFaceToCluster(neighbourFaces(k)) ~= smallGroupSizeCluster(i)) % if the neighbouring face cluster size is not the same the small cluster group number
                        neighbourneighbourFaces = adjacencyListForFaces{neighbourFaces(k)}; % Get the neighbouring faces for the neighbour face
                        currNeighAvgFaceNormal = faceNormals(neighbourFaces(k),:);
                        for n = 1: length(neighbourneighbourFaces)
                            if((mapFaceToCluster(neighbourneighbourFaces(n) ~= smallGroupSizeCluster(i)) & (mapFaceToCluster(neighbourneighbourFaces(n)) == mapFaceToCluster(neighbourFaces(k)))))
                                currNeighAvgFaceNormal = mean([currNeighAvgFaceNormal; faceNormals(neighbourneighbourFaces(n),:)]);
                            end
                        end
                        neighbourFaceNormalAverage{k} = currNeighAvgFaceNormal;
                        neighbourFaceClusterNumber{k} = mapFaceToCluster(neighbourFaces(k));
        %             clusterNumberForNeighbouringFaces = [clusterNumberForNeighbouringFaces; neighbourFaceClusterNumber];
                    end
                end
                neighbourFaceNormalAverage = neighbourFaceNormalAverage(~cellfun('isempty',neighbourFaceNormalAverage));  
                neighbourFaceClusterNumber = neighbourFaceClusterNumber(~cellfun('isempty',neighbourFaceClusterNumber));
            
                % [count,value]=hist(clusterNumberForNeighbouringFaces,unique(clusterNumberForNeighbouringFaces));
                % sortCount = sort(count);

                % for k = 1: length(count)
                %     index = find(count==sortCount(k));
                %     for ii = 1: length(index)
                %         CheckForFaceNormalContraint(clusters{smallGroupSizeCluster(i)}, clusters{value(index(ii))});
                %     end
                % end
                finalClusterNumber = [finalClusterNumber ; neighbourFaceClusterNumber];
                finalFaceNormal = [finalFaceNormal; neighbourFaceNormalAverage];
        end
        %% Now loop through the finalFaceNormals
        
        angleDiff = 360;
        whichClusterNumber = smallGroupSizeCluster(i);

        curr_facenormal = faceNormals(currCluster(1),:);
        for f = 1:length(finalClusterNumber)
            ffacenormal = cell2mat(finalFaceNormal(f,:));
            angle = atan2d(norm(cross(curr_facenormal,ffacenormal)),dot(curr_facenormal,ffacenormal));
            if((angle < angleDiff)&(~(ismember(finalClusterNumber{f},smallGroupSizeCluster))))
                angleDiff = angle;
                whichClusterNumber = finalClusterNumber(f);
            end
        end
        clusters{cell2mat(whichClusterNumber)} = [clusters{cell2mat(whichClusterNumber)}; clusters{smallGroupSizeCluster(i)}];
        
        
        v = clusters{smallGroupSizeCluster(i)};
        v1 = clusters{cell2mat(whichClusterNumber)};
        for c = 1:3
            colorInformationValue(v,c) = colorInformationValue(v1(1),c);
        end
        clusters{smallGroupSizeCluster(i)} = [];
                
    end
      clusters = clusters(~cellfun('isempty',clusters));   
end