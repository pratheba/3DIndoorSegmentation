function [] = displayNormals(triangulatedVertex, vertex, vertexnormals, incenterofTrianges, facenormals)
	trisurf(triangulatedVertex, 'FaceColor', [0.8 0.8 1.0]);
	axis equal
	hold on
	quiver3(vertex(:,1), vertex(:,2), vertex(:,3), vertexnormals(:,1), vertexnormals(:,2), vertexnormals(:,3), 0.7, 'color', 'r');
	quiver3(incenterofTrianges(:,1), incenterofTrianges(:,2), incenterofTrianges(:,3), facenormals(:,1), facenormals(:,2), facenormals(:,3), 0.8, 'color', 'g');
	hold off
end