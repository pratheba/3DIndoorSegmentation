function [clusterFaces, isVisitedFace] = MeshRegionGrowingByComparingFaceNormals(faces, adjacencyListForFaces, currentfaceindex, curr_facenormal, isVisitedFace,faceNormals,centroid, clusterFaces)
    
    smoothnessThresholdinDegree = 10;
    shouldTakeAverage = GetShouldTakeAverageNormal();
    minDistance = GetGlobalValues('minDistance');

    if(~isVisitedFace(currentfaceindex))
        isVisitedFace(currentfaceindex) = 1;
        neighbourFaces = adjacencyListForFaces{currentfaceindex};

        for i=1:length(neighbourFaces)
             curr_facenormal = curr_facenormal/norm(curr_facenormal);
%              disp(curr_facenormal);

            if(~isVisitedFace(neighbourFaces(i)))
                
                
                neigh_facenormal = faceNormals(neighbourFaces(i),:);
                neigh_facenormal = neigh_facenormal /norm(neigh_facenormal);
%                 disp(neigh_facenormal);
                if(~isequal(size(curr_facenormal),size(neigh_facenormal)))
                    curr_facenormal = curr_facenormal';
                end
%                 angleDiff = atan2d(norm(cross(curr_facenormal,neigh_facenormal)),dot(curr_facenormal,neigh_facenormal));
%                 distance = norm(centroid(currentfaceindex,:) - centroid(neighbourFaces(i),:));
%         
                [angleInRad, angleInDeg] = FindDifferenceInAngleBetweenCentroidFaceNormals(centroid(currentfaceindex,:), centroid(neighbourFaces(i),:), curr_facenormal, neigh_facenormal);
                  
                if((dot(curr_facenormal,neigh_facenormal)>= 0) & ((((angleInDeg < 0) & abs(angleInDeg) <=5))||((angleInDeg>=0) & (angleInDeg <=15))))%&(angleInDeg <= 5))% & (distance <= minDistance)) %% check if anti parallel
                    clusterFaces = [ clusterFaces; neighbourFaces(i)];
                    if(shouldTakeAverage)
                        %curr_facenormal = mean(faceNormals(clusterFaces,:));
                        curr_facenormal = mean([curr_facenormal; neigh_facenormal]);
                        curr_facenormal = curr_facenormal/norm(curr_facenormal);
                     else
                        curr_facenormal = neigh_facenormal;
                    end
                     [clusterFaces, isVisitedFace] = MeshRegionGrowingByComparingFaceNormals(faces, adjacencyListForFaces, neighbourFaces(i), curr_facenormal, isVisitedFace, faceNormals, centroid,clusterFaces);
                     
                     curr_facenormal = faceNormals(currentfaceindex,:);
                     curr_facenormal = curr_facenormal /norm(curr_facenormal);

                 else
                    % check for convextiy
                     isFacesConvexilyConnected = CheckIfConvexConnected(centroid(currentfaceindex,:), centroid(neighbourFaces(i),:), curr_facenormal, neigh_facenormal);
                     if(isFacesConvexilyConnected)%&& distance <= minDistance)
                         
                         clusterFaces = [ clusterFaces; neighbourFaces(i)];
                         curr_facenormal = neigh_facenormal;
                         curr_facenormal = curr_facenormal/norm(curr_facenormal);
                         
                         [clusterFaces, isVisitedFace] = MeshRegionGrowingByComparingFaceNormals(faces, adjacencyListForFaces, neighbourFaces(i), curr_facenormal, isVisitedFace, faceNormals, centroid,clusterFaces);
                         
                         curr_facenormal = faceNormals(currentfaceindex,:);
                         
                         curr_facenormal = curr_facenormal /norm(curr_facenormal);
%                      else
%                          disp('face not convex connected');
                     end
            end
        end
    end
end