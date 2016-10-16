function [clusterFaces, isVisitedFace] = MeshRegionGrowingByComparingFaceNormals(faces, adjacencyListForFaces, currentfaceindex, curr_facenormal, isVisitedFace,faceNormals,centroid, clusterFaces)
    
    smoothnessThresholdinDegree = 10;

    if(~isVisitedFace(currentfaceindex))
        isVisitedFace(currentfaceindex) = 1;
        neighbourFaces = adjacencyListForFaces{currentfaceindex};

        for i=1:length(neighbourFaces)
            if(~isVisitedFace(neighbourFaces(i)))
                neigh_facenormal = faceNormals(neighbourFaces(i),:);
             
               % isFacesConvexilyConnected = CheckIfConvexConnected(centroid(currentfaceindex,:), centroid(neighbourFaces(i),:), curr_facenormal, neigh_facenormal);
                angle1 = atan2d(norm(cross(curr_facenormal,neigh_facenormal)),dot(curr_facenormal,neigh_facenormal));
                
               % if(isFacesConvexilyConnected)
                if(angle1 < 5)
                    clusterFaces = [ clusterFaces; neighbourFaces(i)];

                     if(GetShouldTakeAverageNormal)
                        curr_facenormal = mean([curr_facenormal'; neigh_facenormal]);
                        curr_facenormal = curr_facenormal';
                     end

                    [clusterFaces, isVisitedFace] = MeshRegionGrowingByComparingFaceNormals(faces, adjacencyListForFaces, neighbourFaces(i), curr_facenormal, isVisitedFace, faceNormals, centroid,clusterFaces);
                end
            end
        end
    end
end