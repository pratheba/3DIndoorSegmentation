function [clusters,mapFaceToCluster] = AssignSmallerClusterGroupsToBiggerClusters(clusters, smallGroupSizeCluster, mapFaceToCluster,adjacencyListForFaces,colorInformationValue, centroid)
    numOfSmallClusters = length(smallGroupSizeCluster);
    faceNormals = GetGlobalValues('faceNormals');

    mindistance = GetGlobalValues('minDistance');
    isNeighbourToBiggerClusterGroup = zeros(numOfSmallClusters,1);
    
    loopcount = 0;
    while(1)
        if((loopcount > 10) || (isempty(find(isNeighbourToBiggerClusterGroup == 0,1))))
            break;
        end
        loopcount = loopcount + 1;
    %% Get the small group clusters whose neighbour belongs to a larger group and continue from then on
    for s_index = 1: numOfSmallClusters % For each small Cluster
        finalClusterNumber = [];
        finalFaceNormal = [];
        
        if(isNeighbourToBiggerClusterGroup(s_index))
            continue;
        end

        currSmallGroupFaceNumbers = clusters{smallGroupSizeCluster(s_index)}; 

        for fs_index = 1: length(currSmallGroupFaceNumbers) % For each face in a single cluster
            currfaceNumber = currSmallGroupFaceNumbers(fs_index);

            neighbourFaces = adjacencyListForFaces{currfaceNumber}; % Get the neighbouring faces
            
            tempNeighfaces = [];
            neighbourFaceNormalAverage = cell(length(neighbourFaces));
            neighbourFaceClusterNumber = cell(length(neighbourFaces));
            
            for neigh_index = 1:length(neighbourFaces)
                tempNeighbourFacesClusterNumber = setdiff(mapFaceToCluster(neighbourFaces(neigh_index)),smallGroupSizeCluster); % get rid off small cluster groups from neighfaces
                
                if(~isempty(tempNeighbourFacesClusterNumber))
                    isNeighbourToBiggerClusterGroup(s_index) = 1;
                    tempNeighfaces = [tempNeighfaces; neighbourFaces(neigh_index)];
                    neighbourFaceClusterNumber{neigh_index} = tempNeighbourFacesClusterNumber;
                    neighbourFaceNormalAverage{neigh_index} = faceNormals(neighbourFaces(neigh_index),:);
                end
            end

            neighbourFaceNormalAverage = neighbourFaceNormalAverage(~cellfun('isempty',neighbourFaceNormalAverage));  
            neighbourFaceClusterNumber = neighbourFaceClusterNumber(~cellfun('isempty',neighbourFaceClusterNumber));

            finalClusterNumber = [finalClusterNumber ; neighbourFaceClusterNumber];
            finalFaceNormal = [finalFaceNormal; neighbourFaceNormalAverage];
        end

        if(isNeighbourToBiggerClusterGroup(s_index))
            isNeighbourToBiggerClusterGroup(s_index) = 0;
            %% Now loop through the finalFaceNormals
            finalClusterNumber = cell2mat(finalClusterNumber);
            finalFaceNormal = cell2mat(finalFaceNormal);

            angleDiff = 360;
            whichClusterNumber = smallGroupSizeCluster(s_index);
           
            curr_AvgfacenormalOfSmallCluster = faceNormals(currSmallGroupFaceNumbers(1),:);
            if(length(currSmallGroupFaceNumbers)>1)
                r = randperm(length(currSmallGroupFaceNumbers),1);
                %curr_AvgfacenormalOfSmallCluster = mean(faceNormals(currSmallGroupFaceNumbers,:));
                curr_AvgfacenormalOfSmallCluster = faceNormals(currSmallGroupFaceNumbers(r),:);
            end
          
           
            for f = 1:length(finalClusterNumber)
                ffacenormal = finalFaceNormal(f,:);
                currangleDiff = atan2d(norm(cross(curr_AvgfacenormalOfSmallCluster,ffacenormal)),dot(curr_AvgfacenormalOfSmallCluster,ffacenormal));

%                 randnum = randperm(length(clusters{finalClusterNumber(f)}),10);
%                 %meancentroidOfcurrSmallGroup = mean(centroid(currSmallGroupFaceNumbers,:));
%                 avgdistance = [];
%                 currSmallGroupcentroid = centroid(currSmallGroupFaceNumbers(randperm(length(currSmallGroupFaceNumbers),1)),:);
%                 %for len = 1: length(currSmallGroupFaceNumbers)
%                 for r = 1:10 
%                    % distancecentroid = norm(centroid(currSmallGroupFaceNumbers(len),:) - centroid(clusters{finalClusterNumber(f)}(randnum(r)),:));
%                    distancecentroid = norm(currSmallGroupcentroid - centroid(clusters{finalClusterNumber(f)}(randnum(r)),:));
%                    % disp(distancecentroid);
%                    avgdistance = [avgdistance; distancecentroid];
%                 end
%                 avgdistance = mean(avgdistance);
               % end

                if((currangleDiff < angleDiff))% & (avgdistance <= mindistance))%&(~(ismember(finalClusterNumber{f},smallGroupSizeCluster))))%&(distance <= mindistance))
                    angleDiff = currangleDiff;
                    whichClusterNumber = finalClusterNumber(f);
                    isNeighbourToBiggerClusterGroup(s_index) = 1;
                    % changed = 1;
%                 elseif(avgdistance > mindistance)
%                      disp('average distance greater');
                end
            end

            % if(changed == 0)
            %     disp('no change');
            %     disp(whichClusterNumber);
            % end

            if(isNeighbourToBiggerClusterGroup(s_index))
                clusters{whichClusterNumber} = [clusters{whichClusterNumber}; currSmallGroupFaceNumbers];              
                mapFaceToCluster(currSmallGroupFaceNumbers) = whichClusterNumber;
                clusters{smallGroupSizeCluster(s_index)} = [];
            end

            % v = clusters{smallGroupSizeCluster(i)};
            % v1 = clusters{cell2mat(whichClusterNumber)};
            % for c = 1:3
            %     colorInformationValue(v,c) = colorInformationValue(v1(1),c);
            % end
            
%             else
%                 disp('Better luck next time group');
%                 disp(s_index);
        end
    end
%     smallGroupSizeCluster(find(isNeighbourToBiggerClusterGroup == 1))=[];
%     numOfSmallClusters = length(smallGroupSizeCluster);
    
    end
    clusters = clusters(~cellfun('isempty',clusters));   
end