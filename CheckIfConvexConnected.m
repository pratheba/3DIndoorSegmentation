function isConvexConnected = CheckIfConvexConnected(curr_centroid, neigh_centroid, curr_facenormal, neigh_facenormal)

        epsilon = 0.001;
        
        vectorFromCurrentToNeigh = minus(curr_centroid, neigh_centroid);
        vectorFromCurrentToNeigh = vectorFromCurrentToNeigh/norm(vectorFromCurrentToNeigh);
        
        alpha1 = dot(curr_facenormal,vectorFromCurrentToNeigh);
        alpha2 = dot(neigh_facenormal, vectorFromCurrentToNeigh);
        
        AngleInRad = alpha1 - alpha2;
        disp(AngleInRad);
      %  disp(rad2deg(AngleInRad));

        angle1 = atan2d(norm(cross(curr_facenormal,vectorFromCurrentToNeigh)),dot(curr_facenormal,vectorFromCurrentToNeigh));
        angle2 = atan2d(norm(cross(neigh_facenormal,vectorFromCurrentToNeigh)),dot(neigh_facenormal,vectorFromCurrentToNeigh));
        
        AngleInDeg2 = (angle1 - angle2);
        disp(AngleInDeg2);
%         AngleInRad2 = angle1-angle2;
%         AngleInDeg2 = rad2deg(AngleInRad2);
%         disp(AngleInRad2);
%         disp(rad2deg(AngleInRad2));

%         if((AngleInRad + epsilon) >= 0)
%                 isConvexConnected = 1;
%         else
%                 isConvexConnected = 0;
%         end
        
        if(AngleInDeg2 <= 5)
            disp('Convex');
            isConvexConnected = 1;
        else
            disp('Concave');
            isConvexConnected = 0;
        end
%         if((AngleInDeg2 < 90))
%             disp('Concave');
%         else
%             disp('Convex');
%         end
        
       
end




        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%


        % Nxy = [0 0 1];
        % Nyz = [1 0 0];
        % Nzx = [0 1 0];

        % norm_curr_facenormal = curr_facenormal / norm(curr_facenormal);
        % norm_neigh_facenormal = neigh_facenormal / norm(neigh_facenormal);

        % Angle_XY = acosd(dot(cross(norm_curr_facenormal,Nxy), cross(norm_neigh_facenormal,Nxy))); %the result
        % Angle_YZ = acosd(dot(cross(norm_curr_facenormal,Nyz), cross(norm_neigh_facenormal,Nyz))); %the result
        % Angle_ZX = acosd(dot(cross(norm_curr_facenormal,Nzx), cross(norm_neigh_facenormal,Nzx))); %the result

        % disp(Angle_XY);
        % disp(Angle_YZ);
        % disp(Angle_ZX);


%end