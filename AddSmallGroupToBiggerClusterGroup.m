
%% This might be the second way to approach the problem where the smaller groups as clustered together
%% And then either merge to bigger group or leave it as such

function [clusters,mapFaceToCluster] = AddSmallerGroupToBiggerClusterGroup(clusters, smallGroupSizeCluster, mapFaceToCluster,adjacencyListForFaces,colorInformationValue, centroid)
    numOfSmallClusters = length(smallGroupSizeCluster);
    faceNormals = GetGlobalValues('faceNormals');

    clusterNumberForNeighbouringFaces = [];
    finalFaceNormal = [];
    finalClusterNumber = [];

    mindistance = GetGlobalValues('minDistance');
    isNeighbourToBiggerClusterGroup = zeros(numOfSmallClusters,1);
    
    %% Get the small group clusters whose neighbour belongs to a larger group and continue from then on
    for s_index = 1: numOfSmallClusters % For each small Cluster
        currSmallGroupFaceNumbers = clusters{smallGroupSizeCluster(s_index)};

        for fs_index = 1: length(currSmallGroupFaceNumbers) % For each face in a single cluster
                currfaceNumber = currSmallGroupFaceNumbers(fs_index);
                neighbourFaces = adjacencyListForFaces{currfaceNumber}; % Get the neighbouring faces

                neighbourFaces = setdiff(neighbourFaces,smallGroupSizeCluster); % get rid off small cluster groups from neighfaces
                if(length(neighbourFaces) > 0)
                    isNeighbourToBiggerClusterGroup = 1;
                    %% call next function
                    neighbourFaceNormalAverage = cell(length(neighbourFaces));
                    neighbourFaceClusterNumber = cell(length(neighbourFaces));


                    for neigh_index = 1:length(neighbourFaces) % From the neighbouring faces
                        if(mapFaceToCluster(neighbourFaces(neigh_index)) ~= smallGroupSizeCluster(s_index)) % if the neighbouring face cluster size is not the same the small cluster group number
                            currNeighAvgFaceNormal = faceNormals(neighbourFaces(neigh_index),:);

                            % neighbourneighbourFaces = adjacencyListForFaces{neighbourFaces(neigh_index)}; % Get the neighbouring faces for the neighbour face
                            % for n_neigh_index = 1: length(neighbourneighbourFaces)
                            %     if((mapFaceToCluster(neighbourneighbourFaces(n_neigh_index)) ~= smallGroupSizeCluster(s_index)) & (mapFaceToCluster(neighbourneighbourFaces(n_neigh_index)) == mapFaceToCluster(neighbourFaces(neigh_index))))
                            %         currNeighAvgFaceNormal = mean([currNeighAvgFaceNormal; faceNormals(neighbourneighbourFaces(n),:)]); % should i take the mean ?
                            %     end
                            % end

                            neighbourFaceNormalAverage{neigh_index} = currNeighAvgFaceNormal;
                            neighbourFaceClusterNumber{neigh_index} = mapFaceToCluster(neighbourFaces(neigh_index));
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
        end

        if(isNeighbourToBiggerClusterGroup)
            %% Now loop through the finalFaceNormals
            finalClusterNumber = cell2mat(finalClusterNumber);
            finalFaceNormal = cell2mat(finalFaceNormal);

            angleDiff = 360;
            whichClusterNumber = smallGroupSizeCluster(s_index);
            curr_AvgfacenormalOfSmallCluster = mean(faceNormals(currSmallGroupFaceNumbers,:));
          
            % changed = 0;
            for f = 1:length(finalClusterNumber)
                ffacenormal = finalFaceNormal(f,:);
                currangleDiff = atan2d(norm(cross(curr_AvgfacenormalOfSmallCluster,ffacenormal)),dot(curr_AvgfacenormalOfSmallCluster,ffacenormal));

                randnum = randperm(length(clusters{finalClusterNumber(f)}),10);
                meancentroidOfcurrSmallGroup = mean(centroid(currSmallGroupFaceNumbers,:));

                for r = 1:10 
                    distancecentroid = norm(meancentroidOfcurrSmallGroup - centroid(clusters{finalClusterNumber(f)}(randnum(r)),:));
                    disp(distancecentroid);
                end

                if((currangleDiff < angleDiff))%&(~(ismember(finalClusterNumber{f},smallGroupSizeCluster))))%&(distance <= mindistance))
                    angleDiff = currangleDiff;
                    whichClusterNumber = finalClusterNumber(f);
                    % changed = 1;
                end
            end

            % if(changed == 0)
            %     disp('no change');
            %     disp(whichClusterNumber);
            % end

            clusters{whichClusterNumber} = [clusters{whichClusterNumber}; currSmallGroupFaceNumbers];
            mapFaceToCluster(currSmallGroupFaceNumbers) = whichClusterNumber;
            
            
            % v = clusters{smallGroupSizeCluster(i)};
            % v1 = clusters{cell2mat(whichClusterNumber)};
            % for c = 1:3
            %     colorInformationValue(v,c) = colorInformationValue(v1(1),c);
            % end
            clusters{smallGroupSizeCluster(s_index)} = [];
        end
    end
      clusters = clusters(~cellfun('isempty',clusters));   
end