function isConvexConnected = CheckIfConvexConnected(curr_centroid, neigh_centroid, curr_facenormal, neigh_facenormal)

        epsilon = 0.001;
        
        vectorFromCurrentToNeigh = neigh_centroid - curr_centroid;
        vectorFromCurrentToNeigh = vectorFromCurrentToNeigh/norm(vectorFromCurrentToNeigh);
        
        curr_facenormal = curr_facenormal/norm(curr_facenormal);
        neigh_facenormal = neigh_facenormal /norm(neigh_facenormal);
        vectorFromCurrentToNeigh = vectorFromCurrentToNeigh/norm(vectorFromCurrentToNeigh);
        
        angleFromCurrToDiff = acos(dot(curr_facenormal,vectorFromCurrentToNeigh));
        angleFromNeighToDiff = acos(dot(neigh_facenormal,vectorFromCurrentToNeigh));
        
        angleFromCurrToDiffDeg = acosd(dot(curr_facenormal,vectorFromCurrentToNeigh));
        angleFromNeighToDiffDeg = acosd(dot(neigh_facenormal,vectorFromCurrentToNeigh));
        
        angleDiff = ((angleFromCurrToDiff) - (angleFromNeighToDiff));
        angleDiffDeg = ((angleFromCurrToDiffDeg) - (angleFromNeighToDiffDeg));
        
%         disp(angleDiffDeg);
        
        if((angleDiff >= 0) && (dot(neigh_facenormal,vectorFromCurrentToNeigh)>0))
            isConvexConnected = 1;
        else
            isConvexConnected = 0;
        end
               
end
    